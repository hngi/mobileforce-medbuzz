from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractUser

# Create your models here.
class UserManager(BaseUserManager):
    def create_user(self, email, name,
    				password, is_admin=False, 
    				is_staff=False, is_active=True):
        if not email:
            raise ValueError("User must have an email")
        if not password:
            raise ValueError("User must have a password")
        if not name:
            raise ValueError("User must have a name")

        user = self.model(
            email=self.normalize_email(email)
        )
        user.name = name
        user.set_password(password)  # change password to hash
        user.admin = is_admin
        user.staff = is_staff
        user.active = is_active
        return user


    def create_superuser(self, email, name, 
    					 password, **extra_fields):
        if not email:
            raise ValueError("User must have an email")
        if not password:
            raise ValueError("User must have a password")
        if not name:
            raise ValueError("User must have a name")

        user = self.model(
            email=self.normalize_email(email)
        )
        user.name = name
        user.set_password(password)
        user.admin = True
        user.staff = False
        user.active = True
        return user

class User(AbstractUser):
	name = models.CharField(blank=True, max_length=50)
	email = models.EmailField(unique=True)

	objects = UserManager()

	USERNAME_FIELD = 'email'
	REQUIRED_FIELDS = ['name']
	
	def __str__(self):
		return self.email