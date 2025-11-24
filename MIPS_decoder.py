import tkinter as tk
from tkinter import filedialog as openFile
import re

instTypes = {
    'typeI' : {
        'ADDI' : {'op' : '001100', 'smt' : '00000', 'function' : '100000'},
        'ADDIU' : {'op' : '001001', 'smt' : '00000', 'function' : '100000'},
        'LW' : {'op' : '100011', 'smt' : '00000', 'function' : '100000'},
        'SW' : {'op' : '101011', 'smt' : '00000', 'function' : '100000'},
        'SLTI' : {'op' : '001010', 'smt' : '00000', 'function' : '100000'},
        'LBU' : {'op' : '100100', 'smt' : '00000', 'function' : '100000'},
        'ALL' : {'op' : '000000', 'smt' : '00000', 'function' : '100000'},
    },
    'typeR' : {
        'ADD' : {'op' : '000000', 'smt' : '00000', 'function' : '100000'},
        'ADDU' : {'op' : '000000', 'smt' : '00000', 'function' : '100001'},
        'SUB' : {'op' : '000000', 'smt' : '00000', 'function' : '100010'},
        'SUBU' : {'op' : '000000', 'smt' : '00000', 'function' : '100011'},
        'AND' : {'op' : '000000', 'smt' : '00000', 'function' : '100100'},
        'OR' : {'op' : '000000', 'smt' : '00000', 'function' : '100101'},
        'NOR' : {'op' : '000000', 'smt' : '00000', 'function' : '100111'},
        'SLT' : {'op' : '000000', 'smt' : '00000', 'function' : '101010'},
        'SLTU' : {'op' : '000000', 'smt' : '00000', 'function' : '101011'}
    },
    'typeJ' : {
        'J' : {'op' : '000010', 'smt' : '00000', 'function' : '100000', 'rt' : '00000', 'rs' : '00000' },
        'JAL' : {'op' : '000011', 'smt' : '00000', 'function' : '100000', 'rt' : '00000', 'rs' : '00000' }
    }   
}


