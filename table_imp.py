import os
import csv
import psycopg2
from psycopg2 import sql, extras

def import_csv_to_db(cursor, table_name, csv_file):
    with open(csv_file, 'r') as file:
        reader = csv.reader(file)
        headers = next(reader)

        insert_query = sql.SQL('INSERT INTO {} ({}) VALUES %s').format(
            sql.Identifier(table_name),
            sql.SQL(', ').join(map(sql.Identifier, headers))
        )
        
        rows = []
        for row in reader:
            rows.append(tuple(row))
        
        try:
            extras.execute_values(cursor, insert_query, rows)
            print(f"Data imported into {table_name} from {csv_file}")
        except psycopg2.IntegrityError as e:
            print(f"Error importing {table_name} from {csv_file}: {e}")
            cursor.connection.rollback()
        except Exception as e:
            print(f"Error importing {table_name} from {csv_file}: {e}")
            cursor.connection.rollback()

def create_database_if_not_exists(conn_params, dbname):
    conn = psycopg2.connect(**conn_params)
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute(f"SELECT 1 FROM pg_catalog.pg_database WHERE datname = '{dbname}'")
    exists = cur.fetchone()
    if not exists:
        cur.execute(f"CREATE DATABASE {dbname}")
        print(f"Database {dbname} created successfully.")
    else:
        print(f"Database {dbname} already exists.")
    cur.close()
    conn.close()

def main():
    host = "127.0.0.1"  # Replace with your host
    port = "5432"       # Replace with your port
    user = "postgres"   # Replace with your username
    password = "password"  # Replace with your password
    dbname = "kako"  # Replace with your database name

    conn_params = {
        'host': host,
        'port': port,
        'user': user,
        'password': password,
    }

    # Create database if not exists
    create_database_if_not_exists(conn_params, dbname)

    # Connect to the created database
    conn_params['dbname'] = dbname
    conn = psycopg2.connect(**conn_params)
    cur = conn.cursor()

    csv_folder_path = "csv_files"  # Replace with the path to your CSV folder

    # Order of tables based on foreign key dependencies
    order_of_creation = [
"Action"
,"ActionMarche"
,"AspNetRoles"
,"AspNetUsers"
,"ServiceExterieur"
,"Categorie"
,"Categorie_Document"
,"Geoife"
,"GroupesDesMarches"
,"Notification"
,"Province"
,"RefConsistances"
,"RefLimiteNat"
,"RefSpeculation"
,"RefTypeSol"
,"Remarque"
,"Type_Livraison"
,"ViewPMIS"
,"ZonesLambert"
,"acte"
,"actions"
,"adjudicataire"
,"ayant_droit"
,"charge"
,"droit_reel"
,"groupe_proprietaire"
,"opposant"
,"personne"
,"presume"
,"proprietaire"
,"situation_quotidienne"
,"synth_etat_parcelle"
,"temoin"
,"temp_ayant_droit"
,"temp_ayant_droit_matching"
,"temp_opposant"
,"temp_opposant_matching"
,"temp_presume"
,"temp_presume_matching"
,"temp_proprietaire"
,"temp_proprietaire_matching"
,"temp_temoin"
,"temp_temoin_matching"
,"AspNetUserClaims"
,"AspNetUserLogins"
,"AspNetUserRoles"
,"authentification"
,"igt"
,"CollabInterne"
,"Document"
,"RefMotifRejet"
,"Caidat"
,"Cercle"
,"proprietaire_presume"
,"auth_action"
,"Collaborateur"
,"groupement_igt"
,"Etat_Document"
,"Commune"
,"zone"
,"marche"
,"sous_zone"
,"CollabExterne_marche"
,"CollabInterne_marche"
,"DocMarche"
,"Prep_Marche"
,"douar"
,"DocCommun"
,"Livraison"
,"parcelle"
,"Rejet"
,"DocParcelle"
,"Etat_Parcelle"
,"Opposition"
,"Riverain"
,"ayant_droit_parcelle"
,"borne"
,"charge_parcelle"
,"consistance_parcelle"
,"detail_acte"
,"synchronisation"
,"opposant_parcelle"
,"parcelaire"
,"parcelle_motifrejet"
,"presume_parcelle"
,"proprietaire_parcelle"
,"temoin_parcelle"
,"Rejet_parcelle"
,"Satisfaction_Rejet"
,"Opposition_Opposant"
,"borne_opposition"
,"BienLimitrophe"
,"LimiteNat"
,"Prop_morale"
,"Prop_physique"
,"borne_parcelaire"
,"SatRej_parcelle"
]

    try:
        for table_name in order_of_creation:
            csv_file = f"{table_name}.csv"
            csv_file_path = os.path.join(csv_folder_path, csv_file)
            if os.path.exists(csv_file_path):
                import_csv_to_db(cur, table_name, csv_file_path)
            else:
                print(f"CSV file for table {table_name} does not exist.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        conn.commit()
        cur.close()
        conn.close()

if __name__ == "__main__":
    main()
