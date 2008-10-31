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
    
    def track_last_request_url?
      request.method == :get && (params[:format].nil? || params[:format] == 'html')
    end
    
    def last_request_url
      session[:last_request_url]
    end
  end
end
