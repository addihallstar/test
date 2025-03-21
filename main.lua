if rawequal(game:IsLoaded(),false) then
	game.Loaded:Wait()
end
wait(0.5)
local oldcharpos;oldcharpos=game:GetService("Players").LocalPlayer.Character:GetPivot()
game:GetService("Players").LocalPlayer.SimulationRadius = 1000
game:GetService("Players").LocalPlayer.Character:BreakJoints()
wait(game:GetService("Players").RespawnTime+0.5)
game:GetService("Players").LocalPlayer.SimulationRadius = 1000
game:GetService("Players").LocalPlayer.Character:PivotTo(oldcharpos)
wait(0.1)
local p = game.Players.LocalPlayer
local pc = p.Character
p.CharacterAdded:Connect(function(c)
	pc = c
end)
local function safestring(g)
	local EX,N=pcall(function()
		tostring(g)
	end)
	if EX == true then
		return tostring(g)
	end
end
cmd = {
	add = function(n,g,t)
		table.insert(cmd["list"],{["function"] = t,["description"]=g,["name"]=n})
	end,
	list = {}

}
getPlr = function(Name)
	local Players = game.Players
	if Name:lower() == "random" then
		return Players:GetPlayers()[math.random(#Players:GetPlayers())]
	else
		Name = Name:lower():gsub("%s", "")
		for _, x in next, Players:GetPlayers() do
			if x.Name:lower():match(Name) then
				return x
			elseif x.DisplayName:lower():match("^" .. Name) then
				return x
			end
		end
	end
end
function execute(n,...)
	if rawequal(cmd["list"][n:lower()],nil) ~= true then
		cmd["list"][n:lower()]["function"](...)
	else
		notify("No command found with the name of "..n..".","TERMINAL")
	end
end
function notify(t,n,i)
	if rawequal(i,nil) then
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Text = t,
			Title = n,
			Duration = 5;
		})
	else
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Text = t,
			Title = n,
			Duration = 5;
		})
	end
end
hiddenfling = false
Noclip = nil
locks = {}
if getgenv then
else
	getgenv = getfenv
end
if firetouchinterest then
else
	firetouchinterest = function()
		warn("not usable")
	end
end
lock = function(instance, par)
	locks[instance] = true
	instance.Parent = par or instance.Parent
	instance.Name = "RightGrip"
