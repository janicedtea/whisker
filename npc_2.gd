extends Node2D

@onready var player = get_parent().get_node("Player")
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction()
		
func interact():
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["*muttering* odd... true...", "mmm.... oh, what's that? hi there! name's barley", "i've just been learning some new tricks. you ever seen a talking cat? what about a counting one?", "one, two, three, four, five, six, seven... eleven? yeah, i'm not very good at the rest of them.", "why don't you try"], "Barley", preload("res://npc2.png"))
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
