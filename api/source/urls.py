from rest_framework import routers

from api.source.views import TaskViewSet

router = routers.DefaultRouter()

router.register('tasks', TaskViewSet, basename="tasks")

urlpatterns = router.urls