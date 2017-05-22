class Login < Sinatra::Base
  ALLOWED_USERS = %w(Tatum Rob George)
  ALLOWED_PASSWORDS = %w(pa88word admin justletmein)
  enable :sessions

  get('/login') { erb :login }

  post('/login') do
    if ALLOWED_USERS.include?(params[:name]) &&
        ALLOWED_PASSWORDS.include?(params[:password])
      session[:user_name] = params[:name]
      redirect '/'
    else
      redirect '/login'
    end
  end
end
