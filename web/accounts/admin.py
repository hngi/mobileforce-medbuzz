from django import forms
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.forms import UserChangeForm

from .models import User

# Register your models here.
class UserCreationForm(forms.ModelForm):
	"""A form for creating new users. Includes all the require
	fields"""
	password = forms.CharField(label='Password', 
							   widget=forms.PasswordInput)

	class Meta:
		model = User
		fields = ('name', 'email')

	def save(self, commit=True):
		# Save the provided password in hashed format
		user = super().save(commit=False)
		user.set_password(self.cleaned_data["password"])
		if commit:
			user.save()
		return user 


class CustomUserChangeForm(UserChangeForm):

	class Meta:
		model = User
		fields = ('name', 'email')


class UserAdmin(BaseUserAdmin):
	form = CustomUserChangeForm
	addform = UserCreationForm
	model = User
	list_display = ['email', 'name']


admin.site.register(User, UserAdmin)