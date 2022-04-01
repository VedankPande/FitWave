from django.db import models

# Create your models here.

class Workout(models.Model):
    name = models.CharField(max_length=50)