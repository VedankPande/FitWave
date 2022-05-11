from json import loads,dumps
from django.http import JsonResponse
from rest_framework.views import APIView
from .models import ExerciseObject, Workout,ExerciseData
from .serializers import ExerciseDataSerializer, WorkoutSerializer, ExerciseObjectSerializer

#TODO:better filtering for owner and Error handling for get
#workoutview returns a workout along with its exercise details
class WorkoutView(APIView):
    
    def get(self,request):
        try:
            data = request.data #use owner to filter objects
            query = Workout.objects.filter(owner = data["owner"])
            data = WorkoutSerializer(instance=query,many=True).data
            data = loads(dumps(data))
            return JsonResponse({'status':200,"data":data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})
    
    def post(self,request):
        
        data = request.data
        s_data = WorkoutSerializer(data=data)
        if s_data.is_valid():
            s_data.create(s_data.validated_data)
            return JsonResponse({"status":200,"data": s_data.validated_data})
        else:
            return JsonResponse({"status":500,"data":s_data.errors})
    
    #requires workout_id
    def delete(self,request,id):
        try:
            Workout.objects.filter(id = id).delete()
            return JsonResponse({"status":200,"data": "Deleted workout"})
        except Exception as e:
            return JsonResponse({'status':400,"data":e})


class ExerciseDataView(APIView):

    def get(self,request):
        try:
            exercises = ExerciseData.objects.all()
            data = ExerciseDataSerializer(instance=exercises,many=True).data
            data = loads(dumps(data))
            return JsonResponse({"status":200,"data":data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})

#post implementation very messy: fix nested serializer issue with default validator
class ExerciseObjectView(APIView):

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
            return JsonResponse({'status': 200, 'data': ExerciseObjectSerializer(instance=exercise_object).data})
        else:
            return JsonResponse({'status': 500, 'data':{}})
    
    def delete(self,request,id):
        try:
            ExerciseObject.objects.filter(id = id).delete()
            return JsonResponse({'status':200,'data':"deleted exercise object"})
        except Exception as e:
            return JsonResponse({'status':400,'data':e})