end
cmd.add({"to","goto"},"Teleports you to another player's location.",function(name)

	if getPlr(name) then
		pc:PivotTo(getPlr(name).Character:GetPivot())
	end
end)
cmd.add({"run","src","source","exe","execute"},"Runs the selected code.",function(code)
	loadstring(code)()
end)
cmd.add({"commands","cmds","help"},"Shows all of the commands TERMINAL has.",function()
	notify("Press F9 or say '/console' to see the commands. (SCROLL DOWN IF NEEDED)","TERMINAL")
	pcall(function()
		for i,x in next, cmd["list"] do
			local aliases = {}
			for m, v in pairs(x["name"]) do
				if m == 1 then continue end
				if m ~= #x["name"] then
					table.insert(aliases,v..", ")
				else
					table.insert(aliases,v..".")
				end
			end
			if #aliases > 0 then
				local string = ""
				for _, v in ipairs(aliases) do
					string ..= v
				end
				print(x["name"][1]..": Aliases: "..string.." | Description: "..x["description"])
			else
				print(x["name"][1]..": Aliases: none | Description: "..x["description"])
			end
		end
	end)
end)
cmd.add({"wallwalk","spiderman","ww"},"makes you walk on walls",function()
	loadstring(game:HttpGet("https://pastebin.com/raw/s4FjP97j"))()
end)
cmd.add({"httpspy","hspy"},"Executes http spy.", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/HttpSpy'))()
end)
cmd.add({"remotespy","rspy"},"Executes remote spy.",function()
	loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
end)
cmd.add({"gravity"},"Sets workspace gravity value to [number].",function(gravity)
	workspace.Gravity = gravity
end)
cmd.add({"swordreach","reach"},"Adds extra range to your sword.",function()
	pcall(function()
		local reachsize =  40
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
		if Tool:FindFirstChild("OGSize3") then
			Tool.Handle.Size = Tool.OGSize3.Value
			Tool.OGSize3:Destroy()
			Tool.Handle.FunTIMES:Destroy()
		end
		local val = Instance.new("Vector3Value",Tool)
		val.Name = "OGSize3"
		val.Value = Tool.Handle.Size
		local sb = Instance.new("SelectionBox")
		sb.Adornee = Tool.Handle
		sb.Name = "FunTIMES"
		sb.Parent = Tool.Handle
		Tool.Handle.Massless = true
		Tool.Handle.Size = Vector3.new(reachsize,reachsize,reachsize)
	end)
end)
cmd.add({"revive"},'"No... ill never give up. I HAVE THE POWER OF FRIENDSHIP!!!" ahh command, anyway this might not work though',function(t)
	local Older;Older=pc:FindFirstChildOfClass("Humanoid").Health
	local reload = true
	task.spawn(function()
		repeat
			game:GetService("RunService").RenderStepped:Wait()
			pcall(function()
				if pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.FallingDown and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Swimming and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Seated and pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Jumping and  pc:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Freefall then
					pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
				end
			end)
		until rawequal(reload,false)
	end)
	task.spawn(function()
		repeat
			task.wait(0.13)
			pcall(function()
				if rawequal(reload,true) then
					Older=pc:FindFirstChildOfClass("Humanoid").Health
				end
			end)
		until pc:FindFirstChildOfClass("Humanoid").Health <= 0
	end)
	local idk
	pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
	pc:FindFirstChildOfClass("Humanoid").RequiresNeck = false
	pc:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
	idk = pc:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
		local r;r = pc:FindFirstChildOfClass("Humanoid").Health
		pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
		if tonumber(Older)>tonumber(r) then
			pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,false)
			pc:FindFirstChildOfClass("Humanoid").Parent = game.ReplicatedStorage
			game.ReplicatedStorage:FindFirstChild("Humanoid").Parent = pc
			if r<=5 then
				idk:Disconnect()
				delay(0.02,function()
					reload = false
				end)
			end
		else
			Older = r
		end
	end)
end)
cmd.add({"partfling","pf","partf"},"Flings someone using parts, far more undetectable and works in collisions off.",function(name)
	local function PartFling(target)
		if target then
			local function NetworkCheck(Part)
				return Part.ReceiveAge == 0
			end
			local function getclosestpart()
				local bestpart
				local biggestmagnitude 
				for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
						if v.Anchored == false and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent.Parent:FindFirstChildOfClass("Humanoid") and not v:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) then
							if biggestmagnitude == nil or biggestmagnitude ~= nil and (game.Players.LocalPlayer.Character.Head.Position-v.Position).Magnitude < biggestmagnitude then
								if #v:GetConnectedParts() < 2 then
									biggestmagnitude = (game.Players.LocalPlayer.Character.Head.Position-v.Position).Magnitude
									bestpart = v
								end
							end
						end
					end
				end
				return bestpart
			end
			local Part = getclosestpart()
			if Part == nil then return end
			local oldcf=game:GetService("Players").LocalPlayer.Character:GetPivot()
			repeat
				game:GetService("Players").LocalPlayer.Character:PivotTo(Part.CFrame)
				game:GetService("RunService").RenderStepped:Wait()
			until NetworkCheck(Part) == true
			game:GetService("Players").LocalPlayer.Character:PivotTo(oldcf)
			game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			Part.Velocity = Vector3.new(0,5000,0)
			local weld = {Part1 = target.Character.HumanoidRootPart,Part0 = Part}
			local conexttion
			local oldpos=Part.Position
			conexttion = game:GetService('RunService').Heartbeat:Connect(function()
				if NetworkCheck(Part) ~= true or weld.Part1.Velocity.Magnitude >= 100 then
					conexttion:Disconnect()
					pcall(function()
						Part.Position = oldpos
						Part.Velocity = Vector3.zero
					end)
				else
					game:GetService("Players").LocalPlayer.SimulationRadius = 1000
					Part.Velocity = Vector3.new(0,500*5,0)
					Part.CFrame = weld.Part1.CFrame
				end
			end)
		end
	end
	PartFling(getPlr(name))
