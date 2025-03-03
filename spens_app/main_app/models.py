from django.db import models
from django.contrib.auth.models import User

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

