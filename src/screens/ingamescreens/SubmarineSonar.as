package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;

	public class SubmarineSonar extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var symbols_cir:Image;
		private var constels_cir:Image;
		
		private var hit_sonar:Shape;
		private var hit_moon:Shape;
		
		//private var PhraseCounter:int = 0;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var Spinning:Boolean = true;
		
		private var goback:GoBackButton;
		
		public function SubmarineSonar(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineSonar_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineSonar/submarineSonar_bg.jpg'));
				game.TrackAssets('submarineSonar_01');
			}
			
			if(game.CheckAsset('submarineSonar_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineSonar/SubmarineSonar_Sprite.png'));
				game.TrackAssets('submarineSonar_02');
			}
			
			if(game.CheckAsset('submarineSonar_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineSonar/SubmarineSonar_Sprite.xml'));
				game.TrackAssets('submarineSonar_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineSonar","SubmarineSonarObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineSonar_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			symbols_cir = new Image(this.assets.getTexture('symbols'));
			symbols_cir.touchable = false;
			symbols_cir.x = 280;
			symbols_cir.y = 255;
			symbols_cir.pivotX = 255;
			symbols_cir.pivotY = 255;
			symbols_cir.alpha = 1;
			this.addChildAt(symbols_cir,1);
			
			constels_cir = new Image(this.assets.getTexture('constels'));
			constels_cir.touchable = false;
			constels_cir.x = 280;
			constels_cir.y = 255;
			constels_cir.pivotX = 255;
			constels_cir.pivotY = 255;
			constels_cir.alpha = 1;
			this.addChildAt(constels_cir,2);
			//FadeOutOcean(1);
			
			CreateHitSonar();
			CreateHitMoon();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineSonar != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineSonar['Spinning'] == 'no'){
					Spinning = false;
				}else{
					
				}
			}else{
				
			}
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, OnFrameHandler);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadSonar(true,999);
			},1.5);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
		
			//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			
		}
		
		private function OnFrameHandler(e:Event):void{
			if(Spinning === true){
				symbols_cir.rotation = symbols_cir.rotation+deg2rad(2);
				constels_cir.rotation = constels_cir.rotation+deg2rad(1);
			}else{
				
			}
		}
		//hit_moon
		private function CreateHitMoon():void{
			hit_moon = new Shape();
			hit_moon.touchable = false;
			hit_moon.graphics.beginFill(0x00ff00);
			
			hit_moon.graphics.lineTo(543,61);	
			hit_moon.graphics.lineTo(655,71);	
			hit_moon.graphics.lineTo(673,400);	
			hit_moon.graphics.lineTo(583,498);	
			hit_moon.graphics.lineTo(542,490);	
			
			hit_moon.graphics.endFill(false);
			hit_moon.alpha = 0.0;
			hit_moon.graphics.precisionHitTest = true;	
			this.addChild(hit_moon);
			
		}
		private function CreateHitSonar():void{
			hit_sonar = new Shape();
			hit_sonar.touchable = false;
			hit_sonar.graphics.beginFill(0x00ff00);
			
			hit_sonar.graphics.lineTo(0,247);	
			hit_sonar.graphics.lineTo(56,68);	
			hit_sonar.graphics.lineTo(225,0);	
			hit_sonar.graphics.lineTo(398,0);	
			hit_sonar.graphics.lineTo(538,141);	
			hit_sonar.graphics.lineTo(538,385);	
			hit_sonar.graphics.lineTo(389,512);	
			hit_sonar.graphics.lineTo(108,512);	
			
			hit_sonar.graphics.endFill(false);
			hit_sonar.alpha = 0.0;
			hit_sonar.graphics.precisionHitTest = true;	
			this.addChild(hit_sonar);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineConsole as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineConsoleObj,true
						);
					}else if(hit_sonar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineSonar != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineSonar;
						}
						
						if(Spinning === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
							Spinning = false;
							SaveArray['Spinning'] = 'no';		
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
							Spinning = true;
							SaveArray['Spinning'] = 'yes';		
						}
						
								
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineSonar',SaveArray);
						
						
					
						
					}else if(hit_moon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						//if(PhraseCounter == 0){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The vertical row of circles resembles the lunar cycle.");
						//}
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
			
			
			this.assets.removeTexture("submarineSonar_bg",true);
			this.assets.removeTexture("SubmarineSonar_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineSonar_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineSonar_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineSonar_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineSonar_03");
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