end)
cmd.add({"print"},"Prints text in the console.",print)
cmd.add({"sit"},"Sit.",function()
	pc:FindFirstChildOfClass("Humanoid").Sit = true
end)
cmd.add({"reset","die"},"die die die die die die die die",function()
	pc:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead,true)
	pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
end)
cmd.add({"fling","hf","hyperf"},"Flings your target lol.",function(name)
	local Players = game.Players
	local plr = p
	local function Fling(TargetName)
		if Players:FindFirstChild(TargetName) then
			local oldpos;oldpos=plr.Character:FindFirstChild("HumanoidRootPart").CFrame
			local HRP = plr.Character:FindFirstChild("HumanoidRootPart")
			HRP.Transparency = 0.5
			HRP.BrickColor = BrickColor.new("Persimmon")
			HRP:FindFirstChildOfClass("Motor6D").Enabled = false
			local Target = Players:FindFirstChild(TargetName).Character
			workspace.CurrentCamera.CameraSubject = Target:FindFirstChild("Head")
			HRP.CFrame = Target:GetPivot()
			plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
			local otick;otick=tick()
			local MODEL = Instance.new("Model",workspace)
			Instance.new("Humanoid",MODEL).Name = "1"
			repeat
				HRP.Parent = MODEL
				HRP.Position = Target.HumanoidRootPart.Position+(Target:FindFirstChildOfClass("Humanoid").MoveDirection*11)
				for _, v in ipairs(plr.Character:GetChildren()) do
					pcall(function()
						HRP.Velocity = Vector3.new(99999,99999,99999)
						HRP.AssemblyAngularVelocity= Vector3.new(99999,99999,99999)
					end)
				end
				HRP.Velocity = Vector3.new(99999,99999,99999)
				HRP.AssemblyAngularVelocity= Vector3.new(99999,99999,99999)
				task.wait()
			until Target:FindFirstChild("HumanoidRootPart").Velocity.Magnitude >= 99 or tick()-otick >= 3
			MODEL:FindFirstChild("1"):Destroy()
			task.wait(.1)
			workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
			HRP.Parent = plr.Character
			MODEL:Destroy()
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					HRP.Velocity = Vector3.new(0,0,0)
					HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			task.wait(.1)
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			HRP:FindFirstChildOfClass("Motor6D").Enabled = true
			otick=tick()
			HRP.Velocity = Vector3.new(0,0,0)
			HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
			HRP.AssemblyLinearVelocity= Vector3.new(0,0,0)
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					HRP.Velocity = Vector3.new(0,0,0)
					HRP.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			for _, v in ipairs(plr.Character:GetChildren()) do
				pcall(function()
					v.Velocity = Vector3.new(0,0,0)
					v.AssemblyAngularVelocity= Vector3.new(0,0,0)
				end)
			end
			local ootick;ootick=tick()
			plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
			HRP.Transparency = 1
			plr.Character:FindFirstChild("Head").Anchored = false
			repeat
				workspace:BulkMoveTo({HRP},{oldpos})
				task.wait()
			until tick()-ootick >= 0.3
		end
	end
	pcall(function()
		if pc:FindFirstChild("Torso") then
			if name ~= tostring(p.Name) then
				Fling(getPlr(name).Name)
			else
			end
		else
			notify("R15 does not work on HYPERFLING.","TERMINAL")
		end
	end)
end)
cmd.add({"damagetp","dmgtp"},"Teleports away when you get damaged, true for it to avoid players.",function(dclo)

	if dclo ~= nil and rawequal(dclo:lower(),"true") then
		repeat
			task.wait()
			for _, v in ipairs(game.Players:GetPlayers()) do
				if v ~= p then
					if (pc:GetPivot().Position-v.Character:GetPivot().Position).Magnitude <= 50 and v.Team ~= p.Team or (pc:GetPivot().Position-v.Character:GetPivot().Position).Magnitude <= 50 and rawequal(v.Team,nil) then
						pc:PivotTo(pc:GetPivot()*CFrame.new(math.random(-13,23),0,math.random(-13,23)))
					end
				end
			end
		until pc:FindFirstChildOfClass("Humanoid").Health <= 0
	elseif rawequal(dclo,nil) or rawequal(dclo:lower(),"false") then
		local Older;Older=pc:FindFirstChildOfClass("Humanoid").Health
		task.spawn(function()
			repeat
				task.wait(0.13)
				Older=pc:FindFirstChildOfClass("Humanoid").Health
			until pc:FindFirstChildOfClass("Humanoid").Health <= 0
		end)
		pc:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
			local r = pc:FindFirstChildOfClass("Humanoid").Health
			if tonumber(Older)>tonumber(r) then
				pc:PivotTo(pc:GetPivot()*CFrame.new(math.random(-13,23),0,math.random(-13,23)))
			else
				Older = r
			end
		end)
	end
