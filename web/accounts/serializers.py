from .models import User
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
	def create(self, validated_data):
		user = User.objects.create_user(**validated_data)
		return user

	class Meta:
		model = User
		fields = ('name', 'email', 'password')


class UserSerializer2(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = ('email', 'password')