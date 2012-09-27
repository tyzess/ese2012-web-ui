require 'tilt/haml'


class Transaction < Sinatra::Application

  get '/buy' do
    redirect "/"
  end

  post '/buy' do
    owner_name = params[:owner]
    item_name = params[:item_name]
    user_name = session[:name]


    owner = Traders::User.with_name(owner_name)
    user = Traders::User.with_name(user_name)

    # other method???
    item = nil
    owner.all_items.select { |i|
      if i.name == item_name
        item = i
      end
    }

    fail "Item doesn't exist" if item == nil

    if user.buy_item(item)
      haml :main, :locals => {  :time => Time.now ,
                                :users => Traders::User.all,
                                :current_user => user,
                                :message => "You just bought #{item.name}"}
    else
      haml :main, :locals => {  :time => Time.now ,
                                :users => Traders::User.all,
                                :current_user => user,
                                :message => "Failed to buy #{item.name}"}

    end

  end

end