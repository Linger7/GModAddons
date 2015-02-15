local function createRestartTimer(time, reason)
	if time == 0 or time == nil then time = 5 end
	if reason == nil then reason = "No Reason given" end
	
	local max = time;
	
	if timer.Exists("restartTimer") then
		timer.Destroy("restartTimer")
	end
	
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint("The server will restart in " .. max .. " minutes. For Reason:\n" .. reason)
	end
	max = max = 1;
	
	timer.Create("restartTimer", 60, time, function()
		for k,v in pairs(player.GetAll()) do
			v:ChatPrint("The server will restart in " .. max .. " minutes. For Reason:\n" .. reason)
		end
		max = max - 1;
	end)
	
	timer.Simple(60*time-10, function()
		for k,v in pairs(player.GetAll()) do
			v:ChatPrint("The server will restart in 10 seconds. For Reason:\n" .. reason)
		end
	end)
	
	timer.Simple(60*time, function()
		RunConsoleCommand("restart")
	end)
end

concommand.Add("sv_stoprestart", function(Player)
	if IsValid(Player) then
		if Player:IsSuperAdmin() then
			if timer.Exists("restartTimer") then
				timer.Destroy("restartTimer")
			end
		end
	else
		if timer.Exists("restartTimer") then
			timer.Destroy("restartTimer")
		end	
	end
end)

concommand.Add("sv_restart", function(Player, cmd, args, fullstring)
	if IsValid(Player) then
		if Player:IsSuperAdmin() then
			if(args[1] || args[2]) == nil then
				Player:ChatPrint("You need to specify a time in minutes and reason, command time reason !")
				return
			end
			PrintTable(args)
		
			local num = tonumber(args[1])
			local reason = tostring(args[2])
			
			createRestartTimer(num, reason)
		end
	else
		if(args[1] || args[2]) == nil then
				print("You need to specify a time and reason, command time reason !")
				return
		end

		local num = tonumber(args[1])
		local reason = tostring(args[2])
		
		createRestartTimer(num, reason)
	end
end)