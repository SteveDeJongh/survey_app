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

def input_validation(*params)
  message = nil
  params.each_with_index do |value, index|
    if index == 0
      message = "Name must not be blank." if value.nil?
    else
      message = "Please make a selection for Q#{(index)}" if value.nil?
    end
  end
  message
end

post '/survey/submit/' do
  name = params["name"]
  q1 = params["q1"]
  q2 = params["q2"]
  q3 = params["q3"]
  error = input_validation(name, q1, q2, q3)
  if error
    session[:error] = error
    erb :survey, layout: :layout
  else
    @storage.add_survey_result(name, q1, q2, q3)
    session[:success] = "Thanks for submitting the survey."
    redirect '/'
  end
end

get '/results' do
  redirect '/' if !signed_in?
  @survey_data = @storage.retrieve_survey_responses
  erb :results, layout: :layout
end

get '/result/:id' do
  id = params[:id].to_i
  @response_data = @storage.retrieve_survey_response(id)
  erb :result, layout: :layout
end

def responses_in_rows(data)
  data.map do |row|
    "<tr>
      <td><a href='result/#{row[:id]}'>#{row[:id]}</a></td>
      <td>#{row[:created_on]}</td>
      <td>#{row[:name]}</td>
      <td>#{row[:q1]}</td>
      <td>#{row[:q2]}</td>
      <td>#{row[:q3]}</td>
    </tr>"
  end.join
end