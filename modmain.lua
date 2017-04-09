-- modified version of original retarget function
-- conditional statement was modified to ignore Chester
local function NewSpringBeeRetarget(inst)
    if GLOBAL.GetSeasonManager() and GLOBAL.GetSeasonManager():IsSpring() then
        local range = 4
        return GLOBAL.FindEntity(inst, range, function(guy)
            return (guy:HasTag("character") or guy:HasTag("animal") or guy:HasTag("monster") )
                and not guy:HasTag("insect")
				and not guy:HasTag("chester") -- this was added to original function
                and inst.components.combat:CanTarget(guy)
        end)
    else
        return false
    end
end

-- replaces retarget function for bee prefab
-- affects only worker bees
local function ReplaceRetargetFunction(prefab)

 	if prefab:HasTag("worker") and prefab.components.combat.targetfn and prefab.components.combat.SetRetargetFunction then
	    prefab.components.combat:SetRetargetFunction(2, NewSpringBeeRetarget)
	end
		
end

AddPrefabPostInit("bee", ReplaceRetargetFunction)

