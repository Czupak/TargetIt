local prefix = "|cffffa500Target|cff1784d1It|r: "
local macro = "/cleartarget\n/target %s\n/stopmacro [dead][noexists]\n/run SetRaidTarget(\"target\",8)"

SLASH_TARGETIT1 = '/tit'
function SlashCmdList.TARGETIT(msg)
	print(string.format("%sUse /tits to save your current target.\nUse /tits MobName to save custom target.\nUse /titd NAME for pre-defined targets (Currently supports [BRD] for [Shadowforge Flame Keeper])", prefix))
	if TargetItName == nil 
	then
		print(string.format("%sNo target saved.", prefix)) 
	else
		print(string.format("%sCurrent target is [%s]", prefix, TargetItName))
	end
end

SLASH_TARGETITD1 = '/titd'
function SlashCmdList.TARGETITD(msg)
	preds = {
		brd = 'Shadowforge Flame Keeper',
		skulls1 = 'Chronalis',
		skulls2 = 'Scryer',
		skulls3 = 'Somnus',
		skulls0 = 'Axtroz'
	}
	if msg == nil or msg == "" or not preds[msg]
	then
		print(string.format("%sPick defined targets:", prefix))
		for k,v in pairs(preds)
		do
			print(string.format("%s - %s", k, v))
		end
	else
		print(string.format("%s[%s] target set to [%s].", prefix, msg, preds[msg]))
		TargetItName = preds[msg]
		setMacro(TargetItName)
	end
end

SLASH_TARGETITS1 = '/tits'
function SlashCmdList.TARGETITS(msg)
	local target
	if msg == nil or msg == ""
	then
		target = UnitName("target");
	else
		target = msg
	end
	
	if target == null
	then
		print(string.format("%sNo target nor custom name. Use /tits to save your current target. Use /tits MobName to save custom target.",prefix))
	else
		TargetItName = target
		setMacro(TargetItName)
	end
end

function setMacro(target)
	local macroId = GetMacroIndexByName("TargetIt")
	if macroId == nil or macroId == 0
	then
		macroId = CreateMacro("TargetIt", "INV_MISC_QUESTIONMARK", string.format(macro, target), nil)
		print(string.format("%sTarget macro for [%s] created.", prefix, target))
	else
		EditMacro("TargetIt", "TargetIt", nil, string.format(macro, target), nil)
		print(string.format("%sTarget macro for [%s] updated.", prefix, target))
	end
end