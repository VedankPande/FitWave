from json import loads,dumps
from rest_framework.generics import ListAPIView
from django.http import JsonResponse
from .models import UserDailyIntake,FoodData
from rest_framework.views import APIView
from .serializers import DailyIntakeSerializer,FoodDataSerializer
# Create your views here.


class FoodView(APIView):

    #returns all food data
    def get(self,request):
        query = FoodData.objects.all()
        data = FoodDataSerializer(instance=query,many=True).data
        data = loads(dumps(data))
        return JsonResponse({'status':200,'data':data})


#TODO: Complete this
class FoodObjectQuery(ListAPIView):

    model = UserDailyIntake
    serializer = DailyIntakeSerializer

    def get_queryset(self):
        query_set = UserDailyIntake.objects.all()
        user = self.request.query_params.get('user')
        weekly = self.request.query_params.get('weekly') # boolean value? - check if weekly view is required - might be better ways to do this (send all data for user and filter in front end)
        date = self.request.query_params.get('date')

class FoodObjectView(APIView):

    def get(self,request):
        data = request.data
        query = UserDailyIntake.objects.filter(user = data.user)
        data = DailyIntakeSerializer(instance=query,many=True).data
        data = loads(dumps(data))
        return JsonResponse({'status':200,'data':data})
    
    #requires foodData id,user
    def post(self,request):
        data = request.data
        pass

    def delete(self,request):
        pass