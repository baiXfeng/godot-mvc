extends mvc_handler

# override
func _on_enter(a: mvc_app):
	# 监听奖励金币
	a.add_listener("on_award_gold", self, "_on_award_gold")
	
# override
func _on_exit(a: mvc_app):
	# 解除奖励金币监听
	a.remove_listener("on_award_gold", self)

# 模拟奖励金币
func _on_award_gold(e: mvc_event):
	# 获取玩家属性
	var user_attr: user_attribute_proxy = app().get_proxy("user_attr")
	
	# 模拟奖励金币
	var gold: int = randi() % 100 + 1
	
	# 获得金币
	user_attr.add_gold( gold )
	
	printt("金币奖励:", gold, "当前总金币:", user_attr.get_gold())
	
