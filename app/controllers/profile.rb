
require 'tilt/haml'
require '../app/models/traders/user'

class Profile < Sinatra::Application

  get "/profile/:user" do
    if params[:user] == nil or session[:name] == nil
      redirect '/'
    end
    haml :profile , :locals => {:owner => Traders::User.with_name(params[:user])}

  end
end