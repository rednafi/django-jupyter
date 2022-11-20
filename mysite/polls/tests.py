# Create your tests here.

from random import choices
from django.test import TestCase
from polls import models as polls_models
from datetime import datetime, timezone

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
        self.assertEqual(questions.count(), 2)

        choices = polls_models.Choice.objects.all()
        self.assertEqual(choices.count(), 4)
