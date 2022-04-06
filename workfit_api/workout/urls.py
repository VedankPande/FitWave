from django.urls import path
from .views import WorkoutView

urlpatterns = [
    path('workout/', WorkoutView.as_view()),
]