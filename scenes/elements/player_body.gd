extends CharacterBody2D

const JUMP_VELOCITY = -350.0

var PipeNode = preload("res://scenes/elements/pipe_node.tscn")
var score = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	
	get_parent().get_node("CanvasLayer/ScoreLabel").text = "[center]%s[/center]" % str(score)



func _on_pipe_resetter_body_entered(body: Node2D) -> void:
	if body.name == "Pipes":
		body.global_position = Vector2(1248, randf_range(270, 370))


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "ScoreArea":
		score = score + 1


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name in ["Pipes", "Floor"]:
		get_tree().reload_current_scene()
