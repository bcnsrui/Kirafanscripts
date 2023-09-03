--키라판은 갓겜이다
Kirafan3={}

--서포트 크리에메이트 유틸
--서포트 크리에메이트 콜
function Kirafan3.CallSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Kirafan3.CallSptarget)
	e1:SetOperation(Kirafan3.CallSpoperation)
	c:RegisterEffect(e1)
end
function Kirafan3.CallSptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function Kirafan3.CallSpoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end

function Kirafan3.BattleCallSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan3.BattleCallSpcondition)
	e1:SetTarget(Kirafan3.BattleCallSptarget)
	e1:SetOperation(Kirafan3.BattleCallSpoperation)
	c:RegisterEffect(e1)
end
function Kirafan3.BattleCallSpcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and Duel.GetTurnPlayer()==1-tp and Duel.IsBattlePhase()
end
function Kirafan3.BattleCallSptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function Kirafan3.BattleCallSpoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end

--정면의 크리에메이트 공격력 수비력 증가
function Kirafan3.AtkDefSpCreamate(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_SZONE)
    e1:SetTargetRange(LOCATION_MZONE,0)
    e1:SetTarget(Kirafan3.target)
    e1:SetValue(c:GetAttack())
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    e2:SetValue(c:GetDefense())
    c:RegisterEffect(e2)
end
function Kirafan3.target(e,c)
    return e:GetHandler():GetColumnGroup():IsContains(c)
end

--정면의 크리에메이트 공격력 수비력 감소
function Kirafan3.AtkDefDownSpCreamate(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_SZONE)
    e1:SetTargetRange(0,LOCATION_MZONE)
    e1:SetTarget(Kirafan3.target2)
    e1:SetValue(-c:GetAttack())
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    e2:SetValue(-c:GetDefense())
    c:RegisterEffect(e2)
end
function Kirafan3.target2(e,c)
    return e:GetHandler():GetColumnGroup():IsContains(c)
end

--턴 종료시에 돗테오키 존으로
function Kirafan3.TurnSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan3.TurnSpcon)
	e1:SetTarget(Kirafan3.TurnSptg)
	e1:SetOperation(Kirafan3.TurnSpop)
	c:RegisterEffect(e1)
end
function Kirafan3.TurnSpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function Kirafan3.TurnSptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
end
function Kirafan3.TurnSpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end

--상대 턴 종료시에 돗테오키 존으로
function Kirafan3.EnemyTurnSpCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan3.TurnSpcon2)
	e1:SetTarget(Kirafan3.TurnSptg2)
	e1:SetOperation(Kirafan3.TurnSpop2)
	c:RegisterEffect(e1)
end
function Kirafan3.TurnSpcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function Kirafan3.TurnSptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
end
function Kirafan3.TurnSpop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end