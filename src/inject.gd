class_name Inject

static func propagate(node: Node, dependencies: Dictionary) -> void:
	if node.has_method("_inject"):
		node._inject(dependencies)
	for child in node.get_children():
		propagate(child, dependencies)
