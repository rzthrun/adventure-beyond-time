package screens.ingamescreens
{

	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class LabDesk extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var mortar:Image;
		private var mix:Image;
		private var screen:Image;
		private var cabinet:Image;
		private var alcohol:Image;
		private var disk:Image;
		private var solder:Image;
		
		private var hit_detail:Shape;
		private var hit_computer:Shape;
		private var hit_screen:Shape;
		private var hit_cabinet:Shape;
		private var hit_alcohol:Shape;
		
		private var hit_drawing:Shape;
		private var hit_flask:Shape;
		private var hit_roots:Shape;
		private var hit_keyboard:Shape;
		
		private var CabinetOpen:Boolean = false;
		private var Animating:Boolean = false;
		
		private var DiscAttached:Boolean = false;
		private var DiscState:Boolean = false;
		//false = in, true = out
		private var ThereIsPower:Boolean = false;
		private var ComputerOn:Boolean = false;
		
		private var ScreenTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function LabDesk(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labDesk_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDesk/labDesk_bg.jpg'));
				game.TrackAssets('labDesk_01');
			}
			if(game.CheckAsset('labDesk_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDesk/LabDesk_Sprite.png'));
				game.TrackAssets('labDesk_02');
			}
			if(game.CheckAsset('labDesk_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDesk/LabDesk_Sprite.xml'));
				game.TrackAssets('labDesk_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabDesk","LabDeskObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('labDesk_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			solder = new Image(this.assets.getTexture('detail_solder'));
			solder.touchable = false;
			solder.x = 624;
			solder.y = 346;
			
			mortar = new Image(this.assets.getTexture('detail_mortar'));
			mortar.touchable = false;
			mortar.x = 539;
			mortar.y = 344;
			
			
			mix = new Image(this.assets.getTexture('detail_m_mix'));
			mix.touchable = false;
			mix.x = 552;
			mix.y = 332;
			
			
			cabinet = new Image(this.assets.getTexture('cabinet_open'));
			cabinet.touchable = false;
			cabinet.x = 435;
			cabinet.y = 7;
			
			
			alcohol = new Image(this.assets.getTexture('bottle_cover'));
			alcohol.touchable = false;
			alcohol.x = 514;
			alcohol.y = 100;
	
			screen = new Image(this.assets.getTexture('screen_blue'));
			screen.touchable = false;
			screen.x = 167;
			screen.y = 165;
			
			disk = new Image(this.assets.getTexture('disk'));
			disk.touchable = false;
			disk.x = 20;
			disk.y = 209;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SolarPanels'] == 'Attached'){
					ThereIsPower = true;
					trace("THERE IS POWER");
				}
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Solder"] == "PickedUp"){
					solder.alpha = 0;
				}else{
					solder.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					mortar.alpha = 0;
					mix.alpha = 0;
				}else{
					mortar.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == undefined){
						mix.alpha = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'flower'){
						mix.texture = this.assets.getTexture('detail_m_flowers');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'mushroom'){
						mix.texture = this.assets.getTexture('detail_m_mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water'){
						mix.texture = this.assets.getTexture('detail_m_water');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_flower'){						
						mix.texture = this.assets.getTexture('detail_m_water_flowers');
						mix.alpha = 1;					
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_mushroom'){
						mix.texture = this.assets.getTexture('detail_m_water_mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_flower_mushroom'){
						mix.texture = this.assets.getTexture('detail_m_water_flowers_mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'flower_mushroom'){
						mix.texture = this.assets.getTexture('detail_m_flowers_mushroom');
						mix.alpha = 1;	
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'mixed'){
						mix.texture = this.assets.getTexture('detail_m_mix');
						mix.alpha = 1;
					}
					
				}
			}else{
				mix.alpha = 0;
				mortar.alpha = 1;
				solder.alpha = 1;
			}

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk['Cabinet'] == 'Open'){
					CabinetOpen = true;	
					cabinet.alpha = 1;
					alcohol.texture = this.assets.getTexture('bottle_open');
					CreateHitAlcohol();
				}else{
					CabinetOpen = false;
					cabinet.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Alcohol"] == "PickedUp"){
					alcohol.alpha = 0;
				}else{
					alcohol.alpha = 1;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Computer"] == "On"){
					ComputerOn = true;
					screen.texture = this.assets.getTexture('screen_ubuntu');
					screen.alpha = 1;
				}else{
					screen.alpha = 0;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Disk"] == "PickedUp"){
					DiscState = false;
					DiscAttached = false;
					disk.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Disk"] == "Out"){
					DiscState = true;
					DiscAttached = true;
					disk.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Disk"] == "Attached"){
					DiscState = false;
					DiscAttached = true;
					disk.alpha = 0;
				}else{
					DiscState = false;
					DiscAttached = false;
					disk.alpha = 0;	
				}

			}else{
				cabinet.alpha = 0;
				alcohol.alpha = 1;
				disk.alpha = 0;
				screen.alpha = 0;
			}
			
			
		
			
			
			this.addChildAt(solder,1);
			this.addChildAt(mortar,2);
			this.addChildAt(mix,3);			
			this.addChildAt(cabinet,4);			
			this.addChildAt(alcohol,5);			
			this.addChildAt(screen,6);
			this.addChildAt(disk,7);
			
			/*private var mortar:Image;
			private var mix:Image;
			private var screen:Image;
			private var cabinet:Image;
			private var alcohol:Image;
			*/
			//FadeOutOcean(1);
			CreateHitDrawing();
			CreateHitRoots();
			CreateHitFlask();
			CreateHitKeyBoard();
			CreateCabinetHit(CabinetOpen);
			CreateHitDesk();
			CreateHitScreen();
			CreateHitComputer();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crickets_01",((stage.getChildAt(0) as Object).MusicObj.globalVol),1.0);
			
			
		}
		//hit_keyboard
		private function CreateHitKeyBoard():void{
			hit_keyboard = new Shape();
			hit_keyboard.touchable = false;
			hit_keyboard.graphics.beginFill(0xff0000);
			
			hit_keyboard.graphics.lineTo(197,362);				
			hit_keyboard.graphics.lineTo(373,359);				
			hit_keyboard.graphics.lineTo(373,406);				
			hit_keyboard.graphics.lineTo(186,412);				
		
			hit_keyboard.graphics.endFill(false);
			
			hit_keyboard.alpha = 0.0;
			
			hit_keyboard.graphics.precisionHitTest = true;	
			this.addChild(hit_keyboard);
		}
		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(232,142);				
			hit_roots.graphics.lineTo(263,0);				
			hit_roots.graphics.lineTo(368,0);				
			hit_roots.graphics.lineTo(386,151);				
			
			hit_roots.graphics.endFill(false);
			
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitFlask():void{
			hit_flask = new Shape();
			hit_flask.touchable = false;
			hit_flask.graphics.beginFill(0xff0000);
			
			hit_flask.graphics.lineTo(458,221);				
			hit_flask.graphics.lineTo(650,164);				
			hit_flask.graphics.lineTo(692,165);				
			hit_flask.graphics.lineTo(668,332);				
			hit_flask.graphics.lineTo(448,323);				
			
			hit_flask.graphics.endFill(false);
			
			hit_flask.alpha = 0.0;
			
			hit_flask.graphics.precisionHitTest = true;	
			this.addChild(hit_flask);
		}
		
		
		private function CreateHitDrawing():void{
			hit_drawing = new Shape();
			hit_drawing.touchable = false;
			hit_drawing.graphics.beginFill(0xff0000);
			
			hit_drawing.graphics.lineTo(116,0);				
			hit_drawing.graphics.lineTo(228,7);				
			hit_drawing.graphics.lineTo(235,126);				
			hit_drawing.graphics.lineTo(126,124);				
						
			
			hit_drawing.graphics.endFill(false);
			
			hit_drawing.alpha = 0.0;
			
			hit_drawing.graphics.precisionHitTest = true;	
			this.addChild(hit_drawing);
		}
		
		private function CreateHitDesk():void{
			hit_detail = new Shape();
			hit_detail.touchable = false;
			hit_detail.graphics.beginFill(0xff0000);
			
			hit_detail.graphics.lineTo(376,350);				
			hit_detail.graphics.lineTo(454,336);				
			hit_detail.graphics.lineTo(570,341);				
			hit_detail.graphics.lineTo(706,351);				
			hit_detail.graphics.lineTo(770,396);				
			hit_detail.graphics.lineTo(601,507);				
			hit_detail.graphics.lineTo(406,456);				

			hit_detail.graphics.endFill(false);
			
			hit_detail.alpha = 0.0;
			
			hit_detail.graphics.precisionHitTest = true;	
			this.addChild(hit_detail);
		}
		
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(170,177);				
			hit_screen.graphics.lineTo(423,170);				
			hit_screen.graphics.lineTo(425,314);				
			hit_screen.graphics.lineTo(180,328);				

			hit_screen.graphics.endFill(false);
			
			hit_screen.alpha = 0.0;
			
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
		}
		
		private function CreateHitComputer():void{
			hit_computer = new Shape();
			hit_computer.touchable = false;
			hit_computer.graphics.beginFill(0xff0000);
			
			hit_computer.graphics.lineTo(10,145);				
			hit_computer.graphics.lineTo(108,147);				
			hit_computer.graphics.lineTo(125,361);				
			hit_computer.graphics.lineTo(30,362);				
	
			hit_computer.graphics.endFill(false);
			
			hit_computer.alpha = 0.0;
			
			hit_computer.graphics.precisionHitTest = true;	
			this.addChild(hit_computer);
		}
		
		private function CreateHitAlcohol():void{
			hit_alcohol = new Shape();
			hit_alcohol.touchable = false;
			hit_alcohol.graphics.beginFill(0xff0000);
	
			hit_alcohol.graphics.lineTo(472,27);				
			hit_alcohol.graphics.lineTo(588,30);				
			hit_alcohol.graphics.lineTo(578,160);				
			hit_alcohol.graphics.lineTo(469,160);				
			

			hit_alcohol.graphics.endFill(false);
			
			hit_alcohol.alpha = 0.0;
			
			hit_alcohol.graphics.precisionHitTest = true;	
			this.addChild(hit_alcohol);
		}

		
		private function CreateCabinetHit(open:Boolean = false):void{
			hit_cabinet = new Shape();
			
			if(open === false){
				
				hit_cabinet.x = 0;
				hit_cabinet.y = 0;
				hit_cabinet.graphics.beginFill(0x0000FF);

				hit_cabinet.graphics.lineTo(452,19);
				hit_cabinet.graphics.lineTo(593,19);
				hit_cabinet.graphics.lineTo(586,165);
				hit_cabinet.graphics.lineTo(449,163);
				
				hit_cabinet.graphics.endFill(false);
				
				hit_cabinet.alpha = 0.0;
				
				hit_cabinet.graphics.precisionHitTest = true;	
			}else{
				
				hit_cabinet.x = 0;
				hit_cabinet.y = 0;
				hit_cabinet.graphics.beginFill(0x0000FF);		
				hit_cabinet.graphics.lineTo(430,3);
				hit_cabinet.graphics.lineTo(470,21);
				hit_cabinet.graphics.lineTo(468,169);
				hit_cabinet.graphics.lineTo(440,176);
				hit_cabinet.graphics.lineTo(440,154);
				hit_cabinet.graphics.lineTo(428,155);
		
				hit_cabinet.graphics.endFill(false);
				hit_cabinet.alpha = 0.0;
				
				hit_cabinet.graphics.precisionHitTest = true;				
			}
			hit_cabinet.touchable = false;
			this.addChild(hit_cabinet);
			
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
						}else if(hit_detail.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((LabDeskDetail as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.LabDeskDetailObj,true
							);
						}else if(hit_cabinet.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CabinetHandler();
						}else if(hit_computer.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ComputerHandler();
						}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ScreenHandler();
						}else if(hit_keyboard.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
							ScreenHandler();					
						}else if(hit_drawing.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The old framed drawing depicts a green lion biting a bleeding sun.");						
						}else if(hit_flask.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Various pieces of chemistry glassware and an old chalice.");					
						}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The roots give off a sweet odor.");						

						}else if(CabinetOpen){
							if(hit_alcohol.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								AlcoholHandler();
							}
						}
						/*
						private var hit_drawing:Shape;
						private var hit_flask:Shape;
						private var hit_roots:Shape;
						*/
					}
				}
			}
		}
		
		
		private function ComputerHandler():void{
			if(ThereIsPower === true){
				if(ComputerOn === true){
					if(DiscAttached === true){
						if(DiscState === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
							DiscState = true;
							disk.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
							}
							SaveArray['Disk'] = "Out";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);	
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
							DiscState = false;
							DiscAttached = false;
							disk.alpha = 0;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
							}
							SaveArray['Disk'] = "PickedUp";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);							
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Floppy,
								'item_Floppy',
								'inven_floppy_sm'
							);
							
						}
					}else{
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Floppy)
						{	
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

							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
							}
							SaveArray['Disk'] = "Attached";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);	
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've inserted the floppy disk.");
							
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer has a floppy disk drive.");
						}
					}
				}else{
					//TURN COMPUTER ON
					TurnOnComputer();
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Floppy)
				{	
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer doesn't have any power. I will need to turn it on before inserting the floppy disk.");
				}else{				
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer doesn't have any power.");
				}
			}
		}
		
		private function TurnOnComputer():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BootUp();
			Animating = true;
			ComputerOn = true;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
			}
			SaveArray['Computer'] = "On";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);	
			
			
			ScreenTween = new Tween(screen, 4, Transitions.LINEAR);
			ScreenTween.fadeTo(1);
			ScreenTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
				ChangeScreen();
				Animating = false;
				ScreenTween = null;
			}
			Starling.juggler.add(ScreenTween);
		}
		
		private function ChangeScreen():void{
			screen.texture = this.assets.getTexture('screen_ubuntu');
		}
		
		private function ScreenHandler():void{
			if(ThereIsPower === true){
				if(ComputerOn === true){
					FadeOut((LabComputer as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.LabComputerObj,true
					);
				}else{
					TurnOnComputer();
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer doesn't have any power.");
			}
		}
		
		private function AlcoholHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Alcohol"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cabinet is filled with many medicines and first aid items.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					alcohol.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
					}
					SaveArray['Alcohol'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alcohol,
						'item_Alcohol',
						'inven_alcohol_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				alcohol.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
				}
				SaveArray['Alcohol'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alcohol,
					'item_Alcohol',
					'inven_alcohol_sm'
				);
				
			}
		}
		
		private function CabinetHandler():void{
			if(CabinetOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				CabinetOpen = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;					
				}
				
				SaveArray['Cabinet'] = 'Open';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);
				
				hit_cabinet.graphics.clear();
				CreateCabinetHit(true);
				CreateHitAlcohol();
				
				alcohol.texture = this.assets.getTexture('bottle_open');
				cabinet.alpha = 1;
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				CabinetOpen = false;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;					
				}
				
				SaveArray['Cabinet'] = 'Closed';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArray);
				
				this.removeChild(hit_alcohol);
				hit_cabinet.graphics.clear();
				CreateCabinetHit(false);
				
				
				alcohol.texture = this.assets.getTexture('bottle_cover');
				cabinet.alpha = 0;
				
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
			
			
			this.assets.removeTexture("labDesk_bg",true);
			this.assets.removeTexture("LabDesk_Sprite",true);
			this.assets.removeTextureAtlas("LabDesk_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labDesk_01");
			(stage.getChildAt(0) as Object).falseAsset("labDesk_02");
			(stage.getChildAt(0) as Object).falseAsset("labDesk_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				//		(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}