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
	
	public class JungleStump extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var Mushroom:Image;
		private var StumpRings:Image;
		private var StumpRingsOpen:Image;
		
		private var hit_RavineCanyon:Shape;
		private var hit_Mushroom:Shape;
		private var hit_StumpRings:Shape;
		private var hit_forest:Shape;
		private var hit_logHole:Shape;
		private var hit_stumpBase:Shape;
		private var hit_stumpTop:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function JungleStump(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleStump_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStump/jungleStump_bg.jpg'));
				game.TrackAssets('jungleStump_01');
			}
			if(game.CheckAsset('jungleStump_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStump/JungleStump_SpriteSheet.png'));
				game.TrackAssets('jungleStump_02');
			}
			if(game.CheckAsset('jungleStump_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStump/JungleStump_SpriteSheet.xml'));
				game.TrackAssets('jungleStump_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleStump","JungleStumpObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleStump_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			Mushroom = new Image(this.assets.getTexture('mushroom'));
			Mushroom.touchable = false;
			Mushroom.x = 505;
			Mushroom.y = 232;
			
			StumpRings = new Image(this.assets.getTexture('rings'));
			StumpRings.touchable = false;
			StumpRings.x = 251;
			StumpRings.y = 147;
		
			StumpRingsOpen  = new Image(this.assets.getTexture('rings_open'));
			StumpRingsOpen.touchable = false;
			StumpRingsOpen.x = 186;
			StumpRingsOpen.y = 149;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump["Mushroom"] == "PickedUp"){
					Mushroom.alpha = 0;
				}else{
					Mushroom.alpha = 1;
				}			
			}else{
				Mushroom.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['Lid'] == 'open'){
					StumpRings.alpha = 0;
					StumpRingsOpen.alpha = 1;
				}else{
					StumpRings.alpha = 1;
					StumpRingsOpen.alpha = 0;
				}
				
			}else{
				StumpRings.alpha = 1;
				StumpRingsOpen.alpha = 0;
			}
		
			
			
			this.addChildAt(Mushroom,1);	
			this.addChildAt(StumpRings,2);	
			this.addChildAt(StumpRingsOpen,3);	
			
			//FadeOutOcean(1);
			CreateHitMushroom();
			CreateHitRavineCanyon();
			CreateHitStumpRings();
			
			CreateHitStumpTop();
			CreateHitStumpBase();
			CreateHitForest();
			CreateHitLogHole();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			//Crickets_01
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');

		}
		/*
		
		private var hit_forest:Shape;
		private var hit_logHole:Shape;
		private var hit_stumpBase:Shape;
		hit_stumpTop
		*/
		private function CreateHitStumpTop():void{
			hit_stumpTop = new Shape();
			hit_stumpTop.touchable = false;
			hit_stumpTop.graphics.beginFill(0x0000ff);
			
			hit_stumpTop.graphics.lineTo(242,115);	
			hit_stumpTop.graphics.lineTo(258,0);	
			hit_stumpTop.graphics.lineTo(296,0);	
			hit_stumpTop.graphics.lineTo(365,81);	
			hit_stumpTop.graphics.lineTo(358,152);	
			hit_stumpTop.graphics.lineTo(315,122);	
			
			hit_stumpTop.graphics.endFill(false);
			hit_stumpTop.alpha = 0.0;
			
			hit_stumpTop.graphics.precisionHitTest = true;	
			this.addChild(hit_stumpTop);
		}
		
		private function CreateHitStumpBase():void{
			hit_stumpBase = new Shape();
			hit_stumpBase.touchable = false;
			hit_stumpBase.graphics.beginFill(0x0000ff);
			
			hit_stumpBase.graphics.lineTo(191,350);	
			hit_stumpBase.graphics.lineTo(234,263);	
			hit_stumpBase.graphics.lineTo(316,271);	
			hit_stumpBase.graphics.lineTo(363,257);	
			hit_stumpBase.graphics.lineTo(411,371);	
			hit_stumpBase.graphics.lineTo(357,467);	
			hit_stumpBase.graphics.lineTo(200,435);	
			hit_stumpBase.graphics.endFill(false);
			hit_stumpBase.alpha = 0.0;
			
			hit_stumpBase.graphics.precisionHitTest = true;	
			this.addChild(hit_stumpBase);
		}
		
		private function CreateHitLogHole():void{
			hit_logHole = new Shape();
			hit_logHole.touchable = false;
			hit_logHole.graphics.beginFill(0x0000ff);
			
			hit_logHole.graphics.lineTo(477,325);	
			hit_logHole.graphics.lineTo(629,270);	
			hit_logHole.graphics.lineTo(686,342);	
			hit_logHole.graphics.lineTo(671,438);	
			hit_logHole.graphics.lineTo(490,401);	
			hit_logHole.graphics.endFill(false);
			hit_logHole.alpha = 0.0;
			
			hit_logHole.graphics.precisionHitTest = true;	
			this.addChild(hit_logHole);
		}
		
		private function CreateHitForest():void{
			hit_forest = new Shape();
			hit_forest.touchable = false;
			hit_forest.graphics.beginFill(0x0000ff);
			
			hit_forest.graphics.lineTo(375,0);	
			hit_forest.graphics.lineTo(653,0);	
			hit_forest.graphics.lineTo(616,167);	
			hit_forest.graphics.lineTo(447,204);	
			hit_forest.graphics.lineTo(362,197);	
			hit_forest.graphics.endFill(false);
			hit_forest.alpha = 0.0;
			
			hit_forest.graphics.precisionHitTest = true;	
			this.addChild(hit_forest);
		}
		
		private function CreateHitStumpRings():void{
			hit_StumpRings = new Shape();
			hit_StumpRings.touchable = false;
			hit_StumpRings.graphics.beginFill(0x0000ff);
			
			hit_StumpRings.graphics.lineTo(230,183);	
			hit_StumpRings.graphics.lineTo(256,135);	
			hit_StumpRings.graphics.lineTo(315,131);	
			hit_StumpRings.graphics.lineTo(359,169);	
			hit_StumpRings.graphics.lineTo(355,231);	
			hit_StumpRings.graphics.lineTo(320,266);	
			hit_StumpRings.graphics.lineTo(257,266);	
			hit_StumpRings.graphics.endFill(false);
			hit_StumpRings.alpha = 0.0;
			
			hit_StumpRings.graphics.precisionHitTest = true;	
			this.addChild(hit_StumpRings);
		}
		
		private function CreateHitMushroom():void{
			hit_Mushroom = new Shape();
			hit_Mushroom.touchable = false;
			hit_Mushroom.graphics.beginFill(0xff0000);
			
			hit_Mushroom.graphics.lineTo(456,257);	
			hit_Mushroom.graphics.lineTo(478,220);	
			hit_Mushroom.graphics.lineTo(543,220);	
			hit_Mushroom.graphics.lineTo(607,242);	
			hit_Mushroom.graphics.lineTo(606,275);	
			hit_Mushroom.graphics.lineTo(570,288);	
			hit_Mushroom.graphics.lineTo(483,320);	
			hit_Mushroom.graphics.endFill(false);
			hit_Mushroom.alpha = 0.0;
			
			hit_Mushroom.graphics.precisionHitTest = true;	
			this.addChild(hit_Mushroom);
		}
		
		private function CreateHitRavineCanyon():void{
			hit_RavineCanyon = new Shape();
			hit_RavineCanyon.touchable = false;
			hit_RavineCanyon.graphics.beginFill(0xff0000);
			
			hit_RavineCanyon.graphics.lineTo(0,123);	
			hit_RavineCanyon.graphics.lineTo(144,149);	
			hit_RavineCanyon.graphics.lineTo(180,231);	
			hit_RavineCanyon.graphics.lineTo(173,389);	
			hit_RavineCanyon.graphics.lineTo(80,510);	
			hit_RavineCanyon.graphics.lineTo(0,505);	
			hit_RavineCanyon.graphics.endFill(false);
			hit_RavineCanyon.alpha = 0.0;
			
			hit_RavineCanyon.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineCanyon);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleEdge as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
						);
					}else if(hit_RavineCanyon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineFreighter as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterObj,true
						);
					}else if(hit_Mushroom.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						trace("MUSHROOM CLICKED");
						MushroomHandler();
					}else if(hit_StumpRings.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleStumpPuzzle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleStumpPuzzleObj,true
						);
					
					}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The forest is eerie... I feel like it’s watching me.");
							
					}else if(hit_logHole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Moss and lichen grow on the inside of the fallen trunk.");
						
					}else if(hit_stumpBase.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree seems to have been very old.");
						
					}else if(hit_stumpTop.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmm. It appears the trunk snapped... maybe from lightning or wind.");
						
					}
					
					
					/*
					
					private var hit_forest:Shape;
					private var hit_logHole:Shape;
					private var hit_stumpBase:Shape;
					hit_stumpTop
					*/
				}
			}
		}
		//JungleStumpPuzzle
		
		private function MushroomHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump["Mushroom"] == "PickedUp"){
					
				}else{
					Mushroom.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump;
					SaveArray['Mushroom'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStump',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Mushroom,
						'item_Mushroom',
						'inven_mushroom_sm'
					);
					
					
				}
			}else{
				Mushroom.alpha = 0;
				SaveArray['Mushroom'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStump',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Mushroom,
					'item_Mushroom',
					'inven_mushroom_sm'
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
			
			
			this.assets.removeTexture("jungleStump_bg",true);
			this.assets.removeTexture("JungleStump_SpriteSheet",true);
			this.assets.removeTextureAtlas("JungleStump_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleStump_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleStump_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleStump_03");
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
