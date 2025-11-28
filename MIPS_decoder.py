import tkinter as tk
from tkinter import filedialog as openFile
import re
from tkinter import messagebox
from tkinter import filedialog

# --- Instruction Definitions ---
instTypes = {
    'typeI' : {
        'ADDI' : {'op' : '001100', 'smt' : '00000', 'function' : '100000'},
        'ADDIU': {'op' : '001001', 'smt' : '00000', 'function' : '100000'},
        'LW'   : {'op' : '100011', 'smt' : '00000', 'function' : '100000'},
        'SW'   : {'op' : '101011', 'smt' : '00000', 'function' : '100000'},
        'SLTI' : {'op' : '001010', 'smt' : '00000', 'function' : '100000'},
        'LBU'  : {'op' : '100100', 'smt' : '00000', 'function' : '100000'},
        'BEQ'  : {'op' : '000100', 'smt' : '00000', 'function' : '100000'}, 
        'SB'   : {'op' : '101000', 'smt' : '00000', 'function' : '100000'},
    },
    'typeR' : {
        'ADD'  : {'op' : '000000', 'smt' : '00000', 'function' : '100000'},
        'ADDU' : {'op' : '000000', 'smt' : '00000', 'function' : '100001'},
        'SUB'  : {'op' : '000000', 'smt' : '00000', 'function' : '100010'},
        'SUBU' : {'op' : '000000', 'smt' : '00000', 'function' : '100011'},
        'AND'  : {'op' : '000000', 'smt' : '00000', 'function' : '100100'},
        'OR'   : {'op' : '000000', 'smt' : '00000', 'function' : '100101'},
        'NOR'  : {'op' : '000000', 'smt' : '00000', 'function' : '100111'},
        'SLT'  : {'op' : '000000', 'smt' : '00000', 'function' : '101010'},
        'SLTU' : {'op' : '000000', 'smt' : '00000', 'function' : '101011'},
        'SLL'  : {'op' : '000000', 'smt' : '00000', 'function' : '000000'},
    },
    'typeJ' : {
        'J'    : {'op' : '000010'},
        'JAL'  : {'op' : '000011'},
    }
}

