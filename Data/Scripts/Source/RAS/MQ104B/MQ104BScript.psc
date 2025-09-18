Scriptname RAS:MQ104B:MQ104BScript extends Quest

Quest Property RAS_MQ104B Auto Const Mandatory
Quest Property LinEliteCrewQuest Auto Const
Quest Property HellerEliteCrewQuest Auto Const
ObjectReference LC001MQ104B_TerminalPower
Keyword Property LinkCustom01 Mandatory Const Auto
ObjectReference MQ104BSensorTerminalREF001
TerminalMenu Property MQ104BSensorTerminal_Genesis Mandatory Const Auto
ReferenceAlias Property CrashedShipMapMarker Mandatory Const Auto

ObjectReference LC001OutpostPersistentREF
ObjectReference LC001CliffsidePersistentREF
ObjectReference LC127PersistentREF
ObjectReference LodgePersistentREF

ObjectReference MQ104BSetStage20Trigger001
ObjectReference MQ104BSetStage140Trigger
ObjectReference MQ104BSetStage150Trigger
ObjectReference MQ104BSetStage400Trigger

Event OnQuestInit()
    ;Find references from Starfield.esm (adding properties was modifying the cells so this a workaround)
    LC001CliffsidePersistentREF = Game.GetFormFromFile(0xAE2B, "Starfield.esm") as ObjectReference 
    Self.RegisterForRemoteEvent(LC001CliffsidePersistentREF, "OnCellLoad")
    
    LC001OutpostPersistentREF = Game.GetFormFromFile(0x1ED5DA, "Starfield.esm") as ObjectReference 
    Self.RegisterForRemoteEvent(LC001OutpostPersistentREF, "OnCellLoad")

    LC127PersistentREF = Game.GetFormFromFile(0x9520D, "Starfield.esm") as ObjectReference 
    Self.RegisterForRemoteEvent(LC127PersistentREF, "OnCellLoad")

    Self.RegisterForRemoteEvent(CrashedShipMapMarker.GetReference(), "OnCellLoad")

    LodgePersistentREF = Game.GetFormFromFile(0x27C8EC, "Starfield.esm") as ObjectReference 
    Self.RegisterForRemoteEvent(LodgePersistentREF, "OnCellLoad")

    ;Hook crew quests
    Self.RegisterForRemoteEvent(LinEliteCrewQuest, "OnStageSet")
    Self.RegisterForRemoteEvent(HellerEliteCrewQuest, "OnStageSet")
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akSender)
    If(RAS_MQ104B.GetStage() >= 10)
        If(akSender == LC001CliffsidePersistentREF)
            LC001MQ104B_TerminalPower = akSender.GetLinkedRef(LinkCustom01)
            ObjectReference[] refsLinkedToMe = LC001MQ104B_TerminalPower.GetRefsLinkedToMe(LinkCustom01)
            int i = 0
            While (i < refsLinkedToMe.Length)
                RegisterForRemoteEvent(refsLinkedToMe[i], "OnPowerOn")
                i = i + 1
            EndWhile

            MQ104BSensorTerminalREF001 = Game.GetFormFromFile(0x1ED515, "Starfield.esm") as ObjectReference  
            Self.RegisterForRemoteEvent(MQ104BSensorTerminalREF001, "OnTerminalMenuItemRun")

            Self.UnregisterForRemoteEvent(LC001CliffsidePersistentREF, "OnCellLoad")
        ElseIf(akSender == LC001OutpostPersistentREF)
            MQ104BSetStage20Trigger001 = Game.GetFormFromFile(0x1ED514, "Starfield.esm") as ObjectReference 
            Self.RegisterForRemoteEvent(MQ104BSetStage20Trigger001, "OnTriggerEnter")

            Self.UnregisterForRemoteEvent(LC001OutpostPersistentREF, "OnCellLoad")
        ElseIf(akSender == LC127PersistentREF)
            MQ104BSetStage140Trigger = Game.GetFormFromFile(0x2BBA29, "Starfield.esm") as ObjectReference 
            Self.RegisterForRemoteEvent(MQ104BSetStage140Trigger, "OnTriggerEnter")
            MQ104BSetStage150Trigger = Game.GetFormFromFile(0x1C48E7, "Starfield.esm") as ObjectReference 
            Self.RegisterForRemoteEvent(MQ104BSetStage150Trigger, "OnTriggerEnter")

            Self.UnregisterForRemoteEvent(LC127PersistentREF, "OnCellLoad")
        ElseIf(akSender == CrashedShipMapMarker.GetReference())
            Self.RegisterForDistanceLessThanEvent(CrashedShipMapMarker.GetReference(), Game.GetPlayer(), 10)

            Self.UnregisterForRemoteEvent(CrashedShipMapMarker.GetReference(), "OnCellLoad")
        ElseIf(akSender == LodgePersistentREF)
            MQ104BSetStage400Trigger = Game.GetFormFromFile(0x2BBA2A, "Starfield.esm") as ObjectReference 
             Self.RegisterForRemoteEvent(MQ104BSetStage400Trigger, "OnTriggerEnter")

            Self.UnregisterForRemoteEvent(LodgePersistentREF, "OnCellLoad")
        EndIf
    EndIf
