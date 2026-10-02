extends AnimatableBody2D

@export var action := "flip_left"   # which key moves it
@export var is_left := true
@export var length := 80.0
@export var rest_angle := 25.0       # degrees below flat when idle
@export var up_angle := -30.0        # degrees when the key is held
@export var speed := 1200.0          # degrees per second

var _dir := 1.0  # +1 for left flipper, -1 for right (mirrors everything)

func _ready() -> void:
	_dir = 1.0 if is_left else -1.0
	# Put the paddle beside the hinge, not centered on it
	$CollisionShape2D.position = Vector2(length / 2.0 * _dir, 0)
	rotation_degrees = rest_angle * _dir

func _physics_process(delta: float) -> void:
	var target_angle := up_angle if Input.is_action_pressed(action) else rest_angle
	var target := deg_to_rad(target_angle * _dir)
	rotation = move_toward(rotation, target, deg_to_rad(speed) * delta)

func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(length * _dir, 0), Color.TOMATO, 14.0)
	draw_circle(Vector2.ZERO, 7, Color.TOMATO)
