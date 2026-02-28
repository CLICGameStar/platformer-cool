extends Level


func _ready():
	super()
	$Player2HUD.change_season(Player2.Seasons.WINTER)
