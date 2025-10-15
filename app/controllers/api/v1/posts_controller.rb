# frozen_string_literal: true

module API
  module V1
    class PostsController < APIController
      before_action :set_post, only: %i[show update destroy]

      def index
        @query = Post.all.ransack(params[:q])
        @posts = @query.result(distinct: true).order(id: :desc)
        @pagy, @posts = pagy(@posts, page: params[:page] || 1, items: params[:items] || 10)
      end

      def show
        render_model
      end

      def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save
          render_model
        else
          render_error_full_messages(@post)
        end
      end

      def update
        if @post.update(post_params)
          render_model
        else
          render_error_full_messages(@post)
        end
      end

      def destroy
        if @post.destroy
          render json: { message: 'Post deleted successfully' }
        else
          render_error_full_messages(@post)
        end
      end

      private

      def render_model
        render 'api/v1/posts/show', locals: { post: @post }
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.expect(post: %i[title content])
      end
    end
  end
end
