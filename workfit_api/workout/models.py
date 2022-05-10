from django.contrib.postgres.fields import ArrayField,JSONField,HStoreField
from django.db import models

#TODO: Change owner to ownerid(int) once finalized
class Workout(models.Model):
    owner = models.CharField(max_length=20)
    name = models.CharField(max_length=50)
    
    def __str__(self) -> str:
        return self.name

class ExerciseData(models.Model):
    name = models.CharField(max_length=60)
    muscles_worked = models.CharField(max_length=15)

    def __str__(self) -> str:
        return self.name

class ExerciseObject(models.Model):
    sets = models.IntegerField()
    reps = models.IntegerField()
    exercise_data = models.ForeignKey(ExerciseData,on_delete=models.CASCADE,related_name='exercise_instances')
    workout = models.ForeignKey(Workout,on_delete=models.CASCADE,related_name='workout_exercises')

    def __str__(self) -> str:
        return f"Exercise: {self.exercise_data.name} Workout: {self.workout.owner} {self.workout.name}"

#ExerciseData -> name, muscles worked etc
#exerciseObject-> sets,reps,workout_object(fk),exercise_object
#workout -> owner,exercises