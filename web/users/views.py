from rest_framework import generics

from . import models, serializers

# Create your views here.
class UserListView(generics.ListAPIView):
	queryset = models.CustomUser.objects.all()
	serializer_class = serializers.UserSerializer