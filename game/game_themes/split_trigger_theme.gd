extends Node
class_name SplitTriggerTheme

static func get_theme() -> GameTheme:
	var new_theme = GameTheme.new()
	new_theme.background_color = SplitTriggerPalette.dark_ruby
	new_theme.midground_color = SplitTriggerPalette.medium_ruby
	new_theme.foreground_color = SplitTriggerPalette.off_white
	new_theme.primary_color = SplitTriggerPalette.electric_ruby
	new_theme.accent_color = SplitTriggerPalette.electric_energy
	return new_theme

	
class SplitTriggerPalette:
	const dark_purple = Color("13001E")
	const medium_purple = Color("3D0148")
	const purple = Color("674064")
	const light_purple = Color("9C6198")
	const hyperlight_purple = Color("D586D0")
	const electric_purple = Color("FF03ED")
	
	const dark_ruby = Color("1E000E")
	const medium_ruby = Color("470122")
	const ruby = Color("730237")
	const light_ruby = Color("B50558")
	const hyperlight_ruby = Color("E5036D")
	const electric_ruby = Color("FF0151")
	
	const dark_indigo = Color("00031E")
	const medium_indigo = Color("16063F")
	const indigo = Color ("32328C")
	const light_indigo = Color("4549C3")
	const hyperlight_indigo = Color("635BF6")
	const electric_indigo = Color("5441FF")
	
	const dark_blue = Color("000A1E")
	const medium_blue = Color("16233F")
	const blue = Color("324F8C")
	const light_blue = Color("456DC3")
	const hyperlight_blue = Color("5B8DF6")
	const electric_blue = Color("41AAFF")
	
	const dark_teal = Color("001E1E")
	const medium_teal = Color("15383C")
	const teal = Color("32838C")
	const light_teal = Color("3C9DA8")
	const hyperlight_teal = Color("50D1DF")
	const electric_teal = Color("5DFFFF")
	
	const dark_green = Color("001E17")
	const medium_green = Color("2A413A")
	const green = Color("588175")
	const light_green = Color("78BAA7")
	const hyperlight_green = Color("90DCC6")
	const electric_green = Color("A7FFCB")
	
	const dark_olive = Color("1E1600")
	const medium_olive = Color("5E5A42")
	const olive = Color("676040")
	const light_olive = Color("9C9661")
	const hyperlight_olive = Color("D5CD86")
	
	const dark_rust = Color("250C0A")
	const medium_rust = Color("3F1511")
	const rust = Color("8C3027")
	const light_rust = Color("AE3C31")
	const hyperlight_rust = Color("DC4C3E")
	
	const electric_energy = Color("35FF00")
	const warning_red = Color("FF0101")
	const off_white = Color("FFF8D0")
	
	const ui_border_purple = Color("894b82")
	const ui_border_indigo = Color("4E4b89")
	const ui_border_blue = Color("4B5f89")
	const ui_border_ruby = Color("894B66")
	const ui_border_rust = Color("89504B")
	const ui_border_orange = Color("89704B")
