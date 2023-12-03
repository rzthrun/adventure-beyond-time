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
	
	public class JungleEnclaveMessage extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_message:Shape;
		private var MessagePhraseCounter:int = 0;
		private var SubSolved:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleEnclaveMessage(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleEnclaveMessage_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveMessage/jungleEnclaveMessage_bg.jpg'));
				game.TrackAssets('jungleEnclaveMessage_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleEnclaveMessage","JungleEnclaveMessageObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleEnclaveMessage_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					SubSolved = true;
				}
			}
			CreateHitMessage();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveMessage != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveMessage['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveMessage;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveMessage',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveMessage',SaveArray);
			}
			
		}
		
		
		private function CreateHitMessage():void{
			hit_message = new Shape();
			hit_message.touchable = false;
			hit_message.graphics.beginFill(0xff0000);
			
			hit_message.graphics.lineTo(136,328);																																																																																																																														
			hit_message.graphics.lineTo(146,21);																																																																																																																														
			hit_message.graphics.lineTo(653,47);																																																																																																																														
			hit_message.graphics.lineTo(668,408);																																																																																																																														
			hit_message.graphics.lineTo(566,498);																																																																																																																														
			hit_message.graphics.lineTo(231,456);																																																																																																																														
																																																																																																																															
			
			hit_message.graphics.endFill(false);
			hit_message.alpha = 0.0;
			
			hit_message.graphics.precisionHitTest = true;	
			this.addChild(hit_message);
		}

		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveObj,true
						);
					}else if(hit_message.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(SubSolved === false){
							trace("1");
							if(MessagePhraseCounter == 0){
								trace("2");
								MessagePhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Six symbols have been etched into the wall.");
							}else if(MessagePhraseCounter == 1){
								trace("3");
								MessagePhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shapes must be abstract.");
							}else if(MessagePhraseCounter == 2){
								trace("4");
								MessagePhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Two of the symbols repeat.");
							}
						}else{
							if(MessagePhraseCounter == 0){
								MessagePhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These show the lever positions to activate the submarine's main power.");
							}else if(MessagePhraseCounter == 1){
								MessagePhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder who put these here...");
							}else if(MessagePhraseCounter == 2){
								MessagePhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder who put these here...");
							}
						}
				//		(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock forms a natural shelf.");
					}
					
					/*
					private var hit_message:Shape;
					private var MessagePhraseCounter:Shape;
					SubSolved
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
			
			
			this.assets.removeTexture("jungleEnclaveMessage_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveMessage_01");
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
