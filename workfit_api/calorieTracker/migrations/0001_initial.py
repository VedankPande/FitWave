# Generated by Django 4.0.4 on 2022-05-14 20:50

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='FoodData',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('protein', models.DecimalField(decimal_places=2, max_digits=7)),
                ('fat', models.DecimalField(decimal_places=2, max_digits=7)),
                ('carbohydrate', models.DecimalField(decimal_places=2, max_digits=7)),
                ('calorie', models.DecimalField(decimal_places=2, max_digits=7)),
                ('water', models.DecimalField(decimal_places=2, max_digits=7)),
                ('sugar', models.DecimalField(decimal_places=2, max_digits=7)),
                ('fiber', models.DecimalField(decimal_places=2, max_digits=7)),
                ('calcium', models.DecimalField(decimal_places=2, max_digits=7)),
                ('iron', models.DecimalField(decimal_places=2, max_digits=7)),
                ('magnesium', models.DecimalField(decimal_places=2, max_digits=7)),
                ('phosphorus', models.DecimalField(decimal_places=2, max_digits=7)),
                ('potassium', models.DecimalField(decimal_places=2, max_digits=7)),
                ('sodium', models.DecimalField(decimal_places=2, max_digits=7)),
                ('zinc', models.DecimalField(decimal_places=2, max_digits=7)),
                ('copper', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_a', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_e', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_d', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_c', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_b6', models.DecimalField(decimal_places=2, max_digits=7)),
                ('vitamin_b12', models.DecimalField(decimal_places=2, max_digits=7)),
            ],
        ),
        migrations.CreateModel(
            name='UserDailyIntake',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user', models.CharField(max_length=255)),
                ('date', models.DateTimeField(default=django.utils.timezone.now)),
                ('amount', models.IntegerField()),
                ('food_data', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='calorieTracker.fooddata')),
            ],
        ),
    ]