end)
cmd.add({"unairwalk","unairw"},"Turns off airwalk.", function()
	for i, v in pairs(workspace:GetChildren()) do
		if tostring(v) == "Airwalk" then
			v:Destroy()
		end
	end
end)
cmd.add({"airwalk","airw"},"Turns on airwalk.",function()
	task.spawn(function()
		local function AirWalk()

			local AirWPart = Instance.new("Part", workspace)
			local crtl = true
			local Mouse = game.Players.LocalPlayer:GetMouse()
			AirWPart.Size = Vector3.new(7, 2, 3)
			AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
			AirWPart.Transparency = 1
			AirWPart.Anchored = true
			AirWPart.Name = "Airwalk"
			for i = 1, math.huge do
				AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
				wait (.1)
			end
		end
		AirWalk()
	end)
end)
cmd.add({"toolfling","toolf"},"Makes one of your tools fling a player to oblivion on touch.",function()
	task.spawn(function()
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
		if not Tool then
			notify("Please equip a tool.","TERMINAL")
		end
		if not Tool then
			repeat
				task.wait()
				Tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
			until Tool
		end
		Tool.Handle.Massless = true
		task.spawn(function()
			repeat
				task.wait()
				pcall(function()
					if hiddenfling == false then
						local ovel = pc:FindFirstChild("HumanoidRootPart").Velocity
						Tool.Handle.AssemblyLinearVelocity = Vector3.new(99999,9999,999999)
						game:GetService("RunService").RenderStepped:Wait()
						pc:FindFirstChild("HumanoidRootPart").Velocity = ovel
						ovel = pc:FindFirstChild("HumanoidRootPart").Velocity
					end
				end)
			until Tool == nil
		end)
		notify("Successfully activated toolfling on "..Tool.Name.."!","TERMINAL")
	end)
end)
cmd.add({"unwalkfling","unwalkf"},"Disables walkfling.",function()
	pcall(function()
		hiddenfling = false
	end)
end)
cmd.add({"walkfling","walkf"},"Enables walkfling, credits to nameless admin's walkfling.",function()
	if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
		hiddenfling = true
	else
		hiddenfling = true
		local detection = Instance.new("Decal")
		detection.Name = "juisdfj0i32i0eidsuf0iok"
		detection.Parent = game:GetService("ReplicatedStorage")
		local function fling()
			local hrp, c, vel, movel = nil, nil, nil, 0.1
			while true do
				game:GetService("RunService").Heartbeat:Wait()
				if hiddenfling then
					local lp = game.Players.LocalPlayer
					while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
						game:GetService("RunService").Heartbeat:Wait()
						c = lp.Character
						hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
					end
					if hiddenfling then
						vel = hrp.Velocity
						hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
						game:GetService("RunService").RenderStepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel
						end
						game:GetService("RunService").Stepped:Wait()
						if c and c.Parent and hrp and hrp.Parent then
							hrp.Velocity = vel + Vector3.new(0, movel, 0)
							movel = movel * -1
						end
					end
				end
			end
		end

		fling()
	end
end)
cmd.add({"view"},"Lets you view someone.",function(name)
	local target = getPlr(name)
	if target then
		local targetc = target.Character
		workspace.CurrentCamera.CameraSubject = targetc.Humanoid
	end
end)
cmd.add({"unview"},"Changes your camera back to normal.",function()
	local target = p
	if target then
		local targetc = target.Character
		workspace.CurrentCamera.CameraSubject = targetc.Humanoid
	end
end)
cmd.add({"cffling","cframefling","cframef"},"Flings someone using CFrame.",function(name)
	local target = getPlr(name)
	if target then
		local targetc = target.Character
		local done = false
		local opos;opos = pc:GetPivot()
		pc:FindFirstChild("HumanoidRootPart").CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,-15,0)
		pc:FindFirstChildOfClass("Humanoid"):ChangeState(1)
		task.spawn(function()
			repeat
				task.wait()
				pcall(function()
					pc:FindFirstChild("HumanoidRootPart").CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,-15,0)
					pc:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(990000000000000000000,990000000000000000000,990000000000000000000)
					pc:FindFirstChild("HumanoidRootPart").CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,0,0)
				end)
			until done == true or targetc.HumanoidRootPart.Velocity.Magnitude >= 50 or targetc:FindFirstChild("Head") == nil
			task.wait()
			local otick;otick = tick()
			repeat
				pc:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,2,0)
				for _, v in ipairs(pc:GetChildren()) do
					pcall(function()
						v.Velocity = Vector3.new(0,0,0)
						v.AssemblyAngularVelocity = Vector3.new(0,0,0)
						v.AssemblyLinearVelocity = Vector3.new(0,0,0)
					end)
				end
				pc:PivotTo(opos)
				pc:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Running)
				task.wait()
			until tick()-otick >= 1
		end)
		firetouchinterest(targetc:FindFirstChild("HumanoidRootPart"),pc:FindFirstChild("HumanoidRootPart"),0)
		firetouchinterest(targetc:FindFirstChild("HumanoidRootPart"),pc:FindFirstChild("HumanoidRootPart"),1)
		delay(3,function()
			if not done then
				done = not done
			end
		end)
	end
