from translate import Translator
import os, sys
import csv

# This is only a test. Integrate into csv processor functions
translator = Translator(to_lang="es")
translation = translator.translate("This is a pen.")


# Make this a translator for "cat" commands (Read CSV and Write it again into another CSV)
with open('csv_dummy.csv', 'r') as csv_file:
    counter = 0
    for line in csv_file:
        #line = translator.translate(line)
        counter += 1
        print(len(line)) # Should be an array
        print(line)

# Open new csv file for writing
def csv_write(filename):
    # https://www.geeksforgeeks.org/writing-csv-files-in-python/
    with open('dummy_csv_output.csv','w') as out_file:
        CSV_WRITER = csv.writer(out_file)
