from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
import datetime

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

class BeneTransaction(models.Model):
    ACTION_CHOICES = [
        (1, 'Encoded'),
        (2, 'Validated'),
        (3, 'Certified Correct'),
        (4, 'Recommended'),
        (5, 'Approved'),
    ]

    trans_id = models.CharField(
        max_length=50, 
        primary_key=True, 
        editable=False
    )
    action = models.IntegerField(choices=ACTION_CHOICES)
    date_acted = models.DateTimeField(auto_now_add=True)
    acted_by = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        db_table = 'tbl_btransactions'

    def generate_unique_number(self):
        """ Generate a unique 6-digit number """
        while True:
            unique_number = random.randint(100000, 999999)
            if not BeneTransaction.objects.filter(trans_id__endswith=f"_{unique_number}").exists():
                return unique_number

    def save(self, *args, **kwargs):
        if not self.trans_id:
            date_part = datetime.now().strftime('%Y%m%d')
            unique_number = self.generate_unique_number()
            self.trans_id = f"tnx_{date_part}_{unique_number}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.trans_id} - {self.get_action_display()}"


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

    #waitlisted encoding (encoders)
    # encoded_dt = models.DateTimeField(default=timezone.now)
    # encoded_by  = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_encoding') 
    tras_encoding  = models.ForeignKey(BeneTransaction, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_encoding') 

    #validation (project development officer)
    # validated_dt = models.DateTimeField(null=True)
    # validated_by  = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_validation') 
    tras_validation  = models.ForeignKey(BeneTransaction, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_validation') 


    #certified correct by (quality assuracne focal)
    # certified_correct_dt  = models.DateTimeField(null=True)
    # certified_correct_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_qa') 
    tras_qa  = models.ForeignKey(BeneTransaction, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_qa') 

    #recommedation (regional program coordinator)
    # recommended_dt = models.DateTimeField(null=True)
    # recommended_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_recomm') 
    tras_recommendation  = models.ForeignKey(BeneTransaction, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_recomm') 

    #approval (regional director)
    # approved_dt = models.DateTimeField(null=True)
    # approved_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_approval') 
    tras_approval  = models.ForeignKey(BeneTransaction, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_waitlisted_approval') 

    last_updated_dt = models.DateTimeField(auto_now=True)
    last_updated_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='rel_user_beneficiary')  # Track last user who updated

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

    def save(self, *args, **kwargs):
        if self.pk:  # If updating an existing record
            old_record = Beneficiary.objects.get(pk=self.pk)
            changes = []

            for field in self._meta.fields:
                field_name = field.name
                old_value = getattr(old_record, field_name)
                new_value = getattr(self, field_name)

                # Normalize DateField for comparison
                if isinstance(field, models.DateField):
                    if isinstance(old_value, datetime.date) and isinstance(new_value, datetime.date):
                        if old_value.strftime("%Y-%m-%d") == new_value.strftime("%Y-%m-%d"):
                            continue  # Skip logging if they are identical

                # Normalize DateTimeField (especially for timezone differences)
                if isinstance(field, models.DateTimeField):
                    if old_value and new_value:
                        if old_value.replace(microsecond=0) == new_value.replace(microsecond=0):
                            continue  # Skip logging if only microseconds differ

                if str(old_value) != str(new_value):  # If the field has changed
                    print(f"AuditTrail: '{old_value}' to '{new_value}'")
                    changes.append(AuditTrail(
                        beneficiary=self,
                        changed_field=field_name,
                        old_value=old_value,
                        new_value=new_value,
                        changed_by=self.last_updated_by
                    ))

            if changes:
                AuditTrail.objects.bulk_create(changes)  # Save all changes at once

        super().save(*args, **kwargs)  # Proceed with saving the updated record

    # def save(self, *args, **kwargs):
    #     """ Custom save method to track changes in AuditTrail """
    #     if self.pk:  # If the record already exists (update operation)
    #         old_record = Beneficiary.objects.get(pk=self.pk)
    #         changes = []

    #         for field in self._meta.fields:
    #             field_name = field.name
    #             old_value = getattr(old_record, field_name)
    #             new_value = getattr(self, field_name)

    #             if old_value != new_value:  # If value has changed
    #                 changes.append(AuditTrail(
    #                     beneficiary=self,
    #                     changed_field=field_name,
    #                     old_value=old_value,
    #                     new_value=new_value,
    #                     changed_by=self.last_updated_by
    #                 ))

    #         if changes:
    #             AuditTrail.objects.bulk_create(changes)  # Save all changes at once

    #     super().save(*args, **kwargs)  # Proceed with saving the updated record


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


class AuditTrail(models.Model):
    beneficiary = models.ForeignKey(Beneficiary, on_delete=models.CASCADE)
    changed_field = models.CharField(max_length=255, null=True)  # Make sure this matches your field name
    old_value = models.TextField(null=True, blank=True)
    new_value = models.TextField(null=True, blank=True)
    changed_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    changed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'audit_trail'
        ordering = ['-changed_at']

    def __str__(self):
        return f"Change in {self.changed_field} for {self.beneficiary.beneficiary_id} by {self.changed_by}"
