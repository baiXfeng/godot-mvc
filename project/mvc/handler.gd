extends Node
class_name mvc_handler
	
func name() -> String:
	return _name
	
func app() -> mvc_app:
	return _app.get_ref()
	
func get_proxy(name: String) -> mvc_proxy:
	return app().get_proxy(name)
	
func on_enter(a: mvc_app):
	if a.debug_print:
		print("handler <%s:%s> on_enter." % [app().name(), _name])
	_on_enter(a)
	
func on_exit(a: mvc_app):
	if a.debug_print:
		print("handler <%s:%s> on_exit." % [app().name(), _name])
	_on_exit(a)
	queue_free()
	
func notify(event_name: String, value = null):
	app().notify(event_name, value)
	
func send(e: mvc_event):
	app().send(e)
	
# ==============================================================================
# private
var _app: WeakRef
var _name: String
	
# override
func _on_enter(a: mvc_app):
	pass
	
# override
func _on_exit(a: mvc_app):
	pass
	
# ==============================================================================
# private function
func _init(parent: Node = null):
	if parent:
		parent.add_child(self)
	
func _set_name(n: String):
	_name = n
	
func _set_app(a: mvc_app):
	_app = weakref(a)
	
func _to_string() -> String:
	return "handler:%s" % _name
	
