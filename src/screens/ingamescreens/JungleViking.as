package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class JungleViking extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_JungleVikingDeck:Shape;
		private var hit_MountainSide:Shape;
		private var hit_JungleVikingHead:Shape;
		
		private var hit_sail:Shape;
		private var hit_hull:Shape;
		private var hit_mist:Shape;
		private var hit_ground:Shape;
		private var hit_trees:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;	
				
		
		public function JungleViking(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleViking_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleViking/jungleViking_bg.jpg'));
				game.TrackAssets('jungleViking_01');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleViking","JungleVikingObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleViking_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			CreateHitTrees();
			CreateHitGround();
			CreateHitMist();
			CreateHitSail();
			CreateHitHull();
			
			CreateHitVikingHead();
			CreateHitJungleVikingDeck();
			CreateHitMountainSide();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipCreaks",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999,2);
			},0.7);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
		}
		//hit_MountainSide
	
		private function CreateHitTrees():void{
			hit_trees = new Shape();
			hit_trees.touchable = false;
			hit_trees.graphics.beginFill(0xff0000);
			
			hit_trees.graphics.lineTo(0,0);				
			hit_trees.graphics.lineTo(673,5);				
			hit_trees.graphics.lineTo(680,109);				
			hit_trees.graphics.lineTo(0,197);				
			
			hit_trees.graphics.endFill(false);
			hit_trees.alpha = 0.0;
			
			hit_trees.graphics.precisionHitTest = true;	
			this.addChild(hit_trees);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(118,498);				
			hit_ground.graphics.lineTo(250,444);				
			hit_ground.graphics.lineTo(427,437);				
			hit_ground.graphics.lineTo(484,378);				
			hit_ground.graphics.lineTo(675,364);				
			hit_ground.graphics.lineTo(600,512);				
			hit_ground.graphics.lineTo(118,512);				
			
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		
		private function CreateHitMist():void{
			hit_mist = new Shape();
			hit_mist.touchable = false;
			hit_mist.graphics.beginFill(0xff0000);
			
			hit_mist.graphics.lineTo(651,120);				
			hit_mist.graphics.lineTo(800,119);				
			hit_mist.graphics.lineTo(800,330);				
			hit_mist.graphics.lineTo(675,355);				
		
			
			hit_mist.graphics.endFill(false);
			hit_mist.alpha = 0.0;
			
			hit_mist.graphics.precisionHitTest = true;	
			this.addChild(hit_mist);
		}
		
		private function CreateHitHull():void{
			hit_hull = new Shape();
			hit_hull.touchable = false;
			hit_hull.graphics.beginFill(0xff0000);
			
			hit_hull.graphics.lineTo(255,394);				
			hit_hull.graphics.lineTo(370,237);				
			hit_hull.graphics.lineTo(380,181);				
			hit_hull.graphics.lineTo(426,186);				
			hit_hull.graphics.lineTo(462,247);				
			hit_hull.graphics.lineTo(479,345);				
			hit_hull.graphics.lineTo(423,427);				
			hit_hull.graphics.lineTo(311,436);				
				
			
			hit_hull.graphics.endFill(false);
			hit_hull.alpha = 0.0;
			
			hit_hull.graphics.precisionHitTest = true;	
			this.addChild(hit_hull);
		}
		
		private function CreateHitSail():void{
			hit_sail = new Shape();
			hit_sail.touchable = false;
			hit_sail.graphics.beginFill(0xff0000);
			
			hit_sail.graphics.lineTo(98,76);				
			hit_sail.graphics.lineTo(331,122);				
			hit_sail.graphics.lineTo(330,209);				
			hit_sail.graphics.lineTo(81,220);				
			
			hit_sail.graphics.endFill(false);
			hit_sail.alpha = 0.0;
			
			hit_sail.graphics.precisionHitTest = true;	
			this.addChild(hit_sail);
		}
		
		private function CreateHitVikingHead():void{
			hit_JungleVikingHead = new Shape();
			hit_JungleVikingHead.touchable = false;
			hit_JungleVikingHead.graphics.beginFill(0xff0000);
			
			hit_JungleVikingHead.graphics.lineTo(329,32);				
			hit_JungleVikingHead.graphics.lineTo(431,39);				
			hit_JungleVikingHead.graphics.lineTo(426,179);				
			hit_JungleVikingHead.graphics.lineTo(348,177);				
		
			hit_JungleVikingHead.graphics.endFill(false);
			hit_JungleVikingHead.alpha = 0.0;
			
			hit_JungleVikingHead.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleVikingHead);
		}
		
		
		private function CreateHitJungleVikingDeck():void{
			hit_JungleVikingDeck = new Shape();
			hit_JungleVikingDeck.touchable = false;
			hit_JungleVikingDeck.graphics.beginFill(0xff0000);
			
			hit_JungleVikingDeck.graphics.lineTo(61,257);				
			hit_JungleVikingDeck.graphics.lineTo(100,225);				
			hit_JungleVikingDeck.graphics.lineTo(220,214);				
			hit_JungleVikingDeck.graphics.lineTo(349,216);				
			hit_JungleVikingDeck.graphics.lineTo(363,241);				
			hit_JungleVikingDeck.graphics.lineTo(310,319);				
			hit_JungleVikingDeck.graphics.lineTo(206,437);				
			hit_JungleVikingDeck.graphics.lineTo(98,441);				
			hit_JungleVikingDeck.graphics.lineTo(51,370);				
			hit_JungleVikingDeck.graphics.endFill(false);
			hit_JungleVikingDeck.alpha = 0.0;
			
			hit_JungleVikingDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleVikingDeck);
		}
		
		private function CreateHitMountainSide():void{
			hit_MountainSide = new Shape();
			hit_MountainSide.touchable = false;
			hit_MountainSide.graphics.beginFill(0xff0000);
			
			hit_MountainSide.graphics.lineTo(453,51);				
			hit_MountainSide.graphics.lineTo(598,48);				
			hit_MountainSide.graphics.lineTo(645,115);				
			hit_MountainSide.graphics.lineTo(670,360);				
			hit_MountainSide.graphics.lineTo(518,375);				
			hit_MountainSide.graphics.lineTo(471,256);				
	
			hit_MountainSide.graphics.endFill(false);
			hit_MountainSide.alpha = 0.0;
			
			hit_MountainSide.graphics.precisionHitTest = true;	
			this.addChild(hit_MountainSide);
		}
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleDeep as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleDeepObj,true
						);
						
					}else if(hit_JungleVikingDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleVikingDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingDeckObj,true
						);
					}else if(hit_MountainSide.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
						);
					}else if(hit_JungleVikingHead.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleVikingHead as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingHeadObj,true
						);
					}else if(hit_sail.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sail is torn and deteriorating.");
					}else if(hit_hull.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The longboat's hull is made from pieces of curved wood.");
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The forest floor is slippery...");
					}else if(hit_mist.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Water vapor fills the air.");
					}else if(hit_trees.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The jungle is alive...");
					}
					
					/*
					private var hit_sail:Shape;
					private var hit_hull:Shape;
					private var hit_mist:Shape;
					private var hit_ground:Shape;
					private var hit_trees:Shape;
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
			
			
			this.assets.removeTexture("jungleViking_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleViking_01");
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


