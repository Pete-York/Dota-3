

--[[	Author: CarryBrownstein
    Date:	01.02.2020	]]

    --cheese

item_smoke_of_plane = item_smoke_of_plane or class({})
function item_smoke_of_plane:GetBehavior() return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET end

function item_smoke_of_plane:OnSpellStart()
  DebugPrint("[BAREBONES] hello ")
	local caster = 		self:GetCaster()
	local aoe = 		self:GetSpecialValueFor("radius")
	local duration =	self:GetSpecialValueFor("duration")

	caster:EmitSound("DOTA_Item.SmokeOfDeceit.Activate")
	local particle = ParticleManager:CreateParticle("particles/items_fx/dust_of_appearance.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 1, Vector(aoe, aoe, aoe))


	local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY , DOTA_UNIT_TARGET_HERO , DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER , false)
	for _,unit in pairs(targets) do
		smoke_buff = unit:AddNewModifier(caster, self, "modifier_smoke_of_plane", {duration = duration})
	end
  local new_charge_count = self:GetCurrentCharges() - 1
  if new_charge_count == 0 then
    self:Destroy()
  else
    self:SetCurrentCharges(new_charge_count)
  end
  DebugPrint("[BAREBONES] hello " .. new_charge_count)
end 


if modifier_smoke_of_plane == nil then modifier_smoke_of_plane = class({}) end
function modifier_smoke_of_plane:IsDebuff() return false end
function modifier_smoke_of_plane:IsHidden() return false end
function modifier_smoke_of_plane:IsPurgable() return false end

function modifier_smoke_of_plane:GetTexture()
	return "item_dust"
end

function modifier_smoke_of_plane:OnCreated()
	self.speed_bonus	= self:GetAbility():GetSpecialValueFor("speed_bonus")
end

function modifier_imba_dust_of_appearance:GetEffectAttachType()
  return PATTACH_OVERHEAD_FOLLOW end
  
function modifier_smoke_of_plane:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_imba_dust_of_appearance:CheckState()
	return {[MODIFIER_STATE_INVISIBLE] = false}
end


function modifier_smoke_of_plane:GetEffectName()
	return "particles/items2_fx/true_sight_debuff.vpcf" end

function modifier_smoke_of_plane:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW end

function modifier_smoke_of_plane:GetPriority()
	return MODIFIER_PRIORITY_ULTRA end

function modifier_smoke_of_plane:GetModifierMoveSpeedBonus_Percentage()
  if self:GetParent():HasModifier(v) then return self.speed_bonus end
end
