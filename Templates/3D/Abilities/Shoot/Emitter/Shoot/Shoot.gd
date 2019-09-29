extends Position3D

export var force = 25.0

export (PackedScene) var projectile

func _input(event): 
	if event is InputEventMouseButton and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event.button_index == 1 and event.pressed == true:
			shoot()

func shoot():
	var projectile_instance = projectile.instance() # We instance the scene

	add_child(projectile_instance) # The instance is added as a child of the shoot node
	projectile_instance.set_as_toplevel(true) # Projectile parented to the highest node in the level to detach it from the player
	projectile_instance.linear_velocity = global_transform.basis.z * -force # An initial force is applied when clicking, the force is applied on each new instance