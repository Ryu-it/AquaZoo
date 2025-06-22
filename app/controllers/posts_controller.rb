class PostsController < ApplicationController
  def index
    @q = Post.includes(:user).ransack(params[:q])
    @posts = @q.result
    @areas = Area.all
    case params[:category]
    when "zoo"
      render "zoo_index"
    when "aqua"
      render "aqua_index"
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

  def show
    case params[:category]
    when "zoo"
      @post = Post.find(params[:id])
      render "zoo_show"
    when "aqua"
      @post = Post.find(params[:id])
      render "aqua_show"
    end
  end

  def edit
    case params[:category]
    when "zoo"
      @post = Post.find(params[:id])
      render "zoo_edit"
    when "aqua"
      @post = Post.find(params[:id])
      render "aqua_edit"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました"

      if @post.category.name == "zoo"
        redirect_to posts_path(category: "zoo")
      elsif @post.category.name == "aqua"
        redirect_to posts_path(category: "aqua")
      else
        redirect_to root_path
      end

    else
      flash.now[:alert] = "編集に失敗しました"

      # カテゴリーに応じて render を変える
      if @post.category&.name == "zoo"
        render :zoo_edit, status: :unprocessable_entity
      elsif @post.category&.name == "aqua"
        render :aqua_edit, status: :unprocessable_entity
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除に成功しました"
    redirect_to root_path
  end

private

  def post_params
    params.require(:post).permit(
    :name,
    :title,
    :body,
    :url,
    :area_id,
    :image
    )
  end
end
