# django-jupyter
Connecting an ipython notebook server to a containerized Django application.

## Prerequisites

Make sure you're running the latest version of [docker][docker] and
[docker-compose-v2][docker-compose-v2].

## Local development

* Clone the repo.

* Go to the root directory and run:

    ```
    make up
    ```
    This will spin up the docker containers.

* Run the migration:

    ```
    make migrate
    ```
* To access the notebook server go to http://localhost:8895.
* Create some objects from the notebook:

    ![notebook][notebook-scr]

    ```python
    from polls import models as polls_models
    from datetime import datetime, timezone

    for question_text in ("Are you okay?", "Do you wanna go there?"):
        question = polls_models.Question.objects.create(
            question_text=question_text, pub_date=datetime.now(tz=timezone.utc)
        )
        question.choice_set.set(
            polls_models.Choice.objects.create(choice_text=ctext)
            for ctext in ("yes", "no")
        )
    ```
* Inspect the newly created data in http://localhost:8000.

    ![django][django-scr]


[docker]: https://www.docker.com/
[docker-compose-v2]: https://docs.docker.com/compose/compose-v2/
[notebook-scr]: https://user-images.githubusercontent.com/30027932/211682786-fb64effb-eee8-4f5d-bb9d-4bf04e981d28.png
[django-scr]: https://user-images.githubusercontent.com/30027932/211680225-853ff7ed-2d10-4f5e-8b76-3f2550ff94b9.png
