# Generated by Django 5.0.2 on 2024-12-12 08:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dedupe_app', '0021_lib_trans_status_delete_trans_status_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transactions',
            name='status_id',
            field=models.IntegerField(default=0, null=True),
        ),
    ]
