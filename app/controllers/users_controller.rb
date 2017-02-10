post '/fbsessions/new' do
  @user = User.find_or_create_by(fb_id: params[:fb_id])
  @user.update_attributes(params)
  @user.save
  session[:user_id] = @user.id
  redirect("/users/#{@user.id}")
end

#sign up
get '/users/new' do
  erb :'users/new'
end

# create account
post '/users' do
  @user = User.new(params[:account])
  if @user.save
    session[:user_id] = @user.id
    redirect("/users/#{@user.id}")
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end


#log in form
get '/sessions/new' do
  erb :'sessions/new'
end

# log in submit
post '/sessions' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate?(params[:password])
    set_user(user)
    redirect "/"
  else
    @errors = ["Invalid username or password"]
    erb :"sessions/new"
  end
end

#log out
delete '/sessions' do
  session[:user_id] = nil
  redirect('/')
end

# log out for testing
get '/logout' do
  session[:user_id] = nil
  redirect('/')
end

#profile view
get '/users/:user_id' do
  @user = User.find_by(id: params[:user_id])
  if session[:user_id] == @user.id
    erb :'/users/show'
  else
    erb :'404'
  end
end
