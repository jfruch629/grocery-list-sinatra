require "sinatra"
require "csv"
require "pry"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

use Rack::Session::Cookie, {
  secret: "hello_i_am_a_frog",
  expire_after: 86400
}

get '/' do
  redirect "/grocery-list"
end

get '/grocery-list' do
  @grocery_list = []
  CSV.foreach("grocery_list.csv", headers: true) do |row|
    @grocery_list << row
  end
  erb :grocery_list
end

post '/grocery-list' do
  session[:quantity_given] = false
  session[:valid] = true
  @grocery = params[:grocery]
  @quantity = params[:quantity]
  if @grocery == ""
    session[:valid] = false
    if !(@quantity == "")
      session[:quantity_given] = true
    end
  else
    session[:valid] = true
    CSV.open("grocery_list.csv", "a") do |f|
      f.puts([@grocery, @quantity])
    end
  end
  redirect '/grocery-list'
end
