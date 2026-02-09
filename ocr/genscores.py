import os
import re
import pytesseract
from PIL import Image

pytesseract.pytesseract.tesseract_cmd = r'/usr/bin/tesseract'

IMAGE_DIRECTORY = './files'
SCORES_DIR = './scores'

for image in os.listdir(IMAGE_DIRECTORY):
    full_image_path=os.path.join(IMAGE_DIRECTORY, image)
    image = Image.open(full_image_path)

    base_name = os.path.basename(full_image_path)
    date_part = base_name.split('_')[1]
    formatted_date = date_part.replace('-','_')
    scoresfilename = f"{formatted_date}.txt"

    full_score_path=os.path.join(SCORES_DIR, scoresfilename)
    gray_image = image.convert('L')
    text = pytesseract.image_to_string(gray_image)
    lines = text.splitlines()

    with open(full_score_path, 'a') as score_file:
        for line in lines:
            if (line.lower().startswith(('jeremy','angela','rod','donna','ronda','elise','gunnar','steve','carol')) and ':' not in line):
                if re.search(r'\d+$', line):
                    print(line.lower(), file=score_file)
