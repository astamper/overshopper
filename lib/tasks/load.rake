require 'open-uri'
require 'json'

task :load => :environment do
  @tv = Television.all
  @tv.destroy_all
  for page in 1..10 do
    url = "https://api.remix.bestbuy.com/v1/products((categoryPath.id=abcat0101000))?apiKey=#{ENV["BESTBUY_KEY"]}&pageSize=100&page=#{page}&format=json"
    result = open(url).read
    @parsed_result = JSON.parse(result)
    @parsed_result["products"].each_with_index do |var, index|
      @tv = Television.new
      @tv.name = @parsed_result["products"][index.to_i]["name"]
      @tv.imageurl = @parsed_result["products"][index.to_i]["largeImage"]
      @tv.brand = @parsed_result["products"][index.to_i]["manufacturer"]
      @tv.modelnumber = @parsed_result["products"][index.to_i]["modelNumber"]
      @tv.url = @parsed_result["products"][index.to_i]["url"]
      @tv.description = @parsed_result["products"][index.to_i]["longDescription"]
      @tv.width = @parsed_result["products"][index.to_i]["width"]
      @tv.depthwithstandin = @parsed_result["products"][index.to_i]["depthWithStandIn"]
      @tv.depthwithoutstandin = @parsed_result["products"][index.to_i]["depthWithoutStandIn"]
      @tv.heightwithstandin = @parsed_result["products"][index.to_i]["heightWithStandIn"]
      @tv.heightwithoutstandin = @parsed_result["products"][index.to_i]["heightWithoutStandIn"]
      @tv.customerreviewcount = @parsed_result["products"][index.to_i]["customerReviewCount"]
      @tv.customerreviewaverage = @parsed_result["products"][index.to_i]["customerReviewAverage"]
      @tv.tvtype = @parsed_result["products"][index.to_i]["tvType"]
      @tv.regularprice = @parsed_result["products"][index.to_i]["regularPrice"]
      @tv.saleprice = @parsed_result["products"][index.to_i]["salePrice"]
      @tv.save
    end
  end
end

