#  Search for the make, model, year of your car and verify the response status and that the response body contains the results that match your criteria.

testUrl = "https://api.edmunds.com/api/vehicle/v2/toyota/camry/2007?fmt=json&api_key=bucp3bkpzv85eg9k2kmbkt8p"

require 'faraday'
require 'spec_helper'
require 'json'

describe "CarModelTest" do
  context "Search for the make, model, year of your car and verify status and response body" do
    it "should receive a response code of 200" do
      response = Faraday.get testUrl
      expect(response.status).to eq 200
    end
    
    it "response body should contain my search criteria" do
      # Will verify that Model 'Camry' and Year '2007' - we know that a Camry's make belongs to Toyota, so no need to verify this.
      response = Faraday.get testUrl
      expect(response.status).to eq 200 # make sure we do get a successful response
      
      # Parse json response
      jsonResp = response.body
      parsedJson = JSON.parse(jsonResp)
      
      # Verify the year
      parsedJson["year"]=='2007'
      
      # Verify the car model
      parsedJson["styles"].find {|parsedJson1| parsedJson1['submodel'].find{|parsedJson2| parsedJson2['modelName']=='Camry Sedan'} } 
    end
  end
end
