from rest_framework import serializers
from .models import FoodData,UserDailyIntake

class FoodDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodData
        fields = '__all__'

class DailyIntakeSerializer(serializers.ModelSerializer):
    
    custom_validated_data = {}
    food_data = FoodDataSerializer()
    class Meta:
        model = UserDailyIntake
        fields = ('id','owner','date','food_data','amount')
    
    def validate(self,data):
        request_fields = data.keys()
        for field in self.Meta.fields:
            if field in ["id","date"]:
                continue
            if field in request_fields:
                self.custom_validated_data[field] = data[field]
            else:
                print(f"{field} is required")
                return False
        return True

    def create(self,validated_data):
        return UserDailyIntake.objects.create(**validated_data)

