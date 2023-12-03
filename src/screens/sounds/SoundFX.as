package screens.sounds
{
	import flash.filesystem.File;
	import flash.media.Sound;
	
	import starling.utils.AssetManager;
	public class SoundFX
	{
		public var assets:AssetManager;
		public var soundManager:SoundManager;
		
		public var SFX_Lightning_01:Sound;
		public var SFX_Thunder_01:Sound;
		public var SFX_DrawSlideOpen:Sound;
		public var SFX_DrawSlideClosed:Sound;
		public var SFX_DoorMetalRustyOpen:Sound;
		public var SFX_DoorMetalRustyClose:Sound;
		public var SFX_DoorMetalRustyOpenTwo:Sound;
		public var SFX_DoorMetalRustyCloseTwo:Sound;
		public var SFX_ThakOne:Sound;
		public var SFX_ThakTwo:Sound;
		public var SFX_ThakThree:Sound;
		public var SFX_Gurgles:Sound;
		public var SFX_ShovelOne:Sound;
		public var SFX_ShovelTwo:Sound;
		public var SFX_GrainOne:Sound;
		public var SFX_WheelOne:Sound;
		public var SFX_Saw:Sound
		public var SFX_FallingTree:Sound
		public var SFX_TVBlip:Sound
		public var SFX_TVBlop:Sound
		public var SFX_CreakyClose:Sound;
		public var SFX_CreakyOpen:Sound;
		public var SFX_PageUnroll:Sound;
		public var SFX_Knot:Sound;
		public var SFX_RopeClimb:Sound;
		public var SFX_BigLights:Sound;
		public var SFX_RattleOne:Sound;
		public var SFX_Sizzle:Sound;
		public var SFX_SizzleTwo:Sound;
		public var SFX_BlowTorch:Sound;
		public var SFX_MetalDropHeavy:Sound;
		public var SFX_MetalDropLight:Sound;
		public var SFX_BarrelKickDeep:Sound;
		public var SFX_BarrelKickLight:Sound;
		public var SFX_ClinkOne:Sound;
		public var SFX_GrowlDeep:Sound;
		public var SFX_GrowlOne:Sound;
		public var SFX_GrowlTwo:Sound;
		public var SFX_Chewing:Sound;
		public var SFX_ComsicRays:Sound;
		public var SFX_OhmTwo:Sound;
		public var SFX_RemoveNail:Sound;
		public var SFX_RemoveNail3x:Sound;
		public var SFX_CosmicWaffle:Sound;
		public var SFX_CosmicDoor:Sound;
		public var SFX_CosmicWindUp:Sound;
		public var SFX_CosmicProcess:Sound;
		public var SFX_ClickSciFi:Sound;
		public var SFX_ClickSciFiTwo:Sound;
		public var SFX_ClickSciFiThree:Sound;
		public var SFX_ErrorTwo:Sound;
		public var SFX_SciFiTransPorter:Sound;
		public var SFX_Spark:Sound;
		public var SFX_CrystalPing:Sound;
		public var SFX_CrystalPingTwo:Sound;
		public var SFX_CrystalWave:Sound;
		public var SFX_CrystalWaveTwo:Sound;
		public var SFX_HeartBeat:Sound;
		
		
		public var SFX_InvenOpen:Sound;
		public var SFX_Phone:Sound;
		public var SFX_Gong:Sound;
		public var SFX_Powm:Sound;
		public var SFX_PowmTwo:Sound;
		public var SFX_PowmThree:Sound;
		public var SFX_PageTurn:Sound;	
		public var SFX_BoxOpen:Sound;
		public var SFX_BoxClose:Sound;
		public var SFX_ItemPickUp:Sound;		
		public var SFX_LockedDoor:Sound;
		public var SFX_LockedDoorTwo:Sound;		
		public var SFX_CreakyDoor:Sound
		public var SFX_SuccessLow:Sound;
		public var SFX_CreakyDoorTwo:Sound;
		public var SFX_CreakyDoorThree:Sound;
		public var SFX_Steps:Sound;		
		public var SFX_MetalSteps:Sound;		
		public var SFX_Match:Sound
		public var SFX_FireBall:Sound;
		public var SFX_ItemPlace:Sound;
		public var SFX_Thump:Sound;
		public var SFX_Bung:Sound;
		public var SFX_ClickTiny:Sound;
		public var SFX_Click:Sound;
		public var SFX_WindUp:Sound
		public var SFX_ClockChime:Sound;
		public var SFX_WaterFlow:Sound;		
		public var SFX_FridgeOpen:Sound;
		public var SFX_FridgeClose:Sound;		
		public var SFX_DrawerOpen:Sound;
		public var SFX_DrawerClose:Sound;		
		public var SFX_Splash:Sound;
		public var SFX_SplashTwo:Sound;
		public var SFX_SplashOut:Sound;		
		public var SFX_LadderOpen:Sound;
		public var SFX_Ladder:Sound;		
		public var SFX_MailBox:Sound		
		public var SFX_ComputerBeeps:Sound;
		public var SFX_ComputerBeepsTwo:Sound;	
		public var SFX_StoneDrag:Sound;
		public var SFX_HeavyStoneDrag:Sound;		
		public var SFX_Ohm:Sound;		
		public var SFX_AirRelease:Sound;		
		public var SFX_MetalBoxClose:Sound;
		public var SFX_MetalBoxOpen:Sound;		
		public var SFX_PowerUp:Sound;
		public var SFX_EnergyPulse:Sound;		
		public var SFX_LockPick:Sound;
		public var SFX_Unlock:Sound;		
		public var SFX_ChestOpen:Sound;		
		public var SFX_GearsOne:Sound;
		public var SFX_GearsTwo:Sound;
		public var SFX_GearsThree:Sound;		
		public var SFX_BootUp:Sound;		
		public var SFX_Bubbles:Sound;		
		public var SFX_WaterBoil:Sound;		
		public var SFX_Error:Sound;		
		public var SFX_WaterDroplet:Sound;		
		public var SFX_WaterPour:Sound;		
		public var SFX_Machine:Sound;
		
		public var globalVol:Number = 0.5;
		public function SoundFX()
		{
			
			this.assets = new AssetManager();
			soundManager = new SoundManager();
		//	soundManager = SoundManager.getInstance();
			
		}
		private function onLoadAssets():void{
		
		}
		
		public function LoadGlobalGamePlaySoundFX():void{
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Inven/InvenOpen_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/antique-wall-phone.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Gong/gong_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Powm/powm_v011a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Powm/powmTwo_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Powm/powmThree_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/PageTurn_One_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Box/Box_Close_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Box/Box_Open_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Item/ItemPickUp_01.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Item/ItemPlace_v002a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/LockedDoor_One_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/LockedDoor_Two_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/ChestOpen_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/CreakyCabinet_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/CreakyDoor/CreakyDoorOne_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/CreakyDoor/CreakyDoorTwo_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Success/SuccessLow_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Steps/Step_One_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Steps/MetalSteps_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Fire/Match_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Fire/FireBall_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Thumps/ThumpOne_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Bung/Bung_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Click/ClickTiny_v001a006.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Click/Click_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/WindUp/windUp_One_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/ClockChime/ClockChimeLow_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/WaterFlow_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Fridge/FridgeClose_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Fridge/FridgeOpen_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drawer/Drawer_One_Close_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drawer/Drawer_One_Open_v001a002.mp3'));						
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/Splash_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/SplashOut_v001a001.mp3'));			
	//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/SplashOut_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/waterdrop_001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ladder/LadderOpen_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ladder/Ladder_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/MailBox/MailboxDoor_One_v001a001.mp3'));						
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Computer/ComputerBeeps_V001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Computer/BootUpOne_v002a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Computer/Error_v001a001.mp3'));					
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drag/StoneDrag_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ohm/Ohm_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ohm/energyPulseOne_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drag/StoneDragHeavy_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Computer/ComputerBeeps_V003a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Air/AirRelease_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Machine/PowerUpOne_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Machine/Machine_v001a002.mp3'));						
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Lock/LockPick_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Lock/Unlock_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Gears/Gears_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Gears/Gears_v002a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Gears/Coin_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/Bubbles_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/WaterBoil_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/WaterPour_v001a002.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/SplashTwo_v001a001.mp3'));						
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Box/Metal_Box_Close_v001a001.mp3'));			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Box/Metal_Box_Open_v001a001.mp3'));			
			
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Lightning/Lightning_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Lightning/Thunder_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drawer/Drawer_One_Slide_Close_v001.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Drawer/Drawer_One_Slide_Open_v001.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/door_metal_rusty_open.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/door_metal_rusty_close.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/door_metal_rusty_open_two.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Door/door_metal_rusty_close_two.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/thak/thak_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/thak/thak_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/thak/thak_03.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Water/gurgles_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Shovel/shovel_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Shovel/shovel_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Grain/grainflow_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Wheel/wheel_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Saw/saw_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/FallingTree/falling_tree.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/TV/TVBlip.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/TV/TVBlop.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/CreakyDoor/creakyClose_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/CreakyDoor/creakyOpen_03.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/page_unroll_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Knot/knot_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/RopeClimb/RopeClimb_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ohm/BigLight.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Rattle/metal_rattle_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Sizzle/sizzle_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Sizzle/sizzle_04.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Metal/MetalDropHeavy.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Metal/MetalDropLight.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/BlowTorch/blowtorch_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Metal/barrelKick_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Metal/barrelKick_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Clink/clink_01.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Growl/GrowlDeep.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Growl/GrowlOne.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Growl/GrowlTwo.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Growl/Chewing.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/cosmic_rays_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Ohm/ohmTwo_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Hammer/RemoveNail.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Hammer/RemoveNail3x.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/cosmicWaffle.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/cosmic_door.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/CosmicWindUp.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/CosmicProcess.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Computer/ErrorTwo.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Click/ClickSciFi.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Click/ClickSciFiTwo.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Click/ClickSciFiThree.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Cosmic/Transporter_02.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Spark/Spark.mp3'));

			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Crystal/CrystalPing.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Crystal/CrystalPingTwo.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Crystal/CrystalWave.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/Crystal/CrystalWaveTwo.mp3'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/SoundFX/HeartBeat/HeartBeat.mp3'));

			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					
					onLoadGlobalGamePlaySoundFX();
				}				
			});	
		}
		private function onLoadGlobalGamePlaySoundFX():void{
			
			
			SFX_InvenOpen = assets.getSound("InvenOpen_v001a001");
			soundManager.addSound("InvenOpen", SFX_InvenOpen);
			
			SFX_Gong = assets.getSound("gong_v001a001");
			soundManager.addSound("Gong", SFX_Gong);
			
			SFX_Phone = assets.getSound("antique-wall-phone");
			soundManager.addSound("Phone", SFX_Phone);
			
			SFX_Machine = assets.getSound("Machine_v001a002");
			soundManager.addSound("Machine", SFX_Machine);
					
			SFX_WaterPour = assets.getSound("WaterPour_v001a002");
			soundManager.addSound("WaterPour", SFX_WaterPour);
			
			SFX_WaterBoil = assets.getSound("WaterBoil_v001a002");
			soundManager.addSound("WaterBoil", SFX_WaterBoil);
			
			SFX_PowmThree = assets.getSound("powmThree_v001a001");
			soundManager.addSound("PowmThree", SFX_PowmThree);
			
			SFX_PowmTwo = assets.getSound("powmTwo_v001a001");
			soundManager.addSound("PowmTwo", SFX_PowmTwo);
			
			SFX_WaterDroplet = assets.getSound("waterdrop_001a001");
			soundManager.addSound("WaterDroplet", SFX_WaterDroplet);
	
			SFX_Error = assets.getSound("Error_v001a001");
			soundManager.addSound("Error", SFX_Error);			
			
			SFX_Bubbles = assets.getSound("Bubbles_v001a002");
			soundManager.addSound("Bubbles", SFX_Bubbles);
			
			SFX_BootUp = assets.getSound("BootUpOne_v002a002");
			soundManager.addSound("BootUp", SFX_BootUp);
						
			SFX_CreakyDoorThree = assets.getSound("CreakyCabinet_v001a002");
			soundManager.addSound("CreakyDoorThree", SFX_CreakyDoorThree);
			
			SFX_GearsThree = assets.getSound("Coin_v001a001");
			soundManager.addSound("GearsThree", SFX_GearsThree);
			
			SFX_GearsOne = assets.getSound("Gears_v001a002");
			soundManager.addSound("GearsOne", SFX_GearsOne);
			
			SFX_GearsTwo = assets.getSound("Gears_v002a001");
			soundManager.addSound("GearsTwo", SFX_GearsTwo);
			
			SFX_ChestOpen = assets.getSound("ChestOpen_v001a001");
			soundManager.addSound("ChestOpen", SFX_ChestOpen);
			
			SFX_Unlock = assets.getSound("Unlock_v001a001");
			soundManager.addSound("Unlock", SFX_Unlock);
			
			SFX_LockPick = assets.getSound("LockPick_v001a001");
			soundManager.addSound("LockPick", SFX_LockPick);
			
			SFX_LockedDoorTwo = assets.getSound("LockedDoor_Two_v001a001");
			soundManager.addSound("LockedDoorTwo", SFX_LockedDoorTwo);
			
			SFX_EnergyPulse  = assets.getSound("energyPulseOne_v001a002");
			soundManager.addSound("EnergyPulse", SFX_EnergyPulse);
						
			SFX_PowerUp  = assets.getSound("PowerUpOne_v001a001");
			soundManager.addSound("PowerUp", SFX_PowerUp);
			
			SFX_MetalBoxClose  = assets.getSound("Metal_Box_Close_v001a001");
			soundManager.addSound("MetalBoxClose", SFX_MetalBoxClose);
			
			SFX_MetalBoxOpen  = assets.getSound("Metal_Box_Open_v001a001");
			soundManager.addSound("MetalBoxOpen", SFX_MetalBoxOpen);			
			
			SFX_AirRelease = assets.getSound("AirRelease_v001a001");
			soundManager.addSound("AirRelease", SFX_AirRelease);
			
			SFX_MetalSteps = assets.getSound("MetalSteps_v001a002");
			soundManager.addSound("MetalSteps", SFX_MetalSteps);
			
			SFX_HeavyStoneDrag = assets.getSound("StoneDragHeavy_v001a001");
			soundManager.addSound("HeavyStoneDrag", SFX_HeavyStoneDrag);
			
			SFX_Ohm = assets.getSound("Ohm_v001a002");
			soundManager.addSound("Ohm", SFX_Ohm);
			
			SFX_StoneDrag = assets.getSound("StoneDrag_v001a001");
			soundManager.addSound("StoneDrag", SFX_StoneDrag);

			SFX_ComputerBeepsTwo = assets.getSound("ComputerBeeps_V003a002");
			soundManager.addSound("ComputerBeepsTwo", SFX_ComputerBeepsTwo);
			
			SFX_ComputerBeeps = assets.getSound("ComputerBeeps_V001a002");
			soundManager.addSound("ComputerBeeps", SFX_ComputerBeeps);
			
			SFX_MailBox = assets.getSound("MailboxDoor_One_v001a001");
			soundManager.addSound("MailBox", SFX_MailBox);
			
			SFX_LadderOpen = assets.getSound("LadderOpen_v001a001");
			soundManager.addSound("LadderOpen", SFX_LadderOpen);
			
			SFX_Ladder = assets.getSound("Ladder_v001a001");
			soundManager.addSound("Ladder", SFX_Ladder);
			
			SFX_SplashTwo = assets.getSound("SplashTwo_v001a001");
			soundManager.addSound("SplashTwo", SFX_SplashTwo);
			
			SFX_Splash = assets.getSound("Splash_v001a001");
			soundManager.addSound("Splash", SFX_Splash);
			
			SFX_SplashOut = assets.getSound("SplashOut_v001a001");
			soundManager.addSound("SplashOut", SFX_SplashOut);
			
			SFX_DrawerOpen = assets.getSound("Drawer_One_Open_v001a002");
			soundManager.addSound("DrawerOpen", SFX_DrawerOpen);
			
			SFX_DrawerClose = assets.getSound("Drawer_One_Close_v001a002");
			soundManager.addSound("DrawerClose", SFX_DrawerClose);
			
			
			SFX_FridgeOpen = assets.getSound("FridgeOpen_v001a002");
			soundManager.addSound("FridgeOpen", SFX_FridgeOpen);
			
			SFX_FridgeClose = assets.getSound("FridgeClose_v001a001");
			soundManager.addSound("FridgeClose", SFX_FridgeClose);
						
			SFX_WaterFlow = assets.getSound("WaterFlow_v001a002");
			soundManager.addSound("WaterFlow", SFX_WaterFlow);
			
			SFX_ClockChime = assets.getSound("ClockChimeLow_v001a001");
			soundManager.addSound("ClockChime", SFX_ClockChime);
			
			SFX_WindUp = assets.getSound("windUp_One_v001a001");
			soundManager.addSound("WindUp", SFX_WindUp);

			SFX_Click = assets.getSound("Click_v001a001");
			soundManager.addSound("Click", SFX_Click);
			
			SFX_ClickTiny = assets.getSound("ClickTiny_v001a006");
			soundManager.addSound("ClickTiny", SFX_ClickTiny);
			
			SFX_Bung = assets.getSound("Bung_v001a001");
			soundManager.addSound("Bung", SFX_Bung);
			
			SFX_Thump = assets.getSound("ThumpOne_v001a001");
			soundManager.addSound("Thump", SFX_Thump);
			
			SFX_ItemPlace = assets.getSound("ItemPlace_v002a001");
			soundManager.addSound("ItemPlace", SFX_ItemPlace);
			
			SFX_FireBall = assets.getSound("FireBall_v001a001");
			soundManager.addSound("FireBall", SFX_FireBall);
			
			SFX_Match = assets.getSound("Match_v001a001");
			soundManager.addSound("Match", SFX_Match);
			
			SFX_Powm = assets.getSound("powm_v011a002");
			soundManager.addSound("Powm", SFX_Powm);
			
			SFX_PageTurn = assets.getSound("PageTurn_One_v001a002");
			soundManager.addSound("PageTurn", SFX_PageTurn);
			
			SFX_BoxOpen = assets.getSound("Box_Open_v001a001");
			soundManager.addSound("BoxOpen", SFX_BoxOpen);
			
			SFX_BoxClose = assets.getSound("Box_Close_v001a001");
			soundManager.addSound("BoxClose", SFX_BoxClose);
			
			SFX_ItemPickUp = assets.getSound("ItemPickUp_01");
			soundManager.addSound("ItemPickUp", SFX_ItemPickUp);
			
			SFX_LockedDoor = assets.getSound("LockedDoor_One_v001a002");
			soundManager.addSound("LockedDoor", SFX_LockedDoor);
			
			SFX_CreakyDoor = assets.getSound("CreakyDoorOne_v001a001");
			soundManager.addSound("CreakyDoor", SFX_CreakyDoor);
			
			SFX_SuccessLow = assets.getSound("SuccessLow_v001a001");
			soundManager.addSound("SuccessLow", SFX_SuccessLow);
			
			SFX_CreakyDoorTwo = assets.getSound("CreakyDoorTwo_v001a001");
			soundManager.addSound("CreakyDoorTwo", SFX_CreakyDoorTwo);
			
			SFX_Steps = assets.getSound("Step_One_v001a002");
			soundManager.addSound("Steps", SFX_Steps);
			
			
			
			SFX_Lightning_01 = assets.getSound("Lightning_01");
			soundManager.addSound("Lightning_01", SFX_Lightning_01);
			
			SFX_Thunder_01 = assets.getSound("Thunder_01");
			soundManager.addSound("Thunder_01", SFX_Thunder_01);
			
			SFX_DrawSlideOpen = assets.getSound("Drawer_One_Slide_Open_v001");
			soundManager.addSound("DrawSlideOpen", SFX_DrawSlideOpen);
			
			SFX_DrawSlideClosed = assets.getSound("Drawer_One_Slide_Close_v001");
			soundManager.addSound("DrawSlideClosed", SFX_DrawSlideClosed);
			
			SFX_DoorMetalRustyOpen = assets.getSound("door_metal_rusty_open");
			soundManager.addSound("DoorMetalRustyOpen", SFX_DoorMetalRustyOpen);
			
			SFX_DoorMetalRustyClose = assets.getSound("door_metal_rusty_close");
			soundManager.addSound("DoorMetalRustyClose", SFX_DoorMetalRustyClose);
			
			SFX_DoorMetalRustyOpenTwo = assets.getSound("door_metal_rusty_open_two");
			soundManager.addSound("DoorMetalRustyOpenTwo", SFX_DoorMetalRustyOpenTwo);
			
			SFX_DoorMetalRustyCloseTwo = assets.getSound("door_metal_rusty_close_two");
			soundManager.addSound("DoorMetalRustyCloseTwo", SFX_DoorMetalRustyCloseTwo);
			
			SFX_ThakOne = assets.getSound("thak_01");
			soundManager.addSound("ThakOne", SFX_ThakOne);
			
			SFX_ThakTwo = assets.getSound("thak_02");
			soundManager.addSound("ThakTwo", SFX_ThakTwo);
			
			SFX_ThakThree = assets.getSound("thak_03");
			soundManager.addSound("ThakThree", SFX_ThakThree);
			
			
			SFX_Gurgles = assets.getSound("gurgles_01");
			soundManager.addSound("Gurgles", SFX_Gurgles);
			
			SFX_ShovelOne = assets.getSound("shovel_01");
			soundManager.addSound("ShovelOne", SFX_ShovelOne);
			
			SFX_ShovelTwo = assets.getSound("shovel_02");
			soundManager.addSound("ShovelTwo", SFX_ShovelTwo);
			
			SFX_GrainOne = assets.getSound("grainflow_02");
			soundManager.addSound("GrainOne", SFX_GrainOne);
			
			SFX_WheelOne = assets.getSound("wheel_01");
			soundManager.addSound("WheelOne", SFX_WheelOne);
			
			SFX_Saw = assets.getSound("saw_01");
			soundManager.addSound("Saw", SFX_Saw);
			
			SFX_FallingTree = assets.getSound("falling_tree");
			soundManager.addSound("FallingTree", SFX_FallingTree);
			
			SFX_TVBlip = assets.getSound("TVBlip");
			soundManager.addSound("TVBlip", SFX_TVBlip);
			
			
			SFX_TVBlop = assets.getSound("TVBlop");
			soundManager.addSound("TVBlop", SFX_TVBlop);
		
			
			SFX_CreakyClose = assets.getSound("creakyClose_01");
			soundManager.addSound("CreakyClose", SFX_CreakyClose);
			
			SFX_CreakyOpen = assets.getSound("creakyOpen_03");
			soundManager.addSound("CreakyOpen", SFX_CreakyOpen);
		
			SFX_PageUnroll = assets.getSound("page_unroll_02");
			soundManager.addSound("PageUnroll", SFX_PageUnroll);
			
			
			SFX_Knot = assets.getSound("knot_01");
			soundManager.addSound("Knot", SFX_Knot);
			
			SFX_RopeClimb = assets.getSound("RopeClimb_02");
			soundManager.addSound("RopeClimb", SFX_RopeClimb);
			
			SFX_BigLights = assets.getSound("BigLight");
			soundManager.addSound("BigLights", SFX_BigLights);
			
			SFX_RattleOne = assets.getSound("metal_rattle_01");
			soundManager.addSound("RattleOne", SFX_RattleOne);
			
			SFX_Sizzle = assets.getSound("sizzle_02");
			soundManager.addSound("Sizzle", SFX_Sizzle);
			
			SFX_SizzleTwo = assets.getSound("sizzle_04");
			soundManager.addSound("SizzleTwo", SFX_SizzleTwo);
			
			
			SFX_BlowTorch = assets.getSound("blowtorch_01");
			soundManager.addSound("BlowTorch", SFX_BlowTorch);
			
			SFX_MetalDropHeavy = assets.getSound("MetalDropHeavy");
			soundManager.addSound("MetalDropHeavy", SFX_MetalDropHeavy);
			
			SFX_MetalDropLight = assets.getSound("MetalDropLight");
			soundManager.addSound("MetalDropLight", SFX_MetalDropLight);
			

			SFX_BarrelKickDeep = assets.getSound("barrelKick_01");
			soundManager.addSound("BarrelKickDeep", SFX_BarrelKickDeep);
			
			SFX_BarrelKickLight = assets.getSound("barrelKick_02");
			soundManager.addSound("BarrelKickLight", SFX_BarrelKickLight);
			
			SFX_ClinkOne = assets.getSound("clink_01");
			soundManager.addSound("ClinkOne", SFX_ClinkOne);
			
			SFX_GrowlDeep = assets.getSound("GrowlDeep");
			soundManager.addSound("GrowlDeep", SFX_GrowlDeep);
			
			SFX_GrowlOne = assets.getSound("GrowlOne");
			soundManager.addSound("GrowlOne", SFX_GrowlOne);
			
			SFX_GrowlTwo = assets.getSound("GrowlTwo");
			soundManager.addSound("GrowlTwo", SFX_GrowlOne);
			
			SFX_Chewing = assets.getSound("Chewing");
			soundManager.addSound("Chewing", SFX_Chewing);
			
			SFX_ComsicRays = assets.getSound("cosmic_rays_02");
			soundManager.addSound("CosmicRays", SFX_ComsicRays);
			
			SFX_OhmTwo = assets.getSound("ohmTwo_02");
			soundManager.addSound("OhmTwo", SFX_OhmTwo);
			
			SFX_RemoveNail = assets.getSound("RemoveNail");
			soundManager.addSound("RemoveNail", SFX_RemoveNail);
			
			SFX_RemoveNail3x = assets.getSound("RemoveNail3x");
			soundManager.addSound("RemoveNail3x", SFX_RemoveNail3x);
			
			SFX_CosmicWaffle = assets.getSound("cosmicWaffle");
			soundManager.addSound("CosmicWaffle", SFX_CosmicWaffle);
			
			SFX_CosmicDoor = assets.getSound("cosmic_door");
			soundManager.addSound("CosmicDoor", SFX_CosmicDoor);
			
			SFX_CosmicWindUp = assets.getSound("CosmicWindUp");
			soundManager.addSound("CosmicWindUp", SFX_CosmicWindUp);
			
			SFX_CosmicProcess = assets.getSound("CosmicProcess");
			soundManager.addSound("CosmicProcess", SFX_CosmicProcess);
			
			SFX_ClickSciFi = assets.getSound("ClickSciFi");
			soundManager.addSound("ClickSciFi", SFX_ClickSciFi);
			
			SFX_ClickSciFiTwo = assets.getSound("ClickSciFiTwo");
			soundManager.addSound("ClickSciFiTwo", SFX_ClickSciFiTwo);
			
			SFX_ClickSciFiThree = assets.getSound("ClickSciFiThree");
			soundManager.addSound("ClickSciFiThree", SFX_ClickSciFiThree);
			
			//ClickSciFiThree
			SFX_ErrorTwo = assets.getSound("ErrorTwo");
			soundManager.addSound("ErrorTwo", SFX_ErrorTwo);
			
			SFX_SciFiTransPorter  = assets.getSound("Transporter_02");
			soundManager.addSound("Transporter", SFX_SciFiTransPorter);
			//Spark
			SFX_Spark  = assets.getSound("Spark");
			soundManager.addSound("Spark", SFX_Spark);
			
			SFX_CrystalPing  = assets.getSound("CrystalPing");
			soundManager.addSound("CrystalPing", SFX_CrystalPing);
			
			SFX_CrystalPingTwo  = assets.getSound("CrystalPingTwo");
			soundManager.addSound("CrystalPingTwo", SFX_CrystalPingTwo);
			
			
			SFX_CrystalWave  = assets.getSound("CrystalWave");
			soundManager.addSound("CrystalWave", SFX_CrystalWave);
			
			SFX_CrystalWaveTwo  = assets.getSound("CrystalWaveTwo");
			soundManager.addSound("CrystalWaveTwo", SFX_CrystalWaveTwo);
			
			SFX_HeartBeat  = assets.getSound("HeartBeat");
			soundManager.addSound("HeartBeat", SFX_HeartBeat);
			
			//HeartBeat
			
		}
		


		public function PlaySFX_InvenOpen():void{
			
			soundManager.playSound("InvenOpen",globalVol);	
		}
		
		public function PlaySFX_Gong():void{
			
			soundManager.playSound("Gong",globalVol);	
		}
		
		public function PlaySFX_Phone():void{
			
			soundManager.playSound("Phone",globalVol);	
		}
		
		public function PlaySFX_Machine():void{
			
			soundManager.playSound("Machine",globalVol);	
		}
		
		public function PlaySFX_WaterPour():void{
			
			soundManager.playSound("WaterPour",globalVol);	
		}
		
		public function PlaySFX_WaterBoil():void{
			
			soundManager.playSound("WaterBoil",globalVol);	
		}
		
		public function PlaySFX_PowmThree():void{
			
			soundManager.playSound("PowmThree",globalVol);
			
		}
		
		public function PlaySFX_PowmTwo():void{
			
			soundManager.playSound("PowmTwo",globalVol);
			
		}
		
		public function PlaySFX_WaterDroplet():void{
			
			soundManager.playSound("WaterDroplet",globalVol);
			
		}

		
		public function PlaySFX_Error():void{
			
			soundManager.playSound("Error",globalVol);
			
		}

		
		public function PlaySFX_Bubbles():void{
			
			soundManager.playSound("Bubbles",globalVol);
			
		}
		
		public function PlaySFX_BootUp():void{
			
			soundManager.playSound("BootUp",globalVol);
			
		}
		
		public function PlaySFX_CreakyDoorThree():void{
			
			soundManager.playSound("CreakyDoorThree",globalVol);
			
		}
		
		public function PlaySFX_GearsThree():void{
			
			soundManager.playSound("GearsThree",globalVol);
			
		}
		
		public function PlaySFX_GearsOne():void{
			
			soundManager.playSound("GearsOne",globalVol);
			
		}
		
		public function PlaySFX_GearsTwo(repeat:int = 0):void{
			
			soundManager.playSound("GearsTwo",globalVol,repeat);
			
		}
		
		public function PlaySFX_ChestOpen():void{
			
			soundManager.playSound("ChestOpen",globalVol);
			
		}
		
		public function PlaySFX_Unlock():void{
			
			soundManager.playSound("Unlock",globalVol);
			
		}
		
		public function PlaySFX_LockPick():void{
			
			soundManager.playSound("LockPick",globalVol,999);
			
		}
		public function PlaySFX_LockedDoorTwo():void{
			
			soundManager.playSound("LockedDoorTwo",globalVol);
			
		}
		public function PlaySFX_EnergyPulse():void{
			
			soundManager.playSound("EnergyPulse",globalVol);
			
		}
		
		public function PlaySFX_PowerUp():void{
			
			soundManager.playSound("PowerUp",globalVol);
			
		}
		
		public function PlaySFX_MetalBoxClose():void{
			
			soundManager.playSound("MetalBoxClose",globalVol);
			
		}
		
		public function PlaySFX_MetalBoxOpen():void{
			
			soundManager.playSound("MetalBoxOpen",globalVol);
			
		}
		
		public function PlaySFX_AirRelease():void{
			
			soundManager.playSound("AirRelease",globalVol);
			
		}
		
		
		public function PlaySFX_MetalSteps():void{
			
			soundManager.playSound("MetalSteps",globalVol);
			
		}	
		public function PlaySFX_ComputerBeepsTwo():void{
			
			soundManager.playSound("ComputerBeepsTwo",globalVol);
			
		}	
		public function PlaySFX_Click():void{
			
			soundManager.playSound("Click",globalVol);
			
		}	
		public function PlaySFX_HeavyStoneDrag():void{
			
			soundManager.playSound("HeavyStoneDrag",globalVol);
			
		}	
		
		public function PlaySFX_Ohm():void{
			
			soundManager.playSound("Ohm",globalVol);
			
		}	
		public function PlaySFX_StoneDrag():void{
			
			soundManager.playSound("StoneDrag",globalVol);
			
		}	
		public function PlaySFX_ComputerBeeps():void{
			
			soundManager.playSound("ComputerBeeps",globalVol);
			
		}	
		
		public function PlaySFX_MailBox():void{
			
			soundManager.playSound("MailBox",globalVol);
			
		}	
		public function PlaySFX_Ladder():void{
			
			soundManager.playSound("Ladder",globalVol);
	
		}		
		
		
		public function PlaySFX_LadderOpen():void{
			
			soundManager.playSound("LadderOpen",globalVol);	
			
		}
		
		
		public function PlaySFX_SplashTwo():void{
			
			soundManager.playSound("SplashTwo",globalVol);
			
		}
		public function PlaySFX_Splash():void{
			
			soundManager.playSound("Splash",globalVol);
			
		}
		
		public function PlaySFX_SplashOut():void{
			
			soundManager.playSound("SplashOut",globalVol);
			
		}
		
		public function PlaySFX_DrawerOpen():void{
			
			soundManager.playSound("DrawerOpen",globalVol);
			
		}
		public function PlaySFX_DrawerClose():void{
			
			soundManager.playSound("DrawerClose",globalVol);
			
		}
		
		public function PlaySFX_FridgeOpen():void{
			
			soundManager.playSound("FridgeOpen",globalVol);
			
		}
		public function PlaySFX_FridgeClose():void{
			
			soundManager.playSound("FridgeClose",globalVol);
			
		}
		
		
		public function PlaySFX_WaterFlow():void{
			
			soundManager.playSound("WaterFlow",globalVol);	
		}
		
		public function PlaySFX_ClockChime():void{
			
			soundManager.playSound("ClockChime",globalVol);
			
		}
		public function PlaySFX_WindUp(repeatCount:Number = 999):void{
			
			soundManager.playSound("WindUp",globalVol,repeatCount);
			
		}
		public function PlaySFX_ClickTiny():void{
			
			soundManager.playSound("ClickTiny",globalVol);
			
		}
		public function PlaySFX_Bung():void{
			
			soundManager.playSound("Bung",globalVol);
			
		}		
		
		public function PlaySFX_Thump():void{
			
			soundManager.playSound("Thump",globalVol);
			
		}		
		public function PlaySFX_ItemPlace():void{
			
			soundManager.playSound("ItemPlace",globalVol);
			
		}		
		
		public function PlaySFX_FireBall():void{
			
			soundManager.playSound("FireBall",globalVol);
			
		}		
		
		public function PlaySFX_Match():void{
			
			soundManager.playSound("Match",globalVol);
			
		}		
		public function PlaySFX_Steps():void{
			
			soundManager.playSound("Steps",globalVol);
			
		}		
		
		public function PlaySFX_SuccessLow():void{
			
			soundManager.playSound("SuccessLow",globalVol);
			
		}
		public function PlaySFX_CreakyDoorTwo():void{
			
			soundManager.playSound("CreakyDoorTwo",globalVol);
			
		}
		
		public function PlaySFX_CreakyDoor():void{
			
			soundManager.playSound("CreakyDoor",globalVol);
			
		}
		
		public function PlaySFX_LockedDoor():void{
			
			soundManager.playSound("LockedDoor",globalVol);
			
		}
		public function PlaySFX_Powm():void{
			
			soundManager.playSound("Powm",globalVol);
			
		}
		
		public function PlaySFX_PageTurn():void{
			
			soundManager.playSound("PageTurn",globalVol);
			
		}
		
		public function PlaySFX_BoxOpen():void{
			
			soundManager.playSound("BoxOpen",globalVol);
			
		}
		
		public function PlaySFX_BoxClose():void{
			
			soundManager.playSound("BoxClose",globalVol);
			
		}
		
		public function PlaySFX_ItemPickUp():void{
			
			soundManager.playSound("ItemPickUp",globalVol);
			
		}
		
		
		
		
		public function PlaySFX_Lightning_01():void{			
			soundManager.playSound("Lightning_01",globalVol);			
		}
		
		public function PlaySFX_Thunder_01():void{			
			soundManager.playSound("Thunder_01",globalVol);			
		}
	
		public function PlaySFX_DrawSlideClosed():void{			
			soundManager.playSound("DrawSlideClosed",globalVol);			
		}
		public function PlaySFX_DrawSlideOpen():void{			
			soundManager.playSound("DrawSlideOpen",globalVol);			
		}
		
		public function PlaySFX_DoorMetalRustyOpen():void{			
			soundManager.playSound("DoorMetalRustyOpen",globalVol);			
		}
		public function PlaySFX_DoorMetalRustyClose():void{			
			soundManager.playSound("DoorMetalRustyClose",globalVol);			
		}
		
		public function PlaySFX_DoorMetalRustyOpenTwo():void{			
			soundManager.playSound("DoorMetalRustyOpenTwo",globalVol);			
		}
		public function PlaySFX_DoorMetalRustyCloseTwo():void{			
			soundManager.playSound("DoorMetalRustyCloseTwo",globalVol);			
		}
		public function PlaySFX_ThakOne():void{			
			soundManager.playSound("ThakOne",globalVol);			
		}
		public function PlaySFX_ThakTwo():void{			
			soundManager.playSound("ThakTwo",globalVol);			
		}
		public function PlaySFX_ThakThree():void{			
			soundManager.playSound("ThakThree",globalVol);			
		}
		public function PlaySFX_Gurgles():void{			
			soundManager.playSound("Gurgles",globalVol);			
		}
		public function PlaySFX_ShovelOne():void{			
			soundManager.playSound("ShovelOne",globalVol);			
		}
		public function PlaySFX_ShovelTwo():void{			
			soundManager.playSound("ShovelTwo",globalVol);			
		}
		public function PlaySFX_GrainOne():void{			
			soundManager.playSound("GrainOne",globalVol);			
		}
		
		public function PlaySFX_WheelOne():void{			
			soundManager.playSound("WheelOne",globalVol);			
		}
		
		public function PlaySFX_Saw():void{			
			soundManager.playSound("Saw",globalVol);			
		}
		
		public function PlaySFX_TVBlip():void{			
			soundManager.playSound("TVBlip",globalVol);			
		}
		public function PlaySFX_TVBlop():void{			
			soundManager.playSound("TVBlop",globalVol);			
		}
		public function PlaySFX_CreakyClose():void{			
			soundManager.playSound("CreakyClose",globalVol);			
		}
		public function PlaySFX_CreakyOpen():void{			
			soundManager.playSound("CreakyOpen",globalVol);			
		}
		public function PlaySFX_PageUnroll():void{			
			soundManager.playSound("PageUnroll",globalVol);			
		}
		
		public function PlaySFX_Knot():void{			
			soundManager.playSound("Knot",globalVol);			
		}
		
		public function PlaySFX_RopeClimb():void{			
			soundManager.playSound("RopeClimb",globalVol);			
		}
		
		public function PlaySFX_BigLights():void{			
			soundManager.playSound("BigLights",globalVol);			
		}
		
		public function PlaySFX_RattleOne():void{			
			soundManager.playSound("RattleOne",globalVol);			
		}

		public function PlaySFX_Sizzle():void{			
			soundManager.playSound("Sizzle",globalVol);			
		}
		public function PlaySFX_SizzleTwo():void{			
			soundManager.playSound("SizzleTwo",globalVol);			
		}
		public function PlaySFX_BlowTorch():void{			
			soundManager.playSound("BlowTorch",globalVol);			
		}
		public function PlaySFX_MetalDropHeavy():void{			
			soundManager.playSound("MetalDropHeavy",globalVol);			
		}
		
		public function PlaySFX_MetalDropLight():void{			
			soundManager.playSound("MetalDropLight",globalVol);			
		}
		
		public function PlaySFX_BarrelKickLight():void{			
			soundManager.playSound("BarrelKickLight",globalVol);			
		}
		
		public function PlaySFX_BarrelKickDeep():void{			
			soundManager.playSound("BarrelKickDeep",globalVol);			
		}
		
		public function PlaySFX_FallingTree():void{			
			soundManager.playSound("FallingTree",globalVol);			
		}
		public function PlaySFX_ClinkOne():void{			
			soundManager.playSound("ClinkOne",globalVol);			
		}
		
		public function PlaySFX_GrowlDeep():void{			
			soundManager.playSound("GrowlDeep",globalVol);			
		}
		
		public function PlaySFX_GrowlOne():void{			
			soundManager.playSound("GrowlOne",globalVol);			
		}
		
		public function PlaySFX_GrowlTwo():void{			
			soundManager.playSound("GrowlTwo",globalVol);			
		}
		
		public function PlaySFX_Chewing():void{			
			soundManager.playSound("Chewing",globalVol);			
		}
		
		public function PlaySFX_CosmicRays():void{			
			soundManager.playSound("CosmicRays",globalVol);			
		}
		
		public function PlaySFX_OhmTwo():void{			
			soundManager.playSound("OhmTwo",globalVol);			
		}
		public function PlaySFX_RemoveNail():void{			
			soundManager.playSound("RemoveNail",globalVol);			
		}
		public function PlaySFX_RemoveNail3x():void{			
			soundManager.playSound("RemoveNail3x",globalVol);			
		}
		public function PlaySFX_CosmicWaffle():void{			
			soundManager.playSound("CosmicWaffle",globalVol);			
		}
		public function PlaySFX_CosmicDoor():void{			
			soundManager.playSound("CosmicDoor",globalVol);			
		}
		public function PlaySFX_CosmicWindUp(repeatCount:Number = 999):void{			
			soundManager.playSound("CosmicWindUp",globalVol,repeatCount);			
		}
		public function PlaySFX_CosmicProcess():void{			
			soundManager.playSound("CosmicProcess",globalVol);			
		}
		public function PlaySFX_ClickSciFi():void{			
			soundManager.playSound("ClickSciFi",globalVol);			
		}
		public function PlaySFX_ClickSciFiTwo():void{			
			soundManager.playSound("ClickSciFiTwo",globalVol);			
		}
		public function PlaySFX_ErrorTwo():void{			
			soundManager.playSound("ErrorTwo",globalVol);			
		}
		public function PlaySFX_ClickSciFiThree():void{			
			soundManager.playSound("ClickSciFiThree",globalVol);			
		}
		public function PlaySFX_SciFiTransPorter():void{			
			soundManager.playSound("Transporter",globalVol);			
		}
		public function PlaySFX_Spark(repeatCount:Number = 999):void{			
			soundManager.playSound("Spark",globalVol,repeatCount);			
		}
		public function PlaySFX_CrystalWave():void{			
			soundManager.playSound("CrystalWave",globalVol);			
		}
		public function PlaySFX_CrystalPing():void{			
			soundManager.playSound("CrystalPing",globalVol);			
		}
		public function PlaySFX_CrystalPingTwo():void{			
			soundManager.playSound("CrystalPingTwo",globalVol);			
		}
		public function PlaySFX_CrystalWaveTwo():void{			
			soundManager.playSound("CrystalWaveTwo",globalVol);			
		}
		public function PlaySFX_HeartBeat(repeatCount:Number = 999):void{			
			soundManager.playSound("HeartBeat",globalVol,repeatCount);			
		} 
		/*
		HeartBeat
		public var SFX_CrystalPing:Sound;
		public var SFX_CrystalWave:Sound;
		SFX_CrystalWaveTwo
		*/
		
	}
}