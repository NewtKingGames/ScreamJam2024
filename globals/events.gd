extends Node


# Signals used to track if player is in individual light areas
signal player_entered_light_area
signal player_exited_light_area

# Signals used to track if player is either in complete darkness or in some light
signal player_entered_darkness
signal player_exited_darkness

# TODO - add some kind of object to be passed here
signal player_started_interaction(interactable_resource: Interactable)
signal player_exited_interaction(interactable_resource: Interactable)

