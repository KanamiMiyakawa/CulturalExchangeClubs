require 'test_helper'

class Organizings::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get organizings_events_new_url
    assert_response :success
  end

end
