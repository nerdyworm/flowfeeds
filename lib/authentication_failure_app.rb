class AuthenticationFailureApp < Devise::FailureApp
  def redirect
    if params[:format] == "json"
      self.status = 401
      self.content_type  = "json"
      self.response_body = {message: "Please login"}.to_json
    else
      super
    end
  end
end
