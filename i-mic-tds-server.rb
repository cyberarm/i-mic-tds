require_relative "lib/shared"

# HOST (DEFAULT: 0.0.0.0)
# PORT (DEFAULT: 56789)
# MAP (DEFAULT: ?)
# GAME MODE (DEFAULT: Capture the Flag?)
# MAX PLAYERS (DEFAULT: 16)

server = IMICTDS::Networking::Server.new(host: "0.0.0.0", port: IMICTDS::Networking::DEFAULT_PORT)
loop do
  server.think
  sleep 0.001
end
