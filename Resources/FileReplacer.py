import shutil
import os
import sys
import requests


def process_arguments(args):
    """Processes command-line arguments."""
    if len(args) > 1:
        print(f"Script name: {args[0]}")
        print("Arguments received:")
        for i, arg in enumerate(args[1:]):
            print(f"  Argument {i+1}: {arg}")
    else:
        print("No arguments provided.")

if __name__ == "__main__":
    process_arguments(sys.argv)

tag = str(sys.argv[1])
tag = str(tag)
# The URL you want to make a GET request to
url = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + tag

# Send the GET request and store the response
response = requests.get(url)

# Salva o conteúdo da resposta como png
qrCodePath = str("C:\\qax\\projects\\maui\\QRCode\\" + tag + ".png")
with open(qrCodePath , "wb") as f:
    f.write(response.content) 


source_file = qrCodePath
destination_file = 'C:\\Users\\victor.faria\\AppData\\Local\\Android\\Sdk\\emulator\\resources\\poster.png'

# Option 1: Copy and replace (keeping the original source file)
shutil.copy(source_file, destination_file) 
# shutil.copy2 preserves metadata like creation/modification times

# Option 2: Move and replace (deleting the original source file)
# os.replace() is a more robust way to move/rename and replace
#os.replace(source_file, destination_file) 

print("Arquivo Rodado!")