extends Area2D



func _physics_process(delta):
	var bodies=get_overlapping_bodies()
	for body in bodies:
		if body.name=="Car":
			body.money=10
			queue_free()
