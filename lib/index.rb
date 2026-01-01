module IMICTDS
  class Index
    class Error < StandardError; end
    class FilenameNotUniqueError < Error; end
    class FileHashCollisionError < Error; end

    def initialize
      @index = {}
    end

    def scan(directory)
      Dir.glob("#{directory}/**/*.*").each do |file|
        key = File.basename(file).downcase
        # Ignore certain files the game doesn't care about
        next if key == "license.txt"
        next if key == "ofl.txt" # open font license

        raise FilenameNotUniqueError, "Asset filename is not unique! #{key} | #{file}" if @index[key]

        digest = Digest::CRC32.file(file).hexdigest

        @index.each do |k, pair|
          if pair[:hash] == digest
            raise FileHashCollisionError, "Asset file hash collision! `#{k}` collides with `#{key}`"
          end
        end

        # All checks have passed, add to index
        @index[key] = {
          path: File.expand_path(file),
          hash: digest
        }
      end
    end

    def key?(key)
      @index[key]
    end

    def path(key)
      @index.dig(key, :path)
    end

    def hash(key)
      @index.dig(key, :hash)
    end
  end
end
