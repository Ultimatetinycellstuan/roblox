local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

local scoreBoardGui = workspace.Score.ScoreboardGui
local elfScore = scoreBoardGui.Score.ElfScore
local gnomeScore = scoreBoardGui.Score.GnomeScore
local status = scoreBoardGui.Status
local timer = scoreBoardGui.Timer

local goal1 = workspace.goal1
local goal2 = workspace.goal2
local ball = workspace.Ball
local originalPosition = ball.Position

local minutes = 0
local minuteLength = 0.5
local elfSpawn
local gnomeSpawn
local half = 1

local function resetTeams()
	if half == 1 then
		elfSpawn = workspace.Team1Spawn
		gnomeSpawn = workspace.Team2Spawn
	else
		gnomeSpawn = workspace.Team1Spawn
		elfSpawn = workspace.Team2Spawn
	end
	
	for index, player in ipairs(Teams["Elf City"]:GetPlayers()) do
		local character = player.Character or player.CharacterAdded:Wait()
		character.PrimaryPart.CFrame = elfSpawn.CFrame
	end
	for index, player in ipairs(Teams["Gnome Rovers"]:GetPlayers()) do
		local character = player.Character or player.CharacterAdded:Wait()
		character.PrimaryPart.CFrame = gnomeSpawn.CFrame
	end
end

local function resetBall(waitTime)
	ball.Anchored = true
	ball.Position = originalPosition
	ball.AssemblyLinearVelocity = Vector3.new(0,0,0)
	ball.AssemblyAngularVelocity = Vector3.new(0,0,0)
	wait(waitTime)
	ball.Anchored = false
end

local function score(team)
	team.Text = team.Text + 1
	status.Text = "GOAL"
	resetTeams()
	resetBall(1)
end

ball.Touched:Connect(function(part)
	if (half == 1 and part == goal1) or (half == 2 and part == goal2) then
		score(gnomeScore)
	elseif (half == 1 and part == goal2) or (half == 2 and part == goal1) then
		score(elfScore)
	end
end)

-- Main Game Loop
while true do
	ball.Position = originalPosition
	ball.Anchored = true
	
	if #Players:GetPlayers() < 2 then
		status.Text = "Waiting for Players"
		wait(1)
	else
		status.Text = "Starting soon"
		half = 1
		wait(5)
		resetTeams()
		resetBall(0)
		gnomeScore.Text = 0
		elfScore.Text = 0
		goal1.BrickColor = Teams["Elf City"].TeamColor
		goal2.BrickColor = Teams["Gnome Rovers"].TeamColor

		for minutes=1, 90 do
			timer.Text = "Timer: " .. minutes
			status.Text = ""
			
			if #Players:GetPlayers() < 2 then
				break
			end

			if minutes == 45 then
				status.Text = "Half Time"
				half = 2
				goal2.BrickColor = Teams["Elf City"].TeamColor
				goal1.BrickColor = Teams["Gnome Rovers"].TeamColor
				resetTeams()
				resetBall(5)
			end

			wait(minuteLength)
		end
	end
end


