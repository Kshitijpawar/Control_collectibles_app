import sys 
from pathlib import Path
import json 
if __name__ == "__main__":

    master_json = {}
    get_files = sys.argv[1:]
    for file in get_files:
        group_name = Path(file).stem
        json_load = json.load(open(file))
        master_json[group_name] = json_load

    with open("master.json", "w", encoding= "utf-8") as fout:
        json.dump(master_json, fout, indent= 4)