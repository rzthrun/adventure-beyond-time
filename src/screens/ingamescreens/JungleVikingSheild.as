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
	
	public class JungleVikingSheild extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_head:Shape;
		private var hit_sheild:Shape;
		private var hit_wood:Shape;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleVikingSheild(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleVikingSheild_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingSheild/jungleVikingSheild_bg.jpg'));
				game.TrackAssets('jungleVikingSheild_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingSheild","JungleVikingSheildObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleVikingSheild_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			//FadeOutOcean(1);
			CreateHitWood();
			CreateHitSheild();
			CreateHitHead();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999,2);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingSheild != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingSheild['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingSheild;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingSheild',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingSheild',SaveArray);
			}
		}
		
		
		private function CreateHitWood():void{
			hit_wood = new Shape();
			hit_wood.touchable = false;
			hit_wood.graphics.beginFill(0xff0000);
			
			hit_wood.graphics.lineTo(511,73);				
			hit_wood.graphics.lineTo(777,133);				
			hit_wood.graphics.lineTo(793,352);				
			hit_wood.graphics.lineTo(596,506);				
			hit_wood.graphics.lineTo(511,506);				
			
			hit_wood.graphics.endFill(false);
			hit_wood.alpha = 0.0;
			
			hit_wood.graphics.precisionHitTest = true;	
			this.addChild(hit_wood);
		}
		
		private function CreateHitSheild():void{
			hit_sheild = new Shape();
			hit_sheild.touchable = false;
			hit_sheild.graphics.beginFill(0xff0000);
			
			hit_sheild.graphics.lineTo(93,277);				
			hit_sheild.graphics.lineTo(113,104);				
			hit_sheild.graphics.lineTo(239,0);				
			hit_sheild.graphics.lineTo(378,0);				
			hit_sheild.graphics.lineTo(525,97);				
			hit_sheild.graphics.lineTo(593,278);				
			hit_sheild.graphics.lineTo(543,442);				
			hit_sheild.graphics.lineTo(451,507);				
			hit_sheild.graphics.lineTo(276,508);				
			hit_sheild.graphics.lineTo(151,413);				
			
			
			hit_sheild.graphics.endFill(false);
			hit_sheild.alpha = 0.0;
			
			hit_sheild.graphics.precisionHitTest = true;	
			this.addChild(hit_sheild);
		}
		
		private function CreateHitHead():void{
			hit_head = new Shape();
			hit_head.touchable = false;
			hit_head.graphics.beginFill(0xff0000);
			
			hit_head.graphics.lineTo(122,98);				
			hit_head.graphics.lineTo(155,51);				
			hit_head.graphics.lineTo(231,32);				
			hit_head.graphics.lineTo(346,54);				
			hit_head.graphics.lineTo(335,140);				
			hit_head.graphics.lineTo(156,155);				
						
			
			hit_head.graphics.endFill(false);
			hit_head.alpha = 0.0;
			
			hit_head.graphics.precisionHitTest = true;	
			this.addChild(hit_head);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleVikingDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingDeckObj,true
						);
					}else if(hit_head.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A ferocious head with sharp teeth is depicted.");	
					}else if(hit_sheild.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The green body of the dragon twists in an interweaving pattern.");	
					}else if(hit_wood.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wood is old and crumbles at the touch.");	
					}
					/*
					private var hit_head:Shape;
					private var hit_sheild:Shape;
					private var hit_wood:Shape;
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
			
			
			this.assets.removeTexture("jungleVikingSheild_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingSheild_01");
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
