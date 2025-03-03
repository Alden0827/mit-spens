"""
Database Fixture Manager

This script allows you to export and import database data using JSON fixtures.
It is useful for creating backups, migrating data, or testing.

Usage:
    python fixture.py export fixture.json  # Export database to JSON
    python fixture.py import fixture.json  # Import data from JSON to database

Examples:
    Exporting data:
        $ python fixture.py export data.json
    
    Importing data:
        $ python fixture.py import data.json

Requirements:
    - Flask with SQLAlchemy configured (`app.py` must define `db`)
    - Models must be properly defined and imported

Author: Your Name
"""

import json
import sys
from datetime import date, datetime
from decimal import Decimal
from app import app, db  # Import Flask app and SQLAlchemy instance
from models import *  # Import all models

def serialize(obj):
    """Convert non-serializable objects to a JSON-friendly format."""
    if isinstance(obj, (date, datetime)):
        return obj.isoformat()  # Convert to 'YYYY-MM-DD' or 'YYYY-MM-DDTHH:MM:SS'
    elif isinstance(obj, Decimal):
        return float(obj)  # Convert Decimal to float
    raise TypeError(f"Type {type(obj)} not serializable")

def export_fixture(filename):
    """Exports database records to a JSON fixture."""
    with app.app_context():  # Ensure we are in the application context
        tables = db.metadata.tables.keys()
        data = {}

        for table in tables:
            rows = db.session.execute(db.text(f"SELECT * FROM {table}")).mappings().all()
            data[table] = [dict(row) for row in rows]

        with open(filename, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4, ensure_ascii=False, default=serialize)

        print(f"✅ Fixture exported to {filename}")

def import_fixture(filename):
    """Imports records from a JSON fixture into the database."""
    with app.app_context():  # Ensure we are in the application context
        with open(filename, "r", encoding="utf-8") as f:
            data = json.load(f)

        for table, rows in data.items():
            model = db.metadata.tables[table]
            db.session.execute(model.insert(), rows)

        db.session.commit()
        print(f"✅ Fixture imported from {filename}")

def main():
    """CLI handler for managing fixtures."""
    if len(sys.argv) != 3:
        print(__doc__)  # Print the script's docstring if incorrect usage
        sys.exit(1)

    action = sys.argv[1]
    filename = sys.argv[2]

    if action == "export":
        export_fixture(filename)
    elif action == "import":
        import_fixture(filename)
    else:
        print("❌ Invalid command! Use 'import' or 'export'.")
        print(__doc__)  # Print usage guide
        sys.exit(1)

if __name__ == "__main__":
    main()
