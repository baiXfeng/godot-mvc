extends MVCCommand

# override
func _on_execute(e: MVCEvent):
	
	# 获取玩家属性
	var user_attr: user_attribute_proxy = get_proxy("user_attr")
	
	# 读取玩家数据
	var data: Dictionary = _read_file("game.save")
	if not data.is_empty():
		user_attr.load( data )
	
	# 打印玩家序列化数据
	printt("玩家读档:", data)
	
func _read_file(filename: String) -> Dictionary:
	var file_path = "user://" + filename
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file.get_open_error() != OK:
		return {}
	var dict: Dictionary = JSON.parse_string( file.get_as_text() )
	return dict if dict != null else {}
	
