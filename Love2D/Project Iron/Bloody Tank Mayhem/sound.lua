function sound_PlayIngameMusic()

	sound_StopAll()

	local randomNumber = math.random(1, musicCount)
	local currentSong = soundAsset_ingameMusic[randomNumber]
	TEsound.play(currentSong, "MusicChannel", audioMusicVolume, 1, function() sound_PlayIngameMusic() end)

end

function sound_GameStart()
	TEsound.play(soundAsset_countDown, "GameStartChannel", audioSFXVolume, 1)
end

function sound_ButtonPress()	
	TEsound.play(soundAsset_buttonPress, "UIChannel", audioSFXVolume, 1)
end

function sound_FireWeapon()
	TEsound.play(soundAsset_buttonPress, "SFXChannel", audioSFXVolume, 1)

end

function sound_PlayerExplosion()

end

function sound_StopAll()

	TEsound.stop("MusicChannel")

	TEsound.stop("SFXChannel")
	TEsound.stop("GameStartChannel")
	TEsound.stop("UIChannel")

	sound_SetVolume()

end

function sound_SetVolume()

	TEsound.volume("MusicChannel", audioMusicVolume)

	TEsound.volume("SFXChannel", audioSFXVolume)
	TEsound.volume("GameStartChannel", audioSFXVolume)
	TEsound.volume("UIChannel", audioSFXVolume)

end