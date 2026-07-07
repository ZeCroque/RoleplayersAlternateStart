;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_MQReplacerIntroQuest Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0001_Item_00
Function Fragment_Stage_0001_Item_00()
;BEGIN CODE
Alias_TheGuide.TryToEnable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0002_Item_00
Function Fragment_Stage_0002_Item_00()
;BEGIN CODE
Alias_TheGuide.GetActorRef().MoveToFurniture(Alias_HunterPreMQ106Sit.GetReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0005_Item_00
Function Fragment_Stage_0005_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(0)
RAS_TheGuideStartWarning.ShowAsHelpMessage("", 10, 0, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0006_Item_00
Function Fragment_Stage_0006_Item_00()
;BEGIN CODE
Alias_TheGuide.TryToDisable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
SetObjectiveCompleted(0)
(RAS_MQReplacerQuest as RAS:MQReplacer:MQReplacerScript).StartMQReplacer(Alias_ArtifactLocation.GetLocation())
CompleteQuest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0100_Item_00
Function Fragment_Stage_0100_Item_00()
;BEGIN CODE
Alias_TheGuide.TryToDisable()
SetObjectiveFailed(0)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property RAS_MQReplacerQuest Auto Const Mandatory

LocationAlias Property Alias_ArtifactLocation Auto Const Mandatory

ReferenceAlias Property Alias_TheGuide Auto Const Mandatory

ReferenceAlias Property Alias_HunterPreMQ106Sit Auto Const Mandatory

ReferenceAlias Property Alias_HunterPreMQ106Marker Auto Const Mandatory

Message Property RAS_TheGuideStartWarning Auto Const Mandatory
