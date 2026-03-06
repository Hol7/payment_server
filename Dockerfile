FROM elixir:1.19

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix compile

COPY . .

# Create database and run migrations at runtime, not build time
# These will be handled by docker-compose entrypoint or wait script

EXPOSE 4000

CMD ["mix", "phx.server"]