# Generated by Django 5.0.2 on 2025-03-05 08:44

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0029_rename_last_updated_beneficiary_last_updated_dt'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.RemoveField(
            model_name='beneficiary',
            name='encoded_by',
        ),
        migrations.RemoveField(
            model_name='beneficiary',
            name='encoded_dt',
        ),
        migrations.CreateModel(
            name='BeneTransaction',
            fields=[
                ('trans_id', models.CharField(editable=False, max_length=50, primary_key=True, serialize=False)),
                ('action', models.IntegerField(choices=[(1, 'Encoded'), (2, 'Validated'), (3, 'Certified Correct'), (4, 'Recommended'), (5, 'Approved')])),
                ('date_acted', models.DateTimeField(auto_now_add=True)),
                ('acted_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'tbl_btransactions',
            },
        ),
        migrations.AddField(
            model_name='beneficiary',
            name='tras_encoding',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='rel_waitlisted_encoding', to='main_app.benetransaction'),
        ),
    ]
