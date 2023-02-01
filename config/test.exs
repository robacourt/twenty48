import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twenty48, Twenty48Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xWJ0xzGpZTpE5RqdCrRp5ewi5jCWNt5UHF/e0kPA1Z80tSbYBbJupT7teVBtzJhV",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
