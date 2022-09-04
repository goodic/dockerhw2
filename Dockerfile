FROM python:3.9
WORKDIR /code
COPY ./stocks_products .
COPY ./.env .
RUN pip install -r requirements.txt
EXPOSE 8000
CMD python manage.py migrate && gunicorn stocks_products.wsgi -b 0.0.0.0:8000
