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
CMD ["/app/.venv/bin/panel", "serve", "app.py", "--port", "8080", "--prefix", "/dtcgboard", "--num-threads", "0", "--num-procs", "2", "--address", "0.0.0.0", "--index", "app"]
