extends CharacterBody3D


var speed = 2
var hp = 30


@onready var nav: NavigationAgent3D = $NavigationAgent3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _process(delta):
	
	if hp <= 0:
		die()

	var player_position = get_tree().get_first_node_in_group("Player").position
	var direction = Vector3()
	
	nav.target_position = player_position
	look_at(player_position)
	
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = direction * speed
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()


func hurt(damage):
	hp -= damage


func die():
	queue_free()
