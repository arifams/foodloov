class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]


	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			# show a success flash message and redirect to the recipe show page
			redirect_to @recipe, notice: "Successfully created your recipe"
		else
			# show fail flash message and render to new page for another shot to creating a recipe
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			# display a success flash and redirect to recipe show page
			redirect_to @recipe
		else
			# display an alert flasha remain on edit page
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, 
			ingredients_attributes: [:id, :name, :_destroy], 
			directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])

	end
end
