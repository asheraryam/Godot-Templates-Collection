extends RigidBody

export var lifetime = 1.0

var player

func _ready():
	gravity_scale = 0
	continuous_cd = true
	contact_monitor = true
	contacts_reported = 1
	can_sleep = false	
	
	player = get_tree().get_nodes_in_group("Player")[0]
	add_collision_exception_with(player)
	
	if lifetime > 0:
		yield(get_tree().create_timer(lifetime), "timeout")
		queue_free()

func _on_Projectile_body_entered(body):
	queue_free()