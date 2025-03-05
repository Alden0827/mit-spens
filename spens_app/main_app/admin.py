from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(EmployeeProfile)
admin.site.register(Province)
admin.site.register(Municipality)
admin.site.register(Barangay)
admin.site.register(Position)
admin.site.register(FundSource)
admin.site.register(Obligation)
admin.site.register(Payroll)
admin.site.register(AuditTrail)




@admin.register(Beneficiary)
class BeneficiaryAdmin(admin.ModelAdmin):
    list_display = ('beneficiary_id', 'first_name', 'middle_name', 'last_name', 'birth_date', 'sex', 'status', 'last_updated_dt')  # Corrected fields
    search_fields = ('first_name', 'last_name', 'beneficiary_id', 'contact_number')

    def age(self, obj):
        """ Calculate age based on birth_date """
        from datetime import date
        if obj.birth_date:
            today = date.today()
            return today.year - obj.birth_date.year - ((today.month, today.day) < (obj.birth_date.month, obj.birth_date.day))
        return None
    age.short_description = 'Age'

    def last_updated_by(self, obj):
        """ Placeholder for tracking last updated by user """
        return "Unknown"  # Replace with actual tracking if needed
    last_updated_by.short_description = 'Last Updated By'

    list_display += ('age', 'last_updated_by')  # Append computed fields

