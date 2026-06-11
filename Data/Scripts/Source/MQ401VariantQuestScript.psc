Scriptname MQ401VariantQuestScript extends Quest

ReferenceAlias[] Property RefAliasesToEnableArray Const Auto
Bool Property MQ402NoLodgeArtifacts Const Auto
GlobalVariable Property MQ401_NoLodgeArtifacts Mandatory Const Auto
Int Property QuestInitStage=10 Const Auto

Event OnQuestInit()
  Quest RAS_MQReplacerQuest = None
  RAS_MQReplacerQuest = Game.GetFormFromFile(0x1F7C, "RoleplayersAlternateStart.esm") as Quest
  If(!RAS_MQReplacerQuest)
    RAS_MQReplacerQuest = Game.GetFormFromFile(0x1F7C, "RoleplayersAlternateStart_AF.esm") as Quest
      If(!RAS_MQReplacerQuest)
        RAS_MQReplacerQuest = Game.GetFormFromFile(0x1F7C, "RoleplayersAlternateStart.esp") as Quest
      EndIf
  EndIf
  
  If(!RAS_MQReplacerQuest || !RAS_MQReplacerQuest.IsRunning())
    ;for a MQ401 variant, we disable many of the MQ actors, so enable any that the variant needs
    If RefAliasesToEnableArray != None
      EnableQuestActors()
    EndIf

    ;if this Variant doesn't have any Artifacts at the Lodge, or we hand over all of them immediately, then MQ402 needs to skip returning there
    If MQ402NoLodgeArtifacts
        MQ401_NoLodgeArtifacts.SetValueInt(1)
    EndIf

   SetStage(QuestInitStage)
  EndIf
EndEvent

 Function EnableQuestActors()
   int currentElement = 0
   while (currentElement < RefAliasesToEnableArray.Length)
     RefAliasesToEnableArray[currentElement].GetActorRef().Enable()
     currentElement += 1
   endWhile
 EndFunction