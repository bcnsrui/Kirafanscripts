--키라판은 갓겜이다
Kirafan={}

--메인 캐릭터 유틸
--듀얼 개시시의 효과
function Kirafan.DuelStartMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1)
	e1:SetOperation(Kirafan.DuelStarttg)
	e1:SetOperation(Kirafan.DuelStartop)
	c:RegisterEffect(e1)
end
function Kirafan.DuelStarttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function Kirafan.DuelStartfilter(c)
	return c:IsType(TYPE_XYZ)
end
function Kirafan.DuelStartop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local g=Duel.SelectMatchingCard(tp,Kirafan.DuelStartfilter,tp,LOCATION_EXTRA,0,4,4,c)
	if Duel.IsTurnPlayer(tp) then
	Duel.MoveToField(c,tp,tp,LOCATION_EMZONE,POS_FACEUP_ATTACK,true)
	Duel.Overlay(c,g,true)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,5,REASON_RULE)
	else Duel.MoveToField(c,tp,tp,LOCATION_EMZONE,POS_FACEUP_DEFENSE,true)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,2,REASON_RULE)
	Duel.Overlay(c,g,true)	end
end

--일반 소환 / 세트 불가
function Kirafan.NoSummonMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e3)
end

--통상 드로우는 서로 3장
function Kirafan.ThreeDrawMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(3)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(Kirafan.drawop)
	c:RegisterEffect(e2)
end
function Kirafan.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1-tp,3,REASON_RULE)
end

--전투로 파괴되지 않는다
function Kirafan.CannotBattleDestroyMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end

--표시형식 변경 불가
function Kirafan.CannotTurnPositionMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e1)
end

--턴 종료시에 표시 형식 변경
function Kirafan.TurnPositionMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(Kirafan.TurnPositiontg)
	e1:SetOperation(Kirafan.TurnPositionop)
	c:RegisterEffect(e1)
end
function Kirafan.TurnPositiontg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function Kirafan.TurnPositionop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsTurnPlayer(tp) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		else Duel.ChangePosition(c,POS_FACEUP_ATTACK)
	end
end

--관통 데미지를 준다
function Kirafan.PierceDamageMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end

--메인 페이즈 2를 스킵한다
function Kirafan.Main2SkipMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_SKIP_M2)
	c:RegisterEffect(e1)
end

--필드 봉인
function Kirafan.FieldTheRockMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(Kirafan.FieldTheRockop)
	c:RegisterEffect(e1)
end
function Kirafan.FieldTheRockop(e,tp)
	return 0x0a0a0a0a
end

--공격 선언시 1크리에
function Kirafan.AttackCreaMainCharacter(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetCountLimit(1)
    e1:SetTarget(Kirafan.AttackCreatg)
    e1:SetOperation(Kirafan.AttackCreaop)
    c:RegisterEffect(e1)
end
function Kirafan.AttackCreatg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function Kirafan.AttackCreaop(e,tp,eg,ep,ev,re,r,rp)
    Duel.DiscardDeck(tp,1,REASON_EFFECT)
end

--공격 선언시에는 전투 데미지 0
function Kirafan.ZeroBattleDamageMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(Kirafan.ZeroBattleDamagecon)
	e1:SetTarget(Kirafan.ZeroBattleDamagetg)
	e1:SetOperation(Kirafan.ZeroBattleDamageop)
	c:RegisterEffect(e1)
end
function Kirafan.ZeroBattleDamagecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function Kirafan.ZeroBattleDamagetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function Kirafan.ZeroBattleDamageop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end

--공격 대상 불가
function Kirafan.NoBattleTargetMainCharacter(c)	
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end

--공격 선언시에는 효과 발동 불가
function Kirafan.LimitBattleEffectMainCharacter(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetTarget(Kirafan.BattleEffecttg)
    c:RegisterEffect(e1)
end
function Kirafan.BattleEffecttg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetChainLimit(aux.FALSE)
end

--패 매수 제한은 10장
function Kirafan.Limit10HandMainCharacter(c)
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(10)
	c:RegisterEffect(e1)
end