FROM python:3.10

RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /code

COPY poetry.lock pyproject.toml /code/
RUN /root/.local/bin/poetry config virtualenvs.create false
RUN /root/.local/bin/poetry install --without dev --no-root --no-interaction

RUN pip install uvicorn
COPY . /code

CMD ["uvicorn", "alex_api.app:app", "--host", "0.0.0.0", "--port", "8000"]

# If running behind a proxy like Nginx or Traefik add --proxy-headers
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80", "--proxy-headers"]