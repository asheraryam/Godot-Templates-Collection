extends KinematicBody

const GRAVITY = 9.8

export var speed = 6.0
export var jump_height = 6.5
export var mouse_sensitivity = 9

var velocity = Vector3()
var snap_distance = -0.1
var snap = Vector3(0, snap_distance, 0)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# ----------------------------------
# Keyboard controls and gravity

func _physics_process(delta):
	velocity.x = 0 # Resets the direction when no key is pressed
	velocity.z = 0

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_pressed("ui_up"):
			velocity.z = -speed
		if Input.is_action_pressed("ui_down"):
			velocity.z = speed
		if Input.is_action_pressed("ui_left"):
			velocity.x = -speed
		if Input.is_action_pressed("ui_right"):
			velocity.x = speed
		
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			snap = Vector3()
			velocity.y = jump_height
		else:
			snap = Vector3(0, snap_distance, 0)
		
		velocity.y -= GRAVITY * delta # Gravity

	velocity = velocity.rotated(Vector3.UP, rotation.y)
	velocity =  move_and_slide_with_snap(velocity, snap, Vector3.UP, true, 4, 5)
	
# ----------------------------------
# Mouse controls

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_degrees.y += deg2rad(-event.relative.x * mouse_sensitivity) # Yaw axis
		$Head.rotation_degrees.x += deg2rad(-event.relative.y * mouse_sensitivity) # Pitch axis
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x, -90, 90) # Clamps the up and down rotation