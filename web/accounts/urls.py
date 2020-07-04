from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = format_suffix_patterns([
	path('signin/', views.UserSignin.as_view()),
	path('signup/', views.UserSignup.as_view()),
])