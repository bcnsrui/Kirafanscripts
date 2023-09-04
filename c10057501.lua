local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.CallSpCreamate(c)
	Kirafan3.BattleCallSpCreamate(c)
	Kirafan3.TurnSpCreamate(c)
	Kirafan3.AtkDefDownSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(s.target2)
	e1:SetValue(-500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTarget(s.target2)
	e2:SetValue(-500)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.condition)
	e3:SetCost(s.cost)
	e3:SetTarget(s.target)
	e3:SetOperation(s.operation)
	c:RegisterEffect(e3)
end
function s.target2(e,c)
	return e:GetHandler():GetColumnGroup():IsContains(c) and c:IsRace(RACE_WARRIOR)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetCurrentChain()<3
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_COST)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(s.chlimit)
end
function s.chlimit(e,rp,tp)
	return tp==rp
end
function s.filter(c)
	return c:IsFaceup() and not c:IsLocation(LOCATION_EMZONE)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.SelectMatchingCard(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
	if not tc then return end
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		if Duel.GetCurrentChain()==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
		if Duel.GetCurrentChain()==2 then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e3:SetValue(-1500)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e4)
	end
		if Duel.GetCurrentChain()==3 then
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_UPDATE_ATTACK)
		e5:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e5:SetValue(-2000)
		e5:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e5)
		local e6=e5:Clone()
		e6:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e6)
	end
	end
end