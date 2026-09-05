# Fully qualified image names are required for Podman CI (no TTY short-name prompt).
FROM docker.io/library/python:3.12-alpine
WORKDIR /app

COPY app.py test_app.py ./
RUN python -m unittest test_app.py -v

USER 1000

ENTRYPOINT ["python", "app.py"]
