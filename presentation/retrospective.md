!SLIDE bullets

# Retrospective

!SLIDE bullets

* What would happen if you started to add more services?

* Would the previous solution, logic within the controller, to be maintainable
  as you add or remove services?

!SLIDE bullets

* Would using model callbacks be more maintainable as you add or remove
  services?

* Would using an observer be more maintainable as you add or remove services?

!SLIDE bullets

* For the observer or the callback, at what stage in the lifecycle did you
  choose to send the content to the other services?

* What happens to the user's request when a service hangs or takes a long time
  to respond?
