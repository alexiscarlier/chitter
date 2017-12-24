ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'data_mapper'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class Chitter < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/peeps'
  end

  get '/peeps' do
    @user = current_user
    @peeps = Peep.all
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    Peep.create(text: params[:peep], posted_on: DateTime.now)
    redirect '/peeps'
  end

  get '/users/new' do
    erb :'users/new'
  end

   post '/users' do
    user = User.create(name: params[:name], handle: params[:handle], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    if user.save
      redirect '/peeps'
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'users/new'
    end
  end

   helpers do
     def current_user
       @current_user ||= User.get(session[:user_id])
     end
   end

end
