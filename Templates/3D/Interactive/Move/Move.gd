extends KinematicBody

export var speed = 1.0

var destination
var vector

func _ready():
	destination = $Destination.global_transform.origin

func _process(delta):
	vector = (destination - global_transform.origin).normalized()
	global_transform.origin += vector * speed * 0.1