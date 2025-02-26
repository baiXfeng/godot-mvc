extends MVCHnadler
	
# override
func _on_enter(a: MVCApp):
	# 监听战斗模拟事件
	a.add_callable("on_battle_simulation", _on_battle_simulation)
	# 监听恢复血量技能事件
	a.add_callable("on_skill_recover_hp", _on_skill_recover_hp)
	
# override
func _on_exit(a: MVCApp):
	# 解除战斗模拟事件监听
	a.remove_callable("on_battle_simulation", _on_battle_simulation)
	# 解除恢复血量技能事件监听
	a.remove_callable("on_skill_recover_hp", _on_battle_simulation)

# 处理战斗模拟事件
func _on_battle_simulation(e: MVCEvent):
	# 获取玩家属性
	var user_attr: user_attribute_proxy = get_proxy("user_attr")
	
	# 模拟伤害
	var damage: int = -( randi() % 100 + 10 )
	
	# 进行伤害
	user_attr.add_hp( damage )
	
	printt("战斗伤害:", damage, "当前血量:", user_attr.get_hp())

# 处理恢复血量技能
func _on_skill_recover_hp(e: MVCEvent):
	# 获取玩家属性
	var user_attr: user_attribute_proxy = get_proxy("user_attr")
	
	# 模拟恢复
	var recover_hp: int = 50
	
	# 进行恢复
	user_attr.add_hp( recover_hp )
	
	printt("恢复血量:", recover_hp, "当前总血量:", user_attr.get_hp())
	
