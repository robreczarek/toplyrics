require 'rubygems'
require 'nokogiri'
require 'restclient' 
require 'open-uri'
require 'json/ext'
require 'date'

#entry page
base_url = "http://www.poemhunter.com"
file_name = 'poems.json'
pages = Array.new
poemLinks = Array.new
poems = Array.new

#all poems are stored on 20 pages. This loop generates a page for each one.
(1..20).each do |i| 
	pages.push( base_url + "/p/m/l.asp?p=" + i.to_s + "&l=Top500" )
end

#grab each poem on index page
pages.each do |page|
	
	poemList = Nokogiri::HTML(RestClient.get(page))
	thisPage = poemList.css("td.title a")

	thisPage.each do |link|
		poemLinks.push base_url + link["href"]
	end

end

#loep through poem link list and grab data
poemLinks.each do |poemLink|

	#grab poem from list
	poemData = Nokogiri::HTML(RestClient.get(poemLink))

	#save poem into hash
	poem = {
		#might want to improve string formatting to save line breaks
		"title" => poemData.css("h2[itemprop='name']").text,
		"author" => poemData.css("div[class='poet']").text,
		"body" => poemData.css("div[class='KonaBody']").text
	}
	#push poem hash into array
	poems.push(poem)

	#sleep for 5 seconds so that we don't hammer the server
	sleep 1

	current_time = DateTime.now
	current_time = current_time.strftime "%d/%m/%Y %H:%M:%S"
	puts "Completed poem (" + current_time + "): " + poemLink

end

#turn poem array into json and write into file
File.open(file_name, "w") do |f|     
	f.write(poems.to_json)
end