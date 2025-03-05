from django.utils.timezone import now
from main_app.models import Beneficiary

try:
    beneficiary = Beneficiary.objects.get(beneficiary_id="BNF001")
    beneficiary.first_name = "alden2"
    beneficiary.birth_date = "1984-01-02"  # Ensure this is in the correct format
    beneficiary.date_encoded = now()  # Update timestamp
    beneficiary.save()

    print("Beneficiary updated successfully.")
except Beneficiary.DoesNotExist:
    print("No matching beneficiary found.")