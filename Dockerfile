FROM python:3.11-bullseye

# Set the working directory inside the container.
WORKDIR /code

# Don't write .pyc files and make the output unbuffered.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies.
RUN pip install --upgrade pip
COPY requirements.txt requirements-dev.txt  ./
RUN pip install -r requirements.txt -r requirements-dev.txt

# Copy the project code.
COPY . /code
