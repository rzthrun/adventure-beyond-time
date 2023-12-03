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
	
	public class RavineCanyon extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var canoe_pestal:Image;
		
		private var hit_Ravine:Shape;
		private var hit_JungleStump:Shape;
		private var hit_Drone:Shape;
		
		private var hit_roots:Shape;
		private var hit_walls:Shape;
		private var hit_boat:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineCanyon(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineCanyon_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyon/ravineCanyon_bg.jpg'));
				game.TrackAssets('ravineCanyon_01');
			}
			if(game.CheckAsset('ravineCanyon_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyon/RavineCanyon_SpriteSheet.png'));
				game.TrackAssets('ravineCanyon_02');
			}
			if(game.CheckAsset('ravineCanyon_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyon/RavineCanyon_SpriteSheet.xml'));
				game.TrackAssets('ravineCanyon_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineCanyon","RavineCanyonObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineCanyon_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			canoe_pestal  = new Image(this.assets.getTexture('canoe_bowl'));
			canoe_pestal.touchable = false;
			canoe_pestal.x = 552;
			canoe_pestal.y = 323;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe["Motor"] == "PickedUp"){
					canoe_pestal.alpha = 0;
				}else{
					canoe_pestal.alpha = 1;
				}	
			}else{
				canoe_pestal.alpha = 1;
			}
			
			
			this.addChildAt(canoe_pestal,1);
			//FadeOutOcean(1);
			CreateHitRavine();
			CreateHitJungleStump();
			CreateHitDrone();
			CreateHitRoots();
			CreateHitBoat();
			CreateHitWalls();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("Waves_01",0,1.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
		}
		
		/*
		private var hit_roots:Shape;
		private var hit_walls:Shape;
		private var hit_boat:Shape;
		*/
		private function CreateHitBoat():void{
			hit_boat = new Shape();
			hit_boat.touchable = false;
			hit_boat.graphics.beginFill(0xff0000);
			
			hit_boat.graphics.lineTo(131,78);		
			hit_boat.graphics.lineTo(190,59);		
			hit_boat.graphics.lineTo(273,112);		
			hit_boat.graphics.lineTo(255,187);		
			hit_boat.graphics.lineTo(176,135);		
			hit_boat.graphics.lineTo(138,148);		
			
			hit_boat.alpha = 0.0;
			
			hit_boat.graphics.precisionHitTest = true;	
			this.addChild(hit_boat);
		}
		
		private function CreateHitWalls():void{
			hit_walls = new Shape();
			hit_walls.touchable = false;
			hit_walls.graphics.beginFill(0xff0000);
			
			hit_walls.graphics.lineTo(0,0);		
			hit_walls.graphics.lineTo(50,0);		
			hit_walls.graphics.lineTo(111,63);		
			hit_walls.graphics.lineTo(117,268);		
			hit_walls.graphics.lineTo(0,336);		
		
			hit_walls.alpha = 0.0;
			
			hit_walls.graphics.precisionHitTest = true;	
			this.addChild(hit_walls);
		}
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(470,113);		
			hit_roots.graphics.lineTo(531,44);		
			hit_roots.graphics.lineTo(598,41);		
			hit_roots.graphics.lineTo(631,81);		
			hit_roots.graphics.lineTo(621,129);		
			hit_roots.graphics.lineTo(510,205);		
			hit_roots.graphics.lineTo(483,181);		
		
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitJungleStump():void{
			hit_JungleStump = new Shape();
			hit_JungleStump.touchable = false;
			hit_JungleStump.graphics.beginFill(0xff0000);
			
			hit_JungleStump.graphics.lineTo(281,134);		
			hit_JungleStump.graphics.lineTo(412,59);		
			hit_JungleStump.graphics.lineTo(385,268);		
			hit_JungleStump.graphics.lineTo(368,340);		
			hit_JungleStump.graphics.lineTo(298,354);		
			hit_JungleStump.graphics.lineTo(276,343);		
			hit_JungleStump.graphics.lineTo(312,269);		
			hit_JungleStump.graphics.lineTo(324,180);		
			hit_JungleStump.graphics.lineTo(275,187);		
			
			hit_JungleStump.alpha = 0.0;
			
			hit_JungleStump.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleStump);
		}
		
		private function CreateHitRavine():void{
			hit_Ravine = new Shape();
			hit_Ravine.touchable = false;
			hit_Ravine.graphics.beginFill(0xff0000);
			
			//hit_Ravine.graphics.lineTo(98,158);	
			//hit_Ravine.graphics.lineTo(170,158);	
			hit_Ravine.graphics.lineTo(144,156);	
			hit_Ravine.graphics.lineTo(174,144);	
			hit_Ravine.graphics.lineTo(298,222);	
			hit_Ravine.graphics.lineTo(260,314);	
			hit_Ravine.graphics.lineTo(243,339);	
			hit_Ravine.graphics.lineTo(165,330);	
			hit_Ravine.graphics.lineTo(150,256);	

			hit_Ravine.alpha = 0.0;
			
			hit_Ravine.graphics.precisionHitTest = true;	
			this.addChild(hit_Ravine);
		}
		//hit_Drone
		private function CreateHitDrone():void{
			hit_Drone = new Shape();
			hit_Drone.touchable = false;
			hit_Drone.graphics.beginFill(0xff0000);
				
			hit_Drone.graphics.lineTo(349,372);	
			hit_Drone.graphics.lineTo(350,364);	
			hit_Drone.graphics.lineTo(370,349);	
			hit_Drone.graphics.lineTo(378,321);	
			hit_Drone.graphics.lineTo(456,251);	
			hit_Drone.graphics.lineTo(511,221);	
			hit_Drone.graphics.lineTo(640,131);	
			hit_Drone.graphics.lineTo(731,155);	
			hit_Drone.graphics.lineTo(726,334);	
			hit_Drone.graphics.lineTo(568,442);	
			hit_Drone.graphics.lineTo(340,445);	
			
			hit_Drone.alpha = 0.0;
			
			hit_Drone.graphics.precisionHitTest = true;	
			this.addChild(hit_Drone);
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
					}else if(hit_Ravine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineCanyonMessage as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonMessageObj,true
						);
					}else if(hit_JungleStump.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineFreighter as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterObj,true
						);
					}else if(hit_Drone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineCanoe as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanoeObj,true
						);
					}else if(hit_boat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That's a big boat... how'd it get there ?");
						
					}else if(hit_walls.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder what formed this canyon...?");
						
					}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Exposed tree roots.");
						
					}
					
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
			
			
			this.assets.removeTexture("RavineCanyon_bg",true);
			this.assets.removeTexture("RavineCanyon_SpriteSheet",true);
			this.assets.removeTextureAtlas("RavineCanyon_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineCanyon_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineCanyon_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineCanyon_03");
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