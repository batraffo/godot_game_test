extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

onready var ammo_label = $"/root/World/UI/Label"
onready var raycast = $"../Head/Camera/RayCast"
onready var current_ammo = clip_size
var can_fire = true
var reloading = false

func _process(_delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d /%d" % [current_ammo, clip_size])
	
	if Input.is_action_just_pressed("primary_fire"):
		#fireweapon
		if current_ammo > 0 and not reloading:
			if(can_fire):
				fire()
		elif not reloading:
			reaload()
			
	if Input.is_action_just_pressed("reload") and not reloading:
		reaload()
	
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Kiilled" + collider.name)
			

func fire():
	print("Fired Weapon")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	
	can_fire=true

func reaload():
	print("Reloading")
	reloading= true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	reloading = false
	print("Reload Complete")
