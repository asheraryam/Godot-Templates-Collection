extends KinematicBody

const GRAVITY = 0.15

var velocity = Vector3()
var speed = 6
var max_falling_speed = 20
var jump_height = 4

var mouse_sensitivity = 0.15

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# ----------------------------------
# Keyboard controls and gravity

func _physics_process(delta):
	velocity.x = 0 # Resets the direction when no key is pressed
	velocity.z = 0

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_pressed("ui_up"):
			velocity += -transform.basis.z * speed
		if Input.is_action_pressed("ui_down"):
			velocity += transform.basis.z * speed
		if Input.is_action_pressed("ui_left"):
			velocity += -transform.basis.x * speed
		if Input.is_action_pressed("ui_right"):
			velocity += transform.basis.x * speed
		
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = jump_height
		
		velocity.y -= GRAVITY # Gravity
		velocity.y = clamp(velocity.y, -max_falling_speed, max_falling_speed)
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
# ----------------------------------
# Mouse controls

func _input(event): 
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) #yaw
		$Camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity)) #pitch
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-90), deg2rad(90))