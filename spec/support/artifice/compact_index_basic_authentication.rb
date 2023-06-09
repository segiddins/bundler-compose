# frozen_string_literal: true

require_relative "helpers/compact_index"

class CompactIndexBasicAuthentication < CompactIndexAPI
  before do
    halt 401, "Authentication info not supplied" unless env["HTTP_AUTHORIZATION"]
  end
end

require_relative "helpers/artifice"

Artifice.activate_with(CompactIndexBasicAuthentication)
