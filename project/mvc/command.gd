extends RefCounted
class_name mvc_command

var _cmd_list: Array

func add_command(cmd):
	_cmd_list.append(cmd)

func execute(e: mvc_event):
	if not _cmd_list.is_empty():
		for cmd in _cmd_list:
			cmd.execute(e)
	_on_execute(e)
	
# ==============================================================================
# override
func _on_execute(e: mvc_event):
	pass
	
