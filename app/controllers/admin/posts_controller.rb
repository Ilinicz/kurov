class Admin::PostsController < Admin::BaseController
  
  before_action :set_post, only: [
    :edit,
    :update,
    :destroy
  ]
  
  
  def dashboard
    @published_post_count = Post.published.count
    @draft_post_count = Post.drafted.count
    @published = Post.published.page(params[:page]).per(50)
    @drafted = Post.drafted.page(params[:page]).per(50) 
  end
  
  def index
    @posts = Post.published.page(params[:page]).per(50)
  end
  
  def drafts
    @posts = Post.drafted.page(params[:page]).per(50)    
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to admin_posts_dashboard_path, notice: "Новая статья успешно сохранена."
    else
      flash[:alert] = "Ошибка! Статья не была сохранена!"
      render :new
    end
  end

  def edit
  end

  def update
    @post.slug = nil
    if @post.update(post_params)
      redirect_to admin_posts_dashboard_path, notice: "Статья успешно отредактирована."
    else
      flash[:alert] = "Ошибка! Статья не была сохранена!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Статья была успешно удалена."
  end
  
  
  private
  
  def set_post
    @post = Post.friendly.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(
    :title,
    :content_md,
    :draft,
    :updated_at
    )
  end
  
  
end
