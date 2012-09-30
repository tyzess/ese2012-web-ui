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


    item = owner.all_items.detect { |i| i.name == item_name }

    fail "Item doesn't exist" if item == nil

    if user.buy_item(item)
      session[:message] = "You bought #{item.name}"
    else
      session[:message] = "Failed to buy #{item.name}"
    end

    redirect "/"
  end

end