extends KinematicBody

const SPEED = 6
const ROTSPEED = deg2rad(7) 

var velocity = Vector3 (0, 0, 0)


func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x=0
	elif Input.is_action_pressed("ui_right"):
		velocity.x= SPEED
		$MeshInstance.rotate_z(-ROTSPEED)
	elif Input.is_action_pressed("ui_left"):
		velocity.x= -SPEED
		$MeshInstance.rotate_z(ROTSPEED)
	else:
		velocity.x= lerp(velocity.x,0,0.1)
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_up"):
		velocity.z=0
	elif Input.is_action_pressed("ui_down"):
		velocity.z= SPEED
		$MeshInstance.rotate_x(ROTSPEED)
	elif Input.is_action_pressed("ui_up"):
		velocity.z=  -SPEED
		$MeshInstance.rotate_x(-ROTSPEED)
	else:
		velocity.z= lerp(velocity.z,0,0.1)
	move_and_slide(velocity)
