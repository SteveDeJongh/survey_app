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
end

helpers do
  def signed_in?
    session[:signed_in] == true
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
    session[:success] = "#{params[:username]} signed in!"
    redirect '/'
  else
    session[:error] = "Invalid credentials."
    erb :sign_in, layout: :layout
  end
end

get '/signout' do
  session[:username] = nil
  session[:signed_in] = false
  session[:success] = "User signed out."
  redirect '/'
end

get '/survey' do
  erb :survey, layout: :layout
end

post '/survey/submit/' do
  name = params["name"]
  q1 = params["q1"]
  q2 = params["q2"]
  q3 = params["q3"]

  @storage.add_survey_result(name, q1, q2, q3)
  session[:success] = "Thanks for submitting the survey."
  redirect '/'
end