class_name Level
extends Node

const BACKGROUNDS : Dictionary[Player2.Seasons,CompressedTexture2D] = {Player2.Seasons.SPRING: preload("res://Assets/Sprites/Backgrounds/spring.png"), Player2.Seasons.SUMMER: preload("res://Assets/Sprites/Backgrounds/summer.png"), Player2.Seasons.FALL: preload("res://Assets/Sprites/Backgrounds/fall.png"), Player2.Seasons.WINTER: preload("res://Assets/Sprites/Backgrounds/winter.png")}

@export var unused_buttons : Array[String]

signal melt
signal freeze
signal wind(force: int)


func _ready():
	for button_name in unused_buttons:
		$Player2HUD.hide_button(button_name)


func change_season(season: Player2.Seasons):
	change_background(season)
	match season:
		Player2.Seasons.SPRING:
			spring()
		Player2.Seasons.SUMMER:
			summer()
		Player2.Seasons.FALL:
			fall()
		Player2.Seasons.WINTER:
			winter()


func spring():
	wind.emit(0)


func summer():
	wind.emit(0)
	melt.emit()


func fall():
	wind.emit(-50)


func winter():
	wind.emit(0)
	freeze.emit()


func change_background(season: Player2.Seasons):
	$Background.texture = BACKGROUNDS[season]
