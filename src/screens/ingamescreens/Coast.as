package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class Coast extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var bg_two:Image;
		private var bg_twoTween:Tween;
		private var hit_CoastSurf:Shape;
		private var hit_CoastCorner:Shape;
		private var hit_CoastJungle:Shape;
		private var hit_Raft:Shape;
		private var hit_Sky:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		public function Coast(_assets:AssetManager,_game:Game)
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
			
			if(game.CheckAsset('coast_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/coast_bg.jpg'));
				game.TrackAssets('coast_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Coast","CoastObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
	
		//	SaveArray['FirstTime'] = 'No';
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Coast',SaveArray);
			
			bg = new Image(this.assets.getTexture('coast_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
	
			CreateHitCoastCorner();
			CreateHitCoastJungle();
			CreateHitRaft();
			CreateHitCoastSurf();
			CreateHitSky();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Coast != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Coast['FirstTime'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Coast;
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Coast',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,4);
					},1.5);
				}
			
			}else{
				SaveArray['FirstTime'] = 'Yes';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Coast',SaveArray);
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,4);
				},1.5);
			}
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolume("MountainViolin",0,1.5);
			//MUS_Waves_01			
			

			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			
			//	if(animating === false){
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					
					if(hit_CoastSurf.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Waves are crashing gently against the shore.");
					}else if(hit_Sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sky is grey and hazy.");

					}else if(hit_CoastJungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastJungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastJungleObj,true
						);
					
					
					}else if(hit_CoastCorner.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastCorner as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCornerObj,true
						);
					}else if(hit_Raft.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((Raft as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RaftObj,true
						);
					}
					
					
					
					
				
				}
			}
		}
		
		
		
		
		
		private function CreateHitCoastJungle():void{
			hit_CoastJungle = new Shape();
			hit_CoastJungle.touchable = false;
			hit_CoastJungle.graphics.beginFill(0x0000ff);
			
			hit_CoastJungle.graphics.lineTo(152,94);	
			hit_CoastJungle.graphics.lineTo(232,82);	
			hit_CoastJungle.graphics.lineTo(366,128);	
			hit_CoastJungle.graphics.lineTo(405,202);	
			hit_CoastJungle.graphics.lineTo(415,280);	
			hit_CoastJungle.graphics.lineTo(337,300);	
			hit_CoastJungle.graphics.lineTo(233,256);	
			hit_CoastJungle.graphics.lineTo(207,245);	
			hit_CoastJungle.graphics.lineTo(201,226);	
			hit_CoastJungle.graphics.lineTo(150,192);	
			
		//203.75 ,227.84

			hit_CoastJungle.alpha = 0.0;

			hit_CoastJungle.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastJungle);
		}
		
		private function CreateHitCoastCorner():void{
			hit_CoastCorner = new Shape();
			hit_CoastCorner.touchable = false;
			hit_CoastCorner.graphics.beginFill(0xff0000);
			
			hit_CoastCorner.graphics.lineTo(437,171);	
			hit_CoastCorner.graphics.lineTo(478,159);	
			hit_CoastCorner.graphics.lineTo(654,170);	
			hit_CoastCorner.graphics.lineTo(716,258);	
			hit_CoastCorner.graphics.lineTo(715,322);	
			hit_CoastCorner.graphics.lineTo(646,339);	
			hit_CoastCorner.graphics.lineTo(439,299);	
			
			hit_CoastCorner.graphics.endFill(false);
			
			hit_CoastCorner.alpha = 0.0;
			
			
			hit_CoastCorner.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastCorner);
		}
		private function CreateHitRaft():void{
			hit_Raft = new Shape();
			hit_Raft.touchable = false;
			hit_Raft.graphics.beginFill(0x00FF00);
			
			hit_Raft.graphics.lineTo(45,213);	
			hit_Raft.graphics.lineTo(66,189);	
			hit_Raft.graphics.lineTo(199,229);	
			hit_Raft.graphics.lineTo(215,279);	
			hit_Raft.graphics.lineTo(246,335);	
			hit_Raft.graphics.lineTo(76,313);	

			hit_Raft.graphics.endFill(false);
			
			hit_Raft.alpha = 0.0;

			hit_Raft.graphics.precisionHitTest = true;	
			this.addChild(hit_Raft);
		}
		
		private function CreateHitCoastSurf():void{
			hit_CoastSurf = new Shape();
			hit_CoastSurf.touchable = false;
			hit_CoastSurf.graphics.beginFill(0x00FF00);
			
			hit_CoastSurf.graphics.lineTo(276,338);	
			hit_CoastSurf.graphics.lineTo(405,330);	
			hit_CoastSurf.graphics.lineTo(696,374);	
			hit_CoastSurf.graphics.lineTo(587,508);	
			hit_CoastSurf.graphics.lineTo(486,508);	
			hit_CoastSurf.graphics.lineTo(271,430);	

			hit_CoastSurf.graphics.endFill(false);
			
			hit_CoastSurf.alpha = 0.0;
			
			
			hit_CoastSurf.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastSurf);
		}
		
		private function CreateHitSky():void{
			hit_Sky = new Shape();
			hit_Sky.touchable = false;
			hit_Sky.graphics.beginFill(0x00FF00);
			
			hit_Sky.graphics.lineTo(266,0);	
			hit_Sky.graphics.lineTo(800,0);	
			hit_Sky.graphics.lineTo(800,165);	
			hit_Sky.graphics.lineTo(436,143);	
			hit_Sky.graphics.lineTo(261,54);	
			
			
			hit_Sky.graphics.endFill(false);
			
			hit_Sky.alpha = 0.0;
			
			
			hit_Sky.graphics.precisionHitTest = true;	
			this.addChild(hit_Sky);
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

			this.assets.removeTexture("coast_bg",true);
			(stage.getChildAt(0) as Object).falseAsset("coast_01");
	//		this.assets.removeTexture("Coast_SpriteSheet",true);
	//		this.assets.removeTextureAtlas("Coast_SpriteSheet",true);
	//		(stage.getChildAt(0) as Object).falseAsset("coast_01");
	//		(stage.getChildAt(0) as Object).falseAsset("coast_02");
			
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