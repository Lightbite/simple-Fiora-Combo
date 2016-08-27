local myHero = GetMyHero()
local target, LS
local HP = GetCurrentHP(myHero)
local timerold,timernew, AAReady ,AAdone, cAS = 0,0,0,0,0



if GetObjectName(myHero) ~= "Fiora" then return end

OnTick(function(myHero)
if IOW:Mode() == "Combo"  then
	combo()
end

	if HP < 200 then
	PrintChat("Low HP")
	end

MISC()
end)

function MISC()

	cAS = GetAttackSpeed( GetMyHero() ) * 0.69
	timernew = GetTickCount()
	lastAA = timerold - timernew
	
	if -lastAA > (1/ cAS ) * 1000 then
		AAREADY = 1
	end
end

function combo()
target = GetCurrentTarget()

			castQ()
			
			if (AAREADY == 1 ) and CanUseSpell(myHero,_Q) ~= READY then
				AttackUnit(target)
			end
			
			if AAREADY == 0 then
				castE()
			end
			
			if CanUseSpell(myHero,_E) ~= READY then
			CastOffensiveItems(target)
			end
			
			if (AAREADY == 1 ) and CanUseSpell(myHero,_E) ~= READY then
				AttackUnit(target)
			end

		end

function castQ()
if Ready(_Q) then
			CastSkillShot(_Q, GetMousePos())
			end
end

function castE()
if Ready(_E) then
			CastSpell(_E)
			end
end

OnProcessSpellComplete(function(Object,Spell)
	if Object == GetMyHero() then
	    	timerold = GetTickCount()
			AAREADY = 0			
	end
end)

PrintChat("Fiora Burst loaded.")
