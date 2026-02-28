extends CanvasLayer
class_name Player2

signal red
signal orange
signal yellow
signal green
signal blue
signal purple

signal new_season(season: Seasons)

enum Seasons {SPRING, SUMMER, FALL, WINTER}

var current_season: Seasons = Seasons.SPRING


func _process(_delta):
	if Input.is_action_just_pressed("spring_button"):
		change_season(Seasons.SPRING)
	elif Input.is_action_just_pressed("summer_button"):
		change_season(Seasons.SUMMER)
	elif Input.is_action_just_pressed("fall_button"):
		change_season(Seasons.FALL)
	elif Input.is_action_just_pressed("winter_button"):
		change_season(Seasons.WINTER)


func change_season(season: Seasons) -> void:
	if season == current_season:
		return
	current_season = season
	new_season.emit(season)


func hide_button(button_name: String):
	$Buttons.find_child(button_name).visible = false

func _on_red_pressed():
	red.emit()


func _on_orange_pressed():
	orange.emit()


func _on_yellow_pressed():
	yellow.emit()


func _on_green_pressed():
	green.emit()


func _on_blue_pressed():
	blue.emit()


func _on_purple_pressed():
	purple.emit()
	
