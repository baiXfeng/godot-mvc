extends RefCounted
class_name mvc_test

var _app: mvc_app = mvc_app.new("mvc_app_test")

func _init():
	_app.debug_print = true
	_test_proxy()
	_test_handler()
	_test_command()
	_test_event()
	
func _test_proxy():
	_app.add_proxy("p1", mvc_proxy.new(1))
	_app.add_proxy("p2", mvc_proxy.new(2))
	_app.add_proxy("p2", mvc_proxy.new(2))
	_app.add_proxy("p3", mvc_proxy.new(3))
	_app.remove_proxy("p1")
	
	printt("get proxy", _app.get_proxy("p1"), "has proxy", _app.has_proxy("p3"))
	print("")
	
func _test_handler():
	_app.add_handler("h1", mvc_handler.new())
	_app.add_handler("h2", mvc_handler.new())
	_app.add_handler("h3", mvc_handler.new())
	_app.remove_handler("h3")
	
	printt("get handler", _app.get_handler("h1"), "has handler", _app.has_handler("h3"))
	print("")
	
class _cmd extends mvc_command:
	func _init():
		print("test command init.")
	func _on_execute(e: mvc_event):
		print("test command execute.")
	
func _test_command():
	_app.add_command("test_cmd_1", _cmd)
	_app.add_command("test_cmd_2", _cmd)
	
	_app.notify("test_cmd_2")
	
	printt("has command", _app.has_command("test_cmd_1"))
	
	_app.remove_command("test_cmd_1")
	_app.notify("test_cmd_1")
	
	printt("has command", _app.has_command("test_cmd_1"))
	print("")
	
class _event_handler extends mvc_handler:
	# override
	func _on_enter(a: mvc_app):
		a.add_callable("test", _on_event)
	# override
	func _on_exit(a: mvc_app):
		a.remove_callable("test", _on_event)
	func _on_event(e: mvc_event):
		print("handler <%s> on event <%s> with <%s>." % [name(), e.name, e.data])
	
func _test_event():
	var handler: mvc_handler = _app.get_handler("h1")
	handler.notify("test_cmd_2")
	handler.send(mvc_event.new("test_cmd_2", null))
	
	print("")
	
	_app.add_handler("event_handler", _event_handler.new())
	_app.notify("test", "test event handler.")
	_app.remove_handler("event_handler")
	_app.notify("test", "test event handler.")
	
	print("")
	
