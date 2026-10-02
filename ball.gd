extends RigidBody2D

const RADIUS := 12.0

func _ready() -> void:
	# Needed so the ball reports what it bumps into
	contact_monitor = true
	max_contacts_reported = 4
	# Stops a fast ball from passing straight through thin things
	continuous_cd = RigidBody2D.CCD_MODE_CAST_SHAPE
	body_entered.connect(_on_body_entered)

func _draw() -> void:
	draw_circle(Vector2.ZERO, RADIUS, Color.WHITE)

func _on_body_entered(body: Node) -> void:
	# Anything that has a hit() function (our pins) gets told it was hit
	if body.has_method("hit"):
		body.hit()
