from main_app.models import Beneficiary, Barangay
from django.contrib.auth.models import User
from django.utils.timezone import now

# Fetch the Barangay (Handle if it does not exist)
try:
    barangay = Barangay.objects.get(id=124701008)
except Barangay.DoesNotExist:
    raise ValueError("Barangay with ID 124701008 does not exist.")

# Fetch the first user (Handle if no user exists)
user = User.objects.first()
if user is None:
    raise ValueError("No user found. Please create an admin user.")

# Insert a Beneficiary
beneficiary = Beneficiary.objects.create(
    beneficiary_id="BNF001",
    philsys_id="1234567890",
    senior_citizen_id="SC12345",
    biometric_fp="fingerprint_data",
    first_name="Juan",
    middle_name="P.",
    last_name="Dela Cruz",
    birth_date="1985-06-15",
    sex="m",
    address_psgc=barangay,  # Correctly passing the Barangay instance
    address="1234 Sample Street, Sample City",
    contact_number="09123456789",
    email="juan.dcruz@email.com",
    status=2,  # Assuming 2 means "Active"
    date_registered=now(),
    date_encoded=now(),
    last_updated_by=user
)

print(f"Inserted Beneficiary: {beneficiary}")
