require 'http'
require 'json'
require 'date'

class Rekord < ActiveRecord::Base

  def self.fetch_data
	user_agent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; CIBA)"
        data_api   = "http://www.showfm.net/api/record.asp"
	fupdated   = "#{Rails.root}/tmp/record.udt"
	
	updateparam = ApplicationHelper.loadUpdatedmark(fupdated)
	data_api = data_api+"?perpage=1000000&after="+updateparam
	# for fucking debug
	puts data_api

	datacontent = HTTP.with_headers("User-Agent" => user_agent).get(data_api)
	record_data = JSON.parse(datacontent)

	# for fucking debug
	puts record_data	

	if record_data != nil
		record_arr = record_data["records"]

		record_arr.each do |r|
			record = Rekord.find_by_id(r['id'])
			if record == nil
				puts "create a new record #{r}"
				speaker = Speaker.find_by_nameid(r['nj_id'])

				if speaker == nil
					puts "create a new speaker"
					Speaker.create(:name=>r['nj_name'], :nameid=>r['nj_id'])
					speaker = Speaker.find_by_nameid(r['nj_id'])
				end

				Rekord.create(:id=>r['id'], :name=>r['name'], :url=>r['url'], :updated=>r['updated'], :novel_id=>r['novel_id'], :speaker_id=>speaker.id)

			end
		end

		ApplicationHelper.markUpdated(fupdated)
	end
	
  end

  belongs_to :novel
  belongs_to :speaker
end
