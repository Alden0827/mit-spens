# Generated by Django 5.0.2 on 2024-12-13 02:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dedupe_app', '0024_lib_dataset_status_datasets_dataset_status_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='datasets',
            name='dataset_status_id',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]
