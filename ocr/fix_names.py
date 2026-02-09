import os

directory = './files'

for filename in os.listdir(directory):
    if filename.startswith("Screenshot") and filename.endswith(".png"):
        new_filename = filename.replace(' ','_')

        original_file = os.path.join(directory, filename)
        new_file = os.path.join(directory, new_filename)
        os.rename(original_file, new_file)

        print(f'Renamed: {filename} to {new_filename}')
