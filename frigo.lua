local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)

-- For the second set of particles as seen in the video, I chose to do it as multiple combats
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

-- Define a custom area shape as a table
local customArea = {
    {0, 1, 0, 1, 0},
    {0, 0, 0, 0, 0},
    {1, 1, 3, 1, 1},
    {0, 0, 0, 0, 0},
    {0, 1, 0, 1, 0}
}
local customArea2 = {
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 3, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0}
}

-- Use the custom area shape with createCombatArea
combat:setArea(createCombatArea(customArea))
combat2:setArea(createCombatArea(customArea2))

function onGetFormulaValues1(player, level, magicLevel)
    local min = (level / 5) + (magicLevel * 0.8) + 5
    local max = (level / 5) + (magicLevel * 2) + 12
    return -min, -max
end

-- The second part of the spell will do less damage (random values)
function onGetFormulaValues2(player, level, magicLevel)
    local min = (level / 7) + (magicLevel * 0.8) + 5
    local max = (level / 7) + (magicLevel * 2) + 12
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

function onCastSpell(creature, variant)
    local result1 = combat:execute(creature, variant)
    local result2 = combat2:execute(creature, variant)
    return result1 and result2
end