class mainBlock:
    def __init__(self):
        self.decodedOP = 0
        self.decodedRS = 0
        self.decodedRD = 0
        self.decodedRT = 0
        self.decodedSmt = 0
        self.decodedFunction = 0
        self.root = tk.Tk()
        self.root.title('DECODIFICADOR')
        self.root.geometry('800x700')
        
        # self.checkBoxState = tk.BooleanVar()
        # self.checkBox = tk.Checkbutton(self.root, text='CheckBox', font=('Arial', 12), variable=self.checkBoxState)
        # self.checkBox.pack()
        
        self.fileLabel = tk.Label(self.root, text=('Archivo no seleccionado'), font=('Arial', 12))
        self.fileLabel.pack()
        
        self.searchButton = tk.Button(self.root, text=('Abrir archivo'), font=('Arial', 12), command=self.searchFile)
        self.searchButton.pack()
        
        self.fileContent = tk.Text(self.root, wrap='word', font=('Arial', 12), width=50, height=15)
        self.fileContent.pack(padx=200, pady=10, anchor=tk.E, side=tk.RIGHT)
        
        self.decodeButton = tk.Button(self.root, text=('Decodificar'), font=('Arial', 12), command=self.decodeFromEditor)
        self.decodeButton.pack()
        
        self.decodedContent = tk.Text(self.root, wrap='word', font=('Arial', 12), width=50, height=15)
        self.decodedContent.pack(padx=200, pady=10)
        
        self.root.mainloop()     
        
    def codeToBinary(self, currentCode):
            binaryCode = bin(int(currentCode))[2:]
            while len(binaryCode) < 5:
                binaryCode = '0' + binaryCode
            return binaryCode
        
    def setRType(self, clean_line, inst_key):
        self.decodedOP = instTypes['typeR'].get(inst_key, {}).get('op', 'Unknown')
        self.decodedSmt = instTypes['typeR'].get(inst_key, {}).get('smt', 'unknown')
        self.decodedFunction = instTypes['typeR'].get(inst_key, {}).get('function', 'unknown')
        self.decodedRT = clean_line.split('$')[3].strip()
        self.decodedRD = re.split(r'[$]+', clean_line)[1].strip()
        self.decodedRS = clean_line.split('$')[2].strip()
        self.decodedRD = self.codeToBinary(self.decodedRD)
        self.decodedRS = self.codeToBinary(self.decodedRS)
        self.decodedRT = self.codeToBinary(self.decodedRT)
        
    def setIType(self, clean_line, inst_key):
        self.decodedOP = instTypes['typeI'].get(inst_key, {}).get('op', 'Unknown')
        self.decodedSmt = instTypes['typeI'].get(inst_key, {}).get('smt', 'unknown')
        self.decodedFunction = instTypes['typeI'].get(inst_key, {}).get('function', 'unknown')
        self.decodedRS = re.split(r'[$#]+', clean_line)[2].strip()
        self.decodedRT = re.split(r'[$#]+', clean_line)[3].strip()
        self.decodedRD = re.split(r'[$#]+', clean_line)[1].strip()
        self.decodedRD = self.codeToBinary(self.decodedRD)
        self.decodedRS = self.codeToBinary(self.decodedRS)
        self.decodedRT = self.codeToBinary(self.decodedRT)
        
    def setJType(self, clean_line, inst_key):
        self.decodedOP = instTypes['typeJ'].get(inst_key, {}).get('op', 'unknown')
        self.decodedSmt = instTypes['typeJ'].get(inst_key, {}).get('smt', 'unknown')
        self.decodedFunction = instTypes['typeJ'].get(inst_key, {}).get('function', 'unknown')
        self.decodedRS = instTypes['typeJ'].get(inst_key, {}).get('rs', 'unknown')
        self.decodedRT = instTypes['typeJ'].get(inst_key, {}).get('rt', 'unknown')
        self.decodedRD = re.split(r'[#]+', clean_line)[1].strip()
        self.decodedRD = self.codeToBinary(self.decodedRD)
        
    def decodeFromEditor(self):
        rFormat = r"^[A-Z ]+\$[\d ]+\$[\d ]+\$[\d ]+"
        iFormat = r"^[A-Z ]+\$[\d ]+\$[\d ]+\#[\d ]+"
        jFormat = r"^[A-Z ]+\#[\d ]+"
        full_text = self.fileContent.get('1.0', tk.END)
        self.decodedContent.delete(1.0, tk.END)
        lines = full_text.splitlines()
        if lines:
            try:
                for currentLine in lines:
                    cleanLine = currentLine.strip()
                    if re.fullmatch(rFormat, cleanLine):
                        instKey = cleanLine.split('$')[0].strip()
                        self.setRType(cleanLine, instKey)
                    elif re.fullmatch(iFormat, cleanLine):
                        instKey = cleanLine.split('$')[0].strip()
                        self.setIType(cleanLine, instKey)
                    elif re.fullmatch(jFormat, cleanLine):
                        instKey = re.split(r'[#]+', cleanLine)[0].strip()
                        self.setJType(cleanLine, instKey)
                    else:
                        self.decodedContent.insert(tk.END, f'Error: Formato invalido')
                        return
                    self.decodedContent.insert(tk.END, f'{self.decodedOP} {self.decodedRS} {self.decodedRT} {self.decodedRD} {self.decodedSmt} {self.decodedFunction}\n')
            except Exception as e:
                self.decodedContent.insert(tk.END, f'Error decoding: {e}')
    
    def decodeFromFile(self, filename):
        rFormat = r"^[A-Z ]+\$[\d ]+\$[\d ]+\$[\d ]+"
        iFormat = r"^[A-Z ]+\$[\d ]+\$[\d ]+\#[\d ]+"
        jFormat = r"^[A-Z ]+\#[\d ]+"
        if filename:
            try:
                with open(filename, 'r', encoding='utf-8') as file:
                    self.decodedContent.delete(1.0, tk.END)
                    self.fileContent.delete(1.0, tk.END)
                    for line in file:
                        clean_line = line.strip() 
                        if re.fullmatch(rFormat, clean_line):
                            inst_key = clean_line.split('$')[0].strip()
                            self.setRType(clean_line, inst_key)
                        elif re.fullmatch(iFormat, clean_line):
                            inst_key = clean_line.split('$')[0].strip()
                            self.setIType(clean_line, inst_key)
                        elif re.fullmatch(jFormat, clean_line):
                            inst_key = re.split(r'[#]+', clean_line)[0].strip()
                            self.setJType(clean_line, inst_key)
                        self.fileContent.insert(tk.END, line) 
                        self.decodedContent.insert(tk.END, f'{self.decodedOP} {self.decodedRS} {self.decodedRT} {self.decodedRD} {self.decodedSmt} {self.decodedFunction}\n')
            except Exception as e:
                self.fileContent.insert(tk.END, f'Error reading the file: {e}')
    
    def searchFile(self):
        filename = openFile.askopenfilename(initialdir = "/", title = "Select a File", filetypes = (("Text file", "*.txt"), ("all files", "*.*")))
        self.fileLabel.configure(text='Archivo seleccionado: ' + filename)
        self.decodeFromFile(filename)
        

mainBlock()