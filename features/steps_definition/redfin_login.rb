Capybara.default_driver=:selenium

password = "LPmec0MSF8"

wait = Selenium::WebDriver::Wait.new(:timeout => 10)

Given(/^I am on redfin$/) do
  visit 'http://www.redfin.com'
end

Then(/^I click on Sign In$/) do
  find(:xpath, "//a[contains(.,'Sign In')]").click
end

Then(/^click continue with email$/) do
   wait.until{ find("button", :text => "Continue with Email").click } 
end

Then(/^I enter login information$/) do
  fill_in('emailInput', :with => "robert.chaing@gmail.com")
  fill_in 'passwordInput', :with => password
end

Then(/^I click Sign In$/) do
  wait.until{ find("button", :text => "Sign In").click }
end

Then(/^I should not see Sign In and Join$/) do
  page.should have_no_selector(:xpath, "//a[contains(.,'Sign In')]")
  page.should have_no_selector(:xpath, "//a[contains(.,'Join')]")
end

Then(/^enter a location$/) do
  searchFieldXpath = "/html/body/div[1]/div[4]/div/section/div/span/div/div/div[1]/div/div[2]/div[1]/div/div/div/form/div[1]/div/input"
  
  find(:xpath, searchFieldXpath).set("90808")
end

Then(/^click Search$/) do
  searchButtonXpath = "/html/body/div[1]/div[4]/div/section/div/span/div/div/div[1]/div/div[2]/div[1]/div/div/div/form/div[1]/button"
  
  first(:xpath, searchButtonXpath).click
end

Then(/^click on Filters$/) do
  wait.until{ find("button", :text=>"Filters").click }
end

Then(/^set three types of filters$/) do
  
  bathIncrXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div/form/div[1]/div[2]/div/div[1]/div[1]/div[2]/div[2]/span/span[1]/span[3]"
  landPropTypeXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div/form/div[1]/div[2]/div/div[1]/div[3]/div[2]/button[2]"
  forSaleToggleXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div/form/div[1]/div[2]/div/div[1]/div[4]/span/label/div/div/div[1]"
  
  #Trigger three types of filters
  find(:xpath, bathIncrXpath).click           
  find(:xpath, landPropTypeXpath).click
  find(:xpath, forSaleToggleXpath).click
  
  filterSetCountXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div/form/div[1]/div[1]/div[2]/div[2]/button/span/span[3]"
  foundHomesXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div/form/div[2]/div[2]/div"
  
  #Verify that No Match is found (based on filter set) and that there were 3 filters type set.             
  page.find(:xpath, filterSetCountXpath).text.should eq('3')
  page.find(:xpath, foundHomesXpath).text.should eq('No Matches')
    
  wait.until{ find("button", :text=>"Apply Filters").click }
  
  applyFilterCountXpath = "/html/body/div[1]/div[3]/div/div[2]/div[1]/div[2]/div/div[1]"
  
  #Once Apply Filters is selected once again, make sure no homes were found based on set filter.
  page.find(:xpath, applyFilterCountXpath).text.should eq('Showing 0 Homes')
end



