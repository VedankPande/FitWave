from json import loads,dumps
from rest_framework.generics import ListAPIView
from django.http import JsonResponse
from .models import UserDailyIntake,FoodData
from rest_framework.views import APIView
from .serializers import DailyIntakeSerializer,FoodDataSerializer

#TODO: search functionality
class FoodView(APIView):

    #returns all food data
    def get(self,request):
        query = FoodData.objects.all()
        data = FoodDataSerializer(instance=query,many=True).data
        data = loads(dumps(data))
        return JsonResponse({'status':200,'data':data})

class FoodObjectView(APIView):

    def get(self,request,user):
        try:
            query = UserDailyIntake.objects.filter(user = user)
            data = DailyIntakeSerializer(instance=query,many=True).data
            data = loads(dumps(data))
            return JsonResponse({'status':200,'data':data})
        except Exception as e:
            return JsonResponse({'status':500,'data':repr(e)})

    #requires food_data id,user,amount
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

    #requires id
    def delete(self,request):
        pass

##################################################################################################################################################################################

#TODO: Complete this - experimental
class FoodObjectQuery(ListAPIView):

    model = UserDailyIntake
    serializer = DailyIntakeSerializer

    def get_queryset(self):
        query_set = UserDailyIntake.objects.all()
        user = self.request.query_params.get('user')
        weekly = self.request.query_params.get('weekly') # boolean value? - check if weekly view is required - might be better ways to do this (send all data for user and filter in front end)
        date = self.request.query_params.get('date')