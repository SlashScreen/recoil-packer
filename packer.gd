extends Control


const TextureLoad = preload("uid://dixiam2t4hm1r")
const ChannelSelect = preload("uid://do68g6gg1bfae")

@onready var file_dialog: FileDialog = $FileDialog

@onready var color_tex: TextureLoad = $VBoxContainer/HBoxContainer/ColorTexLayer/Color/ColorTex

@onready var team_tex: TextureLoad = $VBoxContainer/HBoxContainer/ColorTexLayer/Team/TeamTex
@onready var team_channel: ChannelSelect = $VBoxContainer/HBoxContainer/ColorTexLayer/Team/TeamChannel

@onready var emission_map: TextureLoad = $VBoxContainer/HBoxContainer/PBRTexLayer/Emission/EmissionMap
@onready var emission_channel: ChannelSelect = $VBoxContainer/HBoxContainer/PBRTexLayer/Emission/EmissionChannel

@onready var specular_multiplier: TextureLoad = $VBoxContainer/HBoxContainer/PBRTexLayer/Specular/SpecularMultiplier
@onready var specular_channel: ChannelSelect = $VBoxContainer/HBoxContainer/PBRTexLayer/Specular/SpecularChannel

@onready var cavity_map: TextureLoad = $VBoxContainer/HBoxContainer/PBRTexLayer/Cavity/CavityMap
@onready var cavity_channel: ChannelSelect = $VBoxContainer/HBoxContainer/PBRTexLayer/Cavity/CavityChannel


func pack_texture_base(path: String) -> void:
	var img := Image.create_empty(color_tex.img.get_width(), color_tex.img.get_height(), false, Image.FORMAT_RGBA8)
	# TODO: Move to compute shader one day if performance is bad
	var has_color := not color_tex.img.is_empty()
	var has_alpha := not team_tex.img.is_empty()
	
	for x: int in color_tex.img.get_width():
		for y: int in color_tex.img.get_height():
			var color := color_tex.img.get_pixel(x, y) if has_color else Color.BLACK
			var alpha := team_tex.img.get_pixel(x, y).a if has_alpha else 0.0
			img.set_pixel(x, y, Color(color.r, color.g, color.b, alpha))
	
	img.save_dds(path)


func pack_texture_extra(path: String) -> void:
	var img := Image.create_empty(color_tex.img.get_width(), color_tex.img.get_height(), false, Image.FORMAT_RGBA8)
	
	var has_emission := not emission_map.img.is_empty()
	var e_chann := emission_channel.selected_channel
	var has_specular := not specular_multiplier.img.is_empty()
	var s_chann := specular_channel.selected_channel
	var has_cavity := not cavity_map.img.is_empty()
	var c_chann := cavity_channel.selected_channel
	
	for x: int in color_tex.img.get_width():
		for y: int in color_tex.img.get_height():
			var r: float = emission_map.img.get_pixel(x, y)[e_chann] if has_emission else 0.0
			var g: float = specular_multiplier.img.get_pixel(x, y)[s_chann] if has_specular else 0.0
			var a: float = cavity_map.img.get_pixel(x, y)[c_chann] if has_cavity else 1.0
			var color := Color(r, g, 0.0, a)
			img.set_pixel(x, y, color)
	
	img.save_dds(path)


func _on_pack_pressed() -> void:
	file_dialog.popup_centered()


func _on_file_dialog_file_selected(path: String) -> void:
	var base_tex_path := path + "_color_team.dds"
	var extra_tex_path := path + "_extra.dds"
	pack_texture_base(base_tex_path)
	pack_texture_extra(extra_tex_path)
