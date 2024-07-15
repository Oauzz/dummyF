import psycopg2

def create_database(host, port, user, password, dbname):
    # Connect to PostgreSQL server
    conn = psycopg2.connect(host=host, port=port, user=user, password=password, dbname='postgres')
    conn.autocommit = True
    cur = conn.cursor()
    
    # Create database
    cur.execute(f"DROP DATABASE IF EXISTS {dbname};")
    cur.execute(f"CREATE DATABASE {dbname};")
    
    # Close connection
    cur.close()
    conn.close()
    print(f"Database {dbname} created successfully.")

def import_schema(host, port, user, password, dbname, schema_file):
    # Connect to the newly created database
    conn = psycopg2.connect(host=host, port=port, user=user, password=password, dbname=dbname)
    cur = conn.cursor()
    
    # Create PostGIS extension
    cur.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
    conn.commit()
    
    # Read the schema file
    with open(schema_file, 'r') as file:
        schema_sql = file.read()
    
    # Execute the schema SQL
    cur.execute(schema_sql)
    
    # Commit and close connection
    conn.commit()
    cur.close()
    conn.close()
    print(f"Schema imported from {schema_file} into database {dbname} successfully.")

if __name__ == "__main__":
    # Database configuration
    host = '127.0.0.1'
    port = 5432
    user = 'postgres'
    password = 'password'
    dbname = 'kako'
    schema_file = 'extracted_schema.sql'

    # Create database and import schema
    create_database(host, port, user, password, dbname)
    import_schema(host, port, user, password, dbname, schema_file)
