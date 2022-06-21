from random import choices
from secrets import choice
from django.utils.timezone import now
from email.policy import default
from time import process_time_ns
import django
from django.db import models

#TODO: Decide fields to use and finish the model
#TODO: Test model inheritance on fooddata and foodobject


class FoodData(models.Model):
   name = models.CharField(max_length=255)
   protein = models.DecimalField(max_digits=7,decimal_places=2)  
   fat = models.DecimalField(max_digits=7,decimal_places=2)
   carbohydrate = models.DecimalField(max_digits=7,decimal_places=2) 
   calorie = models.DecimalField(max_digits=7,decimal_places=2)
   water = models.DecimalField(max_digits=7,decimal_places=2) 
   sugar = models.DecimalField(max_digits=7,decimal_places=2) 
   fiber = models.DecimalField(max_digits=7,decimal_places=2) 
   calcium = models.DecimalField(max_digits=7,decimal_places=2)
   iron = models.DecimalField(max_digits=7,decimal_places=2) 
   magnesium = models.DecimalField(max_digits=7,decimal_places=2) 
   phosphorus = models.DecimalField(max_digits=7,decimal_places=2)
   potassium = models.DecimalField(max_digits=7,decimal_places=2) 
   sodium = models.DecimalField(max_digits=7,decimal_places=2) 
   zinc = models.DecimalField(max_digits=7,decimal_places=2) 
   copper = models.DecimalField(max_digits=7,decimal_places=2) 
   vitamin_a = models.DecimalField(max_digits=7,decimal_places=2) 
   vitamin_e = models.DecimalField(max_digits=7,decimal_places=2) 
   vitamin_d = models.DecimalField(max_digits=7,decimal_places=2) 
   vitamin_c = models.DecimalField(max_digits=7,decimal_places=2)
   vitamin_b6 = models.DecimalField(max_digits=7,decimal_places=2)
   vitamin_b12 = models.DecimalField(max_digits=7,decimal_places=2)

class UserDailyIntake(models.Model):
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
