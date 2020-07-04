from .serializers import UserSerializer, UserSerializer2
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from django.contrib.auth import authenticate
from django.contrib.auth.models import User

# Create your views here.
class UserSignup(APIView):
	"""
	List all users or create a user
	"""
	def get(self, format=None):
		users = User.objects.all()
		serializer = UserSerializer(users, many=True)
		return Response(serializer.data)

	def post(self, request, format=None):
		serializer = UserSerializer(data=request.data)
		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data, 
							status=status.HTTP_201_CREATED)
		return Response(serializer.errors,
						status=status.HTTP_400_BAD_REQUEST)


class UserSignin(APIView):
	"""
	Retrieve a registered user
	"""
	def post(self, request, format=None):
		serializer = UserSerializer(data=request.data)
		if serializer.is_valid():
			user = authenticate(username=request.POST.get('email'),
								password=request.POST.get('password'))
			if user  is not None:
				login(request, user)
				return Response(serializer.data,
								status=status.HTTP_201_CREATED)
			return Response(serializer.errors,
						status=status.HTTP_405_NOT_FOUND)
		return Response(serializer.errors,
						status=status.HTTP_400_BAD_REQUEST)