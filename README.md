## Skinny Controllers

Rails forces an individual to adhere to the Model-View-Controller (MVC)
conventions, but it is still incredibly easy for a developer to take the
project off "the rails" by not trying to keep the cleanest and DRY.

One area that usually receives the most punishment are our poor controllers.
As they sit between the models and the views, they have access to a lot of data
and thus conventions can get lost and your controllers can start getting
bloated.

### Exercise

The objective of the exercise is to _skinny up_ the controller in the sample
code.


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
