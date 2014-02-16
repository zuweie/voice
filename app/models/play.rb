require 'http'
require 'json'
require 'date'

class Play < ActiveRecord::Base
 
  def self.fetch_data
   	user_agent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; CIBA)"
        data_api   = "http://www.showfm.net/api/play.asp"
	fupdated   = "#{Rails.root}/tmp/play.udt"

	updateparam = ApplicationHelper.loadUpdatedmark(fupdated)
	data_api = data_api+"?after="+updateparam

	datacontent = HTTP.with_headers("User-Agent" => user_agent).get(data_api)
	play_data = JSON.parse(datacontent)

	if play_data != nil
		play_arr = play_data["plays"]
		play_arr.each do | p |
			play = Play.find_by_id(p["id"])
			
			if play == nil
				speaker = Speaker.find_by_nameid(p["team"])
				if speaker == nil
					puts " create a new speaker #{p['team']}"
					Speaker.create(:name=>p["team"], :nameid=>p["team"])
					speaker = Speaker.find_by_nameid(p["team"])
				end
				
				puts "create a new play, #{p['name']}"
				
				Play.create(:id=>p["id"], :name=>p["name"], :url=>p["url"], :poster=>p["poster"], :body=>p["body"], :updated=>p["updated"], :tag=>p["tag"], :speaker_id=>speaker.id)
				
			else 
				puts "update the updated field, play : #{p['name']} at #{p['updated']}"
				play.update_attributes(:updated=>p["updated"])
			end
		end
		ApplicationHelper.markUpdated(fupdated)
	end
  end

  belongs_to :speaker
end
