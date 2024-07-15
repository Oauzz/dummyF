import json
import csv
import random
import string
import os
from datetime import datetime, timedelta

def random_string(length):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def random_date():
    start_date = datetime(2000, 1, 1)
    end_date = datetime(2023, 1, 1)
    return start_date + (end_date - start_date) * random.random()

def random_boolean():
    return random.choice([True, False])

def generate_random_data(column, foreign_key_data=None):
    col_type = column["type"]
    col_name = column["name"].strip('"')
    if foreign_key_data and col_name in foreign_key_data:
        return random.choice(foreign_key_data[col_name])
    if col_type == "character" or col_type.startswith("character("):
        length = 8 if col_type == "character" else int(col_type.split('(')[1].split(')')[0])
        return random_string(length)
    elif col_type == "integer" or col_type == "bigint":
        return random.randint(1, 1000)
    elif col_type == "double" or col_type == "numeric":
        return round(random.uniform(1.0, 1000.0), 2)
    elif col_type == "date":
        return random_date().strftime('%Y-%m-%d')
    elif col_type == "timestamp":
        return random_date().strftime('%Y-%m-%d %H:%M:%S')
    elif col_type == "boolean":
        return random_boolean()
    elif col_type == "geometry":
        return "POINT(0 0)"
    elif col_type == "text":
        return random_string(50)
    return None

def generate_csv_for_table(table_name, schema, num_rows=10, foreign_key_data=None):
    table_schema = schema[table_name]
    columns = table_schema["columns"]
    
    # Define the CSV file name
    csv_file = f"{csv_folder}/{table_name}.csv"
    
    # Open the CSV file for writing
    with open(csv_file, mode='w', newline='') as file:
        writer = csv.writer(file)
        
        # Write the header
        header = [col["name"].strip('"') for col in columns]
        writer.writerow(header)
        
        # Write the data rows
        for _ in range(num_rows):
            row = []
            for col in columns:
                row.append(generate_random_data(col, foreign_key_data))
            writer.writerow(row)

    print(f"Generated {csv_file} with {num_rows} rows.")

# Path to the JSON schema file
json_file_path = 'parsed_schema.json'

# Load the schema from the JSON file
with open(json_file_path, 'r') as file:
    schema = json.load(file)

# Read the order of creation from the text file
order_of_creation_path = 'table_creation_order.txt'
with open(order_of_creation_path, 'r') as file:
    order_of_creation = [line.strip() for line in file.readlines()]

# Create a folder to save the CSV files
csv_folder = "csv_files"
os.makedirs(csv_folder, exist_ok=True)

# Generate foreign key data to ensure referential integrity
foreign_key_data = {}

# Iterate over the tables in the order of creation and generate CSV files
for table_name in order_of_creation:
    generate_csv_for_table(table_name, schema, num_rows=10, foreign_key_data=foreign_key_data)
    table_schema = schema[table_name]
    for fk in table_schema.get("foreign_keys", []):
        ref_table = fk["ref_table"]
        for col, ref_col in zip(fk["columns"], fk["ref_columns"]):
            ref_csv_file = f"{csv_folder}/{ref_table}.csv"
            with open(ref_csv_file, 'r') as ref_file:
                ref_reader = csv.DictReader(ref_file)
                ref_data = [row[ref_col.strip('"')] for row in ref_reader]
                foreign_key_data[col.strip('"')] = ref_data

print(f"CSV files generated in folder: {csv_folder}")
