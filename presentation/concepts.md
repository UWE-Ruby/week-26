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

!SLIDE quote

## ActiveRecord Model Callbacks

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

!SLIDE quote

## Setting up a callback

```ruby
class Post < ActiveRecord::Base

  before_save :do_this_before_saving

  def do_this_before_saving
    puts "Doing this before saving for post: #{self}"
  end

end
```

!SLIDE

## Observers

```ruby
class PostObserver < ActiveRecord::Observer

  def after_commit(model)
    puts "Doing this after committing for post: #{model}"
  end

end
```

!SLIDE

## Register the Observer

```ruby
# ... in your config/application.rb
config.active_record.observers = :post_observer
```

!SLIDE

## Nosey Observers

```ruby
class ServiceObserver < ActiveRecord::Observer
  observe :post
  
  def after_commit(model)
    puts "Doing this after committing for post: #{model}"
  end
end
```

!SLIDE quote

## Great Reference

[http://guides.rubyonrails.org](http://guides.rubyonrails.org)

Active Record Validations and Callbacks
