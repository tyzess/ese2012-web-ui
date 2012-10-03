require 'rubygems'
require 'sinatra'
require 'tilt/haml'
require '../app/models/traders/user'
require '../app/models/traders/item'
require '../app/controllers/main'
require '../app/controllers/authentication'
require '../app/controllers/transaction'
require '../app/controllers/profile'

class App < Sinatra::Base

  use Authentication
  use Main
  use Transaction
  use Profile

  enable :sessions
  set :public_folder, 'app/public'

  configure :development do
    urs = Traders::User.create("Urs")
    ese = Traders::User.create("ese")
    kenneth = Traders::User.create("Kenneth")
    adrian = Traders::User.create("Adrian")

    urs.save
    ese.save
    kenneth.save
    adrian.save

    urs.give_credits(1000000)
    ese.give_credits(999)
    kenneth.give_credits(1234)
    adrian.give_credits(45)

    urs.add_item(Traders::Item.create("Hanf",99))
    urs.add_item(Traders::Item.create_active("Hut",13.55))
    urs.add_item(Traders::Item.create_active("Handy",301))

    ese.add_item(Traders::Item.create_active("Velo",221))
    ese.add_item(Traders::Item.create_active("GA",2500))
    ese.add_item(Traders::Item.create("ruby",1))

    adrian.add_item(Traders::Item.create("Schwedische Penispumpe",123) )
    adrian.add_item(Traders::Item.create_active("Huhn",22))
    adrian.add_item(Traders::Item.create_active("Auto",21000))

    kenneth.add_item(Traders::Item.create_active("Einhorn",10000))
    kenneth.add_item(Traders::Item.create_active("lustige Pilze",101))
    kenneth.add_item(Traders::Item.create_active("Bong",500))
  end

end

# Now, run it
App.run!