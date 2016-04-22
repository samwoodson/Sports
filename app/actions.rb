# Homepage (Root path)

before do
  @user = nil
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
end

# helpers do
#   def current_votes(id)
#     Vote.where(post_id: id).count
#   end
# end

get '/' do
  redirect '/posts'
end

get '/posts' do
  erb :'posts/home'
end

get '/posts/:sport' do
  @posts = Post.where(sport: params[:sport]).to_a
  @posts.sort_by!{ |post| -post.votes.count }
  @sport = params[:sport]
  erb :'posts/sport'
end

get '/users/logout' do
  session[:user_id] = nil if @user
  session[:redirect] =  nil
  redirect '/'
end

get '/users/home' do 
  arr = Vote.where(user_id: @user.id).to_a
  final_arr = []
  arr.each do |post|
    final_arr << post.post_id 
  end
  @posts = Post.where(id: final_arr).to_a
  @posts.sort_by!{ |post| -post.votes.count }
  erb :'users/userhome'
end


post '/posts/upvote/:id' do
  @upvote = Vote.new(
    user_id: @user.id,
    post_id: params[:id]
  )
  @upvote.save
  post = Post.find_by(id: params[:id])
  post.score += 1
  post.save
  redirect "posts/#{post.sport}"
end

post '/posts/downvote/:id' do
  @downvote = Vote.new(
    user_id: @user.id,
    post_id: params[:id]
  )
  @downvote.save
  post = Post.find_by(id: params[:id])
  post.score -= 1
  post.save
  redirect "posts/#{post.sport}"
end

post '/users/login' do
  user = User.find_by(email: params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    if session[:redirect]
      redirect session[:redirect]
    else
      redirect '/posts'
    end
  else
    # implement @login_error
    redirect '/users/login'
  end
end
