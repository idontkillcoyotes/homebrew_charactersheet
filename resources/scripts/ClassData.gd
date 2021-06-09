extends Resource
class_name CharacterClassData

enum ATTRIBUTES {
	FUERZA,
	AGILIDAD,
	INTELIGENCIA,
	ASTUCIA,
	CARISMA
}

export (String) var name = ""
export (String) var description = "Breve descripcion de la clase"
export (ATTRIBUTES) var main_attribute = 0
export (int,2,100) var hit_dice_sides = 6
export (int,0,20) var base_bonus_proficiency = 0
export (int,0,20) var main_attribute_bonus = 0
export (int,0,20) var base_physical_resistance = 0
export (int,0,20) var base_magical_resistance = 0
export (Dictionary) var abilities_prof = {
	"fuerza":{
		"agarrar_persona":false,
		"destruir":false,
		"mover_grandes_objetos":false,
		"trepar":false,
		"tumbar":false
	},
	"agilidad":{
		"atletismo":false,
		"juego_de_manos":false,
		"ocultarse":false,
		"sigilo":false
	},
	"inteligencia":{
		"analizar_muestra":false,
		"historia":false,
		"linguistica":false,
		"medicina":false,
		"naturaleza":false,
		"ocultismo":false
	},
	"astucia":{
		"averiguar_intencion":false,
		"investigacion":false,
		"manualidades":false,
		"percepsion":false
	},
	"carisma":{
		"disfrazarse":false,
		"interpretacion":false,
		"intimidar":false,
		"persuasion":false
	}
}

func get_ability_prof(attribute:String,ability:String)->bool:
	var attr : String = attribute.to_lower()
	var name : String = ability.to_lower()
	
	if abilities_prof.has(attr):
		if abilities_prof[attr].has(name):
			return abilities_prof[attr][name]

	return false
