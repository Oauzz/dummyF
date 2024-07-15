import psycopg2
import os
import csv
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def connect_db(host, port, user, password, dbname):
    try:
        conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
        return conn
    except Exception as e:
        logging.error(f"Error connecting to the database: {e}")
        return None

def table_exists(conn, table_name):
    try:
        cur = conn.cursor()
        cur.execute(f"SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = %s);", (table_name.lower(),))
        exists = cur.fetchone()[0]
        cur.close()
        return exists
    except Exception as e:
        logging.error(f"Error checking if table {table_name} exists: {e}")
        return False

def create_tables(conn, schema_file):
    try:
        cur = conn.cursor()
        with open(schema_file, 'r') as file:
            schema_sql = file.read()
        cur.execute(schema_sql)
        conn.commit()
        cur.close()
        logging.info("Tables created successfully.")
    except psycopg2.errors.DuplicateTable:
        logging.info("Tables already exist. Skipping table creation.")
        conn.rollback()
    except Exception as e:
        logging.error(f"Error creating tables: {e}")
        conn.rollback()

def import_csv_data(conn, csv_folder):
    try:
        cur = conn.cursor()
        for csv_file in os.listdir(csv_folder):
            table_name, _ = os.path.splitext(csv_file)
            table_name = table_name.lower()
            if not table_exists(conn, table_name):
                logging.warning(f"Table {table_name} does not exist. Skipping import for {csv_file}.")
                continue

            csv_path = os.path.join(csv_folder, csv_file)

            with open(csv_path, 'r') as file:
                reader = csv.reader(file)
                columns = next(reader)  # Get the column names from the first row of the CSV
                columns = ', '.join(columns)
                query = f"COPY {table_name} ({columns}) FROM STDIN WITH CSV HEADER DELIMITER ','"

                with open(csv_path, 'r') as f:
                    cur.copy_expert(sql=query, file=f)

        conn.commit()
        cur.close()
        logging.info("CSV data imported successfully.")
    except Exception as e:
        logging.error(f"Error importing CSV data: {e}")
        conn.rollback()

if __name__ == "__main__":
    host = "127.0.0.1"
    port = "5432"
    user = "postgres"
    password = "password"
    dbname = "kako"
    schema_file = "extracted_schema.sql"
    csv_folder = "csv_files"

    conn = connect_db(host, port, user, password, dbname)
    if conn:
        create_tables(conn, schema_file)
        import_csv_data(conn, csv_folder)
        conn.close()
