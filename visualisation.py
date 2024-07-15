import json
import networkx as nx
import matplotlib.pyplot as plt

def plot_graph(graph):
    pos = nx.spring_layout(graph)
    plt.figure(figsize=(12, 12))
    nx.draw(graph, pos, with_labels=True, node_size=3000, node_color="lightblue", font_size=10, font_weight="bold", arrows=True)
    plt.title("Table Foreign Key Relationships")
    plt.show()

def run(schema_file):
    try:
        with open(schema_file, 'r') as file:
            schema = json.load(file)

        graph = nx.DiGraph()

        # Add nodes for each table
        tables = schema.keys()
        graph.add_nodes_from(tables)

        # Add edges based on foreign key relationships
        for table, details in schema.items():
            for fk in details.get("foreign_keys", []):
                ref_table = fk["ref_table"]
                graph.add_edge(ref_table, table)

        # Plot the graph
        plot_graph(graph)

    except FileNotFoundError:
        print(f"File {schema_file} not found.")
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    schema_file = "parsed_schema.json"  # replace with your schema file path
    run(schema_file)
