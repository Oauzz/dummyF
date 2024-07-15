import re
import json

def parse_sql_to_json(sql_file):
    with open(sql_file, 'r') as file:
        sql_content = file.read()

    table_pattern = re.compile(r'CREATE TABLE ("?[a-zA-Z_][a-zA-Z0-9_]*"?) \((.*?)\);', re.DOTALL)
    sequence_pattern = re.compile(r'CREATE SEQUENCE (.*?);', re.DOTALL)
    alter_table_pattern = re.compile(r'ALTER TABLE ONLY ("?[a-zA-Z_][a-zA-Z0-9_]*"?)(.*?);', re.DOTALL)

    tables = {}
    sequences = {}

    # Parse tables
    for match in table_pattern.finditer(sql_content):
        table_name, table_body = match.groups()
        columns = []
        primary_key = []
        unique = []
        foreign_keys = []
        checks = []

        for line in table_body.split('\n'):
            line = line.strip().strip(',')
            if line.startswith('CONSTRAINT'):
                if 'PRIMARY KEY' in line:
                    pk_columns = re.findall(r'\((.*?)\)', line)
                    if pk_columns:
                        primary_key = pk_columns[0].split(', ')
                elif 'UNIQUE' in line:
                    unique_columns = re.findall(r'\((.*?)\)', line)
                    if unique_columns:
                        unique.append(unique_columns[0].split(', '))
                elif 'FOREIGN KEY' in line:
                    fk_match = re.search(r'FOREIGN KEY \((.*?)\) REFERENCES ("?[a-zA-Z_][a-zA-Z0-9_]*"?)\((.*?)\)', line)
                    if fk_match:
                        fk_columns, ref_table, ref_columns = fk_match.groups()
                        foreign_keys.append({
                            "columns": fk_columns.split(', '),
                            "ref_table": ref_table,
                            "ref_columns": ref_columns.split(', ')
                        })
                elif 'CHECK' in line:
                    check_expression = re.search(r'CHECK \((.*?)\)', line)
                    if check_expression:
                        checks.append({
                            "expression": check_expression.group(1)
                        })
            else:
                column_match = re.match(r'"?([a-zA-Z_][a-zA-Z0-9_]*)"? (.*)', line)
                if column_match:
                    column_name, column_def = column_match.groups()
                    col_type = column_def.split(' ')[0]
                    nullable = 'NOT NULL' not in column_def
                    default = re.search(r'DEFAULT (.*?)(?: |,|$)', column_def)
                    columns.append({
                        "name": column_name,
                        "type": col_type,
                        "nullable": nullable,
                        "default": default.group(1) if default else None
                    })

        tables[table_name.strip('"')] = {
            "columns": columns,
            "primary_key": primary_key,
            "unique": unique,
            "foreign_keys": foreign_keys,
            "checks": checks
        }

    # Parse sequences
    for match in sequence_pattern.finditer(sql_content):
        sequence_name = match.group(1).strip('"')
        sequences[sequence_name] = {}

    # Parse ALTER TABLE constraints
    for match in alter_table_pattern.finditer(sql_content):
        table_name, alter_body = match.groups()
        table_name = table_name.strip('"')
        if 'ADD CONSTRAINT' in alter_body:
            if 'PRIMARY KEY' in alter_body:
                pk_columns = re.findall(r'\((.*?)\)', alter_body)
                if pk_columns:
                    tables[table_name]["primary_key"] = pk_columns[0].split(', ')
            elif 'UNIQUE' in alter_body:
                unique_columns = re.findall(r'\((.*?)\)', alter_body)
                if unique_columns:
                    tables[table_name]["unique"].append(unique_columns[0].split(', '))
            elif 'FOREIGN KEY' in alter_body:
                fk_match = re.search(r'FOREIGN KEY \((.*?)\) REFERENCES ("?[a-zA-Z_][a-zA-Z0-9_]*"?)\((.*?)\)', alter_body)
                if fk_match:
                    fk_columns, ref_table, ref_columns = fk_match.groups()
                    tables[table_name]["foreign_keys"].append({
                        "columns": fk_columns.split(', '),
                        "ref_table": ref_table.strip('"'),
                        "ref_columns": ref_columns.split(', ')
                    })
            elif 'CHECK' in alter_body:
                check_expression = re.search(r'CHECK \((.*?)\)', alter_body)
                if check_expression:
                    tables[table_name]["checks"].append({
                        "expression": check_expression.group(1)
                    })

    return tables, sequences

def main():
    sql_file = 'extracted_schema.sql'
    tables, sequences = parse_sql_to_json(sql_file)

    with open('parsed_schema.json', 'w') as json_file:
        json.dump(tables, json_file, indent=4)

    with open('parsed_sequences.json', 'w') as json_file:
        json.dump(sequences, json_file, indent=4)

    print("JSON files generated successfully.")

if __name__ == "__main__":
    main()
