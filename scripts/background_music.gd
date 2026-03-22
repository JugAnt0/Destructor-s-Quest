extends Node

@onready var normal_music: AudioStreamPlayer2D = $normal
@onready var boss_music: AudioStreamPlayer2D = $boss

func play_normal():
	boss_music.stop()
	normal_music.play()

func play_boss():
	normal_music.stop()
	boss_music.play()
