# Generated by Django 5.0.2 on 2024-12-12 08:33

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dedupe_app', '0022_alter_transactions_status_id'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transactions',
            name='status_id',
            field=models.ForeignKey(db_column='status_id', on_delete=django.db.models.deletion.PROTECT, to='dedupe_app.lib_trans_status'),
        ),
    ]
