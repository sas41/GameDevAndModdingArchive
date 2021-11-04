function showMainMenu()

	--Start Button
	StartButton = loveframes.Create("imagebutton")
	StartButton:SetState("mainmenu")
	StartButton:SetText("START!")
	StartButton:SetPos(200, 200)
	StartButton:SetSize(100, 25)
	StartButton.OnClick = function(object)
		showLevelSelection()
	end

	loveframes.SetState("mainmenu")

end

function closeMainMenu()

	StartButton:Remove()
	StartButton:SetState("")

end

function showLevelSelection()
	startGame()
end