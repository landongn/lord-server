FROM marcelocg/phoenix

RUN mkdir -p /app
COPY . /app

WORKDIR /app

CMD ["mix", "phoenix.server"]
