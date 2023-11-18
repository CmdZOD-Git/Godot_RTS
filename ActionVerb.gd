extends Resource

class_name ActionVerb

enum verb_list {
	Transform,
}

@export var verb:verb_list
@export var icon:Texture2D
@export var function_called:String
@export var parameters:Array
