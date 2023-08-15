extends CharacterBody3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 5
var jump_speed = 5
var mouse_sensitivity = 0.002
var melee_array = []
var melee :bool
var weapon_damage :int
var weapon_ready = true


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		get_tree().call_group("Weapon", "attack_animation")
		for enemy in melee_array:
			enemy.hurt(weapon_damage)
	walking_sounds()


func _physics_process(delta):
	velocity.y += -gravity * delta
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed



func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(60), deg_to_rad(65))


func walking_sounds():
	pass


func update_weapon(type, damage):
	if type == "melee":
		melee = true
	else: melee = false
	weapon_damage = damage


func _on_attack_area_body_entered(body):
	if body.is_in_group("Enemies"):
		melee_array.append(body)


func _on_attack_area_body_exited(body):
	if body.is_in_group("Enemies"):
		melee_array.erase(body)
