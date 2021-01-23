extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("car"):
		body.queue_free()
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	print("projectile is no more")
	queue_free()
