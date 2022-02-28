module Posts
  class Search
    include Interactor

    def call
      context.posts = Post.all and return if context.q.blank?

      context.posts = Post.search(context.q)
    end
  end
end
