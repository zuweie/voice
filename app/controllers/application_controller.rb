require 'date'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def loadUpdatedMark (f)

      updated = '1999-12-31%2023:59:59'
	if File.exists?(f)
		file = File.new(f, "r")
		if file.size != 0
			updated = file.read
			updated.gsub!("\n", "")
			updated.gsub!(" ","%20")
		end
		file.close
	end
	return updated
  end

  def markUpdated (f)
	file = File.new(f, "w+")
	now = DateTime.parse(Time.now.to_s).strftime('%Y-%m-%d %H:%M:%S').to_s
	file.write(now)
	file.close
  end 

end
