import json
from pathlib import Path
import subprocess
import os

def CreateBA2(achlist, mode):
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
                else:
                    filelist += f
            else:
                filelist += f 
            filelist += "\n"
        filelist = filelist.rstrip('\n')

        with open("tmp.txt", "w") as output:
            output.write(filelist)
        archiveName = "RoleplayersAlternateStart - Main"
        if(mode == "Xbox"):
            archiveName += "_xbox"
        elif(mode == "PS5"):
            archiveName += "_ps"
        elif(mode == "Nexus"):
            archiveName += "_nexus"
        archiveName += ".ba2"
        subprocess.run(["H:/Games/steamapps/common/Starfield/Tools/Archive2/Archive2.exe", "-s=tmp.txt", "-c=Data\\" + archiveName,  "-f=General", "-compression=None"]) 
        os.remove("tmp.txt") 

def main():
    CreateBA2("./Data/RAS.achlist", "Nexus")
    CreateBA2("./Data/RAS_NO_AI.achlist", "PC")
    CreateBA2("./Data/RAS_NO_AI.achlist", "Xbox")
    CreateBA2("./Data/RAS_NO_AI.achlist", "PS5")

if __name__ == "__main__":
    main()