# Create your tests here.

from datetime import datetime, timezone

from django.test import TestCase

from polls import models as polls_models


class PollsTestCase(TestCase):
    def setUp(self):
        # Create questions and choices.
        for question_text in ("Are you okay?", "Do you wanna go there?"):
            question = polls_models.Question.objects.create(
                question_text=question_text, pub_date=datetime.now(tz=timezone.utc)
            )
            question.choice_set.set(
                polls_models.Choice.objects.create(choice_text=ctext)
                for ctext in ("yes", "no")
            )

    def test_polls(self):
        questions = polls_models.Question.objects.all()
        assert questions.count() == 2

        choices = polls_models.Choice.objects.all()
        assert choices.count() == 4
