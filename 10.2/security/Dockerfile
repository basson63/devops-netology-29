FROM python:3.9-alpine
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt &&  pip install --upgrade Jinja2
COPY src ./

CMD [ "python", "./server.py" ]
