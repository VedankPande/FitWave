from django.urls import path
from .views import FoodView,FoodObjectView
urlpatterns = [
    path('food/',FoodView.as_view()),
    path('food-object/',FoodObjectView.as_view()),
    path('food-object/<user>',FoodObjectView.as_view()),
]