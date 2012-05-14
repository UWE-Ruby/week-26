## Skinny Controllers

Rails forces an individual to adhere to the Model-View-Controller (MVC)
conventions, but it is still incredibly easy for a developer to take the
project off "the rails" by not trying to keep the cleanest and DRY.

One area that usually receives the most punishment are our poor controllers.
As they sit between the models and the views, they have access to a lot of data
and thus conventions can get lost and your controllers can start getting
bloated.

### Exercise

This week is a sample Rails application that allows a user to login and
authenticate with various services. After a user has authorized the various
services when the user creates a _post_, they can have it appear on the
various services.

The objective of the exercise is to _skinny up_ the Posts Controller in the
sample code.

> [app/controller/posts_controller.rb](https://github.com/UWE-Ruby/week-26/blob/master/app/controllers/posts_controller.rb)#create is controller action that
you should be addressing.

> You should generate a test account for __Twitter__ and/or __Facebook__ to
  ensure you do not annoy your friends as you create sample posts.

#### Goal

Understand the code.

Move the code that publishes content to __Twitter__ and __Facebook__ out of
controller and move it into model callbacks or into an observer.

### Exercise Retrospective

* What would happen if you started to add more services?

* Would the previous solution, logic within the controller, to be maintainable
  as you add or remove services?

* Would using model callbacks be more maintainable as you add or remove
  services?

* Would using an observer be more maintainable as you add or remove services?

* For the observer or the callback, at what stage in the lifecycle did you
  choose to send the content to the other services?
  
* What happens to the user's request when a service hangs or takes a long time 
  to respond?

### Reading

* [Callbacks](http://guides.rubyonrails.org/active_record_validations_callbacks.html#available-callbacks)

* [Observers](http://guides.rubyonrails.org/active_record_validations_callbacks.html#observers)

### Further Exercise

This project boilerplate allows you to authenticate and post to additional
services. This is a common pattern with applications to add these services.

* Attempt to add a new authentication service

    > Google, Github, etc ...

This is the first part of an exercise. The second part of the exercise we are
going to look at moving the work that is being performed here in an offline
job through [Resque](https://github.com/defunkt/resque) and [Redis](http://redis.io/).

* Install Redis and Resque

    > Start to explore Redis and see if you can interact with the server through
      Resque gem or through another Redis gem.

    > Redis supports many different variable types to store information. Try
      and use some of these [commands](http://redis.io/commands) to store and
      retrieve data.
