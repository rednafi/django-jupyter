from django.urls import path

from polls import views as polls_views

urlpatterns = [
    path("", polls_views.index, name="index"),
]
