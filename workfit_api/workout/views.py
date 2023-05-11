"""
Views for the workout APIs.
"""
from json import loads,dumps
from django.http import JsonResponse
from rest_framework.views import APIView
from .models import ExerciseObject, Workout,ExerciseData
from .serializers import ExerciseDataSerializer, WorkoutSerializer, ExerciseObjectSerializer


class WorkoutView(APIView):
    """ WorkoutView

        get:
        Return a list of all workouts for the user.
        
        post:
        Create a new workout instance in the database

        delete:
        Delete a workout instance in the database.
    """
    def get(self,owner):
        try:
            query = Workout.objects.filter(owner = owner)
            data = WorkoutSerializer(instance=query,many=True).data
            data = loads(dumps(data))
            return JsonResponse({'status':200,"data":data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})
    
    def post(self,request):
        
        data = request.data
        s_data = WorkoutSerializer(data=data)
        if s_data.is_valid():
            return JsonResponse({"status":200,"data": WorkoutSerializer(instance=s_data.create(s_data.validated_data)).data})
        else:
            return JsonResponse({"status":500,"data":s_data.errors})
    
    def delete(self,request,id):
        try:
            Workout.objects.filter(id = id).delete()
            return JsonResponse({"status":200,"data": "Deleted workout"})
        except Exception as e:
            return JsonResponse({'status':400,"data":e})


class ExerciseDataView(APIView):
    """ ExerciseDataView

        get:
        Return a list of all excercises.
    """

    def get(self,request):
        try:
            exercises = ExerciseData.objects.all()
            data = ExerciseDataSerializer(instance=exercises,many=True).data
            data = loads(dumps(data))
            return JsonResponse({"status":200,"data":data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})

class ExerciseObjectView(APIView):
    """ ExerciseObjectView
    
    post:
    Create a new workout set (with sets and reps) for the user.

    delete:
    Delete a workout set (with sets and reps) for the user.
    """
    def post(self,request):
        data = request.data.copy() # required: sets,reps,workout_id,exercise_id
        try:
            data['exercise_data'] = ExerciseData.objects.filter(id=data['exercise_id']).first()
            data['workout'] = Workout.objects.filter(id=data['workout_id']).first()
        except Exception as e:
            return JsonResponse({'status':500, 'data':repr(e)})
        eos = ExerciseObjectSerializer()
        if eos.validate(data):
            exercise_object = eos.custom_validated_data
            return JsonResponse({'status': 200, 'data': ExerciseObjectSerializer(instance = eos.create(exercise_object)).data})
        else:
            return JsonResponse({'status': 500, 'data':{}})
    
    def delete(self,request,id):
        try:
            ExerciseObject.objects.filter(id = id).delete()
            return JsonResponse({'status':200,'data':"deleted exercise object"})
        except Exception as e:
            return JsonResponse({'status':500,'data':e})