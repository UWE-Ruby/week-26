!SLIDE quote

# Concepts

!SLIDE

## Hot Spot

```ruby
class PostsController < ApplicationController

  # ... other actions

  def create
    post = Post.create(params[:post],:user => current_user)

    if post.twitter
      current_user.twitter.update post.message
    end

    if post.facebook
      current_user.facebook.put_wall_post post.message
    end

    redirect_to user_posts_path(current_user)
  end

end

```

!SLIDE

ActiveRecord Model Callbacks

```ruby
before_validation
after_validation
before_save
around_save
before_create
around_create
after_create
after_save
after_commit
```

!SLIDE

Observers

```ruby
class PostObserver < ActiveRecord::Observer

  def after_commit(model)
    # ...
  end

end
```

!SLIDE quote

http://guides.rubyonrails.org