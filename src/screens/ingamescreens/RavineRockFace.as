package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class RavineRockFace extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var message:Image;
		private var waves:MovieClip;
		
		private var hit_message:Shape;
		private var hit_rock:Shape;
		
		private var MessageOpen:Boolean = false;
		private var Animating:Boolean = false;
		
		private var PhraseCounter:int = 0;
		
		private var WavesTween:Tween;
		private var MessageTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function RavineRockFace(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineRockFace_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRockFace/ravineRockFace_bg.jpg'));
				game.TrackAssets('ravineRockFace_01');
			}
			if(game.CheckAsset('ravineRockFace_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRockFace/RavineRockFace_Sprite_01.png'));
				game.TrackAssets('ravineRockFace_02');
			}
			if(game.CheckAsset('ravineRockFace_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRockFace/RavineRockFace_Sprite_01.xml'));
				game.TrackAssets('ravineRockFace_03');
			}
			if(game.CheckAsset('ravineRockFace_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRockFace/RavineRockFace_Sprite_02.atf'));
				game.TrackAssets('ravineRockFace_04');
			}
			if(game.CheckAsset('ravineRockFace_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRockFace/RavineRockFace_Sprite_02.xml'));
				game.TrackAssets('ravineRockFace_05');
			}
			//RavineRockFace_Sprite_01
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineRockFace","RavineRockFaceObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace;
			}
			SaveArray['MessageOpen'] = 'No';
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRockFace',SaveArray);
			*/
			bg = new Image(this.assets.getTexture('ravineRockFace_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			message = new Image(this.assets.getTexture('full_message'));
			message.smoothing = TextureSmoothing.NONE;

			message.touchable = true;
			message.x = 113;
			message.y = 142;
			
			//FadeOutOcean(1);
			
			waves = new MovieClip(this.assets.getTextures("radio_"),8);

			waves.width = waves.width*2;
			waves.height = waves.height*2;
			waves.x = 114;
			waves.y = 21;
			waves.touchable = false;
			waves.loop = true; 
			
	//		waves.alpha = 0.6;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace['MessageOpen'] == 'Yes'){
					MessageOpen = true;
					message.alpha = 1;
				}else{
					message.alpha = 0;
				}
			}else{
				message.alpha = 0;
			}
			
			waves.alpha = 0;
		
			
			this.addChildAt(message,1);
			this.addChildAt(waves,2);	
			
			Starling.juggler.add(waves);
			CreateRockHit();
			CreateMessageHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
		}
		//hit_rock
		private function CreateRockHit():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(23,362);	
			hit_rock.graphics.lineTo(133,0);	
			hit_rock.graphics.lineTo(660,0);	
			hit_rock.graphics.lineTo(795,366);	
			hit_rock.graphics.lineTo(346,496);	
			
			
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		
		private function CreateMessageHit():void{
			hit_message = new Shape();
			hit_message.touchable = false;
			hit_message.graphics.beginFill(0xff0000);
			
			hit_message.graphics.lineTo(100,206);	
			hit_message.graphics.lineTo(594,101);	
			hit_message.graphics.lineTo(715,202);	
			hit_message.graphics.lineTo(601,326);	
			hit_message.graphics.lineTo(91,394);	

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
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((RavineSpaceShip as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipObj,true
							);
						}else if(hit_message.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(MessageOpen === true){
								if(PhraseCounter == 0){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are five glowing symbols etched into the rockface.");
									PhraseCounter = 1;
								}else if(PhraseCounter == 1){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The symbols all consist of straight lines and dots.");
									PhraseCounter = 2;
								}else if(PhraseCounter == 2){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This is clearly the work of whomever came from the spacecraft.");
									PhraseCounter = 0;
								}
							}else{
								MessageHandler();
							}
						}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock is hard and dense.");

						}
					}
				}
			}
		}
		
		private function MessageHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Tricorder)
			{
				
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicRays();
					(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');
					Animating = true;
					MessageOpen = true;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace;
					}
					SaveArray['MessageOpen'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRockFace',SaveArray);
					
					WavesTween = new Tween(waves, 2.0, Transitions.EASE_OUT);
					WavesTween.fadeTo(0.6);
					WavesTween.onComplete = function():void{
						WavesTween = null;
						WavesOut();
					}
					Starling.juggler.add(WavesTween);
				
			}else{
				if(PhraseCounter == 0){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a single strange symbol carved into the rock face.");

					PhraseCounter = 1;
				}else if(PhraseCounter == 1){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like a 'V' with a dot at the intersection.");
					PhraseCounter = 2;
				}else if(PhraseCounter == 2){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like the symbol was made by intense and concentrated heat.");
					PhraseCounter = 0;
				}
				
			}
		}
		
		private function WavesOut():void{
			WavesTween = new Tween(waves, 2.0, Transitions.EASE_IN);
			WavesTween.fadeTo(0);
			WavesTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
			}
			MessageTween = new Tween(message, 2.2, Transitions.EASE_IN);
			MessageTween.fadeTo(1);
			MessageTween.onComplete = function():void{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,0);
				
				}
				MessageTween = null;
				WavesTween = null;
				Animating = false;
			}	
				
				
			Starling.juggler.add(WavesTween);
			Starling.juggler.add(MessageTween);
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
			
			
			this.assets.removeTexture("ravineRockFace_bg",true);
			this.assets.removeTexture("RavineRockFace_Sprite_01",true);
			this.assets.removeTextureAtlas("RavineRockFace_Sprite_01",true);
			this.assets.removeTexture("RavineRockFace_Sprite_02",true);
			this.assets.removeTextureAtlas("RavineRockFace_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineRockFace_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineRockFace_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineRockFace_03");
			(stage.getChildAt(0) as Object).falseAsset("ravineRockFace_04");
			(stage.getChildAt(0) as Object).falseAsset("ravineRockFace_05");
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