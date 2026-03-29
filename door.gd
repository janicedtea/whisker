extends Node2D

@onready var player = get_parent().get_node("Player")
var player_in_range = false

var destinations: Array[Vector2] = [
	Vector2(10, 10), 
	Vector2(20, 20), 
	Vector2(30, 30)
]
var door_number: int = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = true

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interact()

func interact():
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["tell me the answer to peppermints riddle!"], "Mysterious Door", preload("res://doorpicture.png"))
	await dialogue.tree_exited
	

	
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false




func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = false


func _on_dialogue_layer_answered_correctly() -> void:
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["wow... you're right!", "a new door has appeared!"], "Mysterious Door", preload("res://doorpicture.png"))
	await dialogue.tree_exited
	hide()
