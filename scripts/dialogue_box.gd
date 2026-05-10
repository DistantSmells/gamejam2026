extends Control
@onready var label: Label = $Container/MarginContainer/Label
@onready var art: TextureRect = $Container/TextureRect

var first = "Oh that poor Miss Fluffles... she must be so sad trapped in there :("
var second = "I should help her escape!"
var third = "That pin looks easy enough to click and unlatch..."
var fourth = ">:)"

func say():
	print("aaa")
	match label.text:
		" ":
			label.text = first
			art.texture = load("res://assets/art/dialogue box 1.png")
			visible = true
		first:
			label.text = second
			art.texture = load("res://assets/art/dialogue box 2.png")
			visible = true
		second:
			label.text = third
			art.texture = load("res://assets/art/dialogue box 1.png")
			visible = true
		third:
			label.text = fourth
			art.texture = load("res://assets/art/dialogue box 2.png")
			visible = true
		fourth:
			hide_box()

func hide_box():
	visible = false

func _process(delta):
	# Returns true only on the exact frame the key was first pressed
	if Input.is_action_just_pressed("jump") and visible == true:
		say()
