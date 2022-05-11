from django.http import QueryDict
from rest_framework import serializers
from .models import ExerciseData,ExerciseObject,Workout

class ExerciseDataSerializer(serializers.ModelSerializer):

    class Meta:
        model = ExerciseData
        fields = ('name','muscles_worked')


class ExerciseObjectSerializer(serializers.ModelSerializer):

    custom_validated_data = {}
    exercise_data = ExerciseDataSerializer()
    class Meta:
        model = ExerciseObject
        fields = ('id','sets','reps','exercise_data','workout')
    
    def validate(self,data):
        request_fields = data.keys()
        for field in self.Meta.fields:
            if field == "id":
                continue
            if field in request_fields:
                self.custom_validated_data[field] = data[field]
            else:
                print(f"{field} is required")
                return False
        return True

    def create(self,validated_data):
        return ExerciseObject.objects.create(**validated_data)


class WorkoutSerializer(serializers.ModelSerializer):
    
    workout_exercises =ExerciseObjectSerializer(many=True)

    class Meta:
        model = Workout
        #depth = 1
        fields = ('id','owner','name','workout_exercises')

    def create(self,validated_data):
        try:
            return Workout.objects.create(**validated_data)
        except Exception as exc:
            return exc