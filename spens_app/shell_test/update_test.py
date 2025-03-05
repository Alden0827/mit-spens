from django.utils.timezone import now
from main_app.models import Beneficiary

# Update the beneficiary's first name and birth date
updated_rows = Beneficiary.objects.filter(beneficiary_id="BNF001").update(
    first_name="Pedromo",
    birth_date="1990-01-01",
    date_encoded=now(),  # Optional: update timestamp if needed
)

# Check if any records were updated
if updated_rows:
    print("Beneficiary updated successfully.")
else:
    print("No matching beneficiary found.")
