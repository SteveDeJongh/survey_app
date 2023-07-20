# Survey App

require 'sinatra'
require 'sinatra/contrib'
require 'tilt/erubis'
require 'bcrypt'
require 'pry'

require_relative 'database'

configure do
  enable :sessions
  set :erb, :enable_html => true
end

configure(:development) do
  require 'sinatra/reloader'
  also_reload "database.rb"
end

before do
  @storage = DatabasePersistence.new
  session[:signed_in] = false
end

helpers do
  def signed_in?
    session[:signed_in]
  end

  def valid_credentials?(username, password)
    user_info = @storage.retrieve_user_details(username)

    return false if user_info.nil?
    bcrypt_password = BCrypt::Password.new(user_info[:password])
    bcrypt_password == password
  end
end

get '/' do
  erb :home, layout: :layout
end

get '/signin' do
  erb :sign_in, layout: :layout
end

post '/signin' do
  if valid_credentials?(params[:username], params[:password])
    session[:username] = params[:username]
    session[:signed_in] = true
    session[:success] = "#{params[:username]} sgined in!"
    redirect '/'
  else
    session[:error] = "Invalid credentials."
    erb :sign_in, layout: :layout
  end
end