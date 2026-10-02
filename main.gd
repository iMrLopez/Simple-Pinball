extends Node2D

const BALL_SCENE := preload("res://ball.tscn")
const SPAWN_POSITION := Vector2(270, 60)

var score := 0
var balls_left := 3

@onready var score_label: Label = $UI/ScoreLabel

func _ready() -> void:
	# Listen to every pin's "scored" signal
	for pin in get_tree().get_nodes_in_group("pins"):
		pin.scored.connect(_on_pin_scored)
	update_label()
	spawn_ball()

func _on_pin_scored(points: int) -> void:
	score += points
	update_label()

func update_label() -> void:
	score_label.text = "Score: %d    Balls: %d" % [score, balls_left]

func spawn_ball() -> void:
	var ball: RigidBody2D = BALL_SCENE.instantiate()
	ball.position = SPAWN_POSITION
	# A small random sideways push so every ball takes a different path
	ball.linear_velocity = Vector2(randf_range(-150, 150), 0)
	add_child(ball)

# Called by the Drain (Step 7) when a ball falls out
func _on_drain_body_entered(body: Node) -> void:
	if not (body is RigidBody2D):
		return
	body.queue_free()
	balls_left -= 1
	update_label()
	if balls_left > 0:
		spawn_ball.call_deferred()
	else:
		score_label.text += "\nGAME OVER - press Enter"

func _unhandled_input(event: InputEvent) -> void:
	# ui_accept is built in: Enter or Space
	if balls_left == 0 and event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
