# frozen_string_literal: true

if ENV["BUNDLER_SPEC_RUBY_PLATFORM"]
  Object.send(:remove_const, :RUBY_PLATFORM)
  RUBY_PLATFORM = ENV["BUNDLER_SPEC_RUBY_PLATFORM"]
end

module Gem
  def self.ruby=(ruby)
    @ruby = ruby
  end

  Gem.ruby = ENV["RUBY"] if ENV["RUBY"]

  if ENV["BUNDLER_GEM_DEFAULT_DIR"]
    @default_dir = ENV["BUNDLER_GEM_DEFAULT_DIR"]
    @default_specifications_dir = nil
  end

  if ENV["BUNDLER_SPEC_WINDOWS"]
    @@win_platform = true # rubocop:disable Style/ClassVars
  end

  if ENV["BUNDLER_SPEC_PLATFORM"]
    class Platform
      @local = new(ENV["BUNDLER_SPEC_PLATFORM"])
    end
    @platforms = [Gem::Platform::RUBY, Gem::Platform.local]
  end

  self.sources = [ENV["BUNDLER_SPEC_GEM_SOURCES"]] if ENV["BUNDLER_SPEC_GEM_SOURCES"]

  if ENV["BUNDLER_IGNORE_DEFAULT_GEM"]
    module RemoveDefaultBundlerStub
      def default_stubs(pattern = "*")
        super.delete_if { |stub| stub.name == "bundler" }
      end
    end

    class Specification
      class << self
        prepend RemoveDefaultBundlerStub
      end
    end
  end
end
