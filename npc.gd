extends Node2D

@onready var player = get_parent().get_node("Player")
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction()
		
func interact():
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["my name's peppermint, who're you?", "oh, you looking to escape this island?", "there's no way, we've all been stuck here for as long as we can remember!", "oh... well... if you want to go to your friend's place that bad... i guess i can telll you a secret!", "*whispers* answer this riddle: If 5 cats catch 5 mice in 5 minutes, how long will it take one cat to catch a mouse?", "go press the number at the door!"], "Peppermint", preload("res://npc1.png"))
	await dialogue.tree_exited
	

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		player_in_range = false

func interaction():
	print("yayy")
