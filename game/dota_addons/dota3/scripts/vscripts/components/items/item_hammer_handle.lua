

--[[	Author: CarryBrownstein
    Date:	01.02.2020	]]

LinkLuaModifier("modifier_item_hammer_handle", "components/items/item_hammer_handle", LUA_MODIFIER_MOTION_NONE)

item_hammer_handle = class({})
modifier_item_hammer_handle	= class({})


function item_hammer_handle:GetIntrinsicModifierName()
	return "modifier_item_hammer_handle"
end

function modifier_item_hammer_handle:IsHidden()	return true end

function modifier_item_hammer_handle:OnCreated()
	self.base_attack_range		= self:GetAbility():GetSpecialValueFor("base_attack_range")
	self.bonus_damage		= self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_armor	= self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_hammer_handle:DeclareFunctions()
	local decFuncs = {
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return decFuncs
end

function modifier_item_hammer_handle:GetModifierAttackRangeBonus()
	if not self:GetParent():IsRangedAttacker() then
		return self.base_attack_range
  end
end

function modifier_item_hammer_handle:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_hammer_handle:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end