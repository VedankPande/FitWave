from django.urls import path
from .views import FoodView
urlpatterns = [
    path('food/',FoodView.as_view()),
]