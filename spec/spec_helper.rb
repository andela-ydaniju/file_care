# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each do |f|
  require_relative f
end
require 'file_care'
