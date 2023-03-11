extends Node2D

@onready var label = $Label
@onready var sprite = $Sprite2D

enum {
	BACK,
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	KNIGHT
}

var cardVal: int
# Called when the node enters the scene tree for the first time.
func _ready():
#	label = $Label
#	sprite = $Sprite2d
#	label.text = "3"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_card_value(value: int):
	cardVal = value
#	sprite.frame = value

func get_card_value():
	return cardVal

func set_frame(value: int):
	sprite.frame = value


func set_destination(dest: Vector2):
	position = dest

func flip_card():
	if sprite.frame != cardVal:
		sprite.frame = cardVal
	else:
		sprite.frame = BACK
	
	

