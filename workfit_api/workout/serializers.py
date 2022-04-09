from rest_framework import serializers
from .models import ExerciseData,ExerciseObject,Workout

class ExerciseDataSerializer(serializers.ModelSerializer):

    class Meta:
        model = ExerciseData
        fields = ('name','muscles_worked')


class ExerciseObjectSerializer(serializers.ModelSerializer):

    exercise_data = ExerciseDataSerializer(read_only=True)

    class Meta:
        model = ExerciseObject
        fields = ('sets','reps','exercise_data','workout')
    
    #TODO: finish create function
    def create(self,validated_data):
        return validated_data


class WorkoutSerializer(serializers.ModelSerializer):
    
    workout_exercises =ExerciseObjectSerializer(many=True,read_only=True)

    class Meta:
        model = Workout
        #depth = 1
        fields = ('id','owner','name','workout_exercises')

    def create(self,validated_data):
        try:
            return Workout.objects.create(**validated_data)
        except Exception as exc:
            return exc