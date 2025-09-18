;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Scenes:SF_NewGameManager_VehicleVending Extends Scene Hidden Const

;BEGIN FRAGMENT Fragment_Action_05
Function Fragment_Action_05(ReferenceAlias akAlias)
;BEGIN CODE
(RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript).StartVehicleVending()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property RAS_ShipServicesActorREF Auto Const Mandatory
