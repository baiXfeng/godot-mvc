extends mvc_proxy
class_name user_attribute_proxy
	
# 金币
var _gold: int
# 血量
var _hp: int
	
# 金币变更信号
signal on_gold_changed(value)
# 血量变更信号
signal on_hp_changed(value)
	
# 增加金币
func add_gold(value: int):
	_gold += value
	emit_signal("on_gold_changed", _gold)
	
# 获取金币
func get_gold() -> int:
	return _gold
	
# 增加血量
func add_hp(value: int):
	_hp += value
	if _hp <= 0:
		_hp = 0
	emit_signal("on_hp_changed", _hp)
	
# 获取血量
func get_hp() -> int:
	return _hp
	
# override
func _on_save(dict: Dictionary):
	dict["hp"] = _hp
	dict["gold"] = _gold
	
# override
func _on_load(dict: Dictionary):
	_hp = dict["hp"] as int
	_gold = dict["gold"] as int
	