class mainBlock:
    def __init__(self):
        self.binOP = ""
        self.binRS = ""
        self.binRT = ""
        self.binRD = ""
        self.binSMT = ""
        self.binFUNCT = ""
        self.binIMM = ""
        self.binADDR = ""
        self.finalLine = "" 

        self.root = tk.Tk()
        self.root.title('MIPS Assembler for Verilog')
        self.root.geometry('1100x700')
        
        self.fileLabel = tk.Label(self.root, text=('Seleccionar archivo...'), font=('Arial', 12))
        self.fileLabel.pack()
        self.fileLabel.place(x=10, y=10)
        
        self.searchButton = tk.Button(self.root, text=('Abrir archivo'), font=('Arial', 20),command=self.searchFile)
        self.searchButton.pack()
        self.searchButton.place(x=750, y=40, width=300, height=150)
        
        self.fileContent = tk.Text(self.root, wrap='word', font=('Consolas', 12), width=70, height=15)
        self.fileContent.pack(padx=20, pady=10)
        self.fileContent.place(x=10, y=40)
        
        self.decodeButton = tk.Button(self.root, text=('Convertir a binario'), font=('Arial', 20), command=self.decodeFromEditor)
        self.decodeButton.pack()
        self.decodeButton.place(x=750, y=280, width=300, height=150)
        
        self.decodedContent = tk.Text(self.root, wrap='word', font=('Consolas', 12), width=70, height=15, state='disabled')
        self.decodedContent.pack(padx=20, pady=10)
        self.decodedContent.place(x=10, y=380)
        
        self.writeFile = tk.Button(self.root, text=('Generar archivo'), font=('Arial', 20), command=self.createFile)
        self.writeFile.pack()
        self.writeFile.place(x=750, y=520, width=300, height=150)
        
        self.root.mainloop()     
        
        
    def createFile(self):
        full_text = self.decodedContent.get('1.0', tk.END)
        if (full_text == '\n'):
            messagebox.showerror('Error', 'Consola de binario vacia, convierta el valor deseado o abra un archivo antes de continuar')
            return
        
        file = filedialog.asksaveasfile(mode='w', defaultextension='.txt', filetypes=(('Text files', '*.txt'), ('All files', '*.*')))
        if file:
            lines = full_text.splitlines()
            for currentLine in lines:
                file.write(f'{currentLine}\n')
            file.close()
        else:
            messagebox.showerror('Error', 'Se produjo un error al guardar el archivo, favor de reintentar.')
            return
        
    def codeToBinary(self, currentCode, bits):
        try:
            val = int(currentCode)
            if val < 0:
                val = (1 << bits) + val
            binaryCode = format(val, f'0{bits}b')
            return binaryCode[-bits:] 
        except ValueError:
            return "0" * bits

    def setRType(self, clean_line, inst_key):
        parts = re.split(r'[$]+', clean_line)
        rd_val = parts[1].strip()
        rs_val = parts[2].strip()
        rt_val = parts[3].strip()
        self.binOP    = instTypes['typeR'].get(inst_key, {}).get('op', '000000')
        self.binRS    = self.codeToBinary(rs_val, 5)
        self.binRT    = self.codeToBinary(rt_val, 5)
        self.binRD    = self.codeToBinary(rd_val, 5)
        self.binSMT   = instTypes['typeR'].get(inst_key, {}).get('smt', '00000')
        self.binFUNCT = instTypes['typeR'].get(inst_key, {}).get('function', '000000')
        self.finalLine = f"{self.binOP}{self.binRS}{self.binRT}{self.binRD}{self.binSMT}{self.binFUNCT}"

    def setIType(self, clean_line, inst_key):
        parts = re.split(r'[$#]+', clean_line)
        rt_val = parts[1].strip()
        rs_val = parts[2].strip()
        imm_val = parts[3].strip()

        self.binOP  = instTypes['typeI'].get(inst_key, {}).get('op', '000000')
        self.binRS  = self.codeToBinary(rs_val, 5)
        self.binRT  = self.codeToBinary(rt_val, 5)
        self.binIMM = self.codeToBinary(imm_val, 16)
        self.finalLine = f"{self.binOP}{self.binRS}{self.binRT}{self.binIMM}"

    def setJType(self, clean_line, inst_key):
        parts = re.split(r'[#]+', clean_line)
        target_val = parts[1].strip()
        self.binOP   = instTypes['typeJ'].get(inst_key, {}).get('op', '000010')
        self.binADDR = self.codeToBinary(target_val, 26)
        self.finalLine = f"{self.binOP}{self.binADDR}"

    def processLine(self, line, validator):
        cleanLine = line.strip()
        rFormat = r"^[A-Z]+\s+\$[\d]+\s+\$[\d]+\s+\$[\d]+"
        iFormat = r"^[A-Z]+\s+\$[\d]+\s+\$[\d]+\s+\#[\-\d]+"
        jFormat = r"^[A-Z]+\s+\#[\-\d]+"
        
        if not cleanLine:
            return

        try:
            if re.match(rFormat, cleanLine):
                instKey = cleanLine.split('$')[0].strip()
                self.setRType(cleanLine, instKey)
                return self.finalLine
            
            elif re.match(iFormat, cleanLine):
                instKey = cleanLine.split('$')[0].strip()
                self.setIType(cleanLine, instKey)
                return self.finalLine
            
            elif re.match(jFormat, cleanLine):
                instKey = re.split(r'[#]+', cleanLine)[0].strip()
                self.setJType(cleanLine, instKey)
                return self.finalLine
            else:
                if (not validator):
                    messagebox.showerror('Error', f'Formato de instrucción en [{cleanLine}] invalido, el archivo ha sido ignorado.\nFavor de revisar el formato de archivo.')
                    self.fileContent.delete(1.0, tk.END)
                else:
                    messagebox.showerror('Error', f'Formato de instrucción en [{cleanLine}] invalido.\nFavor de revisar el formato de la linea indicada.')
                self.decodedContent.delete(1.0, tk.END)
                return
        except Exception as e:
            return f"ERROR: {e}"

    def decodeFromEditor(self):
        binaryTextConfig = self.decodedContent.cget('state')
        if (binaryTextConfig == 'disabled'):
            self.decodedContent.config(state='normal')
        
        full_text = self.fileContent.get('1.0', tk.END)
        if (full_text == '\n'):
            messagebox.showerror('Error', 'Consola de instrucciones vacia. Agrege instrucciones o abra un archivo antes de continuar')
            return
            
        self.decodedContent.delete(1.0, tk.END)
        lines = full_text.splitlines()
        
        for currentLine in lines:
            if currentLine.strip():
                validator = True
                result = self.processLine(currentLine, validator)
                self.decodedContent.insert(tk.END, result + '\n')
                
        self.decodedContent.config(state='disabled')
    
    def searchFile(self):
        binaryDecodedControl = self.decodedContent.cget('state')
        if (binaryDecodedControl == 'disabled'):
            self.decodedContent.config(state='normal')
            
        filename = openFile.askopenfilename(initialdir = "/", title = "Select a File", filetypes = (("Text file", "*.txt"), ("all files", "*.*")))
        if filename:
            self.fileLabel.configure(text='Selected: ' + filename)
            with open(filename, 'r', encoding='utf-8') as file:
                self.fileContent.delete(1.0, tk.END)
                self.decodedContent.delete(1.0, tk.END)
                
                content = file.read()
                if (content == ''):
                    messagebox.showerror('Error', 'El archivo que seleccionó está vacio. Verifique su selección.')
                    return
                    
                self.fileContent.insert(tk.END, content)

                lines = content.splitlines()
                for line in lines:
                    if line.strip():
                        validator = False
                        result = self.processLine(line, validator)
                        self.decodedContent.insert(tk.END, result + '\n')
                        
        self.decodedContent.config(state='disabled')

mainBlock()