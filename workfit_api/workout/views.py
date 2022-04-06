from django.http import JsonResponse
from django.shortcuts import render
from rest_framework.views import APIView
from .models import Workout,ExerciseData,ExerciseObject
# Create your views here.

#TODO: refactor with serializers
#workoutview returns a workout along with its exercise details
class WorkoutView(APIView):
    
    def get(self,request):
        response = {}
        for workout in Workout.objects.all():
            response[workout] = []
            for exercise in workout.exercise_instances:
                response[workout].append({
                    "name":exercise.exercise_data.name,
                    "sets":exercise.sets,
                    "reps":exercise.reps,
                })
        return JsonResponse({'status':200,"data":response})
    
    def post(self,request):
        
        try:
            print(request.data)
            return JsonResponse({"status":200,"data":request.data})
        except Exception as e:
            print(e)
            return JsonResponse({"status":400,"data":e})

        


#class="Z0LcW an_fna"