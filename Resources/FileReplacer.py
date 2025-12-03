import shutil
import os
import sys

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


source_file = sys.argv[1]
destination_file = sys.argv[2]

# Option 1: Copy and replace (keeping the original source file)
shutil.copy(source_file, destination_file) 
# shutil.copy2 preserves metadata like creation/modification times

# Option 2: Move and replace (deleting the original source file)
# os.replace() is a more robust way to move/rename and replace
#os.replace(source_file, destination_file) 

print("Arquivo Rodado!")