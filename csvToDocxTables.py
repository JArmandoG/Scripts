from csv import DictReader
from docx.shared import Pt
import docx

# Valores para el estilo y archivo .csv para procesar
font_name = 'Helvetica'
font_size = 12
file_name = '' # CSV FILE
save_file = '' # NOMBRE Y/O PATH - DOCX GENERADO (OUTPUT)

def generate_report():
    doc = docx.Document() # Prepara doc como objeto iterable
    with open(file_name, 'r') as csv_file:
        reader_dump = DictReader(csv_file) # Objeto iterable; todavía no es dict
        for my_dict in reader_dump: # Por cada iteración es un dict

            # Generación de tabla y estilos en cada iteración
            table = doc.add_table(rows=10, cols=2)
            style = doc.styles['Normal']
            font = style.font
            font.name = font_name
            font.size = Pt(font_size)
            
            ''' Inline list comprehension (No utilizado)
            keys = [x for x in my_dict.keys()] # Dump KEYS array
            values = [x for x in my_dict.values()] # Dump VALUES array
            '''
            
            '''
            Utilizar DictReader(csv_file).fieldnames para
            visualizar los headers a extraer
            '''
            # Columna izquierda: String values
            table.cell(0,0).text = "Region"
            # Columna derecha: CSV Fieldnames
            table.cell(0,1).text = my_dict['REGION']

            table.cell(0,2).text = "Severity"
            table.cell(0,3).text = my_dict['CHECK_SEVERITY']
            
            table.cell(0,4).text = "Result"
            table.cell(0,5).text = my_dict['CHECK_RESULT']

            table.cell(0,6).text = "Resource ID"
            table.cell(0,7).text = my_dict['CHECK_RESOURCE_ID']

            table.cell(0,8).text = "Description"
            table.cell(0,9).text = my_dict['TITLE_TEXT']

            table.cell(0,10).text = "Finding"
            table.cell(0,11).text = my_dict['CHECK_RESULT_EXTENDED']

            table.cell(0,12).text = "Associated Risk"
            table.cell(0,13).text = my_dict['CHECK_RISK']

            table.cell(0,14).text = "Remediation"
            table.cell(0,15).text = my_dict['CHECK_REMEDIATION']

            table.cell(0,16).text = "AWS Documentation URL"
            table.cell(0,17).text = my_dict['CHECK_DOC']

            table.cell(0,18).text = "" # Espacio en blanco entre iteraciones
            table.cell(0,19).text = "" # Espacio en blanco entre iteraciones

        # Salva toda la información guardada en doc.add_table() \ 
        # al objeto docx.Document(), en el documento con el nombre $save_file
        doc.save(save_file)

generate_report()
