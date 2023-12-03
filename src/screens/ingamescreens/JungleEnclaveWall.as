package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class JungleEnclaveWall extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var dragonball:Image;
		private var arm:Image;
		
		private var hit_dragonball:Shape;
		private var hit_arm:Shape;
		private var hit_message:Shape;
		
		private var hit_roots:Shape;
		private var hit_shelf:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleEnclaveWall(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleEnclaveWall_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveWall/jungleEnclaveWall_bg.jpg'));
				game.TrackAssets('jungleEnclaveWall_01');
			}
			if(game.CheckAsset('jungleEnclaveWall_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveWall/jungleEnclaveWall_Sprite.png'));
				game.TrackAssets('jungleEnclaveWall_02');
			}
			if(game.CheckAsset('jungleEnclaveWall_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveWall/jungleEnclaveWall_Sprite.xml'));
				game.TrackAssets('jungleEnclaveWall_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleEnclaveWall","JungleEnclaveWallObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleEnclaveWall_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			dragonball = new Image(this.assets.getTexture('dragonball'));
			dragonball.touchable = false;
			dragonball.x = 298;
			dragonball.y = 159;
		
			
			arm = new Image(this.assets.getTexture('arms'));
			arm.touchable = false;
			arm.x = 496;
			arm.y = 131;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Dragonball'] == 'PickedUp'){
					dragonball.alpha = 0;
				}else{
					dragonball.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Arm'] == 'PickedUp'){
					arm.alpha = 0;
				}else{
					arm.alpha = 1;
				}
			}else{
				arm.alpha = 1;
				dragonball.alpha = 1;
			}
			
			
			this.addChildAt(dragonball,1);
			this.addChildAt(arm,2);	
			//FadeOutOcean(1);
			CreateHitRoots();
			CreateHitShelf()
			
			CreateHitArm();
			CreateHitDragonBall();
			CreateHitMessage();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
		}
		
		private function CreateHitShelf():void{
			hit_shelf = new Shape();
			hit_shelf.touchable = false;
			hit_shelf.graphics.beginFill(0xff0000);
			
			hit_shelf.graphics.lineTo(201,126);																																																																																																																														
			hit_shelf.graphics.lineTo(706,118);																																																																																																																														
			hit_shelf.graphics.lineTo(757,257);																																																																																																																														
			hit_shelf.graphics.lineTo(366,332);																																																																																																																														
			hit_shelf.graphics.lineTo(195,250);																																																																																																																														
			
			hit_shelf.graphics.endFill(false);
			hit_shelf.alpha = 0.0;
			
			hit_shelf.graphics.precisionHitTest = true;	
			this.addChild(hit_shelf);
		}

		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(183,0);																																																																																																																														
			hit_roots.graphics.lineTo(652,0);																																																																																																																														
			hit_roots.graphics.lineTo(619,69);																																																																																																																														
			hit_roots.graphics.lineTo(430,129);																																																																																																																														
			hit_roots.graphics.lineTo(198,32);																																																																																																																														
			
			hit_roots.graphics.endFill(false);
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitDragonBall():void{
			hit_dragonball = new Shape();
			hit_dragonball.touchable = false;
			hit_dragonball.graphics.beginFill(0xff0000);
			
			hit_dragonball.graphics.lineTo(281,200);																																																																																																																														
			hit_dragonball.graphics.lineTo(317,153);																																																																																																																														
			hit_dragonball.graphics.lineTo(363,145);																																																																																																																														
			hit_dragonball.graphics.lineTo(417,159);																																																																																																																														
			hit_dragonball.graphics.lineTo(443,215);																																																																																																																														
			hit_dragonball.graphics.lineTo(422,270);																																																																																																																														
			hit_dragonball.graphics.lineTo(386,289);																																																																																																																														
			hit_dragonball.graphics.lineTo(321,266);																																																																																																																														
			
			hit_dragonball.graphics.endFill(false);
			hit_dragonball.alpha = 0.0;
			
			hit_dragonball.graphics.precisionHitTest = true;	
			this.addChild(hit_dragonball);
		}
		
		private function CreateHitArm():void{
			hit_arm = new Shape();
			hit_arm.touchable = false;
			hit_arm.graphics.beginFill(0xff0000);
			
			hit_arm.graphics.lineTo(489,179);																																																																																																																														
			hit_arm.graphics.lineTo(643,117);																																																																																																																														
			hit_arm.graphics.lineTo(697,126);																																																																																																																														
			hit_arm.graphics.lineTo(712,164);																																																																																																																														
			hit_arm.graphics.lineTo(670,200);																																																																																																																														
			hit_arm.graphics.lineTo(480,252);																																																																																																																														
			hit_arm.graphics.lineTo(481,250);																																																																																																																														

			hit_arm.graphics.endFill(false);
			hit_arm.alpha = 0.0;
			
			hit_arm.graphics.precisionHitTest = true;	
			this.addChild(hit_arm);
		}
		
		
		private function CreateHitMessage():void{
			hit_message = new Shape();
			hit_message.touchable = false;
			hit_message.graphics.beginFill(0xff0000);
			
			hit_message.graphics.lineTo(0,0);																																																																																																																														
			hit_message.graphics.lineTo(156,0);																																																																																																																														
			hit_message.graphics.lineTo(156,138);																																																																																																																														
			hit_message.graphics.lineTo(107,164);																																																																																																																														
			hit_message.graphics.lineTo(0,156);																																																																																																																														
			
			hit_message.graphics.endFill(false);
			hit_message.alpha = 0.0;
			
			hit_message.graphics.precisionHitTest = true;	
			this.addChild(hit_message);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveObj,true
						);
					}else if(hit_message.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEnclaveMessage as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveMessageObj,true
						);	
					}else if(hit_dragonball.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						DragonBallHandler();
					}else if(hit_arm.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						ArmHandler();
					}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Thin, dangling roots.");
					}else if(hit_shelf.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock forms a natural shelf.");
					}
					
					/*
					private var hit_roots:Shape;
					private var hit_shelf:Shape;
					
					*/
				}
			}
		}
		private function DragonBallHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Dragonball'] == 'PickedUp'){
					if(hit_shelf.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock forms a natural shelf.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					dragonball.alpha = 0;
					SaveArray["Dragonball"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveWall',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallOne,
						'item_DragonBallOne',
						'inven_dragonBallOne_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				dragonball.alpha = 0;
				SaveArray["Dragonball"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveWall',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallOne,
					'item_DragonBallOne',
					'inven_dragonBallOne_sm'
				);
			}
		}
		
		private function ArmHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Arm'] == 'PickedUp'){
					if(hit_shelf.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock forms a natural shelf.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					arm.alpha = 0;
					SaveArray["Arm"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveWall',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_ArmMars,
						'item_ArmMars',
						'inven_armMars_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				arm.alpha = 0;
				SaveArray["Arm"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveWall',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_ArmMars,
					'item_ArmMars',
					'inven_armMars_sm'
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
			
			
			this.assets.removeTexture("jungleEnclaveWall_bg",true);
			this.assets.removeTexture("jungleEnclaveWall_Sprite",true);
			this.assets.removeTextureAtlas("jungleEnclaveWall_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveWall_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveWall_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveWall_03");
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