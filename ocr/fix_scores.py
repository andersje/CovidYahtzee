import os

directory = './scores'

for filename in os.listdir(directory):
    if filename.endswith(".txt"): 
        new_filename = filename.replace('txt','score')

        original_file = os.path.join(directory, filename)
        new_file = os.path.join(directory, new_filename)
        os.rename(original_file, new_file)

        print(f'Renamed: {filename} to {new_filename}')
