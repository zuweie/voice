require 'http'
require 'json'
require 'date'

class Novel < ActiveRecord::Base

  def self.fetch_data
        
        user_agent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; CIBA)"
        data_api   = "http://www.showfm.net/api/novel.asp"
	fupdated   = "#{Rails.root}/tmp/novel.udt"
	
	
	updateparam = ApplicationHelper.loadUpdatedmark(fupdated)
	data_api = data_api+"?after="+updateparam;	
	
	# for fucking debug
	p "data_api : " + data_api

	datacontent = HTTP.with_headers("User-Agent" => user_agent).get(data_api)
	novels_data = JSON.parse(datacontent)
	
	if novels_data != nil
		novels_arr = novels_data["novels"]
		novels_arr.each do | n |
		   novel = Novel.find_by_id(n["id"])
		   if novel == nil
			
			speaker = Speaker.find_by_nameid(n["nj_id"])

			if (speaker == nil)
				puts "create a new speaker #{n['nj_id']} #{n['nj_name']}"
				Speaker.create(:name=>n["nj_name"], :nameid=>n["nj_id"])
				speaker = Speaker.find_by_nameid(n["nj_id"])
			end 

			puts "create a new Novel #{n}"
			Novel.create(:id=>n["id"], :name=>n["novel_name"], :url=>n["url"], :poster=>n["poster"], :author=>n["author"], :updated=>n["updated"], :status=>n["status"], :category=>n["category"], :body=>n["body"], :keyword=>n["keyword"], :speaker_id=>speaker.id)

		   else
			puts "Update the updated field, novel <<#{n['novel_name']}>> new updated at #{n['updated']}"
			novel.update_attributes(:updated=>n["updated"])
		   end
		end
		ApplicationHelper.markUpdated(fupdated)
	end
  end


  belongs_to :speaker
  has_many :rekord
end