end)
cmd.add({"invisible","invis"},"Makes your character invisible for others (YOU CAN STILL USE TOOLS).",function()
	task.spawn(function()
		local player = game.Players.LocalPlayer
		local position     = player.Character.HumanoidRootPart.Position
		wait(0.1)
		player.Character:MoveTo(position + Vector3.new(0, 1000000, 0))
		wait(0.1)
		local humanoidrootpart = player.Character.HumanoidRootPart:clone()
		wait(0.1)
		player.Character.HumanoidRootPart:Destroy()
		humanoidrootpart.Parent = player.Character
		player.Character:MoveTo(position)
	end)
end)
cmd.add({"creatorid","ownerid","oid"},"Changes your userid to the owner's userid (CLIENT).",function()
	task.spawn(function()
		if game.CreatorType == Enum.CreatorType.User then
			game.Players.LocalPlayer.UserId = game.CreatorId
		end
	end)
	task.spawn(function()
		if game.CreatorType == Enum.CreatorType.Group then
			game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
		end
	end)
	task.wait(0.2)
	notify("UserId Set to "..game.Players.LocalPlayer.UserId..".","TERMINAL")
end)
cmd.add({"walkspeed","speed","ws"},"Changes your walkspeed to the specified number, use this with noanti to maximize its potential.",function(num)
	pc:FindFirstChildOfClass("Humanoid").WalkSpeed = num
end)
cmd.add({"noanti"},"Attempts to destroy every anticheat instance, this might break the game.",function()
	local Instances = 0
	for _, v in ipairs(game:GetDescendants()) do
		if v:IsA("LuaSourceContainer") then
			if tostring(v.Name):lower():match("anti") or tostring(v.Name):lower():match("noch") or tostring(v.Name):lower():match("air") or tostring(v.Name):lower():match("cheat") or tostring(v.Name):lower():match("fly") or tostring(v.Name):lower():match("fling") or tostring(v.Name):lower():match("teleport") then
				if v ~= script then
					Instances += 1
					v:Destroy()
				end
			end
		end
	end
end)
cmd.add({"clip"}, "Stops the noclip command.", function()
	Noclip:Disconnect()
	Noclip = nil
	pc:FindFirstChildOfClass("Humanoid").Parent = game.ReplicatedStorage
	game.ReplicatedStorage:FindFirstChild("Humanoid").Parent = pc
end)
cmd.add({"noclip"},"Makes you able to phase through walls.",function()
	Noclip = game:GetService("RunService").Stepped:Connect(function()
		for i, v in pairs(pc:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end)
end)
task.wait()
local Main = Instance.new("ScreenGui",p.PlayerGui)
local Imgl = Instance.new("TextButton",Main)
Main.ResetOnSpawn = false
Imgl.ZIndex = 99999
Imgl.Text = "TERMINAL"
Imgl.BackgroundColor3=Color3.new(0,0.5,0)
Imgl.TextColor3=Color3.new(0,0,0)
Imgl.TextScaled = true
Imgl.Size = UDim2.new(0,0.01,0,0.01)
Imgl:TweenSize(UDim2.new(0.068, 0,0.12, 0),"InOut","Sine",1)
Imgl.Position = UDim2.new(0.023, 0,0.869, 0)
local TBox = nil
Imgl.MouseButton1Down:Connect(function()
	if rawequal(TBox,nil) then
		TBox = Instance.new("TextBox",Main)
		TBox.ZIndex = 100000
		TBox.PlaceholderText = "Command here"
		TBox.Text = ""
		TBox.PlaceholderColor3 = TBox.TextColor3
		TBox.TextScaled = true
		TBox.Position = UDim2.new(0.104, 0,0.882, 0)
		TBox:TweenSize(UDim2.new(0.2, 0,0.097, 0),"InOut","Sine",0.5)
		Instance.new("UICorner",TBox).CornerRadius = UDim.new(0, 8)
		local h = Instance.new("UIStroke",TBox)
		h.Thickness = 2
		h.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		h = nil
		TBox.FocusLost:Connect(function()
			pcall(function()
				local g = TBox.Text
				local cmde = nil
				for _, v in pairs(cmd["list"]) do
					if table.find(v.name,g:split(" ")[1]) then
						cmde = v
					end
				end
				if cmde then
					local sound = Instance.new("Sound",workspace)
					sound.SoundId = "rbxassetid://3450794184"
					sound.Volume = 1
					sound:Play()
					notify("Executed command!","Command Loader")
					cmde["function"](g:split(" ")[2],g:split(" ")[3],g:split(" ")[4],g:split(" ")[5])
				else
					local ge = safestring(g:split(" ")[1])
					if not ge then
						ge = "null"
					end
					if ge == "" then
					else
						notify("No command has been found with the name of '"..ge.."'.","Command Loader")
					end
				end
			end)
		end)
	else
		TBox:TweenSize(UDim2.new(0,0.001,0,0.001),"InOut","Sine",0.5)
		delay(0.5,function()
			pcall(function()
				TBox:Destroy()
				TBox = nil
			end)
		end)
	end
end)
local h = Instance.new("UIStroke",Imgl)
h.Thickness = 2
h.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
h = nil
Instance.new("UICorner",Imgl).CornerRadius = UDim.new(0, 8)
notify("TERMINAL has loaded!","TERMINAL Loader")
