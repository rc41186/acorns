Feature:
	Scenario: Sign into redfin
	Given I am on redfin
	Then I click on Sign In
	And click continue with email
	Then I enter login information
	And I click Sign In
	Then I should not see Sign In and Join
	