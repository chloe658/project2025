extends Node

var item_data: Dictionary = {}

func _ready():
	item_data = LoadData("res://scripts/itemdata.json")
	
func LoadData(file_path):
	var json_data
	var file_data = FileAccess.open(file_path, FileAccess.READ)
	json_data = JSON.parse_string(file_data.get_as_text())
	file_data.close()
	return json_data
	# if not working cos supposed to be json_data.result

# var file_data = FileAccess.new.call()
# file_data.open(file_path, FileAccess.READ)
