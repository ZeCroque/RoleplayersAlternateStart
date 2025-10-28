Scriptname RAS:UpdateQuest:PlayerAliasScript extends ReferenceAlias

Event OnPlayerLoadGame()
    (GetOwningQuest() as RAS:UpdateQuest:UpdateQuestScript).Update()
EndEvent