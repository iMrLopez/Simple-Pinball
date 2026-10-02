extends StaticBody2D

# The main script listens for this
signal scored(points: int)

# @export makes these editable in the Inspector for each pin
@export var points := 100
@export var radius := 10.0
@export var color := Color.GOLD

func _ready() -> void:
	# Put every pin in a group so Main can find them all at once
	add_to_group("pins")

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)

# The ball calls this when it touches the pin
func hit() -> void:
	scored.emit(points)
	# Flash: go extra bright, then fade back over 0.2 seconds
	modulate = Color(3, 3, 3)
	create_tween().tween_property(self, "modulate", Color.WHITE, 0.2)
