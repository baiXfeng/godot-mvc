extends Node2D
	
@onready var _view = $user_attribute_view
	
var _app: mvc_app = mvc_app.new()		# 创建mvc上下文
	
func _ready():
	# 初始化应用
	_init_app()
	# 初始化视图
	_init_view()
	
func _init_app():
	# 启用 mvc 信息打印
	_app.debug_print = true
	
	# 注册数据代理
	_app.add_proxy("user_attr", user_attribute_proxy.new())
	
	# 注册战斗事件处理器
	_app.add_handler("battle_handler", load("res://mvc-scene/handler/battle_handler.gd").new())
	# 注册奖励事件处理器
	_app.add_handler("award_handler", load("res://mvc-scene/handler/award_handler.gd").new())
	
	# 注册存档命令
	_app.add_command("save_game_command", load("res://mvc-scene/command/save_game_command.gd"))
	
func _init_view():
	# 获取用户数据
	var user_attr: user_attribute_proxy = _app.get_proxy("user_attr")
	# 用户数据绑定视图
	_view.set_proxy( user_attr )
	
func _on_AddGold_pressed():
	# 奖励金币事件
	_app.notify("on_award_gold")
	
func _on_AddHP_pressed():
	# 技能回血事件
	_app.notify("on_skill_recover_hp")
	
func _on_Damage_pressed():
	# 战斗伤害模拟
	_app.notify("on_battle_simulation")
	
func _on_SaveGame_pressed():
	# 存档命令
	_app.notify("save_game_command")
