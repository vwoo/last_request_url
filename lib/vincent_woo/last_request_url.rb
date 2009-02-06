module VincentWoo
  module LastRequestUrl
  
  def self.included(base)
    base.helper_method :last_request_url
  end
  
private
    # Remember the last url the user requested.
    def track_last_request_url
      if track_last_request_url?
        session[:last_request_url] = request.protocol + request.host + request.request_uri
      end
    end
    
    # I consider these the base sane conditions useful for all projects. You probably won't need to edit them.
    # Instead, consider adding conditions to additional_conditions_for_tracking_last_request_url()
    def track_last_request_url?
      request.method == :get && 
      (params[:format].nil? || params[:format] == 'html') && 
      additional_conditions_for_tracking_last_request_url
    end
    
    def additional_conditions_for_tracking_last_request_url
      true
    end
    
    def last_request_url
      session[:last_request_url]
    end
  end
end
