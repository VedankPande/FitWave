from django.urls import path
from .views import WorkoutView,ExerciseDataView

urlpatterns = [
    path('workout/', WorkoutView.as_view()),
    path('exercise-data/',ExerciseDataView.as_view()),
]