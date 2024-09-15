# Set the base image
FROM elixir:1.16.3-otp-26-alpine

# Update base image and add system-level dependencies
RUN apk add --update build-base
RUN apk add --no-cache git build-base

# Set the working directory
WORKDIR /app

# Set up hex and rebar
RUN mix do local.hex --force
RUN mix do local.rebar --force

# Copy the project to the working directory
COPY . .

# Install project dependencies and run migrations
RUN mix deps.clean --all
RUN mix deps.get
RUN mix compile --force
RUN mix ecto.migrate

# Expose port and set the run commands
EXPOSE 4000
CMD ["iex", "-S", "mix", "phx.server"]