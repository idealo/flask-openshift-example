FROM python:3.7-alpine

RUN mkdir -p /deploy/app
COPY app/requirements.txt /deploy/app/requirements.txt
RUN pip install -r /deploy/app/requirements.txt

# Deploy application
COPY gunicorn_config.py /deploy/gunicorn_config.py
COPY app /deploy/app
WORKDIR /deploy/app

EXPOSE 8080

CMD ["gunicorn", "--config", "/deploy/gunicorn_config.py", "main:app"]
