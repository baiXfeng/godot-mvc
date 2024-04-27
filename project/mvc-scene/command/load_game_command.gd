extends mvc_command

# override
func _on_execute(e: mvc_event):
	
	# 获取 mvc 上下文
	var app: mvc_app = e.context
	
	# 获取玩家属性
	var user_attr: user_attribute_proxy = app.get_proxy("user_attr")
	
	# 读取玩家数据
	var data: Dictionary = _read_file("game.save")
	if not data.empty():
		user_attr.load( data )
	
	# 打印玩家序列化数据
	printt("玩家读档:", data)
	
func _read_file(filename: String) -> Dictionary:
	var file = File.new()
	var file_path = "user://" + filename
	if file.open(file_path, File.READ) == OK:
		var json_data = file.get_as_text()
		file.close()
		return parse_json(json_data)
	return {}
	
