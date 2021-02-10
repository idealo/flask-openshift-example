FROM python:3.9-alpine

LABEL maintainer="dat.tran@idealo.de"

ENV PYTHONUNBUFFERED=1

EXPOSE 8080
WORKDIR /deploy/app

COPY app /deploy/app
COPY gunicorn_config.py /deploy/gunicorn_config.py

RUN pip install -r /deploy/app/requirements.txt

CMD ["gunicorn", "--config", "/deploy/gunicorn_config.py", "main:app"]
