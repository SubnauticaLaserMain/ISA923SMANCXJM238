local MODULES = {}
local OLD_REQUIRE = require

local function require(ModuleScript: ModuleScript)
    local ModuleState = MODULES[ModuleScript]

    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true
            ModuleState.Value = ModuleState.Closure()
        end

        return ModuleState.Value
    end

    return OLD_REQUIRE(ModuleScript)
end


Create = function(class, properties, radius)
	local instance = Instance.new(class)
	for i, v in next, properties do
		if i ~= "Parent" then
			if typeof(v) == "Instance" then
				v.Parent = instance
			else
				instance[i] = v
			end
		end
	end
	if radius then
		local uicorner = Instance.new("UICorner", instance)
		uicorner.CornerRadius = radius
	end
	return instance
end

local MainFolder = Create('Folder', {
    Name = 'ServerScriptAPI'
})
MainFolder.Parent = game:GetService('CoreGui')


local ScriptsFolder = Create('Folder', {
    Name = 'Scripts-Folder'
})
ScriptsFolder.Parent = MainFolder



local ModulesFolder = Create('Folder', {
	Name = 'Modules'
})
ModulesFolder.Parent = MainFolder



local BreakInStory_Folder = Create('Folder', {
	Name = 'Break In (Story)'
})
BreakInStory_Folder.Parent = ModulesFolder


local BreakInLobby = Create('ModuleScript', {
	Name = 'Lobby'
})
BreakInLobby.Parent = BreakInStory_Folder


local Equip_Module = Create('ModuleScript', {
	Name = 'Equip Module'
})
Equip_Module.Parent = BreakInLobby


MODULES[Equip_Module] = {
	['Closure'] = function()
		local script = Equip_Module
		local Events = game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents')
		local MakeRole = Events:WaitForChild('MakeRole')
		local OutsideRole = Events:WaitForChild('OutsideRole')



		return function(Role, SkinOn)
			if Role and typeof(SkinOn) == 'boolean' or Role and not SkinOn then
				local list = {
					['The Protector'] = function()
						local args = {
							[1] = 'Bat',
							[2] = false,
							[3] = SkinOn
						}

						MakeRole:FireServer(unpack(args))
					end,

					['The Medic'] = function()
						local args = {
							[1] = 'MedKit',
							[2] = false,
							[3] = SkinOn
						}

						MakeRole:FireServer(unpack(args))
					end,

					['The Officer'] = function()
						local args = {
							[1] = 'Gun',
							[2] = false,
							[3] = SkinOn
						}

						local outsideData = {
							[1] = args[1],
							[2] = args[3]
						}


						OutsideRole:FireServer(unpack(outsideData))
						MakeRole:FireServer(unpack(args))
					end,

					['The Swat'] = function()
						local args = {
							[1] = 'SwatGun',
							[2] = false,
							[3] = SkinOn
						}

						local outsideData = {
							[1] = args[1],
							[2] = args[3]
						}


						OutsideRole:FireServer(unpack(outsideData))
						MakeRole:FireServer(unpack(args))
					end,


					['The Stealthy'] = function()
						local args = {
							[1] = 'TeddyBloxpin',
							[2] = true,
							[3] = SkinOn
						}

						MakeRole:FireServer(unpack(args))
					end,

					['The Hungry'] = function()
						local args = {
							[1] = 'Chips',
							[2] = true,
							[3] = SkinOn
						}

						MakeRole:FireServer(unpack(args))
					end,

					['The Fighter'] = function()
						local args = {
							[1] = 'Sword',
							[2] = true,
							[3] = SkinOn
						}

						local outsideData = {
							[1] = args[1],
							[2] = args[3]
						}


						OutsideRole:FireServer(unpack(args))
						MakeRole:FireServer(unpack(args))
					end
				}
			end
		end
	end
}
