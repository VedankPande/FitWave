from rest_framework import serializers
from .models import FoodData,UserDailyIntake

class FoodDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodData
        fields = '__all__'

class DailyIntakeSerializer(serializers.ModelSerializer):
    
    food_data = FoodDataSerializer()
    class Meta:
        model = UserDailyIntake
        fields = '__all__'

