extends StaticBody2D

# The table outline, walked point by point.
# Starts at the left flipper, goes up the left side, across the top,
# down the right side, and ends at the right flipper.
# The gap at the bottom is where the ball drains.
const OUTLINE := [
	Vector2(190, 860), Vector2(20, 760), Vector2(20, 120),
	Vector2(120, 20), Vector2(420, 20), Vector2(520, 120),
	Vector2(520, 760), Vector2(350, 860),
]

func _ready() -> void:
	# One invisible collision line between each pair of points
	for i in OUTLINE.size() - 1:
		var segment := SegmentShape2D.new()
		segment.a = OUTLINE[i]
		segment.b = OUTLINE[i + 1]
		var shape := CollisionShape2D.new()
		shape.shape = segment
		add_child(shape)

func _draw() -> void:
	# Draw the same outline so you can see it
	draw_polyline(PackedVector2Array(OUTLINE), Color.SKY_BLUE, 4.0)
