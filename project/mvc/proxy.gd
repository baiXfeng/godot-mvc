extends RefCounted
class_name MVCProxy
	
signal on_data_changed(sender: MVCProxy, data)
	
func name() -> String:
	return _name
	
func data():
	return _data
	
func set_data(d):
	_data = d
	on_data_changed.emit(self, _data)
	
func app() -> MVCApp:
	return _app.get_ref()
	
func on_enter(a: MVCApp):
	if a.debug_print:
		print("proxy <%s:%s> on_enter." % [app().name(), _name])
	_on_enter(a)
	
func on_exit(a: MVCApp):
	if a.debug_print:
		print("proxy <%s:%s> on_exit." % [app().name(), _name])
	_on_exit(a)
	
func save(dict: Dictionary):
	_on_save(dict)
	
func load(dict: Dictionary):
	_on_load(dict)
	
func notify(event_name: String, value = null):
	app().notify(event_name, value)
	
func send(e: MVCEvent):
	app().send(e)
	
# ==============================================================================
# private
var _app: WeakRef
var _name: String
var _data
	
func _init(data = null):
	_data = data
	
# override
func _on_enter(a: MVCApp):
	pass
	
# override
func _on_exit(a: MVCApp):
	pass
	
# override
func _on_save(dict: Dictionary):
	pass
	
# override
func _on_load(dict: Dictionary):
	pass
	
func _set_name(n: String):
	_name = n
	
func _set_app(a: MVCApp):
	_app = weakref(a)
	
func _to_string() -> String:
	return "proxy:%s:%s" % [_name, _data]
	
