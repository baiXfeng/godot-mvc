extends mvc_command

# override
func _on_execute(e: mvc_event):
	
	# 获取 mvc 上下文
	var app: mvc_app = e.context
	
	# 获取玩家属性
	var user_attr: user_attribute_proxy = app.get_proxy("user_attr")
	
	# 序列化玩家数据
	var data: Dictionary
	user_attr.save( data )
	
	# 保存到磁盘
	_write_file(data, "game.save")
	
	# 打印玩家序列化数据
	printt("玩家存档:", data)
	
func _write_file(data: Dictionary, filename: String) -> bool:
	var data_text = JSON.stringify(data)
	var file_path = "user://" + filename
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file.get_open_error() != OK:
		return false
	file.store_string(data_text)
	return true
	
