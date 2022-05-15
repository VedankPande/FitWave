from django.urls import path
from .views import ExerciseObjectView, WorkoutView,ExerciseDataView

urlpatterns = [
    path('workout/', WorkoutView.as_view()),
    path('workout/<owner>', WorkoutView.as_view()),
    path('workout/<int:id>', WorkoutView.as_view()),
    path('exercise-data/',ExerciseDataView.as_view()),
    path('exercise-add/',ExerciseObjectView.as_view()),
    path('exercise-delete/<int:id>',ExerciseObjectView.as_view()),
]