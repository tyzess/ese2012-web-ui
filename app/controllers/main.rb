require 'tilt/haml'
require '../app/models/traders/user'

class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    message = session[:message]
    session[:message] = nil
    haml :main, :locals => { :time => Time.now ,
                             :users => Traders::User.all,
                             :current_user => Traders::User.with_name(session[:name]),
                             :message => message}
  end

end