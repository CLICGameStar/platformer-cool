class_name Level
extends Node

const BACKGROUNDS : Dictionary[Player2.Seasons,CompressedTexture2D] = {Player2.Seasons.SPRING: preload("res://Assets/Sprites/Backgrounds/spring.png"), Player2.Seasons.SUMMER: preload("res://Assets/Sprites/Backgrounds/summer.png"), Player2.Seasons.FALL: preload("res://Assets/Sprites/Backgrounds/fall.png"), Player2.Seasons.WINTER: preload("res://Assets/Sprites/Backgrounds/winter.png")}

@export var unused_buttons : Array[String]

signal melt
signal freeze
signal wind(force: int)
signal show_cherries
signal hide_cherries


func _ready():
	for button_name in unused_buttons:
		$Player2HUD.hide_button(button_name)
	connect_water()
	connect_cherries()


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


func connect_water():
	get_tree().get_nodes_in_group("waterflows").map(func(waterflow): 
		melt.connect(waterflow.melt)
		freeze.connect(waterflow.freeze))

func connect_cherries():
	get_tree().get_nodes_in_group("cherry_trees").map(func(cherry_tree):
		show_cherries.connect(cherry_tree.enter_spring)
		hide_cherries.connect(cherry_tree.leave_spring))

func spring():
	wind.emit(0)
	show_cherries.emit()


func summer():
	wind.emit(0)
	melt.emit()
	hide_cherries.emit()


func fall():
	wind.emit(-50)
	hide_cherries.emit()


func winter():
	wind.emit(0)
	freeze.emit()
	hide_cherries.emit()


func change_background(season: Player2.Seasons):
	$Background.texture = BACKGROUNDS[season]
