# Generated by Django 5.0.2 on 2025-03-03 03:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0004_alter_barangay_table'),
    ]

    operations = [
        migrations.AlterField(
            model_name='barangay',
            name='code',
            field=models.CharField(max_length=20),
        ),
    ]
