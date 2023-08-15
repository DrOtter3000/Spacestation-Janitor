extends Node3D


func _ready():
	get_tree().call_group("Player", "update_weapon", "melee", 5)


func attack_animation():
	$AnimationPlayer.play("attack")


func idle_animation():
	$AnimationPlayer.play("idle")
