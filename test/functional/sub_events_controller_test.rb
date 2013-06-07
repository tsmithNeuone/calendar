require 'test_helper'

class SubEventsControllerTest < ActionController::TestCase
  setup do
    @sub_event = sub_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_event" do
    assert_difference('SubEvent.count') do
      post :create, sub_event: { all_day: @sub_event.all_day, description: @sub_event.description, ends_at: @sub_event.ends_at, notify_contacts: @sub_event.notify_contacts, starts_at: @sub_event.starts_at, title: @sub_event.title }
    end

    assert_redirected_to sub_event_path(assigns(:sub_event))
  end

  test "should show sub_event" do
    get :show, id: @sub_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_event
    assert_response :success
  end

  test "should update sub_event" do
    put :update, id: @sub_event, sub_event: { all_day: @sub_event.all_day, description: @sub_event.description, ends_at: @sub_event.ends_at, notify_contacts: @sub_event.notify_contacts, starts_at: @sub_event.starts_at, title: @sub_event.title }
    assert_redirected_to sub_event_path(assigns(:sub_event))
  end

  test "should destroy sub_event" do
    assert_difference('SubEvent.count', -1) do
      delete :destroy, id: @sub_event
    end

    assert_redirected_to sub_events_path
  end
end
