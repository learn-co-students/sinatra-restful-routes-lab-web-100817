require 'pry'
class ApplicationController < Sinatra::Base
  set :method_override, 'true'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do #shows index page, with all recipes
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do #new recipe form
    erb :new
  end

  get '/recipes/:id' do
    # binding.pry
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect '/recipes'
  end


end
