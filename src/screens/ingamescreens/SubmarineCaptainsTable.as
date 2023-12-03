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
	
	public class SubmarineCaptainsTable extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var floppy:Image;
		private var screen:Image;
		
		private var hit_screen:Shape;
		private var hit_floppy:Shape;
		
		private var hit_intercom:Shape;
		private var hit_tank:Shape;
		private var hit_keboard:Shape;
		private var hit_box:Shape;
		
		private var Animating:Boolean = false;
		private var ScreenOn:Boolean = false;
		private var ScreenTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function SubmarineCaptainsTable(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineCaptainsTable_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsTable/submarineCaptainsTable_bg.jpg'));
				game.TrackAssets('submarineCaptainsTable_01');
			}
			if(game.CheckAsset('submarineCaptainsTable_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsTable/SubmarineCaptainsTable_Sprite.png'));
				game.TrackAssets('submarineCaptainsTable_02');
			}
			if(game.CheckAsset('submarineCaptainsTable_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsTable/SubmarineCaptainsTable_Sprite.xml'));
				game.TrackAssets('submarineCaptainsTable_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineCaptainsTable","SubmarineCaptainsTableObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineCaptainsTable_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			screen = new Image(this.assets.getTexture('screen'));
			screen.touchable = true;
			screen.x = 391;
			screen.y = 52;
		
			floppy = new Image(this.assets.getTexture('floppy'));
			floppy.touchable = true;
			floppy.x = 275;
			floppy.y = 336;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['Floppy'] == 'PickedUp'){
					floppy.alpha = 0;
				}else{
					floppy.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['ScreenOn'] == 'yes'){
					ScreenOn = true;
					screen.alpha = 1;
				}else{
					screen.alpha = 0;
				}
			}else{
				
				floppy.alpha = 1;
				screen.alpha = 0;
				
			}
		
			
			this.addChildAt(screen,1);
			this.addChildAt(floppy,2);
			CreateHitIntercom();
			CreateHitTank();
			CreateHitBox();
			CreateHitKeyBoard();
			CreateHitScreen();
			CreateHitFloppy();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,2);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsTable',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsTable',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,1);
					},0.5);
				}
			}
			
		}

		private function CreateHitKeyBoard():void{
			hit_keboard = new Shape();
			hit_keboard.touchable = false;
			hit_keboard.graphics.beginFill(0x00ff00);
			
			hit_keboard.graphics.lineTo(378,318);	
			hit_keboard.graphics.lineTo(420,253);	
			hit_keboard.graphics.lineTo(603,264);	
			hit_keboard.graphics.lineTo(688,328);	
			hit_keboard.graphics.lineTo(701,393);	
			hit_keboard.graphics.lineTo(461,442);	
			
			hit_keboard.graphics.endFill(false);
			hit_keboard.alpha = 0.0;
			hit_keboard.graphics.precisionHitTest = true;	
			this.addChild(hit_keboard);
			
		}
		
		private function CreateHitBox():void{
			hit_box = new Shape();
			hit_box.touchable = false;
			hit_box.graphics.beginFill(0x00ff00);
			
			hit_box.graphics.lineTo(176,175);	
			hit_box.graphics.lineTo(351,197);	
			hit_box.graphics.lineTo(338,307);	
			hit_box.graphics.lineTo(168,267);	
			
			
			hit_box.graphics.endFill(false);
			hit_box.alpha = 0.0;
			hit_box.graphics.precisionHitTest = true;	
			this.addChild(hit_box);
			
		}
		
		private function CreateHitTank():void{
			hit_tank = new Shape();
			hit_tank.touchable = false;
			hit_tank.graphics.beginFill(0x00ff00);
			
			hit_tank.graphics.lineTo(61,309);	
			hit_tank.graphics.lineTo(88,277);	
			hit_tank.graphics.lineTo(229,258);	
			hit_tank.graphics.lineTo(278,298);	
			hit_tank.graphics.lineTo(282,389);	
			hit_tank.graphics.lineTo(156,408);	
			
			hit_tank.graphics.endFill(false);
			hit_tank.alpha = 0.0;
			hit_tank.graphics.precisionHitTest = true;	
			this.addChild(hit_tank);
			
		}
		
		private function CreateHitIntercom():void{
			hit_intercom = new Shape();
			hit_intercom.touchable = false;
			hit_intercom.graphics.beginFill(0x00ff00);
			
			hit_intercom.graphics.lineTo(116,0);	
			hit_intercom.graphics.lineTo(325,19);	
			hit_intercom.graphics.lineTo(308,150);	
			hit_intercom.graphics.lineTo(108,171);	
			
			
			hit_intercom.graphics.endFill(false);
			hit_intercom.alpha = 0.0;
			hit_intercom.graphics.precisionHitTest = true;	
			this.addChild(hit_intercom);
			
		}
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0x00ff00);
			
			hit_screen.graphics.lineTo(397,32);	
			hit_screen.graphics.lineTo(648,65);	
			hit_screen.graphics.lineTo(688,122);	
			hit_screen.graphics.lineTo(660,241);	
			hit_screen.graphics.lineTo(370,199);	

			
			hit_screen.graphics.endFill(false);
			hit_screen.alpha = 0.0;
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
			
		}
		
		private function CreateHitFloppy():void{
			hit_floppy = new Shape();
			hit_floppy.touchable = false;
			hit_floppy.graphics.beginFill(0x00ff00);
			
			hit_floppy.graphics.lineTo(253,343);	
			hit_floppy.graphics.lineTo(340,325);	
			hit_floppy.graphics.lineTo(420,366);	
			hit_floppy.graphics.lineTo(336,401);	
			
			hit_floppy.graphics.endFill(false);
			hit_floppy.alpha = 0.0;
			hit_floppy.graphics.precisionHitTest = true;	
			this.addChild(hit_floppy);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineCaptains as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsObj,true
						);
					}else if(hit_floppy.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FloppyHandler();
					}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(ScreenOn === false){
							ScreenHandler();
						}else{
							FadeOut((SubmarineCaptainsComputer as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsComputerObj,true
							);
						}
					}else if(hit_tank.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A half finished scale plastic model of a tank.'");
						
					}else if(hit_box.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The box reads 'M3 Bradley.'");
						
					}else if(hit_keboard.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(ScreenOn === false){
							ScreenHandler();
						}else if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Floppy)
						{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer's external disk drive is broken.");
							
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The computer is an early type of PC.");
							
						}
					}else if(hit_intercom.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Part of the sub's old communications network.");
						
					}
					
					/*
					private var hit_intercom:Shape;
					private var hit_tank:Shape;
					private var hit_keboard:Shape;
					private var hit_box:Shape;
					*/
				}
			}
		}
		//SubmarineCaptainsComputer
		private function ScreenHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BootUp();
			Animating = true;
			ScreenOn = true;
		
			//		screens.alpha = 1;			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable;
			}
			SaveArray['ScreenOn'] = 'yes';
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsTable',SaveArray);
			
			ScreenTween = new Tween(screen, 2, Transitions.LINEAR);
			ScreenTween.fadeTo(1);
			ScreenTween.onComplete = function():void{	
				Animating = false;
				ScreenTween = null;
			}
			Starling.juggler.add(ScreenTween);
		}
		
		private function FloppyHandler():void{	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['Floppy'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					floppy.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable;
					}
					SaveArray['Floppy'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsTable',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Floppy,
						'item_Floppy',
						'inven_floppy_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				floppy.alpha = 0;
				SaveArray['Floppy'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsTable',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Floppy,
					'item_Floppy',
					'inven_floppy_sm'
				);	
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
			
			
			this.assets.removeTexture("submarineCaptainsTable_bg",true);
			this.assets.removeTexture("submarineCaptainsTable_bg",true);
			this.assets.removeTextureAtlas("SubmarineCaptainsTable_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsTable_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsTable_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsTable_03");
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