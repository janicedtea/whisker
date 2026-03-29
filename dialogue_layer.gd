extends CanvasLayer

@onready var dialogue_label = $Panel/DialogueLabel
@onready var name_label = $Panel/NameLabel
@onready var portrait = $Panel/TextureRect

signal answered_correctly()
var dialogue_lines = []
var current_line = 0

func start_dialogue(lines: Array, speaker:String, portrait_texture: Texture2D):
	dialogue_lines = lines
	current_line = 0
	portrait.texture = portrait_texture
	name_label.text = speaker
	dialogue_label.text = dialogue_lines[current_line]

func _input(event):
	if event.is_action_pressed("next"):
		current_line += 1
		if current_line >= dialogue_lines.size():
			queue_free()
			return
		else:
			dialogue_label.text = dialogue_lines[current_line]
	if event.is_action_pressed("correctanswer"):
		print("yadsifojfoes")
		answered_correctly.emit()
		
