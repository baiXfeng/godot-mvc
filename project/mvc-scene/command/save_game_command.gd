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
	
	# 打印玩家序列化数据
	printt("玩家存档:", data)
	
