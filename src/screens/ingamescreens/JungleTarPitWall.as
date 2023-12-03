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
	
	public class JungleTarPitWall extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_pos_01:Shape;
		private var hit_pos_02:Shape;
		private var hit_pos_03:Shape;
		private var hit_pos_04:Shape;
		private var hit_pos_05:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleTarPitWall(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleTarPitWall_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPitWall/jungleTarPitWall_bg.jpg'));
				game.TrackAssets('jungleTarPitWall_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleTarPitWall","JungleTarPitWallObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleTarPitWall_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			
			//FadeOutOcean(1);
			CreatePosHits();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitWall != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitWall['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitWall;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitWall',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitWall',SaveArray);
			}
			
		}
		
		
		private function CreatePosHits():void{
			hit_pos_01 = new Shape();
			hit_pos_01.touchable = false;
			hit_pos_01.graphics.beginFill(0xff0000);
			
			hit_pos_01.graphics.lineTo(233,69);	
			hit_pos_01.graphics.lineTo(262,11);	
			hit_pos_01.graphics.lineTo(428,29);	
			hit_pos_01.graphics.lineTo(419,196);	
			hit_pos_01.graphics.lineTo(240,198);	
			
			
			hit_pos_01.graphics.endFill(false);
			hit_pos_01.alpha = 0.0;
			
			hit_pos_01.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_01);
			
			
			hit_pos_02 = new Shape();
			hit_pos_02.touchable = false;
			hit_pos_02.graphics.beginFill(0xff0000);
			
			hit_pos_02.graphics.lineTo(465,8);	
			hit_pos_02.graphics.lineTo(633,58);	
			hit_pos_02.graphics.lineTo(628,173);	
			hit_pos_02.graphics.lineTo(524,216);	
			hit_pos_02.graphics.lineTo(455,180);	
			
			
			hit_pos_02.graphics.endFill(false);
			hit_pos_02.alpha = 0.0;
			
			hit_pos_02.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_02);
			
			hit_pos_03 = new Shape();
			hit_pos_03.touchable = false;
			hit_pos_03.graphics.beginFill(0xff0000);
			
			hit_pos_03.graphics.lineTo(205,264);	
			hit_pos_03.graphics.lineTo(244,222);	
			hit_pos_03.graphics.lineTo(380,243);	
			hit_pos_03.graphics.lineTo(399,368);	
			hit_pos_03.graphics.lineTo(357,401);	
			hit_pos_03.graphics.lineTo(222,382);	
			
			
			hit_pos_03.graphics.endFill(false);
			hit_pos_03.alpha = 0.0;
			
			hit_pos_03.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_03);
			
			hit_pos_04 = new Shape();
			hit_pos_04.touchable = false;
			hit_pos_04.graphics.beginFill(0xff0000);
			
			hit_pos_04.graphics.lineTo(461,247);	
			hit_pos_04.graphics.lineTo(668,238);	
			hit_pos_04.graphics.lineTo(650,396);	
			hit_pos_04.graphics.lineTo(444,386);	
			
			
			hit_pos_04.graphics.endFill(false);
			hit_pos_04.alpha = 0.0;
			
			hit_pos_04.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_04);
			
			hit_pos_05 = new Shape();
			hit_pos_05.touchable = false;
			hit_pos_05.graphics.beginFill(0xff0000);
			
			hit_pos_05.graphics.lineTo(356,425);	
			hit_pos_05.graphics.lineTo(388,402);	
			hit_pos_05.graphics.lineTo(544,423);	
			hit_pos_05.graphics.lineTo(535,478);	
			hit_pos_05.graphics.lineTo(378,487);	
			
			
			hit_pos_05.graphics.endFill(false);
			hit_pos_05.alpha = 0.0;
			
			hit_pos_05.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_05);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleTarPit as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitObj,true
						);
					}else if(hit_pos_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Line right... arrow left... two... sun... hmmm.");
					}else if(hit_pos_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Line up... arrow right... three... wheel?");
					}else if(hit_pos_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It was painted with a thick white tree sap.");
					}else if(hit_pos_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The markings must be symbolic in nature.");
					}else if(hit_pos_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The line and circle in the same position as the top...");
					}

					
					
					/*
					private var hit_pos_01:Shape;
					private var hit_pos_02:Shape;
					private var hit_pos_03:Shape;
					private var hit_pos_04:Shape;
					private var hit_pos_05:Shape;
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
			
			
			this.assets.removeTexture("jungleTarPitWall_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleTarPitWall_01");
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