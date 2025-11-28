;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Scenes:SF_NewGameManager_FaceGen Extends Scene Hidden Const

;BEGIN FRAGMENT Fragment_Phase_02_Begin
Function Fragment_Phase_02_Begin()
;BEGIN CODE
MQ101.SetStage(45)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Phase_04_End
Function Fragment_Phase_04_End()
;BEGIN AUTOCAST TYPE RAS:NewGameManagerQuest:NewGameManagerQuestScript
RAS:NewGameManagerQuest:NewGameManagerQuestScript kmyQuest = GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript
;END AUTOCAST
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()
ObjectReference MedBenchREF = MedBench.GetRef()
PlayerREF.Waitfor3dLoad()
MedBenchREF.Waitfor3dLoad()
PlayerREF.SnapIntoInteraction(MedBenchREF)
kmyQuest.SetupVanillaCharGen()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Phase_05_End
Function Fragment_Phase_05_End()
;BEGIN CODE
;save before chargen scene
Game.SetInCharGen(False, false, false)
Game.RequestSave()
Game.SetInCharGen(True, True, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Phase_07_Begin
Function Fragment_Phase_07_Begin()
;BEGIN CODE
MQ101.SetStage(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Phase_07_End
Function Fragment_Phase_07_End()
;BEGIN CODE
MQ101.SetStage(62)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property MedBench Auto Const

Quest Property MQ101 Auto Const
