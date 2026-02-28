extends Node2D

var backgrounds : Dictionary[Player2.Seasons,CompressedTexture2D] = {Player2.Seasons.SPRING: preload("res://Assets/Sprites/Backgrounds/spring.png"), Player2.Seasons.SUMMER: preload("res://Assets/Sprites/Backgrounds/summer.png"), Player2.Seasons.FALL: preload("res://Assets/Sprites/Backgrounds/fall.png"), Player2.Seasons.WINTER: preload("res://Assets/Sprites/Backgrounds/winter.png")}

func _ready():
	$Player2HUD.hide_button("Orange")
	$Player2HUD.hide_button("Yellow")
	$Player2HUD.hide_button("Purple")
	$Player2HUD.hide_button("Green")
	$Player2HUD.hide_button("Blue")
	
func change_background(season: Player2.Seasons):
	$Background.texture = backgrounds[season]
