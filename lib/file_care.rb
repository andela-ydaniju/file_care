# frozen_string_literal: true
require 'file_care/version'
require 'pry'
module FileCare
  def trash(*args)
    args.each do |file|
      if File.exist? "#{destination}/#{File.basename(file)}"
        FileUtils.mv(file, file = add_time(file))
      end
      FileUtils.mv(file, destination)
    end
  rescue Errno::ENOENT => e
    puts e.message
  end

  def destination
    "#{Dir.home}/.Trash"
  end

  def add_time(file)
    now = Time.now.strftime('%H.%M.%S %p')
    base = File.basename(file, '.*')
    if File.directory? base
      return "#{sanitize!(file)} #{now}"
    else
      return "#{sanitize!(base)} #{now}#{File.extname(file)}"
    end
  end

  def sanitize!(file)
    file = file.slice(0..-2) if file.end_with? '/'

    file
  end
end

module FileUtils
  extend FileCare
end
