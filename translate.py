import subprocess
import os
import re
import shutil

def replaceCKLaunchArgs(args):
    mo2IniPath = os.getenv('LOCALAPPDATA') + "\\ModOrganizer\\Starfield\\ModOrganizer.ini"
    with open(mo2IniPath, 'r') as file:
        fileData = file.read()

    matches = re.findall("(.)\\\\.*CreationKit.exe", fileData) 
    index = matches[0]

    matches = re.findall("(" + index + "\\\\arguments=)(.*)", fileData) 
    fileData = fileData.replace(matches[0][0] + matches[0][1], matches[0][0] + args)

    with open(mo2IniPath, 'w') as file:
        file.write(fileData)

def runCK():
    subprocess.run(["J:/100Install/mo2/ModOrganizer.exe", "-p", "ZZZ_AlternateStart", "moshortcut://Starfield:Creation Kit"])

def createAllStringFiles():
    stringFiles = os.listdir("./Data/Strings")
    supportedLanguages = ["de", "es", "fr", "it", "ja", "pl", "ptbr", "zhhans"]

    for supportedLanguage in supportedLanguages:
        for stringFile in stringFiles:
            shutil.copy("./Data/Strings/" + stringFile, "./Data/Strings/" + stringFile.replace("en", supportedLanguage))

def main():
    replaceCKLaunchArgs("-TagifyPlugin:RoleplayersAlternateStart.esp")
    runCK()
    replaceCKLaunchArgs("-ExportText:RoleplayersAlternateStart.esp")
    runCK()
    replaceCKLaunchArgs("-CompileTextExport:RoleplayersAlternateStart.esp en H:\\Games\\steamapps\\common\\Starfield\\TextExport\\RoleplayersAlternateStart.esp")
    runCK()
    createAllStringFiles()
    replaceCKLaunchArgs("")
    runCK()
    replaceCKLaunchArgs("-DelocalizeMasterfile:RoleplayersAlternateStart.esm")
    runCK()
    replaceCKLaunchArgs("")

if __name__ == "__main__":
    main()