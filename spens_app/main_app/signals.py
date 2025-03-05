from django.db.models.signals import pre_save
from django.dispatch import receiver
from .models import Beneficiary, AuditTrail

@receiver(pre_save, sender=Beneficiary)
def audit_trail(sender, instance, **kwargs):
	pass
    # if instance.pk:  # Ensure it's an update, not a new record
    #     try:
    #         old_instance = Beneficiary.objects.get(pk=instance.pk)
    #     except Beneficiary.DoesNotExist:
    #         return  # Skip logging if the record is not found

    #     changed_fields = {}
    #     for field in instance._meta.fields:
    #         field_name = field.name
    #         old_value = getattr(old_instance, field_name)
    #         new_value = getattr(instance, field_name)

    #         # Check for changes and ignore "last_updated_by" field to avoid unnecessary logs
    #         if old_value != new_value and field_name != "last_updated_by":
    #             changed_fields[field_name] = (old_value, new_value)

    #     # Save changes to AuditTrail
    #     for field, (old_value, new_value) in changed_fields.items():
    #         AuditTrail.objects.create(
    #             beneficiary=instance,
    #             changed_field=field,  # Use the correct field name
    #             old_value=old_value if old_value is not None else "",
    #             new_value=new_value if new_value is not None else "",
    #             changed_by=instance.last_updated_by if instance.last_updated_by else None
    #         )
