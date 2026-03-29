extends CharacterBody2D

var walk_speed = 4
const tile_size = 16

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

enum PlayerState {idle, turning, walking}
enum FacingDirection {left, right, up, down}


var player_state = PlayerState.idle
var facing_direction = FacingDirection.down
var can_move = true

var initial_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0


func _ready():
	anim_tree.active = true
	initial_position = position
	
var interact_target = null

func _process(_delta):
	if interact_target and Input.is_action_just_pressed("interact"):
		interact_target.interact()

func _on_interaction_area_body_entered(body):
	if body.has_method("interact"):
		interact_target = body

func _on_interaction_area_body_exited(body):
	if body == interact_target:
		interact_target = null

func _physics_process(delta):
	if !can_move:
		return
	#if player_state == PlayerState.turning:
		#return
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		anim_state.travel("Walk")
		move(delta)
	else:
		anim_state.travel("Idle")
		is_moving = false
		
func process_player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if input_direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_direction)
		anim_tree.set("parameters/Walk/blend_position", input_direction)
		anim_tree.set("parameters/Turn/blend_position", input_direction)
		
		if need_to_turn():
			player_state = PlayerState.turning
			anim_state.travel("Turn")
		else:
			initial_position = position
			is_moving = true
	else:
		anim_state.travel("Idle")


func need_to_turn():
	var new_facing_direction
	if input_direction.x < 0:
		new_facing_direction = FacingDirection.left
	elif input_direction.x > 0:
		new_facing_direction = FacingDirection.right
	elif input_direction.y < 0:
		new_facing_direction = FacingDirection.up
	elif input_direction.y > 0:
		new_facing_direction = FacingDirection.down
		
	if facing_direction != new_facing_direction:
		facing_direction = new_facing_direction
		return true
	facing_direction = new_facing_direction
	return false

func finished_turning():
	player_state = PlayerState.idle
	
func move(delta):
	var motion = input_direction * tile_size * walk_speed * delta
	if move_and_collide(motion):
		is_moving = false
		input_direction = Vector2.ZERO
		return
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.00:
		percent_moved_to_next_tile = 0.00
		is_moving = false
		input_direction = Vector2.ZERO


func _on_animation_player_animation_finished(anim_name):
	if anim_name.begins_with("turn"):
		finished_turning()
