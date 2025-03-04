from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

class Region(models.Model):
    name = models.CharField(max_length=255, unique=True)
    code = models.CharField(max_length=20, unique=True)

    class Meta:
        db_table = 'tbl_region'  # Corrected table name

    def __str__(self):
        return self.name

class Province(models.Model):
    name = models.CharField(max_length=255, unique=True)
    code = models.CharField(max_length=20, unique=True)
    region = models.ForeignKey(Region, on_delete=models.CASCADE)  # Added ForeignKey

    class Meta:
        db_table = 'tbl_province'

    def __str__(self):
        return self.name

class Municipality(models.Model):
    name = models.CharField(max_length=255, unique=True)
    code = models.CharField(max_length=20, unique=True)
    # province = models.ForeignKey(Province, on_delete=models.CASCADE)  # Added ForeignKey
    province = models.ForeignKey(Province, on_delete=models.CASCADE, null=True)

    class Meta:
        db_table = 'tbl_municipality'

    def __str__(self):
        return self.name

class Barangay(models.Model):
    name = models.CharField(max_length=255, unique=False)
    code = models.CharField(max_length=20, unique=True)
    municipality = models.ForeignKey(Municipality, on_delete=models.CASCADE)
    class Meta:
        db_table = 'tbl_barangay'

    def __str__(self):
        return self.name

class Position(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'tbl_position'

    def __str__(self):
        return self.name

class EmployeeProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    emp_id = models.IntegerField(unique=True)  # Employee ID (integer)
    first_name = models.CharField(max_length=100)
    middle_name = models.CharField(max_length=100, blank=True, null=True)
    last_name = models.CharField(max_length=100)
    name_exit = models.CharField(max_length=100, blank=True, null=True)
    position = models.ForeignKey(Position, on_delete=models.SET_NULL, null=True)
    contact_number = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField(unique=True)
    office = models.CharField(max_length=255, blank=True, null=True)
    area_of_assignment = models.ForeignKey(Municipality, on_delete=models.SET_NULL, null=True)

    SEX_CHOICES = [
        ('Male', 'Male'),
        ('Female', 'Female')
    ]
    sex = models.CharField(max_length=6, choices=SEX_CHOICES, null=True)

    EMP_STATUS_CHOICES = [
        ('Active', 'Active'),
        ('Inactive', 'Inactive'),
        ('Resigned', 'Resigned'),
        ('Retired', 'Retired'),
    ]
    emp_status = models.CharField(max_length=50, choices=EMP_STATUS_CHOICES)

    POS_STATUS_CHOICES = [
        ('COS', 'Contract of Service (COS)'),
        ('Contractual', 'Contractual'),
        ('Regular', 'Regular'),
    ]
    pos_status = models.CharField(max_length=20, choices=POS_STATUS_CHOICES)

    item_number = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'tbl_employee'

    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.emp_id})"


class Beneficiary(models.Model):
    beneficiary_id = models.CharField(max_length=20, unique=True)  # Unique system-generated ID
    philsys_id = models.CharField(max_length=20, unique=True, blank=True, null=True)  # PhilSys National ID
    senior_citizen_id = models.CharField(max_length=20, unique=True, blank=True, null=True)  # Senior Citizen ID
    biometric_fp = models.CharField(max_length=50, null=True)
    first_name = models.CharField(max_length=50)
    middle_name = models.CharField(max_length=50, blank=True, null=True)
    last_name = models.CharField(max_length=50)
    birth_date = models.DateField()
    sex = models.CharField(max_length=1, choices=[('m', 'Male'), ('f', 'Female')])
    address_psgc = models.ForeignKey(Barangay, on_delete=models.SET_NULL, null=True)
    address = models.TextField()  # Full address of the beneficiary
    contact_number = models.CharField(max_length=15, blank=True, null=True)
    email = models.CharField(max_length=15, blank=True, null=True)
    status = models.IntegerField(choices=[(2, '2 - Active'), (1, '1 - Waitlisted'), (3, '3 - Deceased'),(4, '4 - Inactive'),(5, '5 - Waived'),(6, '6 - Moved-out without notice'), (7, '7 - Ineligible')], default=1)
    date_registered = models.DateTimeField()
    date_encoded = models.DateTimeField(default=timezone.now)
    last_updated = models.DateTimeField(auto_now=True)

    #for pantawid beneficiary only ----------------------------
    is_pantawid = models.BooleanField(default=False)  # Boolean: True or False
    pantawid_hhid = models.CharField(max_length=25, blank=True, null=True)  # Nullable string (HHID)
    PANTAWID_LOWB_CHOICES = [
        (1, 'Survival'),
        (2, 'Subsistence'),
        (3, 'Self-Sufficient'),
    ]
    pantawid_lowb = models.IntegerField(choices=PANTAWID_LOWB_CHOICES, blank=True, null=True)  
    
    class Meta:
        db_table = 'tbl_beneficiaries'
        ordering = ['last_name', 'first_name']

    def __str__(self):
        return f"{self.beneficiary_id} - {self.first_name} {self.last_name}"


