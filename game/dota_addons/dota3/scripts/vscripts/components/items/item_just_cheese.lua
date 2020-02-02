

--[[	Author: CarryBrownstein
    Date:	01.02.2020	]]

    --cheese

local function ConsumeCheese(parent, item)
	-- Play sound
	parent:EmitSound("DOTA_Item.Cheese.Activate")

	-- Fully heal yourself
	parent:Heal(parent:GetMaxHealth(), parent)
	parent:GiveMana(parent:GetMaxMana())

	-- Spend a charge
	item:SetCurrentCharges(item:GetCurrentCharges() - 1)

	-- If this was the last charge, remove the item
	if item:GetCurrentCharges() == 0 then
		if not parent:IsClone() then
			parent:RemoveItem(item)
		else
			if parent.GetCloneSource and parent:GetCloneSource() and parent:GetCloneSource():HasItemInInventory(item:GetName()) then
				parent:GetCloneSource():RemoveItem(item)
			end
		end
	else -- starting the cooldown manually is required for the auto-use
		item:UseResources(false, false, true)
	end
end


item_just_cheese = item_just_cheese or class({})

function item_just_cheese:OnSpellStart()
	if IsServer() then
		ConsumeCheese(self:GetParent(), self)
	end
end