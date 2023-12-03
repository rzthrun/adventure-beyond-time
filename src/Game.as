package
{
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.filesystem.File;
	
	import screens.GamePlayHandler;
	import screens.MainMenu;
	import screens.PreLoader;
	import screens.StartUpScreen;
	import screens.ingamescreens.FarCoastDingyEmbedded;
	import screens.ingamescreens.FreightWheelEmbedded;
	import screens.ingamescreens.PirateTopDeckEmbedded;
	import screens.ingamescreens.QueensBookEmbedded;
	import screens.ingamescreens.TriremeDeviceEmbedded;
	import screens.ingamescreens.SubmarineCaptainsEmbedded;
	import screens.sounds.Ambient;
	import screens.sounds.Music;
	import screens.sounds.SoundFX;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import screens.ingamescreens.TemplePascalEmbedded;
	import screens.ingamescreens.ChamberBlueNautilusEmbedded;
	
	public class Game extends Sprite
	{
		
	
		
		[Embed(source="./../fonts/arial2.fnt", mimeType="application/octet-stream")]
		public static const Arial2Xml:Class;
		
		[Embed(source="./../fonts/arial2_0.png")]
		public static const Arial2Texture:Class;
		
		
		[Embed(source="./../fonts/digital.fnt", mimeType="application/octet-stream")]
		public static const DigitalXml:Class;
		
		[Embed(source="./../fonts/digital_0.png")]
		public static const DigitalTexture:Class;
		
		
		public var QueensBookImages:QueensBookEmbedded;
		public var FreighterWheelImages:FreightWheelEmbedded;
		public var PirateTopDeckImages:PirateTopDeckEmbedded;
		public var FarCoastDingyImages:FarCoastDingyEmbedded;
		public var TriremeDeviceImages:TriremeDeviceEmbedded;
		public var SubmarineCaptainsImages:SubmarineCaptainsEmbedded;
		public var TemplePascalImages:TemplePascalEmbedded;
		public var ChamberBlueNautilusImages:ChamberBlueNautilusEmbedded;
		public var PreLoaderObj:PreLoader;
		
		public var SavedGame:Save = new Save();
		public var screenStartUp:StartUpScreen;
		private var screenMainMenu:MainMenu;
		public var screenGamePlayHandler:GamePlayHandler;
		
		public var BlackOutRect:Quad;
		public var BORFadeOutTween:Tween;
		
		public var SoundFXObj:SoundFX;
		public var MusicObj:Music;
		public var AmbientObj:Ambient;
		public var assets:AssetManager;
		
		public var LoadedAssetArr:Array = new Array();
		
		public var thinFat:Boolean;
		public var rationChange:Number; 
		
		
		public function Game()
		{
			
			
			super();
			
			
			var texture:Texture = Texture.fromBitmap(new Arial2Texture());
			var xml:XML = XML(new Arial2Xml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
			
			var texture2:Texture = Texture.fromBitmap(new DigitalTexture());
			var xml2:XML = XML(new DigitalXml());
			TextField.registerBitmapFont(new BitmapFont(texture2, xml2));
			
			rationChange = (Starling.current.nativeStage.fullScreenHeight / Starling.current.nativeStage.fullScreenWidth) - (512/800);
			
			if ((Starling.current.nativeStage.fullScreenHeight / Starling.current.nativeStage.fullScreenWidth) < (512/800)){
				thinFat = true;
			}else{
				thinFat = false;
			}
			
			if(thinFat == true){
				
				//this.x = 
				var ratio:Number = (Starling.current.nativeStage.fullScreenWidth / 800);
			//	this.x = -(Math.abs(((945*ratio)-Starling.current.nativeStage.stageWidth)/2));
				this.height = 512;
				this.width = 800;

			}else{
				
				
			}
			
			/*This is the asset Manager, you are going to pass it down to the game objects
			Let's try it, It will need to be referenced by all of them.
			*/
			assets = new AssetManager();
			
			
			SoundFXObj = new SoundFX();
			MusicObj = new Music();
			AmbientObj = new Ambient();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			BlackOutRect = new Quad(800,512);
			BlackOutRect.touchable = false;
			BlackOutRect.setVertexColor(0, 0x000000);
			BlackOutRect.setVertexColor(1, 0x000000);
			BlackOutRect.setVertexColor(2, 0x000000);
			BlackOutRect.setVertexColor(3, 0x000000);
			BlackOutRect.alpha = 0;
			BlackOutRect.x = 0;
			BlackOutRect.y = 0;			
			
		}
		
		public function TrackAssets(FileTag:String):void{
			LoadedAssetArr[FileTag] = true;
		}
		public function CheckAsset(FileTag:String):Boolean{
			if(LoadedAssetArr[FileTag] === true){
				return true;
			}else{
				return false;
			}
		}
		public function falseAsset(FileTag:String):void{
			LoadedAssetArr[FileTag] = false;
		}
		
		//public function onAddedToStage():void
		public function onAddedToStage(event:starling.events.Event):void
		{
			
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			(stage.getChildAt(0) as Object).SoundFXObj.LoadGlobalGamePlaySoundFX();
			screenStartUp = new StartUpScreen(this.assets);
			screenStartUp.alpha = 1;
			
			
			this.addChild(screenStartUp);	
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, handleDeactivate, false, 0, true);
		}	
		
		public function addMainMenuFromFinish(blackOut:Boolean = false):void{
		
			MusicObj.currentSong = null;
			MusicObj.soundManager.stopSound("JamLoop");
			AmbientObj.currentAmbient = null;
			AmbientObj.soundManager.stopAllSounds();
	
			this.removeChild(screenGamePlayHandler);
			screenGamePlayHandler.dispose();
			screenGamePlayHandler = null;
			trace("MainMenuFunc");
			screenMainMenu = new MainMenu(this,this.assets,false);
			screenMainMenu.alpha = 1;
			
			addMainMenu(false);		
		}
		
		public function addPreLoader():void{
			
			//		this.removeChild(screenStartUp,true);
			//if(fromGame === false){
			//			screenStartUp.dispose();
			//			screenStartUp = null;
			//}
			
			PreLoaderObj = new PreLoader(this.assets)
			this.addChild(PreLoaderObj);
			QueensBookImages = PreLoaderObj.QueensBookImages;
			FreighterWheelImages = PreLoaderObj.FreighterWheelImages;
			PirateTopDeckImages = PreLoaderObj.PirateTopDeckImages;
			FarCoastDingyImages = PreLoaderObj.FarCoastDingyImages;
			TriremeDeviceImages = PreLoaderObj.TriremeDeviceImages;
			SubmarineCaptainsImages = PreLoaderObj.SubmarineCaptainsImages;
			TemplePascalImages = PreLoaderObj.TemplePascalImages;
			ChamberBlueNautilusImages = PreLoaderObj.ChamberBlueNautilusImages;
			//FreighterWheelImages:FreightWheelEmbedded;
			
		}
		
		public function addMainMenu(fromGame:Boolean=true):void{
			this.removeChild(screenStartUp,true);
			this.removeChild(PreLoaderObj,true);
			MusicObj.LoadMainTheme();
		
			trace("MainMenuFunc");
			screenMainMenu = new MainMenu(this,this.assets,fromGame);
			screenMainMenu.alpha = 1;
			
			this.addChildAt(screenMainMenu,0);			
			
		}
		public function addGamePlay():void{
			this.assets.removeTexture("MainMenu_spriteSheet_01",true);
			this.assets.removeTextureAtlas("MainMenu_spriteSheet_01",true);
			this.assets.removeTexture("MainMenu_spriteSheet_02",true);
			this.assets.removeTextureAtlas("MainMenu_spriteSheet_02",true);
			this.assets.removeTexture("MainMenu_spriteSheet_03",true);
			this.assets.removeTextureAtlas("MainMenu_spriteSheet_03",true);
			this.assets.removeTexture("MainMenu_spriteSheet_04",true);
			this.assets.removeTextureAtlas("MainMenu_spriteSheet_04",true);
			this.assets.removeTexture("MainMenu_spriteSheet_05",true);
			this.assets.removeTextureAtlas("MainMenu_spriteSheet_05",true);
			this.assets.removeTexture("mainMenu_bg",true);
		//	this.assets.removeTexture("Reset_bg",true);
		//	this.assets.removeTexture("VolButton",true);
			falseAsset("mainMenu_01");
			falseAsset("mainMenu_02");
			falseAsset("mainMenu_03");
			falseAsset("mainMenu_04");
			falseAsset("mainMenu_05");
			falseAsset("mainMenu_06");
			falseAsset("mainMenu_07");
			falseAsset("mainMenu_08");
			falseAsset("mainMenu_09");
			falseAsset("mainMenu_10");
			falseAsset("mainMenu_11");
			/*
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/v2/MainMenu_spriteSheet.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_01');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/v2/MainMenu_spriteSheet.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_02');
				
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/plate_exterior_wide_v002a006.jpg'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_03');
			}
			*/
			
			
			this.removeChild(screenMainMenu,true);
			screenMainMenu.dispose();
			screenMainMenu = null;
			screenGamePlayHandler = new GamePlayHandler(true,assets,this,BlackOutRect);
			screenGamePlayHandler.alpha = 1;
			this.addChildAt(screenGamePlayHandler,0);
			
//			screenGamePlayHandler.rotation = 3.14159265;
//			screenGamePlayHandler.x = 800;
//			screenGamePlayHandler.y = 480;
			
			
		}
		public function unLoadGamePlay():void{
			this.removeChild(screenGamePlayHandler,true);
			screenGamePlayHandler.dispose();
			screenGamePlayHandler = null;
			addMainMenu();
			
		}
		
		public function BlackOutRectangleFade(FadeTo:Number = 1,duration:Number = 1,OnComplateCallback:Function = null):void{
			if(FadeTo == 1){
				BlackOutRect.alpha = 0;
				trace("Rect 0");
			}else{
				BlackOutRect.alpha = 1;
				trace("Rect 1");
			}
			
			BlackOutRect.touchable = true;
			this.addChildAt(BlackOutRect,1);
			BORFadeOutTween = new Tween(BlackOutRect, duration, Transitions.LINEAR);
			BORFadeOutTween.fadeTo(FadeTo);
			BORFadeOutTween.onComplete = null;
			BORFadeOutTween.onComplete = function():void{OnCompleteBlackRectFade(OnComplateCallback)};
			Starling.juggler.add(BORFadeOutTween);		
			
			
		}
		public function OnCompleteBlackRectFade(callback:Function = null):void{
			BlackOutRect.touchable = false;
			this.removeChild(BlackOutRect);
			if(callback == null){
				trace("BackRect CB is NULL");
				
			}else{
				trace("BackRect CB is NOT NULL");
				callback();
			}
			
			
			trace("Black Rectangle Removed");
		}
		
		
		
		public function handleDeactivate(e:flash.events.Event):void{
			NativeApplication.nativeApplication.removeEventListener(flash.events.Event.DEACTIVATE, handleDeactivate);
			
			MusicObj.PauseAll();
			AmbientObj.PauseAll();
			MusicObj.soundManager.stopAllSounds();
			AmbientObj.soundManager.stopAllSounds();
		//	(stage.getChildAt(0) as Object).AmbientObj.globalVol = 0;

			//Active = false;
			//	MusicObj.handleDeactivate();
			//	SoundFXObj.handleDeactivate();
			//if(IntroSequenceObj.finished == "no"){
			//	IntroSequenceObj.tm.stop();
			trace("Deactivated");
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, handleActivate, false, 0, true);
		}
		public function handleActivate(e):void{
			NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, handleActivate);
			//	Active = true;
			//	MusicObj.handleActivate();
			//	SoundFXObj.handleActivate();
			//IntroSequenceObj.tm.start();
			AmbientObj.resumeCurrentSong();
			MusicObj.resumeCurrentSong();
		//	(stage.getChildAt(0) as Object).AmbientObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.AmbientObj.data.AmbientVol;

			trace("Activated");
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, handleDeactivate, false, 0, true);
		}
				
		
		
		
		
		
		
	}
}