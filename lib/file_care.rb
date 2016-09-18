# frozen_string_literal: true
require 'file_care/version'

module FileCare
  def trash(*args)
    args.each do |file|
      destination = "#{Dir.home}/.Trash"
      FileUtils.mv(file, destination)
    end
  end
end

module FileUtils
  extend FileCare
end
