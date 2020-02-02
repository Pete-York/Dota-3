

--[[	Author: CarryBrownstein
    Date:	01.02.2020	]]

    item_mad_moon_shard = item_mad_moon_shard or class({})

    LinkLuaModifier("modifier_item_mad_moon_shard", "components/items/item_mad_moon_shard", LUA_MODIFIER_MOTION_NONE)
    LinkLuaModifier("modifier_item_mad_moon_shard_active", "components/items/item_mad_moon_shard", LUA_MODIFIER_MOTION_NONE)
    
    function item_mad_moon_shard:GetIntrinsicModifierName() return "modifier_item_mad_moon_shard" end
    
    function item_mad_moon_shard:OnSpellStart()
      local caster = self:GetCaster()
      if caster:IsTempestDouble() then return end
      local pos = caster:GetAbsOrigin()
      local target = self:GetCursorTarget()
      local current_stacks = self:GetCurrentCharges()
      if target then
        if target:IsTempestDouble() then
          target = nil
        end
        if target == caster then
          local moon_buff = caster:FindModifierByName("modifier_item_mad_moon_shard_active")
          if moon_buff then
            target = nil
          else
            moon_buff = caster:AddNewModifier(caster, self, "modifier_item_mad_moon_shard_active", {})
            EmitSoundOnClient("Item.MoonShard.Consume", caster:GetPlayerOwner())
          end
          caster:RemoveItem(self)
        else
          EmitSoundOnClient("Item.MoonShard.Consume", caster:GetPlayerOwner())
          EmitSoundOnClient("Item.MoonShard.Consume", target:GetPlayerOwner())
          local moon_buff = target:FindModifierByName("modifier_item_mad_moon_shard_active")
          if moon_buff then
          else
            moon_buff = target:AddNewModifier(caster, self, "modifier_item_mad_moon_shard_active", {})
          end
          caster:RemoveItem(self)
        end
      else
        EmitSoundOn("Item.DropWorld", caster)
        local moon = CreateItem("item_mad_moon_shard", caster, caster)
        CreateItemOnPositionSync(pos, moon)
        moon:SetPurchaser(caster)
        moon:SetPurchaseTime(self:GetPurchaseTime())
        caster:RemoveItem(self)
      end
    end
    
    
    ---------------------------------------
    --     STATS MODIFIER   --
    ---------------------------------------
    modifier_item_mad_moon_shard = modifier_item_mad_moon_shard or class({})
    
    function modifier_item_mad_moon_shard:IsHidden() return false end
    function modifier_item_mad_moon_shard:IsDebuff() return false end
    function modifier_item_mad_moon_shard:IsPurgable() return false end
    function modifier_item_mad_moon_shard:RemoveOnDeath() return false end
    
    function modifier_item_mad_moon_shard:OnCreated()
      if not IsServer() then return end
      self:StartIntervalThink(0.2)
    end
    
    function modifier_item_mad_moon_shard:DeclareFunctions()
      return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION
      }
    end
    
    function modifier_item_mad_moon_shard:GetModifierAttackSpeedBonus_Constant()
      return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    end
    
    function modifier_item_mad_moon_shard:GetBonusNightVision()
      return self:GetAbility():GetSpecialValueFor("bonus_night_vision")
    end
    
    
    ---------------------------------------
    --     ACTIVE MODIFIER               --
    ---------------------------------------
    
    modifier_item_mad_moon_shard_active = modifier_item_mad_moon_shard_active or class({})
    
    function modifier_item_mad_moon_shard_active:IsHidden() return false end
    function modifier_item_mad_moon_shard_active:IsDebuff() return false end
    function modifier_item_mad_moon_shard_active:IsPurgable() return false end
    function modifier_item_mad_moon_shard_active:RemoveOnDeath() return false end
    function modifier_item_mad_moon_shard_active:GetTexture() return "item_moon_shard" end
    
    function modifier_item_mad_moon_shard_active:OnCreated()
      if self:GetAbility() then
        self.consume_as_1		= self:GetAbility():GetSpecialValueFor("consume_as_1")
        self.consume_vision_1	= self:GetAbility():GetSpecialValueFor("consume_vision_1")
      else
        self.consume_as_1		= 60
        self.consume_vision_1	= 200
      end
    end
    
    function modifier_item_mad_moon_shard_active:DeclareFunctions()
      return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION
      }
    end
    
    function modifier_item_mad_moon_shard_active:GetModifierAttackSpeedBonus_Constant()
      return self.consume_as_1
    end

    function modifier_item_mad_moon_shard_active:GetBonusNightVision()
      return self.consume_vision_1
    end
    