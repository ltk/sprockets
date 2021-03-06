require 'sprockets/compressing'
require 'sprockets/engines'
require 'sprockets/mime'
require 'sprockets/paths'
require 'sprockets/processing'

module Sprockets
  module Configuration
    include Paths, Mime, Engines, Processing, Compressing

    def initialize_configuration(parent)
      @paths             = parent.paths
      @mime_types        = parent.mime_types
      @mime_exts         = parent.mime_exts
      @encodings         = parent.encodings
      @engines           = parent.engines
      @engine_extensions = parent.engine_extensions
      @preprocessors     = parent.preprocessors
      @postprocessors    = parent.postprocessors
      @bundle_processors = parent.bundle_processors
      @compressors       = parent.compressors
    end

    private
      def mutate_config(sym)
        obj = yield self.instance_variable_get("@#{sym}").dup
        self.instance_variable_set("@#{sym}", obj.freeze)
      end

      def mutate_hash_config(sym, key)
        mutate_config(sym) do |hash|
          obj = yield hash[key].dup
          hash[key] = obj.freeze
          hash
        end
      end
  end
end
