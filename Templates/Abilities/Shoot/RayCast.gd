extends RayCast

export var bullet_speed = 500.0
export (PackedScene) var bullet
export (PackedScene) var shell
export (PackedScene) var nozzle_flash
export (PackedScene) var impact
export (PackedScene) var blood

var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0] # Get the target with the first node in the Player group
	add_exception(player)

func _input(event):
	if event is InputEventMouseButton and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event.button_index == 1 and event.pressed == true:
			if is_colliding():
				if get_collider().get_class() == "StaticBody":
					impact()
				if get_collider().has_method("damage"):
					get_collider().damage()
				$BulletPosition.look_at(get_collision_point(), Vector3.UP)
			else:
				$BulletPosition.rotation = Vector3()
			spawn_bullet()

func impact():
	var impact_instance = impact.instance() # We instance the scene

	add_child(impact_instance) # The instance is added as a child of the shoot node
	impact_instance.set_as_toplevel(true)
	impact_instance.global_transform.origin = get_collision_point()
	
func spawn_bullet():
	var bullet_instance = bullet.instance() # We instance the scene
	
	add_child(bullet_instance) # The instance is added as a child of the shoot node
	bullet_instance.set_as_toplevel(true) # Projectile parented to the highest node in the level to detach it from the player
	bullet_instance.global_transform.origin = $BulletPosition.global_transform.origin
	bullet_instance.linear_velocity = global_transform.basis.z * -bullet_speed # An initial force is applied when clicking, the force is applied on each new instance