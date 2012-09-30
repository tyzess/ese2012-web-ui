require 'tilt/haml'
require '../app/models/traders/user'

class Authentication < Sinatra::Application

  get "/login" do
    message = session[:message]
    session[:message] = nil
    haml :login , :locals => { :message => message }
  end

  post "/login" do
    name = params[:username]
    password = params[:password]
    user = Traders::User.with_name name

    if name == "" or password == ""
      session[:message] = "Empty username or password"
      redirect "/login"
    else
        if user.nil? or password != name
          session[:message] = "Username or password are not valid"
          redirect "/login"
        else
          session[:name] = name
          redirect '/'
        end
    end

  end

  get "/logout" do
    session[:name] = nil
    session[:message] = "Successfully LoggedOut"
    redirect "/login"
  end

end