package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class CoastCaveDoor extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var ComboArray:Array = new Array();
		
		private var bg:Image;
		private var comboLock:Image;
		private var hit_comboLock:Shape;
		
		private var comboAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		public function CoastCaveDoor(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastCaveDoor_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveDoor/coastCaveDoor_bg.jpg'));
				game.TrackAssets('coastCaveDoor_01');
			}
			if(game.CheckAsset('coastCaveDoor_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveDoor/CoastCaveDoor_Sprite.png'));
				game.TrackAssets('coastCaveDoor_02');
			}
			if(game.CheckAsset('coastCaveDoor_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveDoor/CoastCaveDoor_Sprite.xml'));
				game.TrackAssets('coastCaveDoor_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCaveDoor","CoastCaveDoorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastCaveDoor_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			comboLock = new Image(this.assets.getTexture('combo_missingOne'));
			comboLock.touchable = false;
			comboLock.x = 394;
			comboLock.y = 148;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor['ComboLock'] == 'Attached'){
					comboAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Third'] == 'Attached'){
							comboLock.texture = this.assets.getTexture('combo');
							comboLock.alpha = 1;
						}else{
							comboLock.alpha = 1;
						}
					}else{
						comboLock.alpha = 1;
					}
				}else{
					comboLock.alpha = 0;
				}
			}else{
				comboLock.alpha = 0;
			}
			
			this.addChildAt(comboLock,1);
			
			CreateComboHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			}
		}
		//hit_comboLock
		private function CreateComboHit():void{
			hit_comboLock = new Shape();
			hit_comboLock.touchable = false;
			hit_comboLock.graphics.beginFill(0xff0000);
			
			hit_comboLock.graphics.lineTo(393,121);	
			hit_comboLock.graphics.lineTo(563,148);	
			hit_comboLock.graphics.lineTo(545,248);	
			hit_comboLock.graphics.lineTo(358,221);	

			hit_comboLock.graphics.endFill(false);
			hit_comboLock.alpha = 0.0;
			
			hit_comboLock.graphics.precisionHitTest = true;	
			this.addChild(hit_comboLock);
		}
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastCave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveObj,true
						);
					}else if(hit_comboLock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						ComboHandler();
					}
					//hit_comboLock
				}
			}
		}
		private function ComboHandler():void{
			if(comboAttached === true){
				FadeOut((CoastCaveCombo as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveComboObj,true
				);
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PirateTubeEmpty)
				{
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PirateTubeEmpty,
							"item_PirateTubeEmpty"
						);
					comboAttached = true;
					comboLock.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor;			
					}
					SaveArray['ComboLock'] = 'Attached';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveDoor',SaveArray);
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PirateTube)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PirateTube,
							"item_PirateTube"
						);
					comboAttached = true;
					comboLock.texture = this.assets.getTexture('combo');
					comboLock.alpha = 1;					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor;			
					}
					SaveArray['ComboLock'] = 'Attached';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveDoor',SaveArray);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
						ComboArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo;
					}
					ComboArray['Third'] = 'Attached';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveCombo',ComboArray);
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a cylindrical slot built into the door.");
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
			
			
			this.assets.removeTexture("coastCaveDoor_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("coastCaveDoor_01");
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