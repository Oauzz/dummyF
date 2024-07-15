import psycopg2
import os
import csv
import logging

logging.basicConfig(level=logging.INFO)

def correct_headers(cursor, table_name, headers):
    # Fetch table columns from the database
    cursor.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name='{table_name}'")
    table_columns = [row[0] for row in cursor.fetchall()]
    corrected_headers = []
    for header in headers:
        if header.lower() in table_columns:
            corrected_headers.append(header.lower())
        else:
            corrected_headers.append(header)
    return corrected_headers

def import_csv_to_db(cursor, table_name, csv_file):
    with open(csv_file, 'r') as file:
        reader = csv.reader(file)
        headers = next(reader)
        
        # Correct headers to match the database columns
        headers = correct_headers(cursor, table_name, headers)
        
        # Log the correction process
        logging.info(f"Corrected headers for {table_name}: {headers}")

        # Insert data
        for row in reader:
            cursor.execute(
                f'INSERT INTO "{table_name}" ({", ".join(headers)}) VALUES ({", ".join(["%s"] * len(headers))})',
                row
            )

def run_import(dbname, user, password, host, port, csv_folder):
    try:
        conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
        cursor = conn.cursor()

        # Read the order of creation from the text file
        order_of_creation_path = 'table_creation_order.txt'
        with open(order_of_creation_path, 'r') as file:
            order_of_creation = [line.strip() for line in file.readlines()]

        for table_name in order_of_creation:
            csv_file = f"{csv_folder}/{table_name}.csv"
            if os.path.exists(csv_file):
                try:
                    import_csv_to_db(cursor, table_name, csv_file)
                    conn.commit()
                    logging.info(f"Data imported into {table_name} from {csv_file}")
                except Exception as e:
                    conn.rollback()
                    logging.error(f"Error importing {table_name} from {csv_file}: {e}")
            else:
                logging.warning(f"CSV file for {table_name} does not exist. Skipping.")

        cursor.close()
        conn.close()
    except Exception as e:
        logging.error(f"An error occurred: {e}")

if __name__ == "__main__":
    dbname = "kako"
    user = "postgres"
    password = "password"
    host = "127.0.0.1"
    port = "5432"
    csv_folder = "csv_files"
    
    run_import(dbname, user, password, host, port, csv_folder)
