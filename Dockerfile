FROM python:3.12
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
# COPY --from=ghcr.io/astral-sh/uv:python3.12-trixie-slim /uv /uvx /bin/

ENV UV_NO_DEV=1
WORKDIR /app/


COPY ./pyproject.toml /app/pyproject.toml
COPY ./README.md /app/README.md
COPY ./LICENSE /app/LICENSE
COPY ./src/dtcg_jupyter_board /app/dtcgboard
COPY ./src/dtcg_jupyter_board/static/ /app/static/

RUN uv sync --no-dev --extra oggm
# RUN uv pip install --upgrade -e .[oggm]

WORKDIR /app/dtcgboard/
CMD ["/app/.venv/bin/panel", "serve", "dashboard.ipynb", "--port", "8080"]

# CMD ["fastapi", "run", "app.py", "--proxy-headers", "--port", "8080"]
# CMD ["/app/.venv/bin/fastapi", "run", "app/main.py", "--port", "80", "--host", "0.0.0.0"]