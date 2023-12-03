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
	
	public class JungleEdge extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var book:Image;
		private var cover:Image;
		private var mushroom:Image;
		private var stumpRings_on:Image;
		private var stumpRings_off:Image;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var hit_Jungle:Shape;
		private var hit_JungleStump:Shape;
		private var hit_JungleHole:Shape;
		private var hit_mountain:Shape;
		private var hit_ground:Shape;
		private var hit_forest:Shape;
		
		private var goback:GoBackButton;		
		
		public function JungleEdge(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleEdge_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEdge/jungleEdge_bg.jpg'));
				game.TrackAssets('jungleEdge_01');
			}
			if(game.CheckAsset('jungleEdge_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEdge/JungleEdge_SpriteSheet.png'));
				game.TrackAssets('jungleEdge_02');
			}
			if(game.CheckAsset('jungleEdge_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEdge/JungleEdge_SpriteSheet.xml'));
				game.TrackAssets('jungleEdge_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleEdge","JungleEdgeObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_WoodCircle,
				'item_WoodCircle',
				'inven_woodCircle_sm'
			);
			*/
			
			bg = new Image(this.assets.getTexture('jungleEdge_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			book = new Image(this.assets.getTexture('hole_book'));
			book.touchable = false;
			book.x = 438;
			book.y = 256;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole['Cover'] == 'open'){
					cover = new Image(this.assets.getTexture('hole_cover_off'));
					cover.touchable = false;
					cover.x = 352;
					cover.y = 261;

				}else{
					cover = new Image(this.assets.getTexture('hole_cover_on'));
					cover.touchable = false;
					cover.x = 427;
					cover.y = 238;

				}
			}else{
				cover = new Image(this.assets.getTexture('hole_cover_on'));
				cover.touchable = false;
				cover.x = 427;
				cover.y = 238;

			}
			

			mushroom = new Image(this.assets.getTexture('stump_mushroom'));
			mushroom.touchable = false;
			mushroom.x = 269;
			mushroom.y = 263;
			
			stumpRings_on = new Image(this.assets.getTexture('stump_rings'));
			stumpRings_on.touchable = false;
			stumpRings_on.x = 137;
			stumpRings_on.y = 211;
			
			stumpRings_off = new Image(this.assets.getTexture('stump_rings_open'));
			stumpRings_off.touchable = false;
			stumpRings_off.x = 103;
			stumpRings_off.y = 208;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump['Mushroom'] == 'PickedUp'){
					mushroom.alpha = 0;
				}else{
					mushroom.alpha = 1;
				}
			}else{
				mushroom.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['Lid'] == 'open'){
					stumpRings_on.alpha = 0;
					stumpRings_off.alpha = 1;
				}else{
					stumpRings_on.alpha = 1;
					stumpRings_off.alpha = 0;
				}
				
			}else{
				stumpRings_on.alpha = 1;
				stumpRings_off.alpha = 0;
			}
			
			
			
			
			this.addChildAt(book,1);
			this.addChildAt(cover,2);		
			this.addChildAt(mushroom,3);
			this.addChildAt(stumpRings_on,4);
			this.addChildAt(stumpRings_off,4);
			
			CreateHitJungle();
			CreateHitJungleHole();
			CreateHitJungleStump();
			CreateHitMountain();
			CreateHitGround();
			CreateHitForest();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Jungle_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		//hit_JungleHole
		/*
		private var hit_mountain:Shape;
		private var hit_ground:Shape;
		private var hit_forest:Shape;
		*/
		private function CreateHitForest():void{
			hit_forest = new Shape();
			hit_forest.touchable = false;
			hit_forest.graphics.beginFill(0xff0000);
			
			hit_forest.graphics.lineTo(255,67);	
			hit_forest.graphics.lineTo(326,91);	
			hit_forest.graphics.lineTo(466,63);	
			hit_forest.graphics.lineTo(611,126);	
			hit_forest.graphics.lineTo(570,208);	
			hit_forest.graphics.lineTo(501,190);	
			hit_forest.graphics.lineTo(411,188);	
			hit_forest.graphics.lineTo(347,240);	
			hit_forest.graphics.lineTo(251,222);	
			
			hit_forest.alpha = 0.0;
			
			hit_forest.graphics.precisionHitTest = true;	
			this.addChild(hit_forest);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(125,393);	
			hit_ground.graphics.lineTo(387,350);	
			hit_ground.graphics.lineTo(591,346);	
			hit_ground.graphics.lineTo(699,382);	
			hit_ground.graphics.lineTo(603,504);	
			hit_ground.graphics.lineTo(141,504);	
		
			
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(268,63);	
			hit_mountain.graphics.lineTo(305,0);	
			hit_mountain.graphics.lineTo(371,0);	
			hit_mountain.graphics.lineTo(400,77);	
			hit_mountain.graphics.lineTo(325,83);	

			
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitJungleHole():void{
			hit_JungleHole = new Shape();
			hit_JungleHole.touchable = false;
			hit_JungleHole.graphics.beginFill(0xff0000);
			
			hit_JungleHole.graphics.lineTo(396,224);	
			hit_JungleHole.graphics.lineTo(456,202);	
			hit_JungleHole.graphics.lineTo(525,210);	
			hit_JungleHole.graphics.lineTo(553,272);	
			hit_JungleHole.graphics.lineTo(525,343);	
			hit_JungleHole.graphics.lineTo(423,345);	
			hit_JungleHole.graphics.lineTo(397,317);	
	
			
			hit_JungleHole.alpha = 0.0;
			
			hit_JungleHole.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleHole);
		}
		private function CreateHitJungle():void{
			hit_Jungle = new Shape();
			hit_Jungle.touchable = false;
			hit_Jungle.graphics.beginFill(0xff0000);
			
			hit_Jungle.graphics.lineTo(612,165);	
			hit_Jungle.graphics.lineTo(666,131);	
			hit_Jungle.graphics.lineTo(800,151);	
			hit_Jungle.graphics.lineTo(800,323);	
			hit_Jungle.graphics.lineTo(691,362);	
			hit_Jungle.graphics.lineTo(580,327);		

			hit_Jungle.alpha = 0.0;
			
			hit_Jungle.graphics.precisionHitTest = true;	
			this.addChild(hit_Jungle);
		}
		
		
		private function CreateHitJungleStump():void{
			hit_JungleStump = new Shape();
			hit_JungleStump.touchable = false;
			hit_JungleStump.graphics.beginFill(0xff0000);
			
			hit_JungleStump.graphics.lineTo(0,146);	
			hit_JungleStump.graphics.lineTo(94,146);	
			hit_JungleStump.graphics.lineTo(148,119);	
			hit_JungleStump.graphics.lineTo(208,153);	
			hit_JungleStump.graphics.lineTo(247,238);	
			hit_JungleStump.graphics.lineTo(337,267);	
			hit_JungleStump.graphics.lineTo(358,294);	
			hit_JungleStump.graphics.lineTo(355,347);	
			hit_JungleStump.graphics.lineTo(291,362);	
			hit_JungleStump.graphics.lineTo(228,357);	
			hit_JungleStump.graphics.lineTo(168,378);	
			hit_JungleStump.graphics.lineTo(58,359);	
			hit_JungleStump.graphics.lineTo(0,359);	
				

			hit_JungleStump.alpha = 0.0;
			
			hit_JungleStump.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleStump);
		}
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastJungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastJungleObj,true
						);
					}else if(hit_Jungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleTarPit as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitObj,true
						);
					}else if(hit_JungleStump.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleStump as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleStumpObj,true
						);
					}else if(hit_JungleHole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleHole as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleHoleObj,true
						);
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Somehow the mountain doesn't seem as friendly from here...");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground is damp and muddy.");
						
						
					}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The forest is thick and dark.");
						
					}

					
					/*
					private var hit_mountain:Shape;
					private var hit_ground:Shape;
					private var hit_forest:Shape;
					*/
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
			
			
			this.assets.removeTexture("jungleEdge_bg",true);
			this.assets.removeTexture("JungleEdge_SpriteSheet",true);
			this.assets.removeTextureAtlas("JungleEdge_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleEdge_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleEdge_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleEdge_03");
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
import starling.utils.AssetManager;

