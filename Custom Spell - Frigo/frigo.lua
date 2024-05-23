-- Define combat 1
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

-- Define combat 2
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

-- Define how many times to cast each spell
local spellLoop = 10

-- Define custom area shapes as tables
local customArea = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 0, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 2, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 0, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

local customArea2 = {
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 0, 1, 1, 0, 0},
    {0, 0, 0, 0, 2, 0, 0, 0, 0},
    {0, 0, 1, 1, 0, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0}
}

-- Use the custom area shapes with createCombatArea
combat:setArea(createCombatArea(customArea))
combat2:setArea(createCombatArea(customArea2))

--Calculate the values to be used for damage for combat 1
function onGetFormulaValues1(player, level, magicLevel)
    local min = (level / 5) + (magicLevel * 0.8) + 5
    local max = (level / 5) + (magicLevel * 2) + 12
    return -min, -max
end

--Calculate the values to be used for damage for combat 2
function onGetFormulaValues2(player, level, magicLevel)
    local min = (level / 7) + (magicLevel * 0.8) + 5
    local max = (level / 7) + (magicLevel * 2) + 12
    return -min, -max
end

--Calculates the damage value for combat 1
combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
--Calculates the damage value for combat 2
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

--Casts both spells defined number of times
function onCastSpell(creature, variant)
    for i = 1, spellLoop do
        combat:execute(creature, variant)
        combat2:execute(creature, variant)
    end
    return true
end
