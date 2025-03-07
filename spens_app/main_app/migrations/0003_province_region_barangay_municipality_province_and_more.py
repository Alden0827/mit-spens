# Generated by Django 5.0.2 on 2025-03-03 02:39

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0002_remove_employeeprofile_code_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Province',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('code', models.CharField(max_length=20, unique=True)),
            ],
            options={
                'db_table': 'tbl_province',
            },
        ),
        migrations.CreateModel(
            name='Region',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('code', models.CharField(max_length=20, unique=True)),
            ],
            options={
                'db_table': 'tbl_region',
            },
        ),
        migrations.CreateModel(
            name='Barangay',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('code', models.CharField(max_length=20, unique=True)),
                ('municipality', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main_app.municipality')),
            ],
        ),
        migrations.AddField(
            model_name='municipality',
            name='province',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='main_app.province'),
        ),
        migrations.AddField(
            model_name='province',
            name='region',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='main_app.region'),
        ),
    ]
