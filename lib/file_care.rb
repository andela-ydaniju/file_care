# frozen_string_literal: true
require 'file_care/version'

module FileCare
  def trash(*args)
  end
end

module FileUtils
  extend FileCare
end
