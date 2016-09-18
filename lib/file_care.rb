# frozen_string_literal: true
require 'file_care/version'
require 'pry'
module FileCare
  def trash(*args)
    args.each do |file|
      if File.exist? "#{destination}/#{File.basename(file)}"
        FileUtils.mv(file, file = "#{sanitize!(file)}#{Time.now}")
      end
      FileUtils.mv(file, destination)
    end
  rescue Errno::ENOENT => e
    puts e.message
  end

  def destination
    "#{Dir.home}/.Trash"
  end

  def sanitize!(file)
    file = file.slice(0..-2) if file.end_with? '/'

    file
  end
end

module FileUtils
  extend FileCare
end
