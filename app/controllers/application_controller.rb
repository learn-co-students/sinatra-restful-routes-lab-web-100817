require 'pry'
class ApplicationController < Sinatra::Base

  set :method_override, 'true'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end

  get '/recipes' do
    erb :recipes
  end
  
  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    recipe = Recipe.find(params[:id])
    @recipe_name = recipe.name
    recipe.destroy
    erb :delete
  end
end
