from django.db import models

from api.core.constants import Status


class Task(models.Model):
    description = models.CharField(max_length=250)
    status = models.IntegerField(choices=Status.choices(), default=1)
