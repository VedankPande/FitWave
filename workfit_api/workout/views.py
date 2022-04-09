from json import loads,dumps
from django.http import JsonResponse
from django.shortcuts import render
from regex import W
from rest_framework.views import APIView
from .models import Workout,ExerciseData,ExerciseObject
from .serializers import ExerciseDataSerializer, WorkoutSerializer, ExerciseObjectSerializer

#TODO:filter for owner
#workoutview returns a workout along with its exercise details
class WorkoutView(APIView):
    
    def get(self,request):
        response = []
        for workout in Workout.objects.all():
            data = WorkoutSerializer(instance=workout).data
            data = loads(dumps(data))
            response.append(data)
        return JsonResponse({'status':200,"data":response})
    
    #TODO: complete with serializer
    def post(self,request):
        
        data = request.data
        s_data = WorkoutSerializer(data=data)
        if s_data.is_valid():
            s_data.create(s_data.validated_data)
            return JsonResponse({"status":200,"data": s_data.validated_data})
        else:
            return JsonResponse({"status":500,"data":s_data.errors})


class ExerciseDataView(APIView):

    def get(self,request):
        exercises = ExerciseData.objects.all()
        data = ExerciseDataSerializer(instance=exercises,many=True).data
        data = loads(dumps(data))
        return JsonResponse({"status":200,"data":data})


class ExerciseObjectView(APIView):

    def post(self,request):
        data = request.data.copy() # required: sets,reps,workout_id,exercise_id
        data['workout'] = Workout.objects.filter(id=data['workout_id']).first()
        data['exercise_data'] = ExerciseData.objects.filter(id=data['exercise_id']).first()
        print(data)
        response = ExerciseObjectSerializer(instance=data).data
        return JsonResponse({'data':response})