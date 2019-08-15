FROM python:3.7-alpine
MAINTAINER NathanaelGuirguis

# Recommended setting for running Python inside of a container
ENV PYTHONUNBUFFERED 1

# Makes a copy of the local requirements.txt and copies to the docker container, then have pip install all dependencies.
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create an app directory and copy it inside the Docker image
RUN mkdir /app 
WORKDIR /app 
COPY ./app /app

#Create a user named user, and then start as the user 'user'
# If you do not specify a user here, you will automatically log in as root 
RUN adduser -D user
USER user 
