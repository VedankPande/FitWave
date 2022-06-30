# Generated by Django 4.0.4 on 2022-06-29 18:16

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
            ],
        ),
        migrations.CreateModel(
            name='UserDailyIntake',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user', models.CharField(max_length=255)),
                ('date', models.DateTimeField(default=django.utils.timezone.now)),
                ('amount', models.IntegerField()),
                ('meal', models.CharField(choices=[('BR', 'Breakfast'), ('LU', 'Lunch'), ('DI', 'Dinner'), ('SN', 'Snacks')], default='BR', max_length=2)),
                ('food_data', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='calorieTracker.fooddata')),
            ],
        ),
    ]
