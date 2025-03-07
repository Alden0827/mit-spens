# Generated by Django 5.0.2 on 2025-03-03 02:26

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Municipality',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('code', models.CharField(max_length=20, unique=True)),
            ],
            options={
                'db_table': 'tbl_municipality',
            },
        ),
        migrations.CreateModel(
            name='Position',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'tbl_position',
            },
        ),
        migrations.CreateModel(
            name='EmployeeProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('emp_id', models.IntegerField(unique=True)),
                ('first_name', models.CharField(max_length=100)),
                ('middle_name', models.CharField(blank=True, max_length=100, null=True)),
                ('last_name', models.CharField(max_length=100)),
                ('name_exit', models.CharField(blank=True, max_length=100, null=True)),
                ('contact_number', models.CharField(blank=True, max_length=20, null=True)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('office', models.CharField(blank=True, max_length=255, null=True)),
                ('emp_status', models.CharField(choices=[('Active', 'Active'), ('Inactive', 'Inactive'), ('Resigned', 'Resigned'), ('Retired', 'Retired')], max_length=50)),
                ('pos_status', models.CharField(choices=[('COS', 'Contract of Service (COS)'), ('Contractual', 'Contractual'), ('Regular', 'Regular')], max_length=20)),
                ('item_number', models.CharField(max_length=50, unique=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('code', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='main_app.municipality')),
                ('position', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='main_app.position')),
            ],
            options={
                'db_table': 'tbl_employee',
            },
        ),
    ]
