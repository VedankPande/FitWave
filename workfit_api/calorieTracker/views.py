from json import loads,dumps
from rest_framework.generics import ListAPIView
from django.http import JsonResponse
from .models import UserDailyIntake,FoodData
from rest_framework.views import APIView
from .serializers import DailyIntakeSerializer,FoodDataSerializer

class FoodView(APIView):
    """ FoodView

        get:
        Return a list of all food records in the database.

    """
    
    def get(self,request):
        query = FoodData.objects.all()
        data = FoodDataSerializer(instance=query,many=True).data
        data = loads(dumps(data))
        return JsonResponse({'status':200,'data':data})

class FoodObjectView(APIView):

    """ WorkoutView

        get:
        Return a list of all food instances logged by the user.
        
        post:
        Create a new food logging instance for the user.

        delete:
        Delete a food logging instance for the user.

    """

    def get(self,request,user):
        try:
            query = UserDailyIntake.objects.filter(user = user)
            data = DailyIntakeSerializer(instance=query,many=True).data
            data = loads(dumps(data))
            return JsonResponse({'status':200,'data':data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})

    def post(self,request):
        data = request.data.copy()
        try:
            data['food_data'] = FoodData.objects.filter(id = data["id"]).first()
        except Exception as exc:
            print(repr(exc))
        serializer = DailyIntakeSerializer()
        if serializer.validate(data):
            intake_object = serializer.custom_validated_data
            return JsonResponse({'status':200,'data':DailyIntakeSerializer(instance=serializer.create(intake_object)).data})
        else:
            return JsonResponse({'status':500,'data':{}})

    def delete(self,request,id):
        try:
            UserDailyIntake.objects.filter(id=id).delete()
            return JsonResponse({'status':200,'data':'deleted userintake object'})
        except Exception as e:
            return JsonResponse({'status':500,'data':e})
