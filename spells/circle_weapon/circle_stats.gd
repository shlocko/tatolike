extends Stats

class_name CircleStats


func get_dict():
	var props = self.get_property_list()
	var dict = {}
	for prop in props:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			var name = prop.name
			var value = self.get(name)
			dict[name] = value
	return dict
