
import pandas as pd
import matplotlib.pyplot as plt
import pickle
import numpy as np

def convert_xlsx(filename='temp', path='/', fda=0.01):
    df = pd.read_excel(path+filename+'.xlsx')
    Linked_A = df[df.columns[0]]
    Linked_B = df[df.columns[1]]
    assert len(Linked_A) == len(Linked_B)
    mod_a = 0
    if filename[:4] == 'GCN5':
        mod_a = 25

    mod_b = 0
    if filename[5:9] == 'GCN5':
        mod_b = 25

    n = len(Linked_A)
    links = []
    for i in range(n):
        links.append((int(Linked_A[i])-mod_a, int(Linked_B[i])-mod_b, fda))
   
    return links

def process_pairwise_MS(path='data/', ms_dict_out='ms_G_3_S_2_linked.pkl'):
    Subunits = ['GCN5', 'ADA3', 'SGF29', 'ADA2B']
    Subunit_token = ['A', 'B', 'C', 'D']

    MS_links = {}
    for i, subunit_a in enumerate(Subunits):
        MS_links[Subunit_token[i]] = {}
        for j in range(len(Subunits)-i):
            subunit_b = Subunits[i+j]            
            if subunit_a == 'SGF29' and subunit_b == 'ADA2B':
               pass
            else:   
                MS_links[Subunit_token[i]][Subunit_token[i+j]] = convert_xlsx(subunit_a+'-'+subunit_b,path)
   
    with open(ms_dict_out, 'wb') as f:
        pickle.dump(MS_links, f)

def process_df(path='data/', ms_dict_out='ms_linked.pkl'):
    Subunits = ['GCN5', 'ADA3', 'SGF29', 'ADA2B']
    Subunit_token = ['A', 'B', 'C', 'D']

    df = pd.DataFrame(columns=['P1-P2', 'C1-C2', 'K1', 'K2', 'Precision'])
    count = 1
    for i, subunit_a in enumerate(Subunits):
        for j in range(len(Subunits)-i):
            subunit_b = Subunits[i+j]            
            if subunit_a == 'SGF29' and subunit_b == 'ADA2B':
                pass
            else:   
                data = pd.read_excel(path+subunit_a+'-'+subunit_b+'.xlsx')
                for k in range(len(data)):
                    df.loc[count] = [subunit_a+'-'+subunit_b, Subunit_token[i]+'-'+Subunit_token[i+j], data.iloc[k][0], data.iloc[k][1], data.iloc[k][7]]
                    count += 1
    
    df.to_csv('output.csv')
    counts, bins = np.histogram(df['Precision'])
    
if __name__ == '__main__':
    process_pairwise_MS()
    process_df()