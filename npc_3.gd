extends Node2D

@onready var player = get_parent().get_node("Player")
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction()
		
func interact():
	var dialogue = preload("res://dialogue_layer.tscn").instantiate()
	get_tree().current_scene.add_child(dialogue)
	dialogue.start_dialogue(["zzz... oh, hi there! my name's chamomile, but you can call me cam", "im soooo eepy lately. have you got anything to wake me up?", "wow, you're quiet. i'm stumped here.", "...wait a minute!"], "Chamomile", preload("res://npc3.png"))
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
