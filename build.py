from CIScripts import translator
from CIScripts import ba2_creator
from CIScripts import utils
from CIScripts import mod_info
from CIScripts import mo2
import os

def ClearArchives(isAF):
    archiveName = mod_info.config.mainArchiveNameAF if isAF else mod_info.config.mainArchiveName

    fullArchivePath = "./Data/" + archiveName + mod_info.config.archiveExtension
    if os.path.isfile(fullArchivePath):
        os.remove(fullArchivePath)

    fullArchivePath = "./Data/" + archiveName + "_xbox" + mod_info.config.archiveExtension
    if os.path.isfile(fullArchivePath):
        os.remove(fullArchivePath)

    fullArchivePath = "./Data/" + archiveName + "_ps" + mod_info.config.archiveExtension
    if os.path.isfile(fullArchivePath):
        os.remove(fullArchivePath)
    
def main():   
    if utils.AskForUserConfirm("Would you like to localize the .esm?"):
        translator.Translate()
        ClearArchives(True)
        ClearArchives(False)
        mo2.runMO2Target("xTranslator")
        if(not utils.AskForUserConfirm(".esm localized. Proceed to archive creation?")):
            return

    if(os.path.isfile(mod_info.config.modShortName + "_Thumbnail.png") or utils.AskForUserConfirm("Thumbnail file not found. Proceed anyway?")):
        ba2_creator.CreateArchives()

if __name__ == "__main__":
    main()