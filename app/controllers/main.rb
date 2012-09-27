require 'tilt/haml'
require '../app/models/traders/user'

class Main < Sinatra::Application

  get "/" do

    redirect '/login' unless session[:name]

    haml :main, :locals => { :time => Time.now ,
                             :users => Traders::User.all,
                             :current_user => Traders::User.with_name(session[:name]),
                             :message => nil}
  end

end