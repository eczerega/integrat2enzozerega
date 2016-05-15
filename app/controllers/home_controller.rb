class HomeController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def index
	end

	def buscar
		tag = params[:tag]
		access_token = params[:access_token]
		if tag != nil && access_token != nil
			begin
				respond_to do |format|	
					url = URI("https://api.instagram.com/v1/tags/"+tag+"?access_token="+access_token)
					puts url
					http = Net::HTTP.new(url.host, url.port)
					http.use_ssl = true
					http.verify_mode = OpenSSL::SSL::VERIFY_NONE
					request = Net::HTTP::Get.new(url)
					response = http.request(request)
					response1_json = JSON.parse(response.read_body)
					#metadata
					total = response1_json["data"]["media_count"].to_i
					url = URI("https://api.instagram.com/v1/tags/"+tag+"/media/recent?access_token="+access_token)
					http = Net::HTTP.new(url.host, url.port)
					http.use_ssl = true
					http.verify_mode = OpenSSL::SSL::VERIFY_NONE
					request = Net::HTTP::Get.new(url)
					response = http.request(request)
					response2_json= JSON.parse(response.read_body)
					tags = Array.new
					all_posts = Array.new
					user = nil
					likes = nil
					images= nil
					caption = nil
					response2_json["data"].each do |post|
						#tags.push(post["tags"])
						begin
							tags = post["tags"]
						rescue
							tags= "no tags"
						end
						begin
							username= post["user"]["username"].to_s
						rescue
							username="no user"
						end
						begin
							likes= post["likes"]["count"].to_i
						rescue
							likes = 0
						end
						begin
							url= post["images"]["standard_resolution"]["url"].to_s
						rescue
							url="no url"
						end
						begin
							caption= post["caption"]["text"].to_s
						rescue
							caption="no caption"
						end
							post_json = {:tags => tags, :username => username, :likes => likes, :url => url, :caption => caption}
						
						all_posts.push(post_json)
					end
					metadata = {:total => total.to_i}
					if Update.first != nil
						metadata ={:metadata => metadata, :posts => all_posts, :version => Update.first.version.to_s + ", created at: " +  Update.first.date}
					else
						metadata ={:metadata => metadata, :posts => all_posts, :version => '1'}
					end
					format.all { render :json => metadata, :status => 200 }
					#format.all { render :text => "Error formato no soportado", :status => 400 }
				end
			rescue Exception => e
				respond_to do |format|		
					format.all { render  :json => { :errors => e.to_s }, :status => 400 }
					#format.all { render :text => "Error formato no soportado", :status => 400 }				
				end						
			end
		else
			respond_to do |format|		
				format.all { render  :json => { :errors => 'parametros incorrectos' }, :status => 400 }
				#format.all { render :text => "Error formato no soportado", :status => 400 }
			end			
		end
	end

end
