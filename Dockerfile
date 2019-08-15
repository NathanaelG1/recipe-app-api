FROM python:3.7-alpine
MAINTAINER NathanaelGuirguis

# Recommended setting for running Python inside of a container
ENV PYTHONUNBUFFERED 1

# Makes a copy of the local requirements.txt and copies to the docker container, then have pip install all dependencies.
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .temp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip3 install -r /requirements.txt
RUN apk del .temp-build-deps

# Create an app directory and copy it inside the Docker image
RUN mkdir /app 
WORKDIR /app 
COPY ./app /app

#Create a user named user, and then start as the user 'user'
# If you do not specify a user here, you will automatically log in as root 
RUN adduser -D user
USER user 
