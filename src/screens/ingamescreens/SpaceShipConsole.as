package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class SpaceShipConsole extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var tricorder:Image;
		private var blue:Image;
		private var lights:Image;
		
		private var hit_tricorder:Shape
		private var hit_blue:Shape;
		private var hit_keyBoard:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var LightsTween:Tween;
		private var BlueTween:Tween;
		
		
		private var Animating:Boolean = false;
		private var TricorderAttached:Boolean = false;
		public var delayedcall:DelayedCall;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function SpaceShipConsole(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('spaceShipConsole_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipConsole/SpaceShipConsole_Sprite.jpg'));
				game.TrackAssets('spaceShipConsole_01');
			}
			if(game.CheckAsset('spaceShipConsole_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipConsole/SpaceShipConsole_Sprite.xml'));
				game.TrackAssets('spaceShipConsole_02');
			}
			if(game.CheckAsset('spaceShipConsole_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipConsole/SpaceShipConsole_Sprite_02.png'));
				game.TrackAssets('spaceShipConsole_03');
			}
			if(game.CheckAsset('spaceShipConsole_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipConsole/SpaceShipConsole_Sprite_02.xml'));
				game.TrackAssets('spaceShipConsole_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SpaceShipConsole","SpaceShipConsoleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('spaceShipConsole_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			tricorder = new Image(this.assets.getTexture('tricorder'));
			tricorder.touchable = false;
			tricorder.x = 347;
			tricorder.y = 184;
			
			
			lights = new Image(this.assets.getTexture('lights'));
			lights.touchable = false;
			lights.x = 0;
			lights.y = 0;
			
			
			blue = new Image(this.assets.getTexture('blue'));
			blue.touchable = false;
			blue.x = 0;
			blue.y = 0;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == ['Attached']){
					TricorderAttached = true;
					
					tricorder.alpha = 1;
					lights.alpha = 0;
					blue.alpha = 1;
				}else{
					
					tricorder.alpha = 0;
					lights.alpha = 0;
					blue.alpha = 0;
				}
			}else{
				
				tricorder.alpha = 0;
				lights.alpha = 0;
				blue.alpha = 0;
			}
			
			
			this.addChildAt(tricorder,1);
			this.addChildAt(lights,2);			
			this.addChildAt(blue,3);
			CreateKeyBoardHit();
			CreateTricorderHit();
			CreateBlueHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == 'Attached'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,999);
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipConsole',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipConsole',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
					},0.5);
				}
			}
		
			
		}
		//hit_keyBoard
		private function CreateKeyBoardHit():void{
			hit_keyBoard = new Shape();
			hit_keyBoard.touchable = false;
			hit_keyBoard.graphics.beginFill(0xff0000);
			
			hit_keyBoard.graphics.lineTo(179,512);	
			hit_keyBoard.graphics.lineTo(332,345);	
			hit_keyBoard.graphics.lineTo(506,289);	
			hit_keyBoard.graphics.lineTo(726,330);	
			hit_keyBoard.graphics.lineTo(743,380);	
			hit_keyBoard.graphics.lineTo(480,429);	
			hit_keyBoard.graphics.lineTo(368,506);	
			
			hit_keyBoard.graphics.endFill(false);
			hit_keyBoard.alpha = 0.0;
			
			hit_keyBoard.graphics.precisionHitTest = true;	
			this.addChild(hit_keyBoard);
		}
		
		
		private function CreateTricorderHit():void{
			hit_tricorder = new Shape();
			hit_tricorder.touchable = false;
			hit_tricorder.graphics.beginFill(0xff0000);
				
			hit_tricorder.graphics.lineTo(296,174);	
			hit_tricorder.graphics.lineTo(402,144);	
			hit_tricorder.graphics.lineTo(454,261);	
			hit_tricorder.graphics.lineTo(348,299);	

			hit_tricorder.graphics.endFill(false);
			hit_tricorder.alpha = 0.0;
			
			hit_tricorder.graphics.precisionHitTest = true;	
			this.addChild(hit_tricorder);
		}
		
		private function CreateBlueHit():void{
			hit_blue = new Shape();
			hit_blue.touchable = false;
			hit_blue.graphics.beginFill(0xff0000);
			
			hit_blue.graphics.lineTo(45,116);	
			hit_blue.graphics.lineTo(517,3);	
			hit_blue.graphics.lineTo(571,43);	
			hit_blue.graphics.lineTo(639,246);	
			hit_blue.graphics.lineTo(626,311);	
			hit_blue.graphics.lineTo(184,456);	
			hit_blue.graphics.lineTo(91,392);	

			hit_blue.graphics.endFill(false);
			hit_blue.alpha = 0.0;
			
			hit_blue.graphics.precisionHitTest = true;	
			this.addChild(hit_blue);
		}

		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((SpaceShipInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipInteriorObj,true
							);
						}else if(TricorderAttached === false){
							if(hit_tricorder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TricorderHandler();
							}else if(hit_keyBoard.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakTwo();
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Nothing happens when I press the buttons.");

								}else if(PhraseCounter == 1){
									PhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Electrical circuits run between the keys on the console.");

								}else if(PhraseCounter == 2){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Nothing labeled - all the keys are the same eerie dark grey.");
								}
							}else if(hit_blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pipes and circuits run into the clean metal surface.");
									
								}else if(PhraseCounter == 1){
									PhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I see buttons, but no sort of visual interface.");
									
								}else if(PhraseCounter == 2){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This must be a control station...");
								}
							}
							
							/*
							private var hit_keyBoard:Shape;
							
							private var PhraseCounter:Shape;
							*/
							
						}else{
							if(hit_blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((SpaceShipPuzzle as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipPuzzleObj,true
								);
							}
						}
					}
				}
			}
		}
		
		private function TricorderHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Tricorder)
			{
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeClose();
				Animating = true;
				TricorderAttached = true;
				tricorder.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Tricorder,
						"item_Tricorder"
					);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole;
				}
				SaveArray["Tricorder"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipConsole',SaveArray);
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("SpaceHum",0,0.5,'stop');
					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
					LightsAnimator();
				},1.5);
			}else{
				if(PhraseCounter == 0){
					PhraseCounter = 1;
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's an oblong opening in the center of the console.");
					
				}else if(PhraseCounter == 1){
					PhraseCounter = 2;
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't see beyond the rim of the opening; all fades to darkness quickly inside.");
					
				}else if(PhraseCounter == 2){
					PhraseCounter = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Tricorder'] == 'PickedUp'){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The opening is roughly the size of the device I found by the strange skeleton.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole gapes silently, almost as though it were waiting.");
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole gapes silently, almost as though it were waiting.");
					}
					
				}
			}
		}
		
		/*
		private var LightsTween:Tween;
		private var BlueTween:Tween;
		*/
		private function LightsAnimator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			
			LightsTween = new Tween(lights, 2, Transitions.LINEAR);
			LightsTween.fadeTo(1);
			LightsTween.onComplete = function():void{
				game.SoundFXObj.PlaySFX_CosmicWaffle();
				BlueAnimator();
				LightsTween = null;
			}
			Starling.juggler.add(LightsTween);
		}
		private function BlueAnimator():void{
			
			BlueTween = new Tween(blue, 2.5, Transitions.LINEAR);
			BlueTween.fadeTo(1);
			BlueTween.onComplete = function():void{
				game.SoundFXObj.PlaySFX_CosmicProcess();
				
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,1);
					},3);
				}
				
				Animating = false;
				BlueTween = null;
			}
			Starling.juggler.add(BlueTween);
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
			
			
			
			this.assets.removeTexture("SpaceShipConsole_Sprite",true);
			this.assets.removeTextureAtlas("SpaceShipConsole_Sprite",true);
			this.assets.removeTexture("SpaceShipConsole_Sprite_02",true);
			this.assets.removeTextureAtlas("SpaceShipConsole_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("spaceShipConsole_01");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipConsole_02");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipConsole_03");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipConsole_04");
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
