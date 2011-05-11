class LegacyUrlProxy

  URL_MAPPING = {
    "/old/url-1" => "/new/url-1",
    "/old/url-2" => "/new/url-2",
    "/old/url-3" => "/new/url-3",
  }
  
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    dest_url = URL_MAPPING[request.path_info.gsub(/\/$/, "")]
    if dest_url
      [301, {"Location" => request.script_name + dest_url}, [""]]
    else
      @app.call(env)
    end

  end

end
