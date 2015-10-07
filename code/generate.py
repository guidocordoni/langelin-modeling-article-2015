##############
###GENERATOR
##############


import random
import string

def setp():
    r = random.random()
    if r < 0.5:
        return "-"
    else:
        return "+"

def generator():
        P = range(76)
        P[0] = "Lang"
        #P1-FGM
        P[1] = setp()
        #P2-FGP
        if P[1] == "+":
            P[2] = setp()
        else:
            P[2] = '0'
        #P3-FGN
        if P[2] == "+":
            P[3] = setp()
        else:
            P[3] = '0'
        #P4-GCO
        if P[3] != "+":
            P[4] = setp()
        else:
            P[4] = '0'
        #P5-FGG
        #P6-NOD
        if P[2] == "+":
            P[5] = setp()
            P[6] = setp()
        else:
            P[5] = '0'
            P[6] = '0'
        #P7-FSN
        if P[3] == "+" or P[4] == "+" and P[6] == "-":
            P[7] = setp()
        else:
            P[7] = '0'
        #P8-FNN
        if P[7] == "+":
            P[8] = setp()
        else:
            P[8] = '0'
        #P9-CGB
        P[9] = setp()
        #P10-FIN
        if P[9] == "+":
            P[10] = setp()
        else:
            P[10] = '0'
        #P11-DGR
        if P[2] == "+":
            P[11] = setp()
        else:
            P[11] = '0'
        #P12-CGR
        if P[9] == "-" and P[11] == "+" and P[8] != "-":
            P[12] = setp()
        else:
            P[12] = '0'
        #P13-NSD
        if P[11] == "+" or (P[3] == "+" and P[7] != "+"):
            P[13] = setp()
        else:
            P[13] = '0'
        #P14-DPQ
        if P[8] == "+" and P[9] != "+":
            P[14] = setp()
        else:
            P[14] = '0'
        #P15-DCN
        if P[11] == "+" or (P[3] == "+" and P[7] != "+"):
            P[15] = setp()
        else:
            P[15] = '0'
        #P16-DOR
        if P[11] == "+":
            P[16] = setp()
        else:
            P[16] = '0'
        #P17-DIN
        if P[7] == "+":
            P[17] = setp()
        else:
            P[17] = '0'
        #P18-CPS
        if P[7] == "+" and P[4] != "+":
            P[18] = setp()
        else:
            P[18] = '0'
        #19-NPA
        if P[3] == "+" and P[9] == "+":
            P[19] = setp()
        else:
            P[19] = '0'
        #20-BAT
        if P[19] == "+" and P[11] == "-":
            P[20] = setp()
        else:
            P[20] = '0'
        #21-FGC
        if P[20] != "+":
            P[21] = setp()
        else:
            P[21] = '0'
        #22-GBC
        if P[21] == "+":
            P[22] = setp()
        else:
            P[22] = '0'
        #23-IBC
        if P[22] == "+":
            P[23] = setp()
        else:
            P[23] = '0'
        #24-CCN
        if P[19] == "+":
            P[24] = setp()
        else:
            P[24] = "0"
        #P25-DNN
        if P[15] == "-" and P[13] == "+":
            P[25] = setp()
        else:
            P[25] = "0"
        #P26-FGT
        P[26] = setp()
        #P27-DGP
        if P[11] != "+":
            P[27] = setp()
        else:
            P[27] = '0'
        #P28-TCL
        if P[20] == "+":
            P[28] = setp()
        else:
            P[28] = '0'
        #P29-TPL
        if P[28] != "+":
            P[29] = setp()
        else:
            P[29] = '0'
        #P30-TSL
        if P[29] == "+":
            P[30] = setp()
        else:
            P[30] = '0'
        #31-TAD
        if P[29] == "-" or P[30] == "-":
            P[31] = setp()
        else:
            P[31] = '0'
        #32-TSP
        if (P[3] == "+" and P[7] != "+") or P[11] == "+" and P[29] == "+" or (P[12] == "-" and P[31] == "+"):
            P[32] = setp()
        else:
            P[32] = '0'
        #33-TDL
        if P[29] == "+":
            P[33] = setp()
        else:
            P[33] = '0'
        #34-ELI
        P[34] = setp()
        #P35-AST
        P[35] = setp()
        #P36-FFS
        if P[7] == "+" and P[35] == "+":
            P[36] = setp()
        else:
            P[36] = '0'
        #P37-FSP
        if P[3] == '+' or P[4] == "+":
            P[37] = setp()
        else:
            P[37] = '0'
        #P38-ADI
        if P[13] == '-' and P[36] == '+':
            P[38] = setp()
        else:
            P[38] = '0'
        #P39-ADR
        P[39] = setp()
        #P40-AER
        if P[39] == '-':
            P[40] = setp()
        else:
            P[40] = '0'
        #P41-ARR and P42-NPP
        if P[35] == '+':
            P[41] = setp()
            P[42] = setp()
        else:
            P[41] = '0'
            P[42] = '0'
        #P43-NOC
        P[43] = setp()
        #P44-NOO
        if P[43] == "-":
            P[44] = setp()
        else:
            P[44] = '0'
        #P45-NM1
        if P[44] == "-" and P[42] == '-':
            P[45] = setp()
        else:
            P[45] = '0'
        #P46-NM2
        if P[45] == '-':
            P[46] = setp()
        else:
            P[46] = '0'
        #P47-NOA
        if P[46] == '-':
            P[47] = setp()
        else:
            P[47] = '0'
        #P48-GCN
        P[48] = setp()
        #P49-GFN
        if P[2] == "+" and P[48] == "+":
            P[49] = setp()
        else:
            P[49] = setp()
        #P50-GAL
        P[50] = setp()
        #P51-GUN
        if P[49] != "+":
            P[51] = setp()
        else:
            P[51] = '0'
        #P52-GFS
        if P[13] != "+" and P[51] == "-":
            P[52] = setp()
        else:
            P[52] = '0'
        #P53-GFR
        if P[51] == "-":
            P[53] = setp()
        else:
            P[53] = '0'
        #P54-GFO
        if P[51] != "+" and P[50] == "-" or P[49] != "+":
            P[54] = setp()
        else:
            P[54] = '0'
        #P55-GPR
        if P[39] == "+":
            P[55] = setp()
        else:
            P[55] = '0'
        #56-EZ1
        P[56] = setp()
        #P57-EZ2
        if P[56] == '-':
            P[57] = setp()
        else:
            P[57] = '0'
        #P58-EZ3
        if P[56] == "-" and P[57] != "+":
            P[58] = setp()
        else:
            P[58] = '0'
        #P59-DMP
        if P[15] == "+":
            P[59] = setp()
        else:
            P[59] = '0'
        #P60-DMG
        if P[59] == "+":
            P[60] = setp()
        else:
            P[60] = '0'
        #P61-HGI
        if P[48] == "+" or P[60] == "+" and P[57] == "-":
            P[61] = setp()
        else:
            P[61] = '0'
        #P62-GSI
        P[62] = setp()
        #P63-GST
        if P[62] == "+":
            P[63] = setp()
        else:
            P[63] = '0'
        #P64-GEI
        if P[49] == "+":
            P[64] = setp()
        else:
            P[64] = '0'
        #P65-NGO
        if P[54] != '-' and P[47] == '-' or P[35] == "-" and P[50] == "-" or P[49] != "+":
            P[65] = setp()
        else:
            P[65] = '0'
        #P66-NOE
        if P[65] == '-' or (P[54] != "+" and P[47] == "-" or P[35] == "-"):
            P[66] = setp()
        else:
            P[66] = '0'
        #P67-AFM
        if P[35] == "+" and P[65] == "+":
            P[67] = setp()
        else:
            P[67] = '0'
        #P68-ACM
        if P[67] == "-":
            P[68] = setp()
        else:
            P[68] = '0'
        #P69-DOA
        if (P[13] == "+" and (P[41] == "+" or P[15] == "+" or P[67] == "+" or P[68] == "+")) or (P[15] == "+" and P[12] == "+"):
            P[69] = setp()
        else:
            P[69] = '0'
        #P70-ACP
        if P[35] == "+" and (P[45] == "-" and P[39] == "+") or (P[42] == "+" or P[46] != "-" and P[39] == "-"):
            P[70] = setp()
        else:
            P[70] = '0'
        #P71-NCL
        P[71] = setp()
        #P72-APO
        if P[49] != "+":
            P[72] = setp()
        else:
            P[72] = '0'
        #P73-AGE
        if P[72] == "+":
            P[73] = setp()
        else:
            P[73] = '0'
        #P74-PDC
        if P[11] == "+" and P[13] == "+" or P[12] != "+" and P[49] != "+":
            P[74] = setp()
        else:
            P[74] = '0'
        #75-ACL
        if P[35] == "+" and P[72] == "-" and P[11] != "+" or P[74] == "-" and P[59] != "+":
            P[75] = setp()
        else:
            P[75] = '0'
        return P



generator(1000)



##################################################################################
):
            dif = dif + 1
    dist = dif / (dif + id)
    return dist

#generate X languages
def distance(number):
    random_sample = []
    for i in range(number):
        lang = generator()
        random_sample.append(lang)
    final_dist=[]
    for i in range(len(random_sample)):
    #remove from the sample the ith string
        p0 = random_sample.pop(i)
        for j in range(len(random_sample)):
    #calculate the distance from the removed string and all the others
            dist = jaccard(p0, random_sample[j])
            dist_round=round(dist, 3)
            final_dist.append(dist_round)
        #put the string back
        random_sample.insert(i, p0)
    return final_dist

#biggest problem= distances are repeated 2 times
