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
	
	
	public class MountainLedge extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var dragonBall:Image;
		
		private var hit_dragonBall:Shape;
		private var hit_mountain:Shape;
		private var hit_pedestal:Shape;
		private var hit_sky:Shape;
		private var hit_tree:Shape;
		private var hit_ocean:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function MountainLedge(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('mountainLedge_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainLedge/mountainLedge_bg.jpg'));
				game.TrackAssets('mountainLedge_01');
			}
			//MountainLedge_Sprite
			if(game.CheckAsset('mountainLedge_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainLedge/MountainLedge_Sprite.png'));
				game.TrackAssets('mountainLedge_02');
			}
			if(game.CheckAsset('mountainLedge_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainLedge/MountainLedge_Sprite.xml'));
				game.TrackAssets('mountainLedge_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("MountainLedge","MountainLedgeObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		/*	
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallOne,
			'item_DragonBallOne',
			'inven_dragonBallOne_sm'
			);
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallThree,
			'item_DragonBallThree',
			'inven_dragonBallThree_sm'
			);
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallFive,
			'item_DragonBallFive',
			'inven_dragonBallFive_sm'
			);
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallTwo,
			'item_DragonBallTwo',
			'inven_dragonBallTwo_sm'
			);
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallSeven,
			'item_DragonBallSeven',
			'inven_dragonBallSeven_sm'
			);
		*/	
			
			
			bg = new Image(this.assets.getTexture('mountainLedge_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			dragonBall = new Image(this.assets.getTexture('dragonball'));
			dragonBall.touchable = true;
			dragonBall.x = 375;
			dragonBall.y = 116;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge['DragonBall'] == 'PickedUp'){
					dragonBall.alpha = 0;
				}else{
					dragonBall.alpha = 1;
				}
			}else{
				dragonBall.alpha = 1;
			}
			
			this.addChildAt(dragonBall,1);
			CreateHitSky();
			CreateHitMountain();
			CreateHitOcean();
			CreateHitTrees();
			CreateHitPedestal();
			//FadeOutOcean(1);
			CreateHitDragonBall();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainLedge',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainLedge',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
					},0.5);
				}
			}
		}
	
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(50,0);		
			hit_sky.graphics.lineTo(665,0);		
			hit_sky.graphics.lineTo(800,144);		
			hit_sky.graphics.lineTo(800,249);		
			hit_sky.graphics.lineTo(306,234);		
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateHitPedestal():void{
			hit_pedestal = new Shape();
			hit_pedestal.touchable = false;
			hit_pedestal.graphics.beginFill(0xff0000);
			
			hit_pedestal.graphics.lineTo(221,360);		
			hit_pedestal.graphics.lineTo(361,171);		
			hit_pedestal.graphics.lineTo(449,176);		
			hit_pedestal.graphics.lineTo(551,357);		
			hit_pedestal.graphics.lineTo(426,410);		
			
			hit_pedestal.graphics.endFill(false);
			hit_pedestal.alpha = 0.0;
			
			hit_pedestal.graphics.precisionHitTest = true;	
			this.addChild(hit_pedestal);
		}
		
		private function CreateHitTrees():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(551,325);		
			hit_tree.graphics.lineTo(791,304);		
			hit_tree.graphics.lineTo(793,380);		
			hit_tree.graphics.lineTo(627,416);		
			
			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitOcean():void{
			hit_ocean = new Shape();
			hit_ocean.touchable = false;
			hit_ocean.graphics.beginFill(0xff0000);
			
			hit_ocean.graphics.lineTo(490,256);		
			hit_ocean.graphics.lineTo(800,256);		
			hit_ocean.graphics.lineTo(800,307);		
			hit_ocean.graphics.lineTo(538,315);		
			
			hit_ocean.graphics.endFill(false);
			hit_ocean.alpha = 0.0;
			
			hit_ocean.graphics.precisionHitTest = true;	
			this.addChild(hit_ocean);
		}
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(0,0);		
			hit_mountain.graphics.lineTo(181,154);		
			hit_mountain.graphics.lineTo(310,245);		
			hit_mountain.graphics.lineTo(273,309);		
			hit_mountain.graphics.lineTo(106,382);		
			hit_mountain.graphics.lineTo(0,366);		
			
			hit_mountain.graphics.endFill(false);
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitDragonBall():void{
			hit_dragonBall = new Shape();
			hit_dragonBall.touchable = false;
			hit_dragonBall.graphics.beginFill(0xff0000);
			
			hit_dragonBall.graphics.lineTo(355,97);		
			hit_dragonBall.graphics.lineTo(473,97);		
			hit_dragonBall.graphics.lineTo(473,205);		
			hit_dragonBall.graphics.lineTo(355,205);		
			
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
						FadeOut((MountainTemple as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainTempleObj,true
						);
					}else if(hit_dragonBall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						DragonBallHandler();
					}else if(hit_pedestal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cliff tapers and converges to form a near perfect pedestal.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The formation of the stone looks organic.");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The round shapes look like bacteria or fungal growth.");
							
						}
						
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The steep slope of the mountain looms over the jungle below.");
						
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sky is an indifferent, pale gray.");
						
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The jungle below rustles and teems with life.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree canopies sway in the breeze.");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Dense, wet air hangs over the jungle like a protective veil.");	
							
						}
						
						
					}else if(hit_ocean.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ocean expands out toward the wall of clouds.");	
						
						
					}

				
				}
				
				
				
			}
		}
		
		private function DragonBallHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge['DragonBall'] == 'PickedUp'){
					if(hit_pedestal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cliff tapers and converges to form a near perfect pedestal.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The formation of the stone looks organic.");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The round shapes look like bacteria or fungal growth.");
							
						}
					
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sky is an indifferent, pale gray.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
					dragonBall.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge;
					}
					SaveArray['DragonBall'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainLedge',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallTwo,
						'item_DragonBallTwo',
						'inven_dragonBallTwo_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
				dragonBall.alpha = 0;
				SaveArray['DragonBall'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainLedge',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallTwo,
					'item_DragonBallTwo',
					'inven_dragonBallTwo_sm'
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
			
			
			this.assets.removeTexture("mountainLedge_bg",true);
			this.assets.removeTexture("MountainLedge_Sprite",true);
			this.assets.removeTextureAtlas("MountainLedge_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("mountainLedge_01");
			(stage.getChildAt(0) as Object).falseAsset("mountainLedge_02");
			(stage.getChildAt(0) as Object).falseAsset("mountainLedge_03");
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
