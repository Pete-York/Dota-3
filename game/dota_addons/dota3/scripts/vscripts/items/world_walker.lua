-- Same name as in npc_items_custom.txt :)
if item_world_walker == nil then
	item_world_walker = class({})
end

print("World Walker script loaded!!")

function item_world_walker:CastFilterResultTarget( hTarget ) 
    -- return UF_SUCCESS
    -- if IsServer() then
	-- 	if not target:GetUnitName() == "npc_space_gong" then
	-- 		return UF_FAIL_CUSTOM
	-- 	end
	-- 	return UF_SUCCESS
	-- end
    return UF_SUCCESS
end

function item_world_walker:GetCustomCastErrorTarget(target) 
	if IsServer() then
		print("Wrong target message..")
		return "#dota_hud_error_cast_only_spacegong"
	end
end

function item_world_walker:OnSpellStart()
	DebugPrint("I have did a thing!")
	local hCaster = self:GetCaster() --We will always have Caster.
	local hTarget = false --We might not have target so we make fail-safe so we do not get an error when calling - self:GetCursorTarget()
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	local vPoint = self:GetCursorPosition() --We will always have Vector for the point.
	local vOrigin = hCaster:GetAbsOrigin() --Our caster's location
	local nMaxBlink = 1200 --How far can we actually blink?
    local nClamp = 960 --If we try to over reach we use this value instead. (this is mechanic from blink dagger.)
    
    hCaster:EmitSound("DOTA_Item.BlinkDagger.Activate") --Emit sound for the blink
    if hTarget == nil then
        return
    end

    local spaceGong = Entities:FindByName(nil, "SPACE_GONG")
    if hTarget == spaceGong then 
        DebugPrint(" ----------------- SpaceGong targeted!!! ------------")
    end
end


function try_win(keys)
    local caster = keys.caster
    local Player_ID = caster:GetPlayerOwnerID()

end

