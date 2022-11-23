# Create your views here.

from django.http import HttpResponse

from polls import models as polls_models


def index(request):
    output = "Questions & Choices\n=====================\n"
    questions = polls_models.Question.objects.all()
    for question in questions:
        output += f"{question.question_text}\n"
        choices = question.choice_set.all()
        for choice in choices:
            output += f"\t{choice.choice_text}\n"
        output += "---------------------------\n"
    return HttpResponse(output, content_type="text/plain")
