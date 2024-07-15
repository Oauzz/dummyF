import re

def extract_entities(schema_content):
    tables = []
    sequences = []
    alter_table_statements = []

    # Regular expressions to match the entities
    table_regex = re.compile(r'CREATE TABLE.*?;', re.DOTALL | re.IGNORECASE)
    sequence_regex = re.compile(r'CREATE SEQUENCE.*?;', re.DOTALL | re.IGNORECASE)
    alter_table_regex = re.compile(r'ALTER TABLE.*?;', re.DOTALL | re.IGNORECASE)

    # Find all matches
    tables = table_regex.findall(schema_content)
    sequences = sequence_regex.findall(schema_content)
    alter_table_statements = alter_table_regex.findall(schema_content)

    return tables, sequences, alter_table_statements

# Load the schema content from the uploaded file
schema_file_path = 'schema.sql'
with open(schema_file_path, 'r') as file:
    schema_content = file.read()

# Extract entities from the schema content
tables, sequences, alter_table_statements = extract_entities(schema_content)

# Write the extracted entities to a new SQL file
extracted_file_path = 'extracted_schema.sql'
with open(extracted_file_path, 'w') as file:
    file.write('-- Extracted Tables\n')
    for table in tables:
        file.write(table + '\n\n')

    file.write('-- Extracted Sequences\n')
    for sequence in sequences:
        file.write(sequence + '\n\n')

    file.write('-- Extracted ALTER TABLE Statements\n')
    for alter_statement in alter_table_statements:
        file.write(alter_statement + '\n\n')

extracted_file_path
