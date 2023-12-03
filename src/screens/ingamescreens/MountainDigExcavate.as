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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class MountainDigExcavate extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hominid:Image;
		private var dragonBall:Image;
		
		private var hit_dragonBall:Shape;
		private var hit_hominid:Shape
		
		private var hit_sedminet:Shape;
		private var hit_shellsOne:Shape;
		private var hit_shellsTwo:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var PhraseCounter:int = 0;
		
		private var goback:GoBackButton;		
		
		private var Animating:Boolean = false;
		
		
		public function MountainDigExcavate(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('mountainDigExcavate_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigExcavate/mountainDigExcavate_bg.jpg'));
				game.TrackAssets('mountainDigExcavate_01');
			}
			if(game.CheckAsset('mountainDigExcavate_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigExcavate/MountainDigExcavate_Sprite.atf'));
				game.TrackAssets('mountainDigExcavate_02');
			}
			if(game.CheckAsset('mountainDigExcavate_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigExcavate/MountainDigExcavate_Sprite.xml'));
				game.TrackAssets('mountainDigExcavate_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("MountainDigExcavate","MountainDigExcavateObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('mountainDigExcavate_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			hominid = new Image(this.assets.getTexture('hominid_full'));
			hominid.smoothing = TextureSmoothing.NONE;
			hominid.touchable = false;
			hominid.x = 56;
			hominid.y = 1;

			dragonBall = new Image(this.assets.getTexture('dragonball_full'));
			dragonBall.smoothing = TextureSmoothing.NONE;
			dragonBall.touchable = false;
			dragonBall.x = 410;
			dragonBall.y = 209;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					hominid.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'Opened'){
					hominid.texture = this.assets.getTexture('hominid_half')
					hominid.alpha = 1;
				}else{
					hominid.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					dragonBall.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'Opened'){
					dragonBall.texture = this.assets.getTexture('dragonball_half')
					dragonBall.alpha = 1;
				}else{
					dragonBall.alpha = 1;
				}
			}else{
				hominid.alpha = 1;
				dragonBall.alpha = 1;
			}
			
			
			this.addChildAt(hominid,1);
			this.addChildAt(dragonBall,2);
			//FadeOutOcean(1);
			CreateSedmentHit();
			CreateShellsTwoHit();
			CreateShellsOneHit();
			CreateDragonBallHit();
			CreateHomindHit()
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
			},0.5);
		}

		private function CreateShellsOneHit():void{
			hit_shellsOne = new Shape();
			hit_shellsOne.touchable = false;
			hit_shellsOne.graphics.beginFill(0xff0000);
			
			hit_shellsOne.graphics.lineTo(370,277);							
			hit_shellsOne.graphics.lineTo(608,413);							
			hit_shellsOne.graphics.lineTo(560,512);							
			hit_shellsOne.graphics.lineTo(157,512);							
		
			hit_shellsOne.graphics.endFill(false);
			
			hit_shellsOne.alpha = 0.0;
			
			hit_shellsOne.graphics.precisionHitTest = true;	
			this.addChild(hit_shellsOne);
		}
		
		
		private function CreateShellsTwoHit():void{
			hit_shellsTwo = new Shape();
			hit_shellsTwo.touchable = false;
			hit_shellsTwo.graphics.beginFill(0xff0000);
			
			hit_shellsTwo.graphics.lineTo(370,112);							
			hit_shellsTwo.graphics.lineTo(582,52);							
			hit_shellsTwo.graphics.lineTo(750,225);							
			hit_shellsTwo.graphics.lineTo(636,290);							
			hit_shellsTwo.graphics.lineTo(445,232);							
			
			hit_shellsTwo.graphics.endFill(false);
			
			hit_shellsTwo.alpha = 0.0;
			
			hit_shellsTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_shellsTwo);
		}
		
		private function CreateSedmentHit():void{
			hit_sedminet = new Shape();
			hit_sedminet.touchable = false;
			hit_sedminet.graphics.beginFill(0xff0000);
			
			hit_sedminet.graphics.lineTo(9,3);							
			hit_sedminet.graphics.lineTo(623,7);							
			hit_sedminet.graphics.lineTo(795,160);							
			hit_sedminet.graphics.lineTo(594,508);							
			hit_sedminet.graphics.lineTo(99,502);							
		
			hit_sedminet.graphics.endFill(false);
			
			hit_sedminet.alpha = 0.0;
			
			hit_sedminet.graphics.precisionHitTest = true;	
			this.addChild(hit_sedminet);
		}
		
		
		private function CreateHomindHit():void{
			hit_hominid = new Shape();
			hit_hominid.touchable = false;
			hit_hominid.graphics.beginFill(0xff0000);
			
			hit_hominid.graphics.lineTo(97,42);							
			hit_hominid.graphics.lineTo(186,17);							
			hit_hominid.graphics.lineTo(294,76);							
			hit_hominid.graphics.lineTo(293,234);							
			hit_hominid.graphics.lineTo(225,280);							
			hit_hominid.graphics.lineTo(138,275);							
			hit_hominid.graphics.lineTo(112,227);							
			
			hit_hominid.graphics.endFill(false);
			
			hit_hominid.alpha = 0.0;
			
			hit_hominid.graphics.precisionHitTest = true;	
			this.addChild(hit_hominid);
		}
		
		
		private function CreateDragonBallHit():void{
			hit_dragonBall = new Shape();
			hit_dragonBall.touchable = false;
			hit_dragonBall.graphics.beginFill(0xff0000);
			
			hit_dragonBall.graphics.lineTo(395,327);				
			hit_dragonBall.graphics.lineTo(466,220);				
			hit_dragonBall.graphics.lineTo(568,220);				
			hit_dragonBall.graphics.lineTo(636,314);				
			hit_dragonBall.graphics.lineTo(590,428);				
			hit_dragonBall.graphics.lineTo(458,440);				

			hit_dragonBall.graphics.endFill(false);
			
			hit_dragonBall.alpha = 0.0;
			
			hit_dragonBall.graphics.precisionHitTest = true;	
			this.addChild(hit_dragonBall);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((MountainDig as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainDigObj,true
						);
					}else if(hit_dragonBall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						DragonBallHandler();
					}else if(hit_hominid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						HominidHandler();
					}else if(hit_shellsOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are many seashells in these layers of sediment.");
						
					}else if(hit_shellsTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are fossils of all different types in this rock.");
						
					}else if(hit_sedminet.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These bones may have last seen daylight millions of years ago.");
						
					}
					
					/*
					private var hit_sedminet:Shape;
					private var hit_shellsOne:Shape;
					private var hit_shellsTwo:Shape;
					*/
				}
			}
		}
		
		private function HominidHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole in the rock where the hominid skull was located.");

				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'Opened'){
					hominid.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate;
					}
					SaveArray['Hominid'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigExcavate',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hominid,
						'item_Hominid',
						'inven_hominid_sm'
					);	
				}else{
					HominidItemHandler();
				}
			}else{
				HominidItemHandler();
			}
		}
		
		private function HominidItemHandler():void{
			
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SculptTools)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelTwo();
				hominid.texture = this.assets.getTexture('hominid_half')
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate;
				}
				SaveArray['Hominid'] = 'Opened';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigExcavate',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_SculptTools,
						"item_SculptTools"
					);
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadBeatUpOne(true,1);
					},1.5);
				}
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Trowel)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fossil is very fragile. Even the trowel could severely damage it. I must use the most gentle tools possible.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PickAxe)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hominid skull is very fragile. The pick axe will surely shatter it.");
				
			}else{
				if(PhraseCounter == 0){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A skull... it looks like of an early human ancestor.");
					PhraseCounter = 1;
				}else if(PhraseCounter == 1){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe not a direct ancestor, but an evolutionary relative.");
					PhraseCounter = 2;
				}else if(PhraseCounter == 2){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder what thoughts passed behind those eyes so long ago.");
					PhraseCounter = 0;
				}
			}
		}
		
		private function DragonBallHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The area of sediment where the spherical stone was.");
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'Opened'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					dragonBall.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate;
					}
					SaveArray['DragonBall'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigExcavate',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallFive,
						'item_DragonBallFive',
						'inven_dragonBallFive_sm'
					);	
				}else{
					DragonBallItemHandler();
				}
			}else{
				DragonBallItemHandler();
			}
		
		}
		private function DragonBallItemHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PickAxe)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClinkOne();
				dragonBall.texture = this.assets.getTexture('dragonball_half')
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Crystal'] == 'PickedUp'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PickAxe,
								"item_PickAxe"
							);
					}
				}
					
					
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate;
				}
				SaveArray['DragonBall'] = 'Opened';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigExcavate',SaveArray);
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Trowel)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sediment around the sphere is very hard and dense, I'll need more forceful tools to remove it.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SculptTools)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sediment around the sphere is very hard and dense, I'll need more forceful tools to remove it.");
				
			}else{
				
				if(PhraseCounter == 0){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A stone sphere, half exposed from under the layers of sediment.");
					PhraseCounter = 1;
				}else if(PhraseCounter == 1){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere is strongly fixed to the wall. I will need to use a lot of force to remove it.");

					PhraseCounter = 2;
				}else if(PhraseCounter == 2){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The spherical stone has five smooth areas on its surface.");
					PhraseCounter = 0;
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
			
			
			this.assets.removeTexture("mountainDigExcavate_bg",true);
			this.assets.removeTexture("MountainDigExcavate_Sprite",true);
			this.assets.removeTextureAtlas("MountainDigExcavate_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("mountainDigExcavate_01");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigExcavate_02");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigExcavate_03");
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
