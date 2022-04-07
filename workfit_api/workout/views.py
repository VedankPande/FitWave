from json import loads,dumps
from django.http import JsonResponse
from django.shortcuts import render
from rest_framework.views import APIView
from .models import Workout,ExerciseData,ExerciseObject
from .serializers import ExerciseDataSerializer, WorkoutSerializer
# Create your views here.

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
        Workout.objects.create(name=data['name'],owner=data["owner"])
        return JsonResponse({"status":200,"data":WorkoutSerializer(data,many=False)})


class ExerciseDataView(APIView):

    def get(self,request):
        exercises = ExerciseData.objects.all()
        data = ExerciseDataSerializer(instance=exercises,many=True).data
        data = loads(dumps(data))
        return JsonResponse({"status":200,"data":data})


class ExerciseObjectView(APIView):

    def post(self,request):
        pass
        


#class="Z0LcW an_fna"