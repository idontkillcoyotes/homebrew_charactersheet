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
export (String) var description = ""
export (ATTRIBUTES) var main_attribute = 0
export (int,2,100) var hit_dice_sides = 6
export (int,0,20) var base_bonus_proficiency = 0
export (int,0,20) var main_attribute_bonus = 0
export (int,0,20) var base_physical_resistance = 0
export (int,0,20) var base_magical_resistance = 0
export (Dictionary) var abilities_prof = {
	"Agarrar persona":false,
	"Analizar muestra":false,
	"Atletismo":false,
	"Averiguar intenciones":false,
	"Destruir":false,
	"Disfrazarse":false,
	"Historia":false,
	"Interpretacion":false,
	"Investigacion":false,
	"Intimidar":false,
	"Juego de manos":false,
	"Linguistica":false,
	"Manualidades":false,
	"Medicina":false,
	"Mover grandes objetos":false,
	"Naturaleza":false,
	"Ocultarse":false,
	"Ocultismo":false,
	"Percepcion":false,
	"Persuasion":false,
	"Sigilo":false,
	"Trepar":false,
	"Tumbar":false
}

func get_ability_prof(ability:String)->bool:
	if abilities_prof.has(ability):
		return abilities_prof[ability]
	return false

func set_ability_prof(ability:String,value:bool):
	if abilities_prof.has(ability):
		abilities_prof[ability] = value
