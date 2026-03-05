FROM elixir:1.19

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY . .

RUN mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]