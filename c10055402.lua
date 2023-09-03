local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.CallSpCreamate(c)
	Kirafan3.BattleCallSpCreamate(c)
	Kirafan3.TurnSpCreamate(c)
	Kirafan3.AtkDefSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(s.target)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTarget(s.target)
	e2:SetValue(500)
	c:RegisterEffect(e2)
end
function s.target(e,c)
	return e:GetHandler():GetColumnGroup():IsContains(c) and c:IsAttribute(e:GetHandler():GetAttribute())
end