import pickle
from pymol import cmd
import json
import tkinter as tk
from tkinter import filedialog

def load_ms_data(filename):
    with open(filename, 'rb') as f:
        ms_data = pickle.load(f)
    return ms_data

def show_pairs(data, colour1='red', colour2='white', shape='spheres', cutoff='1000.0'):
    for chain in data:
        for partner in data[chain]:
            for row in data[chain][partner]:    
                sel1 = f'(chain {chain} and resi {row[0]})'
                cmd.color(colour1, sel1)
                sel1 = f'(chain {chain} and resi {row[0]} and resn lys)'
                cmd.color(colour2, sel1)
                
                sel1a = f'(chain {chain} and resi {row[0]} and name CA)'
                
                sel2  = f'(chain {partner} and resi {row[1]})'
                cmd.color(colour1, sel2)
                sel2  = f'(chain {partner} and resi {row[1]} and resn lys)'
                cmd.color(colour2, sel2)

                sel2a = f'(chain {partner} and resi {row[0]} and name CA)'
                
                # cmd.show(shape, sel1)
                # cmd.show(shape, sel2)
                cmd.distance(f'{chain}-{partner}-{row[0]}-{row[1]}', sel1a, sel2a)

def get_file():
    root = tk.Tk()
    root.withdraw()

    file_path = filedialog.askopenfilename()
    return file_path

file_path = get_file()
data = load_ms_data(file_path)
with open('d.json', 'w+') as f:
    json.dump(data, f)
show_pairs(data)
