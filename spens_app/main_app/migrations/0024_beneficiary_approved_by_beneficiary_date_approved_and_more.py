# Generated by Django 5.0.2 on 2025-03-05 07:22

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0023_rename_date_registered_beneficiary_date_recommended_and_more'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='beneficiary',
            name='approved_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='rel_waitlisted_approval', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='beneficiary',
            name='date_approved',
            field=models.DateTimeField(null=True),
        ),
        migrations.AddField(
            model_name='beneficiary',
            name='recommended_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='rel_waitlisted_recomm', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='beneficiary',
            name='encoded_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='rel_waitlisted_encoding', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='beneficiary',
            name='validated_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='rel_waitlisted_validation', to=settings.AUTH_USER_MODEL),
        ),
    ]