EndEvent

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  If(akSender == LinEliteCrewQuest && auiStageID == 50)
    RAS_MQ104B.SetStageNoWait(112)
    Self.UnregisterForRemoteEvent(LinEliteCrewQuest, "OnStageSet")
  ElseIf(akSender == HellerEliteCrewQuest && auiStageID == 50)
    RAS_MQ104B.SetStage(125)
    Self.UnregisterForRemoteEvent(HellerEliteCrewQuest, "OnStageSet")
  EndIf
EndEvent

Event ObjectReference.OnPowerOn(ObjectReference akSender, ObjectReference akPowerGenerator)
    bool allPowered = true
    int i = 0
    ObjectReference[] refsLinkedToMe = LC001MQ104B_TerminalPower.GetRefsLinkedToMe(LinkCustom01)
    While (i < refsLinkedToMe.Length)
        if(refsLinkedToMe[i])
            if(refsLinkedToMe[i].IsPowered() == false)
                allPowered = false
            EndIf
        EndIf
        i = i + 1
    EndWhile
    if(allPowered == true)
      RAS_MQ104B.SetStage(95)
      While (i < refsLinkedToMe.Length)
          UnregisterForRemoteEvent(refsLinkedToMe[i], "OnPowerOn")
          i = i + 1
      EndWhile
    EndIf
EndEvent

Event ObjectReference.OnTerminalMenuItemRun(ObjectReference akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
  If(akTerminalBase == MQ104BSensorTerminal_Genesis && auiMenuItemID == 1)
      RAS_MQ104B.SetStage(100)
      Self.UnregisterForRemoteEvent(MQ104BSensorTerminalREF001, "OnTerminalMenuItemRun")
  EndIf
EndEvent

Event ObjectReference.OnTriggerEnter(ObjectReference akTrigger, ObjectReference akActionRef)
  If(akTrigger == MQ104BSetStage20Trigger001)
    If(RAS_MQ104B.GetStage() == 15)
         RAS_MQ104B.SetStage(20)
        Self.UnregisterForRemoteEvent(MQ104BSetStage20Trigger001, "OnTriggerEnter")
    EndIf
  ElseIf(akTrigger == MQ104BSetStage140Trigger)
     RAS_MQ104B.SetStage(140)
    Self.UnregisterForRemoteEvent(MQ104BSetStage140Trigger, "OnTriggerEnter")
  ElseIf(akTrigger == MQ104BSetStage150Trigger)
     RAS_MQ104B.SetStage(150)       
    Self.UnregisterForRemoteEvent(MQ104BSetStage150Trigger, "OnTriggerEnter")
  ElseIf(akTrigger == MQ104BSetStage400Trigger)
    If(RAS_MQ104B.GetStage() == 390)
      RAS_MQ104B.SetStage(400)
      Self.UnregisterForRemoteEvent(MQ104BSetStage400Trigger, "OnTriggerEnter")
    EndIf
  EndIf
EndEvent

Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance, int aiEventID)
    RAS_MQ104B.SetStage(120)
EndEvent