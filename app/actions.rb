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
  @posts = Post.where(sport: params[:sport]).order("random()").to_a
  @sport = params[:sport]
  erb :'posts/sport'
end

get '/posts/search/:sport' do
  @sport = params[:sport]
  term = params[:terms]
  @posts = Post.where("content LIKE ? OR title LIKE ?", '%'+term+'%', '%'+term+'%').where(sport: @sport)
  erb:'posts/sport'
end

get '/posts/trending/:sport' do
    @sport = params[:sport]
    posts = Post.where(sport: params[:sport]).to_a
    posts.sort_by!{ |post| -post.votes.count }
    @posts = []
    posts.each do |post|
      if post.votes.count >=1
        @posts << post 
      end
    end
    erb :'posts/sport'
end

get '/users/logout' do
  session[:user_id] = nil if @user
  session[:redirect] =  nil
  redirect '/'
end

get '/users/home' do 
  arr = Vote.where(user_id: @user.id)
  final_arr = []
  arr.each do |post|
    final_arr << post.post_id 
  end
  @posts = Post.where(id: final_arr).to_a
  @posts.sort_by!{ |post| -post.votes.count }
  erb :'users/userhome'
end

# post '/erb' do
#   if request.xhr?
#     erb :test, {  layout => false }
#   else
#     redirect to('/erb')
#   end
# end

post '/posts/upvote/:id' do
  content_type :json
  newvote = Vote.new(
    user_id: @user.id,
    post_id: params[:id],
    kind: 'upvote'
  )
  newvote.save
  post = Post.find_by(id: params[:id])
  # redirect "/posts/#{post.sport}"
  {vote_count: post.votes.count}.to_json
end



post '/posts/downvote/:id' do
  content_type :json
  post = Post.find_by(id: params[:id])
  vote = Vote.find_by(user_id: @user.id, post_id: post.id)
  vote.destroy
  post.reload
  # redirect "/posts/#{post.sport}"
  {vote_count: post.votes.count}.to_json
end

post '/posts/remove/:id' do
  vote = Vote.find_by(user_id: @user.id, post_id: params[:id])
  vote.destroy if vote
  redirect "/users/home"
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
