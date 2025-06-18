class PostsController < ApplicationController
  def index
    case params[:category]
    when "zoo"
      @posts = Post.where(category: "zoo")
      render "zoo_index"
    when "aqua"
      @posts = Post.where(category: "aqua")
      render "aqua_index"
    else
      @posts = Post.all
      render "index"
    end
  end

  def new
    case params[:category]
    when "zoo"
      @post = Post.new
      render "zoo_new"
    when "aqua"
      @post = Post.new
      render "aqua_new"
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.category = Category.find_by(name: params[:category])

    if @post.save
      flash[:notice] = "投稿に成功しました"

      if @post.category.name == "zoo"
        redirect_to posts_path(category: "zoo")
      elsif @post.category.name == "aqua"
        redirect_to posts_path(category: "aqua")
      else
        redirect_to root_path
      end

    else
      flash.now[:alert] = "投稿に失敗しました"

      # カテゴリーに応じて render を変える
      if @post.category&.name == "zoo"
        render :zoo_new, status: :unprocessable_entity
      elsif @post.category&.name == "aqua"
        render :aqua_new, status: :unprocessable_entity
      else
        render :new, status: :unprocessable_entity
      end
    end
  end


private

  def post_params
    params.require(:post).permit(
    :name,
    :title,
    :body,
    :url,
    :area_id
    )
  end
end
