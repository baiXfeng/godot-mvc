extends Node
class_name MVCHandler
	
func name() -> String:
	return _name
	
func app() -> MVCApp:
	return _app.get_ref()
	
func get_proxy(name: String) -> MVCProxy:
	return app().get_proxy(name)
	
func on_enter(a: MVCApp):
	if a.debug_print:
		print("handler <%s:%s> on_enter." % [app().name(), _name])
	_on_enter(a)
	
func on_exit(a: MVCApp):
	if a.debug_print:
		print("handler <%s:%s> on_exit." % [app().name(), _name])
	_on_exit(a)
	queue_free()
	
func notify(event_name: String, value = null):
	app().notify(event_name, value)
	
func send(e: MVCEvent):
	app().send(e)
	
# ==============================================================================
# private
var _app: WeakRef
var _name: String
	
# override
func _on_enter(a: MVCApp):
	pass
	
# override
func _on_exit(a: MVCApp):
	pass
	
# ==============================================================================
# private function
func _init(parent: Node = null):
	if parent:
		parent.add_child(self)
	
func _set_name(n: String):
	_name = n
	
func _set_app(a: MVCApp):
	_app = weakref(a)
	
func _to_string() -> String:
	return "handler:%s" % _name
	
