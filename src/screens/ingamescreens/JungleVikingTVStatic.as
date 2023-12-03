package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class JungleVikingTVStatic extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:MovieClip;
		
		private var message:Image;
		private var hood_left:Image;
		private var hood_right:Image;
		
		private var hit_screen:Shape;
		
		private var currentPage:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleVikingTVStatic(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleVikingTVStatic_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTVStatic/JungleVikingTVStatic_Sprite_01.jpg'));
				game.TrackAssets('jungleVikingTVStatic_01');
			}
			if(game.CheckAsset('jungleVikingTVStatic_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTVStatic/JungleVikingTVStatic_Sprite_01.xml'));
				game.TrackAssets('jungleVikingTVStatic_02');
			}
			if(game.CheckAsset('jungleVikingTVStatic_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTVStatic/JungleVikingTVStatic_Sprite_02.png'));
				game.TrackAssets('jungleVikingTVStatic_03');
			}
			if(game.CheckAsset('jungleVikingTVStatic_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTVStatic/JungleVikingTVStatic_Sprite_02.xml'));
				game.TrackAssets('jungleVikingTVStatic_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingTVStatic","JungleVikingTVStaticObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	bg = new Image(this.assets.getTexture('coastSkeleton_bg_one'));
		//	bg.touchable = true;
		//	this.addChild(bg);
			
			bg = new MovieClip(this.assets.getTextures("static_"),12);
			bg.x = 0;
			bg.y = 0;
			bg.width = 800;
			bg.height = 512;
			bg.touchable = true;
			bg.loop = true; // default: true
			bg.play();
			this.addChildAt(bg,0);	
	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTVStatic != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTVStatic["currentPage"] == "curPageIs_00"){
					currentPage = 0;
					message = new Image(this.assets.getTexture('page_01'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTVStatic["currentPage"] == "curPageIs_01"){					
					currentPage = 1;
					message = new Image(this.assets.getTexture('page_02'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTVStatic["currentPage"] == "curPageIs_02"){
					currentPage = 2;
					message = new Image(this.assets.getTexture('page_03'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTVStatic["currentPage"] == "curPageIs_03"){	
					currentPage = 3;
					message = new Image(this.assets.getTexture('page_04'));
				}else{
					currentPage = 0;
					message = new Image(this.assets.getTexture('page_01'));
				}
			}else{
				currentPage = 0;
				message = new Image(this.assets.getTexture('page_01'));
			}
			
		
			message.touchable = false;
			message.x = 155;
			message.y = 20;	

			hood_left = new Image(this.assets.getTexture('left'));
			hood_left.touchable = false;
			hood_left.x = 0;
			hood_left.y = 0;	
			
			hood_right = new Image(this.assets.getTexture('right'));
			hood_right.touchable = false;
			hood_right.x = 746;
			hood_right.y = 0;	
			
			message.alpha = 1;
			hood_left.alpha = 1;
			hood_right.alpha = 1;
			
			this.addChildAt(message,1);	
			this.addChildAt(hood_left,2);	
			this.addChildAt(hood_right,3);	
			
			CreateHitScreen();
			//FadeOutOcean(1);
			Starling.juggler.add(bg);
		
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Jungle_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipCreaks",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadTVStatic(true,999);
		}
		
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(152,12);				
			hit_screen.graphics.lineTo(638,12);				
			hit_screen.graphics.lineTo(638,478);				
			hit_screen.graphics.lineTo(152,478);				
			
			
			hit_screen.graphics.endFill(false);
			hit_screen.alpha = 0.0;
			
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleVikingTV as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingTVObj,true
						);
					}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
						MessageHandler();
					}
				}
			}
		}
		private function MessageHandler():void{
			if(currentPage == 0){
				currentPage = 1;
				message.texture = this.assets.getTexture('page_02');
			}else if(currentPage == 1){
				currentPage = 2;
				message.texture = this.assets.getTexture('page_03');
			}else if(currentPage == 2){
				currentPage = 3;
				message.texture = this.assets.getTexture('page_04');
			}else if(currentPage == 3){
				currentPage = 0;
				message.texture = this.assets.getTexture('page_01');
			}
			
			SaveArray["currentPage"] = "curPageIs_0"+currentPage;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTVStatic',SaveArray);
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
			
			
			this.assets.removeTexture("JungleVikingTVStatic_Sprite_01",true);
			this.assets.removeTextureAtlas("JungleVikingTVStatic_Sprite_01",true);
			this.assets.removeTexture("JungleVikingTVStatic_Sprite_02",true);
			this.assets.removeTextureAtlas("JungleVikingTVStatic_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTVStatic_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTVStatic_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTVStatic_03");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTVStatic_04");
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