local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAppearanceLoaded:Connect(function(character)
		local shirtExists = character:FindFirstChild("Shirt")
		if shirtExists then
			shirtExists:Destroy()
		end
		
		local pantsExists = character:FindFirstChild("Pants")
		if pantsExists then
			pantsExists:Destroy()
		end
		
		
		print(player.Name, "has joined", player.Team)
		local team = player.Team
		local shirt = team.Shirt:Clone()
		local pants = team.Pants:Clone()
		shirt.Parent = character
		pants.Parent = character
	end)
end)
