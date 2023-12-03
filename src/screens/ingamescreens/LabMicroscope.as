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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	
	public class LabMicroscope extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var goo:Image;
		private var dna:Image;
		private var screen:Image;
		
		private var hit_screen:Shape;
		private var hit_goo:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var Animating:Boolean = false;
		public var delayedCall:DelayedCall;
		private var GooAttached:Boolean = false;
		private var DNATween:Tween;
		private var Solved:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		
		public function LabMicroscope(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labMicroscope_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMicroscope/labMicroscope_bg.jpg'));
				game.TrackAssets('labMicroscope_01');
			}
			if(game.CheckAsset('labMicroscope_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMicroscope/LabMicroscope_Sprite.png'));
				game.TrackAssets('labMicroscope_02');
			}
			if(game.CheckAsset('labMicroscope_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMicroscope/LabMicroscope_Sprite.xml'));
				game.TrackAssets('labMicroscope_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabMicroscope","LabMicroscopeObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			
			bg = new Image(this.assets.getTexture('labMicroscope_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			goo = new Image(this.assets.getTexture('goo'));
		//	goo.smoothing = TextureSmoothing.NONE;
			goo.touchable = false;
			goo.x = 108;
			goo.y = 1;
			
			dna = new Image(this.assets.getTexture('dna'));
		//	dna.smoothing = TextureSmoothing.NONE;
			dna.touchable = false;
			dna.x = 187;
			dna.y = 34;
			
			screen = new Image(this.assets.getTexture('screen_analyze'));
		//	screen.smoothing = TextureSmoothing.NONE;
			screen.touchable = false;
			screen.x = 16;
			screen.y = 10;
					
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Slide'] == 'Attached'){
					GooAttached = true;
					goo.alpha = 1;
				}else{
					goo.alpha = 0;
				}
			}else{
				goo.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope['Analyzed'] == 'Yes'){
					Solved = true;
					screen.texture = this.assets.getTexture('screen_success');
					dna.alpha = 1;
				}else{
					dna.alpha = 0;
				}
			}else{
				dna.alpha = 0;
			}
			
			
			
			screen.alpha = 1;
			
			this.addChildAt(goo,1);			
			this.addChildAt(dna,2);
			this.addChildAt(screen,3);
			//FadeOutOcean(1);
			CreateHitScreen();
			CreateHitGoo();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crickets_01",((stage.getChildAt(0) as Object).MusicObj.globalVol/2),1.0);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Attached"){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
							if(GooAttached === true){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope != undefined){
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope['Analyzed'] != 'Yes'){
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope['MusicQue'] == 'Yes'){
											
										}else{
											if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
												SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope;
												SaveArray['MusicQue'] = 'Yes';
												
												(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabMicroscope',SaveArray);
												
												Starling.juggler.delayCall(function():void{
													(stage.getChildAt(0) as Object).MusicObj.LoadJamLoop(true,3);
													
												},1.5);
											}
										}
									}else{
										if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope;
											SaveArray['MusicQue'] = 'Yes';
											
											(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabMicroscope',SaveArray);
											
											Starling.juggler.delayCall(function():void{
												(stage.getChildAt(0) as Object).MusicObj.LoadJamLoop(true,3);
												
											},1.5);
										}
									}
								}else{
									
								}
							}
						}
					}
				}
			}
			
			
		}
		//hit_goo
		private function CreateHitGoo():void{
			hit_goo = new Shape();
			hit_goo.touchable = false;
			hit_goo.graphics.beginFill(0xff0000);
			
			hit_goo.graphics.lineTo(130,250);							
			hit_goo.graphics.lineTo(189,116);							
			hit_goo.graphics.lineTo(395,21);							
			hit_goo.graphics.lineTo(573,135);							
			hit_goo.graphics.lineTo(612,293);							
			hit_goo.graphics.lineTo(522,495);							
			hit_goo.graphics.lineTo(285,496);							
			
			hit_goo.graphics.endFill(false);
			
			hit_goo.alpha = 0.0;
			
			hit_goo.graphics.precisionHitTest = true;	
			this.addChild(hit_goo);
		}

		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(0,0);							
			hit_screen.graphics.lineTo(293,0);							
			hit_screen.graphics.lineTo(293,26);							
			hit_screen.graphics.lineTo(233,77);							
			hit_screen.graphics.lineTo(0,77);							
		
			hit_screen.graphics.endFill(false);
			
			hit_screen.alpha = 0.0;
			
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((LabEquipment as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.LabEquipmentObj,false
							);
						}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ScreenHandler();
						}else if(hit_goo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(GooAttached === false){
								if(PhraseCounter == 0){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's nothing to look at under the microscope but dust.");
									PhraseCounter = 1;
								}else if(PhraseCounter == 1){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The dust and dirt has gotten inside the lens - I'd have to take it apart to clean it.");
									PhraseCounter = 0;
								}
								
							}else if(Solved === false){
								if(PhraseCounter == 0){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The green slime from the unworldly red chamber up close.");
									PhraseCounter = 1;
								}else if(PhraseCounter == 1){(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Doesn't looks so unusual. Maybe running an analysis will show something more.");

									
									PhraseCounter = 0;
								}
							}else{
								if(PhraseCounter == 0){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The analysis has revealed the molecular structure of the slime.");
									PhraseCounter = 1;
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Bounded groups of atoms spin from the center in a spiral pattern.");
								}
							}
						}
					}
					
				}
			}
		}
		
		private function ScreenHandler():void{
			if(Solved === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				Animating = true;
				screen.texture = this.assets.getTexture('screen_working');
				delayedCall = new DelayedCall(function():void{
					Solve();
					
				},3);
				Starling.juggler.add(delayedCall);	
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't need to run a second analysis of the slime.");

			}
		}
		
		private function Solve():void{
			if(GooAttached === false){				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
				screen.texture = this.assets.getTexture('screen_failed');
				Animating = false;
				delayedCall = null;
			}else{
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['MachineOn'] == 'Yes'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
						Solved = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope;
						}
						SaveArray['Analyzed'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabMicroscope',SaveArray);	
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeeps();
						screen.texture = this.assets.getTexture('screen_sending');
						delayedCall = new DelayedCall(function():void{
							FadeInDNA();
							delayedCall = null;
						},3);
						Starling.juggler.add(delayedCall);		
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
						screen.texture = this.assets.getTexture('screen_failed');
						Animating = false;
						delayedCall = null;
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
					screen.texture = this.assets.getTexture('screen_failed');
					Animating = false;
					delayedCall = null;
				}
			}
		}
		
		
		private function FadeInDNA():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterBoil();
			DNATween = new Tween(dna, 3, Transitions.LINEAR);
			DNATween.fadeTo(1);
			DNATween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				ChangeScreen();
				Animating = false;
				DNATween = null;
			}
			Starling.juggler.add(DNATween);
		}
		
		private function ChangeScreen():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
			screen.texture = this.assets.getTexture('screen_success');
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
			
			
			this.assets.removeTexture("labMicroscope_bg",true);
			this.assets.removeTexture("LabMicroscope_Sprite",true);
			this.assets.removeTextureAtlas("LabMicroscope_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labMicroscope_01");
			(stage.getChildAt(0) as Object).falseAsset("labMicroscope_02");
			(stage.getChildAt(0) as Object).falseAsset("labMicroscope_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}
