require 'tilt/haml'
require '../app/models/traders/user'

class Authentication < Sinatra::Application

  get "/login" do
    haml :login , :locals => { :message => nil }
  end

  # checks username and password, if its right, it opens the gate to paradise
  post "/login" do
    name = params[:username]
    password = params[:password]
    user = Traders::User.with_name name

    if name == "" or password == ""
      haml :login , :locals => { :message => "Empty username or password" }
    else
        if user.nil? #or password != name
          haml :login , :locals => { :message => "Username or password are not valid" }
        else
          session[:name] = name
          redirect '/'
        end
    end

  end

  get "/logout" do
    session[:name] = nil
    haml :login , :locals => { :message => "Successfully LoggedOut" }
  end

end