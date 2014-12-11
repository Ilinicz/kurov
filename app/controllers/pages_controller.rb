class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
  end
  
  def inside
  end
  
def posts
    @posts = Post.published.page(params[:page]).per(10)
  end
  
  def show_post
    @post = Post.friendly.find(params[:id])
  rescue
    redirect_to root_path
  end
 
  
  def email
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    
    if @name.blank?
      flash[:alert] = "Пожалуйста, представьтесь."
      render :contact
    elsif @email.blank? || @email.scan(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).size < 1
      flash[:alert] = "Вы не указали валидный e-mail для связи с вами."
      render :contact
    elsif @message.blank? || @message.length < 10
      flash[:alert] = "Кажется, Вы забыли написать само сообщение."
      render :contact
    elsif @message.scan(/<a href=/).size > 0 || @message.scan(/\[url=/).size > 0 || @message.scan(/\[link=/).size > 0 || @message.scan(/http:\/\//).size > 0
      flash[:alert] = "В целях безопасности нельзя отправлять ссылки."
      render :contact
    else    
      ContactMailer.contact_message(@name,@email,@message).deliver
      redirect_to root_path, notice: "Ваше сообщение принято. Спасибо!"
    end
  end
  
end
