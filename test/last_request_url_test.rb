require 'test/unit'
ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
require 'test_help'

class ExampleController < ActionController::Base
  include VincentWoo::LastRequestUrl
  before_filter :track_last_request_url
  
  def rescue_action(e); raise e; end
  
  def index
    render :text => 'hello world'
  end
end



ActionController::Routing::Routes.draw do |map|
  map.resources :example
end



class LastRequestUrlTest < Test::Unit::TestCase
  def setup
    @controller   = ExampleController.new
    @request      = ActionController::TestRequest.new
    @request.host = 'www.test.local'
    @response     = ActionController::TestResponse.new
  end
  
  
  def test_should_record_url_for_get_request
    get :index
    assert_response :success
    assert_equal 'http://www.test.local/example', session[:last_request_url]
  end
  
  def test_should_not_record_url_for_non_get_requests
    post :index
    assert_nil session[:last_request_url]
  end
  
  def test_should_not_record_url_if_format_specified_and_not_html
    get :index, :format => 'pdf'
    assert_nil session[:last_request_url]
  end
  
  def test_recording_decision_should_be_overrideable
    def @controller.track_last_request_url?
      false
    end
    
    get :index
    assert_nil session[:last_request_url]
  end
  
  def test_tracking_conditions_should_be_easily_added_to_without_clobbering_base_conditions
    class << @controller
      def additional_conditions_for_tracking_last_request_url
        params[:controller] != 'example'
      end
    end
    
    get :index
    assert_nil session[:last_request_url]
  end
end
