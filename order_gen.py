import logging
import networkx as nx
import json

logging.basicConfig(level=logging.INFO)

def determine_creation_order(schema):
    graph = nx.DiGraph()

    # Add nodes for each table
    tables = schema.keys()
    graph.add_nodes_from(tables)

    # Add edges based on foreign key relationships
    for table, details in schema.items():
        for fk in details.get("foreign_keys", []):
            ref_table = fk["ref_table"]
            graph.add_edge(ref_table, table)

    # Detect and break cycles
    while True:
        try:
            # Perform topological sort
            creation_order = list(nx.topological_sort(graph))
            logging.info("Order of table creation:")
            for table in creation_order:
                logging.info(table)
            return creation_order
        except nx.NetworkXUnfeasible:
            # Graph has cycles, break one cycle
            cycle = list(nx.find_cycle(graph))
            logging.warning(f"Cycle detected: {cycle}")
            graph.remove_edge(*cycle[0])
            logging.info(f"Removed edge: {cycle[0]} to break the cycle.")

def run(schema_file):
    logging.info(f"Determining order of table creation from schema file: {schema_file}")

    try:
        with open(schema_file, 'r') as file:
            schema = json.load(file)

        creation_order = determine_creation_order(schema)

        if creation_order:
            output_file = "table_creation_order.txt"
            with open(output_file, 'w') as f:
                for table in creation_order:
                    f.write(table + "\n")
            logging.info(f"Order of table creation written to {output_file}")

    except FileNotFoundError:
        logging.error(f"File {schema_file} not found.")
    except json.JSONDecodeError as e:
        logging.error(f"Error decoding JSON: {e}")
    except Exception as e:
        logging.error(f"An error occurred: {e}")

if __name__ == "__main__":
    schema_file = "parsed_schema.json"  # replace with your schema file path
    run(schema_file)
