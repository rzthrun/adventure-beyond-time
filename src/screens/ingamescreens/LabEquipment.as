package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	
	
	public class LabEquipment extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var slide:Image;
		private var screen:Image;
		private var disk:Image;
		private var goo:Image;
		private var crystal:Image;
		private var stone:Image;
		private var hose:Image;
		private var machine_mc:MovieClip;
		
		
		private var hit_microscope:Shape;
		private var hit_printer:Shape;
		private var hit_screen:Shape;
		private var hit_machine:Shape;
		
		private var screenTween:Tween;
		private var CrystalTween:Tween;
		
		private var Animating:Boolean = false;
		private var ThereIsPower:Boolean = false;
		private var MachineOn:Boolean = false;
		private var DiscAttached:Boolean = false;
		private var DiscState:Boolean = false;
		private var MachineSolved:Boolean = false;
		
		private var PhraseCounter:int = 0;
		
		public var delayedCall:DelayedCall;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function LabEquipment(_assets:AssetManager,_game:Game)
		{
			super();
			//	this.assets = new AssetManager();
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('labEquipment_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabEquipment/labEquipment_bg.jpg'));
				game.TrackAssets('labEquipment_01');
			}
			if(game.CheckAsset('labEquipment_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabEquipment/LabEquipment_Sprite.atf'));
				game.TrackAssets('labEquipment_02');
			}
			if(game.CheckAsset('labEquipment_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabEquipment/LabEquipment_Sprite.xml'));
				game.TrackAssets('labEquipment_03');
			}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabEquipment","LabEquipmentObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			//(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);	
			
	//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
	//			SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
	//		}
	//		SaveArray['SlimeQue'] = "no";
	//		SaveArray['MachineOn'] = "no";
	//		(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SolarPanels'] == 'Attached'){
					ThereIsPower = true;
					trace("THERE IS POWER");
				}
			}
			
			
			bg = new Image(this.assets.getTexture('labEquipment_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			slide = new Image(this.assets.getTexture('slide'));
			slide.smoothing = TextureSmoothing.NONE;
			slide.touchable = false;
			slide.x = 65;
			slide.y = 258;
			
			hose = new Image(this.assets.getTexture('hose'));
			hose.smoothing = TextureSmoothing.NONE;
			hose.touchable = false;
			hose.x = 390;
			hose.y = 122;
			
			screen = new Image(this.assets.getTexture('screen'));
			screen.smoothing = TextureSmoothing.NONE;
			screen.touchable = false;
			screen.x = 268;
			screen.y = 29;

			disk = new Image(this.assets.getTexture('disk'));
			disk.smoothing = TextureSmoothing.NONE;
			disk.touchable = false;
			disk.x = 268;
			disk.y = 204;
			
			goo = new Image(this.assets.getTexture('printer_goo'));
			goo.smoothing = TextureSmoothing.NONE;
			goo.touchable = false;
			goo.x = 528;
			goo.y = 236;
			
			stone = new Image(this.assets.getTexture('printer_stone'));
			stone.smoothing = TextureSmoothing.NONE;

			stone.touchable = false;
			stone.x = 638;
			stone.y = 201;
			
			crystal = new Image(this.assets.getTexture('printer_crystal'));
			crystal.smoothing = TextureSmoothing.NONE;
			crystal.touchable = false;
			crystal.x = 559;
			crystal.y = 208;
			
			machine_mc = new MovieClip(this.assets.getTextures("anima_"),3);
			machine_mc.smoothing = TextureSmoothing.NONE;
			machine_mc.x = 389;
			machine_mc.y = 41;
			
			machine_mc.touchable = false;
			machine_mc.loop = false; 
			machine_mc.alpha = 0;
			machine_mc.stop();
			
			machine_mc.addFrameAt(6,this.assets.getTexture("anima_04"), null, 0.33);
			machine_mc.addFrameAt(7,this.assets.getTexture("anima_05"), null, 0.33);
			machine_mc.addFrameAt(8,this.assets.getTexture("anima_04"), null, 0.33);
			machine_mc.addFrameAt(9,this.assets.getTexture("anima_03"), null, 0.33);
			machine_mc.addFrameAt(10,this.assets.getTexture("anima_02"), null, 0.33);
			machine_mc.addFrameAt(11,this.assets.getTexture("anima_01"), null, 0.1);
			machine_mc.addFrameAt(12,this.assets.getTexture("anima_00"), null, 0.1);
			machine_mc.addFrameAt(13,this.assets.getTexture("anima_01"), null, 0.1);
			machine_mc.addFrameAt(14,this.assets.getTexture("anima_00"), null, 0.1);
			machine_mc.addFrameAt(15,this.assets.getTexture("anima_01"), null, 0.33);
			machine_mc.addFrameAt(16,this.assets.getTexture("anima_02"), null, 0.33);
			machine_mc.addFrameAt(17,this.assets.getTexture("anima_03"), null, 0.33);
			machine_mc.addFrameAt(18,this.assets.getTexture("anima_04"), null, 0.33);
			machine_mc.addFrameAt(19,this.assets.getTexture("anima_05"), null, 0.1);
			machine_mc.addFrameAt(20,this.assets.getTexture("anima_04"), null, 0.1);
			machine_mc.addFrameAt(21,this.assets.getTexture("anima_05"), null, 0.1);
			machine_mc.addFrameAt(22,this.assets.getTexture("anima_04"), null, 0.33);
			machine_mc.addFrameAt(23,this.assets.getTexture("anima_03"), null, 0.33);
			machine_mc.addFrameAt(24,this.assets.getTexture("anima_02"), null, 0.33);
			machine_mc.addFrameAt(25,this.assets.getTexture("anima_01"), null, 0.1);
			machine_mc.addFrameAt(26,this.assets.getTexture("anima_00"), null, 0.1);
			machine_mc.addFrameAt(27,this.assets.getTexture("anima_01"), null, 0.1);
			machine_mc.addFrameAt(28,this.assets.getTexture("anima_00"), null, 0.1);
			machine_mc.addFrameAt(29,this.assets.getTexture("anima_01"), null, 0.1);
			machine_mc.addFrameAt(30,this.assets.getTexture("anima_00"), null, 0.1);
			machine_mc.addFrameAt(31,this.assets.getTexture("anima_00"), null, 0.33);
			machine_mc.addFrameAt(32,this.assets.getTexture("anima_01"), null, 0.33);
			machine_mc.addFrameAt(33,this.assets.getTexture("anima_00"), null, 0.33);
			
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['MachineOn'] == 'Yes'){
					screen.alpha = 1;
					MachineOn = true;
				}else{
					screen.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Slide'] == 'Attached'){
					slide.alpha = 1;
				}else{
					slide.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Hose'] == 'Attached'){
					hose.alpha = 1;
				}else{
					hose.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "PickedUp"){
					DiscState = false;
					DiscAttached = false;
					disk.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Out"){
					DiscState = true;
					DiscAttached = true;
					disk.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Attached"){
					DiscState = false;
					DiscAttached = true;
					disk.alpha = 0;
				}else{
					DiscState = false;
					DiscAttached = false;
					disk.alpha = 0;	
				}
				
			}else{
				slide.alpha = 0;
				hose.alpha = 0;
				disk.alpha = 0;
				screen.alpha = 0;	

			}
			
				
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					stone.alpha = 1;
				}else{
					stone.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					goo.alpha = 1;
				}else{
					goo.alpha = 0;
				}
			}else{
				goo.alpha = 0;
				
				stone.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine['Solved'] == 'Yes'){
					MachineSolved = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Crystal'] == 'Printed'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != 'undefined'){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Crystal'] == 'PickedUp'){
									crystal.alpha = 0;
								}else{
									crystal.alpha = 1;
								}
							}else{
								crystal.alpha = 0;
							}
						}else{
							crystal.alpha = 0;
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
							}
							SaveArray['Crystal'] = "Printed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);	
							
							delayedCall = new DelayedCall(PrintCrystal,2.5);
							Starling.juggler.add(delayedCall);	
						}
					}else{
						crystal.alpha = 0;
					}
				}else{
					crystal.alpha = 0;
				}
				
			}else{
				crystal.alpha = 0;
			}
			
			
			this.addChildAt(slide,1);	
			this.addChildAt(hose,2);
			this.addChildAt(screen,3);						
			this.addChildAt(disk,4);			
			this.addChildAt(goo,5);		
			this.addChildAt(stone,6);
				
			this.addChildAt(crystal,7);			
			this.addChildAt(machine_mc,8);	
			
		
			
			CreateHitPrinter();
			CreateHitMachine();
			CreateHitScreen();
			CreateHitMicroScope();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crickets_01",((stage.getChildAt(0) as Object).MusicObj.globalVol),1.0);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['SlimeQue'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Slimed'] == 'Yes'){
						
							if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
								SaveArray['SlimeQue'] = 'Yes';
								
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);
								
								Starling.juggler.delayCall(function():void{
									(stage.getChildAt(0) as Object).MusicObj.LoadJamLoop(true,4);
									
								},1.5);
							}
						}
					}
				
				}
			}else{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Slimed'] == 'Yes'){
						
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							
							SaveArray['SlimeQue'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);
							
							Starling.juggler.delayCall(function():void{
								//	Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadJamLoop(true,4);
								//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
							},1.5);
						}
					}
				}
				
			}
			
		//	Starling.juggler.delayCall(function():void{
		//		PrintCrystal();
		//	},3);
			
		//	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
		//		(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hammer,
		//		'item_Hammer',
		//		'inven_hammer_sm'
		//	);
		}
		
		private function PrintCrystal():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Machine();
			machine_mc.addEventListener(Event.COMPLETE, FadeInCrystal);
			machine_mc.addEventListener(Event.ENTER_FRAME, MachineSounds);
			machine_mc.alpha = 1;
			machine_mc.play();
			Starling.juggler.add(machine_mc);	
		}
		private function MachineSounds():void{
			if(machine_mc.currentFrame == 6 || machine_mc.currentFrame == 7){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
			}else if(machine_mc.currentFrame >= 11 && machine_mc.currentFrame <= 15){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
				if(machine_mc.currentFrame == 13){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Machine();
				}
			}else if(machine_mc.currentFrame >= 19 && machine_mc.currentFrame <= 22){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
				if(machine_mc.currentFrame == 13){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Machine();
				}
			}else if(machine_mc.currentFrame >= 28 && machine_mc.currentFrame <= 30){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
			}else if(machine_mc.currentFrame == 31){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_AirRelease();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Machine();
			}
		}
		
		private function FadeInCrystal():void{
			
			machine_mc.stop();
			machine_mc.alpha = 0;
			machine_mc.removeEventListener(Event.ENTER_FRAME, MachineSounds);
			machine_mc.removeEventListener(Event.COMPLETE, FadeInCrystal);
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
			CrystalTween = new Tween(crystal, 3, Transitions.LINEAR);
			CrystalTween.fadeTo(1);
			
			CrystalTween.onComplete = function():void{
				
				
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
					
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
						
						Starling.juggler.delayCall(function():void{
							CrystalTween = null;
							(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,3);
							//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
						},1.5);
					}
					Animating = false;
					
					
				},1.0);
			}
			Starling.juggler.add(CrystalTween);
		}
		
		private function CreateHitPrinter():void{
			hit_printer = new Shape();
			hit_printer.touchable = false;
			hit_printer.graphics.beginFill(0xff0000);
			
			hit_printer.graphics.lineTo(490,39);							
			hit_printer.graphics.lineTo(668,41);							
			hit_printer.graphics.lineTo(684,103);							
			hit_printer.graphics.lineTo(769,129);							
			hit_printer.graphics.lineTo(723,337);							
			hit_printer.graphics.lineTo(462,294);							
			
			hit_printer.graphics.endFill(false);
			
			hit_printer.alpha = 0.0;
			
			hit_printer.graphics.precisionHitTest = true;	
			this.addChild(hit_printer);
		}
		
		private function CreateHitMachine():void{
			hit_machine = new Shape();
			hit_machine.touchable = false;
			hit_machine.graphics.beginFill(0x0000ff);
			
			hit_machine.graphics.lineTo(255,194);							
			hit_machine.graphics.lineTo(421,192);							
			hit_machine.graphics.lineTo(421,351);							
			hit_machine.graphics.lineTo(255,353);							
			
			hit_machine.graphics.endFill(false);
			
			hit_machine.alpha = 0.0;
			
			hit_machine.graphics.precisionHitTest = true;	
			this.addChild(hit_machine);
		}
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(250,16);							
			hit_screen.graphics.lineTo(413,16);							
			hit_screen.graphics.lineTo(413,162);							
			hit_screen.graphics.lineTo(250,162);							

			hit_screen.graphics.endFill(false);
			
			hit_screen.alpha = 0.0;
			
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
		}
		
		
		private function CreateHitMicroScope():void{
			hit_microscope = new Shape();
			hit_microscope.touchable = false;
			hit_microscope.graphics.beginFill(0xff0000);
			
			hit_microscope.graphics.lineTo(15,132);							
			hit_microscope.graphics.lineTo(71,69);							
			hit_microscope.graphics.lineTo(161,83);							
			hit_microscope.graphics.lineTo(199,296);							
			hit_microscope.graphics.lineTo(93,330);							
			hit_microscope.graphics.lineTo(8,302);							
			
			hit_microscope.graphics.endFill(false);
			
			hit_microscope.alpha = 0.0;
			
			hit_microscope.graphics.precisionHitTest = true;	
			this.addChild(hit_microscope);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((Lab as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.LabObj,true
							);
						}else if(hit_printer.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((LabPrinter as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.LabPrinterObj,true
							);
							
						}else if(hit_microscope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MircoscopeHandler();
							
						}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ScreenHandler();
							
						}else if(hit_machine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MachineHandler();
							
						}
					}
				}
			}
		}
		
		private function MachineHandler():void{
			if(MachineSolved === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Hose)
				{
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hose is very dirty. I should try to sterilize if before attaching it to the machine.");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_HoseClean)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					hose.alpha = 1;
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_HoseClean,
							"item_HoseClean"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
					}
					SaveArray['Hose'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);	
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've connected the hose.");
					
	
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Floppy)
				{
					if(ThereIsPower === true){
						if(MachineOn === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
							DiscState = false;
							DiscAttached = true;
							disk.alpha = 0;
							
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
								.InventoryObj.removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Floppy,
									"item_Floppy"
								);
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
							}
							SaveArray['Disk'] = "Attached";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);	
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've inserted the floppy disk.");
							
						}else{
							TurnOnMachine();
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to get power to the machine before I try to insert the floppy disk.");
	
					}
				}else{
					if(ThereIsPower === true){
						if(MachineOn === true){
							if(DiscAttached === true){
								if(DiscState === false){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
									DiscState = true;
									disk.alpha = 1;
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
									}
									SaveArray['Disk'] = "Out";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);	
								}else{
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
									DiscState = false;
									DiscAttached = false;
									disk.alpha = 0;
									
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
									}
									SaveArray['Disk'] = "PickedUp";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);							
									
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
										(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Floppy,
										'item_Floppy',
										'inven_floppy_sm'
									);
								}
							}else{
								if(PhraseCounter == 0){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The equipment is humming and beeping quietly.");
									PhraseCounter = 1;
								}else{
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Multiple pieces of locally networked computer equipment.");
								}
							
							}
						}else{
							TurnOnMachine();
						}
					}else{
						if(PhraseCounter == 0){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These machines don't have any power, but they look very sophisticated.");
							PhraseCounter = 1;
						}else{
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are multiple different devices networked together.");
							
						}
						
					}
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I'm done with these devices...");
			}

		}
		
		private function ScreenHandler():void{
			if(ThereIsPower === true){
				if(MachineOn === true){
					FadeOut((LabMachine as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.LabMachineObj,true
					);
				}else{
					TurnOnMachine();
	
					
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The device doesn't have any power. I can't turn it on.");
			}
			
		}
		
		private function TurnOnMachine():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BootUp();
			Animating = true;
			MachineOn = true;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
			}
			SaveArray["MachineOn"] = "Yes";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);
			
			
			screenTween = new Tween(screen, 2, Transitions.LINEAR);
			screenTween.fadeTo(1)
			screenTween.onComplete = function():void{
				Animating = false;
				
				screenTween = null;
			}
			Starling.juggler.add(screenTween);
		}
		
		
		private function MircoscopeHandler():void{
//			ThereIsPower
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Slide)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				slide.alpha = 1;
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Slide,
						"item_Slide"
					);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
				}
				SaveArray["Slide"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArray);
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Slime)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That's a good idea, but I need to place the slime on a glass slide before I can look at it through the microscope.");

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Glass)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmmm... I could use these glass shards to make a slide. I'll have to combine them with something first though...");

			}else{
				if(ThereIsPower === true){
					FadeOut((LabMicroscope as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.LabMicroscopeObj,false
					);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The microscope is electronic. It won't work without power flowing to it.");
				}
			}
			
		}
		
		
		private function FadeOut(loadClass:Class,loadObj:Object,Fade:Boolean = false):void{
			trace("FADE OUT");
			this.removeEventListener(TouchEvent.TOUCH,TouchHandler);
			
			//goBackButton.touchable = false;
			this.touchable = false;
			if(Fade === false){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,0.5,this.Exit);
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadScene(
						loadClass, 
						loadObj
					);		
			}else{
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadSceneAlphaFade(
						loadClass, 
						loadObj,
						this.Exit
					);				
			}
			
		}
		
		public function Exit(blackOut:Boolean = false):void{
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("labEquipment_bg",true);
			this.assets.removeTexture("LabEquipment_Sprite",true);
			this.assets.removeTextureAtlas("LabEquipment_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labEquipment_01");
			(stage.getChildAt(0) as Object).falseAsset("labEquipment_02");
			(stage.getChildAt(0) as Object).falseAsset("labEquipment_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}