# Fund Sources Table
class FundSource(models.Model):
    fund_source_id = models.AutoField(primary_key=True)
    fund_name = models.CharField(max_length=255, unique=True)  # Name of the fund source
    description = models.TextField(blank=True, null=True)
    total_amount = models.DecimalField(max_digits=15, decimal_places=2)  # Total amount allocated
    balance = models.DecimalField(max_digits=15, decimal_places=2)  # Remaining balance

    class Meta:
        db_table = 'tbl_fund_sources'

    def __str__(self):
        return self.fund_name


# Obligations Table (Funds allocated for payroll)
class Obligation(models.Model):
    obligation_id = models.AutoField(primary_key=True)
    fund_source = models.ForeignKey(FundSource, on_delete=models.CASCADE, related_name="obligations", null=True)
    obligation_date = models.DateField()
    amount_obligated = models.DecimalField(max_digits=15, decimal_places=2)
    description = models.TextField(blank=True, null=True)

    class Meta:
        db_table = 'tbl_obligations'

    def __str__(self):
        return f"Obligation {self.obligation_id} - {self.amount_obligated}"


# Payroll Table
class Payroll(models.Model):
    payroll_id = models.AutoField(primary_key=True)
    payroll_date = models.DateField()  # Date when the payroll is processed
    period_start = models.DateField()  # Start of the payroll period
    period_end = models.DateField()  # End of the payroll period
    total_amount = models.DecimalField(max_digits=15, decimal_places=2, default=0.00)  # Total amount
    obligation = models.ForeignKey(Obligation, on_delete=models.CASCADE, related_name="payrolls", null=True)  # Links to Obligation
    status = models.CharField(max_length=20, choices=[('Pending', 'Pending'), ('Approved', 'Approved'), ('Released', 'Released')], default='Pending')

    class Meta:
        db_table = 'tbl_payroll'
        ordering = ['-payroll_date']

    def __str__(self):
        return f"Payroll {self.payroll_id} - {self.payroll_date}"


# Payroll Details Table (Individual Beneficiary Payments)
class PayrollDetail(models.Model):
    payroll = models.ForeignKey(Payroll, on_delete=models.CASCADE, related_name="payroll_details")
    beneficiary = models.ForeignKey(Beneficiary, on_delete=models.CASCADE, related_name="payroll_entries")
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=[('Pending', 'Pending'), ('Paid', 'Paid')], default='Pending')
    date_paid = models.DateField(null=True)

    class Meta:
        db_table = 'tbl_payroll_details'

    def __str__(self):
        return f"{self.beneficiary} - {self.amount} ({self.status})"


# Liquidations Table (Tracks released funds and expenses)
class Liquidation(models.Model):
    liquidation_id = models.AutoField(primary_key=True)
    payroll = models.ForeignKey(Payroll, on_delete=models.CASCADE, related_name="liquidations")
    liquidation_date = models.DateField()
    total_liquidated = models.DecimalField(max_digits=15, decimal_places=2)  # Amount liquidated
    remarks = models.TextField(blank=True, null=True)

    class Meta:
        db_table = 'tbl_liquidations'

    def __str__(self):
        return f"Liquidation {self.liquidation_id} - {self.total_liquidated}"