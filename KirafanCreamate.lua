--키라판은 갓겜이다
Kirafan2={}

--크리에메이트 유틸
--콜에 코스트가 없는 크리에메이트
function Kirafan2.ZeroCreaCallCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	c:RegisterEffect(e1)
end

--콜에 코스트가 1개 필요한 크리에메이트
function Kirafan2.OneCreaCallCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(Kirafan2.callcon)
	e1:SetOperation(Kirafan2.callop)
	c:RegisterEffect(e1)
end
function Kirafan2.callfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function Kirafan2.callcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function Kirafan2.callop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,nil)
	if #g==0 then return end
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
end

--콜에 코스트가 2개 필요한 크리에메이트
function Kirafan2.TwoCreaCallCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(Kirafan2.callcon)
	e1:SetOperation(Kirafan2.callop)
	c:RegisterEffect(e1)
end
function Kirafan2.callfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function Kirafan2.callcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function Kirafan2.callop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,nil)
	if #g==0 then return end
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	local last2=g:GetFirst()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last2:GetSequence() then last2=tc end
	end
	Duel.Remove(last2,POS_FACEUP,REASON_EFFECT)
end

--콜에 코스트가 3개 필요한 크리에메이트
function Kirafan2.ThreeCreaCallCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(Kirafan2.callcon)
	e1:SetOperation(Kirafan2.callop)
	c:RegisterEffect(e1)
end
function Kirafan2.callfilter(c)
	return c:IsAbleToRemoveAsCost()
end
function Kirafan2.callcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and Duel.IsExistingMatchingCard(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function Kirafan2.callop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Kirafan2.callfilter,tp,LOCATION_GRAVE,0,nil)
	if #g==0 then return end
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	local last2=g:GetFirst()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last2:GetSequence() then last2=tc end
	end
	Duel.Remove(last2,POS_FACEUP,REASON_EFFECT)
	local last3=g:GetFirst()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last3:GetSequence() then last3=tc end
	end
	Duel.Remove(last3,POS_FACEUP,REASON_EFFECT)
end

--전투로 파괴되지 않는다
function Kirafan2.CannotBattleDestroyCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end

--표시형식 변경 불가
function Kirafan2.CannotTurnPositionCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e1)
end

--턴 종료시에 표시 형식 변경
function Kirafan2.TurnPositionCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(Kirafan2.TurnPositiontg)
	e1:SetOperation(Kirafan2.TurnPositionop)
	c:RegisterEffect(e1)
end
function Kirafan2.TurnPositiontg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function Kirafan2.TurnPositionop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	else Duel.Remove(c,POS_FACEUP,REASON_EFFECT) end
end

--관통 데미지를 준다
function Kirafan2.PierceDamageCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end

--공격 선언시 1크리에
function Kirafan2.AttackCreaCreamate(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetTarget(Kirafan2.AttackCreatg)
    e1:SetOperation(Kirafan2.AttackCreaop)
    c:RegisterEffect(e1)
end
function Kirafan2.AttackCreatg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function Kirafan2.AttackCreaop(e,tp,eg,ep,ev,re,r,rp)
    Duel.DiscardDeck(tp,1,REASON_EFFECT)
end

--공격 선언시에는 전투 데미지 0
function Kirafan2.ZeroBattleDamageCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(Kirafan2.ZeroBattleDamagecon)
	e1:SetTarget(Kirafan2.ZeroBattleDamagetg)
	e1:SetOperation(Kirafan2.ZeroBattleDamageop)
	c:RegisterEffect(e1)
end
function Kirafan2.ZeroBattleDamagecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function Kirafan2.ZeroBattleDamagetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function Kirafan2.ZeroBattleDamageop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end

--정면의 크리에메이트만 공격 가능 정면에 없으면 직접 공격
function Kirafan2.LimitBattleTargetCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(Kirafan2.dircon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetCondition(Kirafan2.atcon)
	e2:SetValue(Kirafan2.atlimit)
	c:RegisterEffect(e2)
end
function Kirafan2.dircon(e)
	return e:GetHandler():GetColumnGroupCount()==0
end
function Kirafan2.atkfilter(c)
	return c:GetColumnGroupCount()>0
end
function Kirafan2.atcon(e)
	return Duel.IsExistingMatchingCard(Kirafan2.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function Kirafan2.atlimit(e,c)
	return not e:GetHandler():GetColumnGroup():IsContains(c)
end

--공격 선언시에는 효과 발동 불가
function Kirafan2.LimitBattleEffectCreamate(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetTarget(Kirafan2.BattleEffecttg)
    c:RegisterEffect(e1)
end
function Kirafan2.BattleEffecttg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetChainLimit(aux.FALSE)
end