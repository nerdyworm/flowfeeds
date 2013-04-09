class SessionsController < Devise::SessionsController
  def create
    user = warden.authenticate(scope: :user)

    if user
      sign_in(user)
      render json: user
    else
      render json: { message: t('devise.failure.invalid')}, status: 401
    end
  end

  def destroy
    sign_out(:user)

    render json: { message: t('devise.sessions.signed_out') }
  end
end
