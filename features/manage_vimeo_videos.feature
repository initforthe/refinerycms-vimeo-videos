@vimeo_videos
Feature: Vimeo Videos
  In order to have vimeo_videos on my website
  As an administrator
  I want to manage vimeo_videos

  Background:
    Given I am a logged in moxie user
    And I have no vimeo_videos

  @vimeo_videos-list @list
  Scenario: Vimeo Videos List
   Given I have vimeo_videos titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of vimeo_videos
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @vimeo_videos-valid @valid
  Scenario: Create Valid Vimeo Video
    When I go to the list of vimeo_videos
    And I follow "Add New Vimeo Video"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 vimeo_video

  @vimeo_videos-invalid @invalid
  Scenario: Create Invalid Vimeo Video (without title)
    When I go to the list of vimeo_videos
    And I follow "Add New Vimeo Video"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 vimeo_videos

  @vimeo_videos-edit @edit
  Scenario: Edit Existing Vimeo Video
    Given I have vimeo_videos titled "A title"
    When I go to the list of vimeo_videos
    And I follow "Edit this vimeo_video" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of vimeo_videos
    And I should not see "A title"

  @vimeo_videos-duplicate @duplicate
  Scenario: Create Duplicate Vimeo Video
    Given I only have vimeo_videos titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of vimeo_videos
    And I follow "Add New Vimeo Video"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 vimeo_videos

  @vimeo_videos-delete @delete
  Scenario: Delete Vimeo Video
    Given I only have vimeo_videos titled UniqueTitleOne
    When I go to the list of vimeo_videos
    And I follow "Remove this vimeo video forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 vimeo_videos
 