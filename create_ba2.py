import json
from pathlib import Path
import subprocess
import os
import shutil
import re
import glob

def GetVoicesFromAchList(achlist, mode, languageCode=""):
    filelist = ""
    with open(achlist, "r") as file:
        data = json.load(file)
        for f in data:        
            p = Path(f)
            if p.suffix == ".wem":
                if mode == "Xbox":
                    filelist += "Data\\Xbox\\" + str(Path(*p.parts[1:]))
                elif mode == "PS5":
                    filelist += "Data\\PS5\\" + str(Path(*p.parts[1:]))
                elif mode == "Localized":
                    filelist += "Data\\LocalizedVoices\\" + languageCode + "\\" + str(Path(*p.parts[1:]))
                else:
                    filelist += f
            else:
                filelist += f 
            filelist += "\n"
        filelist = filelist.rstrip('\n')
    return filelist

def GetFilesFromAchList(achList):
    filelist = ""
    with open(achList, "r") as file:
        data = json.load(file)
        for f in data:        
            filelist += f 
            filelist += "\n"
        filelist = filelist.rstrip('\n')
    return filelist

def InitFileList(fileListName, fileList, buildFolder):
    with open(buildFolder + fileListName, "w") as output:
        output.write(fileList)
        output.write("\n")

def AppendToFileList(fileListName, fileList, buildFolder):
    with open(buildFolder + fileListName, "a") as output:
        output.write(fileList)
        output.write("\n")

def CopyFilesToBuildFolder(fileList, buildFolder):
    for file in fileList.splitlines():
        dest = buildFolder + os.path.dirname(file)
        matches = re.findall(".*([sS]ound.*)", dest)  
        if(len(matches)):
            dest = buildFolder + "Data\\" + matches[0]
        os.makedirs(dest, exist_ok=True)
        shutil.copy(file, dest)

def CreateBA2(fileListName, archiveName, outputFolder):
    subprocess.run(["H:/Games/steamapps/common/Starfield/Tools/Archive2/Archive2.exe", "-s=" + fileListName, "-c=" + outputFolder + archiveName,  "-f=General", "-compression=None"], cwd='./build') 

def CreateLocalizedVoiceBA2(voiceList, voiceListPath, archiveNameBase, buildFolder, outputFolder):
    supportedLanguages = ["de", "es", "fr", "it", "ja", "pl", "ptbr", "zhhans"]
    for supportedLanguage in supportedLanguages:
        fileListName = supportedLanguage + ".txt"
        CopyFilesToBuildFolder(GetVoicesFromAchList(voiceListPath, "Localized", supportedLanguage), buildFolder)
        InitFileList(fileListName, voiceList, buildFolder)
        CreateBA2(fileListName, archiveNameBase + "Voices_" + supportedLanguage + ".ba2", outputFolder)
        os.remove(buildFolder + fileListName)

def CopyESMs(outputDir):
    esmPaths = glob.glob("./Data/*.esm")
    for esmPath in esmPaths:
        shutil.copy(esmPath, outputDir + esmPath)

def CopyFOMODFiles(thumbnail, outputDir):
    fomodFiles = glob.glob("./fomod/**/*.*", recursive=True)
    for fomodFile in fomodFiles:
        if os.path.isfile(fomodFile) and Path(fomodFile).suffix != ".in":
            dest = outputDir + os.path.dirname(fomodFile)
            os.makedirs(dest, exist_ok=True)
            shutil.copy(fomodFile, dest)
    shutil.copy(thumbnail, outputDir)
    shutil.copy("readme.md", outputDir)

def CopyArtifactsToDataFolder(artifactsPath):
    artifacts = glob.glob(artifactsPath + "/Data/*")
    for artifact in artifacts:
        shutil.copy(artifact, "./Data/")

def main():   
    modName = "RoleplayersAlternateStart"
    archiveNameBase = modName + " - "
    mainArchiveName = archiveNameBase + "Main" 
    archiveExtension = ".ba2"
    buildFolder = "./build/"

    mainFileList = GetFilesFromAchList("./Data/RAS_Main.achlist")
    modifiedVoiceList = GetFilesFromAchList("./Data/RAS_ModifiedVoices.achlist")
    vanillaVoiceListName = "./Data/RAS_VanillaVoices.achlist"
    vanillaVoiceList = GetFilesFromAchList(vanillaVoiceListName)

# ========================================================================

    if os.path.isdir(buildFolder):
        shutil.rmtree(buildFolder)

# ========================================================================

    buildName = "Nexus"
    artifactsSubpath = "artifacts\\" + buildName + "\\"
    artifactsFullpath = buildFolder + artifactsSubpath
    fileListName = buildName + ".txt"
    outputFolder =  "output\\"
    
    # Prepare build files
    CopyFilesToBuildFolder(mainFileList, buildFolder)
    CopyFilesToBuildFolder(modifiedVoiceList, buildFolder)

    # AI build
    InitFileList(fileListName, mainFileList, buildFolder)
    AppendToFileList(fileListName, modifiedVoiceList, buildFolder)   
    CreateBA2(fileListName, mainArchiveName + archiveExtension, artifactsSubpath + "Data\\")
    os.remove(buildFolder + fileListName)
    
    # No-AI Build
    InitFileList(fileListName, mainFileList, buildFolder)
    CreateBA2(fileListName, mainArchiveName + "_NO_AI" + archiveExtension, artifactsSubpath + "Data\\")
    os.remove(buildFolder + fileListName)

    # Localized voices
    CreateLocalizedVoiceBA2(vanillaVoiceList, vanillaVoiceListName, archiveNameBase, buildFolder, artifactsSubpath + "Data\\")

    # Copy esms
    CopyESMs(artifactsFullpath)
    
    # Create zip
    CopyFOMODFiles("RAS_Thumbnail.png", artifactsFullpath)
    
    os.makedirs(outputFolder, exist_ok=True)
    shutil.make_archive(outputFolder + modName, 'zip', artifactsFullpath)

    # Cleanup
    shutil.rmtree(buildFolder + "Data")

# ========================================================================

    buildName = "Creation"
    artifactsSubpath = "artifacts\\" + buildName + "\\"
    artifactsFullpath = buildFolder + artifactsSubpath
    fileListName = buildName + ".txt"

    # Prepare common build files
    CopyFilesToBuildFolder(mainFileList, buildFolder)
    
    # Prepare file list
    InitFileList(fileListName, mainFileList, buildFolder)
    AppendToFileList(fileListName, vanillaVoiceList, buildFolder) 

    # PC build
    CopyFilesToBuildFolder(GetVoicesFromAchList(vanillaVoiceListName, "PC"), buildFolder)
    CreateBA2(fileListName, mainArchiveName + archiveExtension, artifactsSubpath + "Data\\")

    # Xbox build
    CopyFilesToBuildFolder(GetVoicesFromAchList(vanillaVoiceListName, "Xbox"), buildFolder)
    CreateBA2(fileListName, mainArchiveName + "_xbox" + archiveExtension, artifactsSubpath + "Data\\")

    # PS5 Build
    CopyFilesToBuildFolder(GetVoicesFromAchList(vanillaVoiceListName, "PS5"), buildFolder)
    CreateBA2(fileListName, mainArchiveName + "_ps" + archiveExtension, artifactsSubpath + "Data\\")

    CopyArtifactsToDataFolder(artifactsFullpath)

    # Cleanup    
    os.remove(buildFolder + fileListName)
    shutil.rmtree(buildFolder + "Data")

if __name__ == "__main__":
    main()