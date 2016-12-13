FROM elixir

RUN mkdir -p /app
COPY . /app


WORKDIR /app
RUN mix local.hex --force
RUN mix deps.get
RUN mix do ecto.create, ecto.migrate
RUN npm install

CMD ["mix", "pheonix.server"]
