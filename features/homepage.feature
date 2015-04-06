Feature: Home page
  Scenario: Viewing the current weather of a location
    Given I visit the homepage
    When I enter my zip code in the from field
    And I enter a zip code in the to field
    And I press Submit
    Then I should see the current weather
