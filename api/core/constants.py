from enum import Enum


class ChoiceEnum(Enum):
    @classmethod
    def choices(cls):
        return [(choice.value, choice.name) for choice in cls]


class Status(ChoiceEnum):
    TODO = 1
    DONE = 2
