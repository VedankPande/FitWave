"""
Database models for Calorie Tracker API.
"""
from random import choices
from secrets import choice
from django.utils.timezone import now
from email.policy import default
from time import process_time_ns
import django
from django.db import models


class FoodData(models.Model):
   """ FoodData Model """
   
   name = models.CharField(max_length=255)
   protein = models.DecimalField(max_digits=7,decimal_places=2)  
   fat = models.DecimalField(max_digits=7,decimal_places=2)
   carbohydrate = models.DecimalField(max_digits=7,decimal_places=2) 
   calorie = models.DecimalField(max_digits=7,decimal_places=2)


class UserDailyIntake(models.Model):
   """ UserDailyIntake Model """

   BREAKFAST = 'BR'
   LUNCH = 'LU'
   DINNER = 'DI'
   SNACKS = 'SN'
   MEAL_CHOICES = [
      (BREAKFAST,'Breakfast'),
      (LUNCH,'Lunch'),
      (DINNER,'Dinner'),
      (SNACKS,'Snacks'),

   ]
   user = models.CharField(max_length=255)
   date = models.DateTimeField(default=now)
   food_data = models.ForeignKey(FoodData,on_delete=models.CASCADE)
   amount = models.IntegerField()
   meal = models.CharField(max_length=2,choices=MEAL_CHOICES,default=BREAKFAST)
