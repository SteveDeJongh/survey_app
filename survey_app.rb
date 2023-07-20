# Survey App

require 'sinatra'
require 'sinatra/contrib'
require 'tilt/erubis'
require 'bcrypt'

require_relative 'database'

configure do
  enable :sessions
  set :erb, :enable_html => true
end

configure(:development) do
  require 'sinatra/reloader'
  also_reload "database.rb"
end

helpers do
  def signed_in?
    true # Logic to do.
  end
end

get '/' do
  erb :home, layout: :layout
end

get '/signin' do
  erb :sign_in, layout: :layout
end
