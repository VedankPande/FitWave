# Generated by Django 4.0.3 on 2022-04-06 09:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('workout', '0002_exercisedata_exerciseobject_workout_owner_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='exercisedata',
            name='muscles_worked',
            field=models.CharField(max_length=15),
        ),
    ]
