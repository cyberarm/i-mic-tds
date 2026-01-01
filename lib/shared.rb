module IMICTDS
  DEVELOPMENT_MODE = ARGV.join.include?("--dev")
  DEBUG_QUICKPLAY = ARGV.join.include?("--debug-quickplay")
  ROOT_PATH = File.expand_path("..", __dir__)

  module Networking
    DEFAULT_MAX_CLIENTS = 16
    DEFAULT_CHANNEL_COUNT = 8

    DEFAULT_PORT = 56_789
  end
end

if IMICTDS::DEVELOPMENT_MODE || IMICTDS::DEBUG_QUICKPLAY
  require_relative "../../ffi-enet/lib/ffi-enet"
  require_relative "../../ffi-enet/lib/ffi-enet/renet"
else
  require "ffi-enet"
  require "ffi-enet/renet"
end
require "digest/crc"

# TODO: Require CyberarmEngine::Vector and supporting classes for headless server

require_relative "version"
require_relative "index"

require_relative "ecs/entity_store"
require_relative "ecs/entity"
require_relative "ecs/component"
require_relative "ecs/components/position"
require_relative "ecs/components/velocity"
require_relative "ecs/components/render"
require_relative "ecs/system"
require_relative "ecs/systems/movement"
require_relative "ecs/systems/render"
require_relative "ecs/prefabs"

require_relative "networking/packet"
require_relative "networking/server"
require_relative "networking/connection"
require_relative "networking/packet_handler"
require_relative "networking/packet_handlers/input"
require_relative "networking/packet_handlers/snapshot"

require_relative "game"
require_relative "map"
require_relative "polygon"

require_relative "game_mode"
require_relative "game_modes/bomb_detonation"
require_relative "game_modes/capture_the_flag"
require_relative "game_modes/team_deathmatch"
require_relative "game_modes/king_of_the_hill"

module IMICTDS
  @_internal_monotonic_offset_ms = 0
  @_internal_index = Index.new

  # Assert that all of a classes children use a unique TYPE (id)
  def self.assert_subclassed_type_unique(klass)
    subclasses = klass.subclasses
    subclasses.each do |klass|
      subclasses.each do |compared|
        next if klass == compared

        raise "#{klass} and #{compared} have the same type! (#{klass::TYPE})" if klass::TYPE == compared::TYPE
      end
    end
  end

  def self.format_byte_size(byte_count)
    case byte_count
    when 0..1023 # Bytes
      "#{byte_count} B"
    when 1024..1_048_575 # KiloBytes
      "#{format_size_number(byte_count / 1024.0)} KB"
    when 1_048_576..1_073_741_999 # MegaBytes
      "#{format_size_number(byte_count / 1_048_576.0)} MB"
    else # GigaBytes
      "#{format_size_number(byte_count / 1_073_742_000.0)} GB"
    end
  end

  def self.format_size_number(i)
    format("%0.2f", i)
  end

  def self.milliseconds
    Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond) - @_internal_monotonic_offset_ms
  end

  def self._monotonic_offset_ms(ms)
    @_internal_monotonic_offset_ms = ms
  end

  def self.index
    @_internal_index
  end

  # Returns a UUIDv7-ish unique identifier with an acceptably low risk of collisions
  # as a string. "Reimplementing" as we plan to use mruby later for distribution.
  def self.generate_uuid
    unix_epoch_ms = (Time.now.to_f * 1000).to_i
    random_number = Random.srand

    hex_string = random_number.to_s(16)

    "%08x-%04x-%s-%s-%s" % [
      (unix_epoch_ms & 0x0000_ffff_ffff_0000) >> 16,
      (unix_epoch_ms & 0x0000_0000_0000_ffff),
      hex_string[0..3],
      hex_string[4..7],
      hex_string[8..19]
    ]
  end
end

# Keep me dev from making simple errors
IMICTDS.assert_subclassed_type_unique(IMICTDS::Networking::PacketHandler)
IMICTDS.assert_subclassed_type_unique(IMICTDS::ECS::Component)
# Tickle the clock
IMICTDS._monotonic_offset_ms(IMICTDS.milliseconds)
# Index our assets
IMICTDS.index.scan(File.expand_path("../../assets", __FILE__))
