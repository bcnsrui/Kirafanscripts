--키라판은 갓겜이다
Kirafan4={}

--나이트 크리에메이트 유틸
--나이트 크리에메이트 콜
function Kirafan4.BattleCallKnCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan4.BattleCallKncondition)
	e1:SetTarget(Kirafan4.BattleCallKntarget)
	e1:SetOperation(Kirafan4.BattleCallKnoperation)
	c:RegisterEffect(e1)
end
function Kirafan4.BattleCallKncondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and Duel.GetTurnPlayer()==1-tp and Duel.IsBattlePhase()
end
function Kirafan4.BattleCallKntarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function Kirafan4.BattleCallKnoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
end

--턴 종료시에 돗테오키 존으로
function Kirafan4.TurnKnCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan4.TurnKncon)
	e1:SetTarget(Kirafan4.TurnKntg)
	e1:SetOperation(Kirafan4.TurnKnop)
	c:RegisterEffect(e1)
end
function Kirafan4.TurnKncon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function Kirafan4.TurnKntg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
end
function Kirafan4.TurnKnop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end

--전투로 파괴되지 않는다
function Kirafan4.CannotBattleDestroyKnCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end