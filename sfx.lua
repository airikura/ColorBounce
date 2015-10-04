local sfx = {} 

--sfx.menuMusic = audio.loadSound("ColorBounceMenuMusic3.mp3")
--sfx.gameMusic = audio.loadSound("ColorBounceSoundtrack2.mp3")
sfx.musicIsPlaying = false
sfx.init = function()
	masterVolume = audio.getVolume() 
	audio.setVolume(1.0)
end

sfx.play = function(handle, options)
	local settings = loadTable("gameSettings.json")
	if ((settings and settings.shouldPlayMusic == false) or 
		sfx.musicIsPlaying) then 
		return false
	end
	audio.play(handle, options)
	sfx.musicIsPlaying = true
end

sfx.stop = function(handle)
	audio.stop()
	handle = nil
	sfx.musicIsPlaying = false
end

return sfx