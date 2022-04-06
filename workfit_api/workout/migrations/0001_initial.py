# Generated by Django 4.0.3 on 2022-04-05 12:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Workout',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='Exercise',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('sets', models.IntegerField(default=8)),
                ('reps', models.IntegerField(default=8)),
                ('workout', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='exercises', to='workout.workout')),
            ],
        ),
    ]