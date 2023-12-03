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
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;
	
	public class Chamber extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var red:Image;
		private var green:Image;
		private var blue:Image;
		private var lightbeam:Image;
		private var portal:Image;
		
		private var hit_ChamberPrism:Shape;
		private var hit_Red:Shape;
		private var hit_Green:Shape;
		private var hit_Blue:Shape;
		
		private var hit_steps:Shape;
		private var hit_wallOne:Shape;
		private var hit_wallTwo:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		private var Animating:Boolean = false;
		private var PortalOpen:Boolean = false;
		public var delayedCall:DelayedCall;
		private var PortalTween:Tween;
		
		public function Chamber(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamber_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Chamber/chamber_bg.jpg'));
				game.TrackAssets('chamber_01');
			}
			if(game.CheckAsset('chamber_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Chamber/Chamber_Sprite.atf'));
				game.TrackAssets('chamber_02');
			}
			if(game.CheckAsset('chamber_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Chamber/Chamber_Sprite.xml'));
				game.TrackAssets('chamber_03');
			}
			if(game.CheckAsset('chamber_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Chamber/Chamber_Sprite_02.png'));
				game.TrackAssets('chamber_04');
			}
			if(game.CheckAsset('chamber_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Chamber/Chamber_Sprite_02.xml'));
				game.TrackAssets('chamber_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Chamber","ChamberObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
	//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber != undefined){
	//		 SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber;
	//		}
	//		SaveArray['Portal'] = "no";
	//		(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Chamber',SaveArray);
			
			
			
			
			bg = new Image(this.assets.getTexture('chamber_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			red = new Image(this.assets.getTexture('red'));
			red.smoothing = TextureSmoothing.NONE;
			red.touchable = false;
			red.x = 310;
			red.y = 256;
		
			green = new Image(this.assets.getTexture('green'));
			green.smoothing = TextureSmoothing.NONE;
			green.touchable = false;
			green.x = 478;
			green.y = 1;
			
			
			blue = new Image(this.assets.getTexture('blue'));
			blue.smoothing = TextureSmoothing.NONE;
			blue.touchable = false;
			blue.x = 155;
			blue.y = 1;
			
			lightbeam = new Image(this.assets.getTexture('lightbeam'));
			
			lightbeam.touchable = false;
			lightbeam.x = 81;
			lightbeam.y = 0;
			
			
			portal = new Image(this.assets.getTexture('vortex'));
			portal.touchable = false;
			portal.width = portal.width*2;
			portal.height = portal.height*2;
			portal.pivotX = 67.5;
			portal.pivotY = 67.5;
			portal.x = 145;
			portal.y = 175;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Red'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						red.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						red.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						red.alpha = 1;
					}else{
						red.alpha = 0;
					}
				}else{
					red.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Green'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 0){
						green.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						green.alpha = 1;					
					}else{
						green.alpha = 0;
					}
				}else{
					green.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Blue'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						blue.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 4){
						blue.alpha = 1;					
					}else{
						blue.alpha = 0;
					}
				}else{
					blue.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						PortalOpen = true;
						red.alpha = 1;
						green.alpha = 1;
						blue.alpha = 1;	
						lightbeam.alpha = 1;
						portal.alpha = 0;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber != undefined){
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber['Portal'] == 'Open'){
								
								
								AddPortalEnterFrame();
								portal.alpha = 1;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber;
								}
								SaveArray['Portal'] = "Open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Chamber',SaveArray);
								
								portal.alpha = 0;
								Animating = true;
								delayedCall = new DelayedCall(function():void{
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
									(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
									FadeInPortal();
								},1.5);
								Starling.juggler.add(delayedCall);
							}
						}else{
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Chamber;
							}
							SaveArray['Portal'] = "Open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Chamber',SaveArray);

							
							portal.alpha = 0;
							Animating = true;
							delayedCall = new DelayedCall(function():void{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
								(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
								FadeInPortal();
							},1.5);
							Starling.juggler.add(delayedCall);
						}
					
					}else{
						lightbeam.alpha = 0;
						portal.alpha = 0;
					}
				}else{
					lightbeam.alpha = 0;
					portal.alpha = 0;
				}
				
				
			}else{
				red.alpha = 0;
				green.alpha = 0;
				blue.alpha = 0;	
				lightbeam.alpha = 0;
				portal.alpha = 0;
			}
			
				
			this.addChildAt(red,1);
			this.addChildAt(green,2);
			this.addChildAt(blue,3);
			this.addChildAt(lightbeam,4);
			this.addChildAt(portal,5);
			
			CreateHitWallTwo();
			CreateHitWallOne();
			CreateHitSteps();
			
			CreateHitChamberPrism();
			CreateHitChamberRed();
			CreateHitChamberBlue();
			CreateHitChamberGreen()
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.5,'stop');
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
				
		}
		
		private function FadeInPortal():void{
			AddPortalEnterFrame();
			PortalTween = new Tween(portal, 2.5, Transitions.EASE_IN_OUT_BOUNCE);
			PortalTween.fadeTo(1);
			PortalTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				//AddPortalEnterFrame();	
				Animating = false;
				delayedCall = null;
				PortalTween = null;
				
			}
			Starling.juggler.add(PortalTween);
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_HeartBeat(10);
				//(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,0);
			},4);
			
		}
		
		private function AddPortalEnterFrame():void{
			portal.addEventListener(EnterFrameEvent.ENTER_FRAME, RotatePortal);
		}
		private function RotatePortal(e:Event):void{
			portal.rotation = portal.rotation-0.1;
		}
		
		private function CreateHitWallTwo():void{
			hit_wallTwo = new Shape();
			hit_wallTwo.touchable = false;
			hit_wallTwo.graphics.beginFill(0xff0000);
			
			hit_wallTwo.graphics.lineTo(0,0);												
			hit_wallTwo.graphics.lineTo(800,0);												
			hit_wallTwo.graphics.lineTo(800,512);												
			hit_wallTwo.graphics.lineTo(0,512);												
			
			
			hit_wallTwo.graphics.endFill(false);
			hit_wallTwo.alpha = 0.0;
			
			hit_wallTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_wallTwo);
		}
		private function CreateHitWallOne():void{
			hit_wallOne = new Shape();
			hit_wallOne.touchable = false;
			hit_wallOne.graphics.beginFill(0xff0000);
			
			hit_wallOne.graphics.lineTo(220,160);												
			hit_wallOne.graphics.lineTo(351,163);												
			hit_wallOne.graphics.lineTo(427,186);												
			hit_wallOne.graphics.lineTo(709,193);												
			hit_wallOne.graphics.lineTo(730,344);												
			hit_wallOne.graphics.lineTo(549,549);												
			hit_wallOne.graphics.lineTo(549,366);												
			hit_wallOne.graphics.lineTo(360,245);												
			hit_wallOne.graphics.lineTo(263,220);												
															
			
			hit_wallOne.graphics.endFill(false);
			hit_wallOne.alpha = 0.0;
			
			hit_wallOne.graphics.precisionHitTest = true;	
			this.addChild(hit_wallOne);
		}
		
		private function CreateHitSteps():void{
			hit_steps = new Shape();
			hit_steps.touchable = false;
			hit_steps.graphics.beginFill(0xff0000);
			
			hit_steps.graphics.lineTo(0,280);												
			hit_steps.graphics.lineTo(24,227);												
			hit_steps.graphics.lineTo(268,264);												
			hit_steps.graphics.lineTo(381,350);												
			hit_steps.graphics.lineTo(601,423);												
			hit_steps.graphics.lineTo(580,481);												
			hit_steps.graphics.lineTo(259,405);												
			hit_steps.graphics.lineTo(0,389);												
	
			hit_steps.graphics.endFill(false);
			hit_steps.alpha = 0.0;
			
			hit_steps.graphics.precisionHitTest = true;	
			this.addChild(hit_steps);
		}
		
		private function CreateHitChamberPrism():void{
			hit_ChamberPrism = new Shape();
			hit_ChamberPrism.touchable = false;
			hit_ChamberPrism.graphics.beginFill(0xff0000);
			
			hit_ChamberPrism.graphics.lineTo(31,209);												
			hit_ChamberPrism.graphics.lineTo(50,133);												
			hit_ChamberPrism.graphics.lineTo(137,92);												
			hit_ChamberPrism.graphics.lineTo(218,167);												
			hit_ChamberPrism.graphics.lineTo(257,265);												
			hit_ChamberPrism.graphics.lineTo(100,290);												
			hit_ChamberPrism.graphics.lineTo(35,236);												
											
			hit_ChamberPrism.graphics.endFill(false);
			hit_ChamberPrism.alpha = 0.0;
			
			hit_ChamberPrism.graphics.precisionHitTest = true;	
			this.addChild(hit_ChamberPrism);
		}
		
		private function CreateHitChamberRed():void{
			hit_Red = new Shape();
			hit_Red.touchable = false;
			hit_Red.graphics.beginFill(0xff0000);
			
			hit_Red.graphics.lineTo(335,321);												
			hit_Red.graphics.lineTo(371,252);												
			hit_Red.graphics.lineTo(554,270);												
			hit_Red.graphics.lineTo(570,286);												
			hit_Red.graphics.lineTo(527,407);												
			hit_Red.graphics.lineTo(467,398);												
			hit_Red.graphics.lineTo(458,378);												
												
			hit_Red.graphics.endFill(false);
			hit_Red.alpha = 0.0;
			
			hit_Red.graphics.precisionHitTest = true;	
			this.addChild(hit_Red);
		}
		
		private function CreateHitChamberGreen():void{
			hit_Green = new Shape();
			hit_Green.touchable = false;
			hit_Green.graphics.beginFill(0xff0000);
			
			hit_Green.graphics.lineTo(489,78);												
			hit_Green.graphics.lineTo(542,6);												
			hit_Green.graphics.lineTo(662,40);												
			hit_Green.graphics.lineTo(673,197);												
			hit_Green.graphics.lineTo(515,183);												
			
			hit_Green.graphics.endFill(false);
			hit_Green.alpha = 0.0;
			
			hit_Green.graphics.precisionHitTest = true;	
			this.addChild(hit_Green);
		}
		
		private function CreateHitChamberBlue():void{
			hit_Blue = new Shape();
			hit_Blue.touchable = false;
			hit_Blue.graphics.beginFill(0xff0000);
			
			hit_Blue.graphics.lineTo(145,78);												
			hit_Blue.graphics.lineTo(189,0);												
			hit_Blue.graphics.lineTo(314,0);												
			hit_Blue.graphics.lineTo(343,44);												
			hit_Blue.graphics.lineTo(350,164);												
			hit_Blue.graphics.lineTo(213,158);																							
			
			hit_Blue.graphics.endFill(false);
			hit_Blue.alpha = 0.0;
			
			hit_Blue.graphics.precisionHitTest = true;	
			this.addChild(hit_Blue);
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
							FadeOut((TemplePascal as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.TemplePascalObj,true
							);
						}else if(hit_ChamberPrism.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PortalOpen === false){
								FadeOut((ChamberPrism as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberPrismObj,true
								);
							}else{
								GoToOutto();
								
							}
							
						}else if(hit_Red.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((ChamberRed as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberRedObj,true
							);	
						}else if(hit_Green.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((ChamberGreen as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberGreenObj,true
							);	
						}else if(hit_Blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((ChamberBlue as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberBlueObj,true
							);	
						}else if(hit_steps.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
							if(PortalOpen === false){
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Shapes rise up to form a stairway.");
								}else if(PhraseCounter == 1){
									PhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The steps lead to a bulbous mass with a pedestal on top...");
									
								}else if(PhraseCounter == 2){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Smaller patterns coalesce around the stairs and platform.");
									
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The structure vibrates with the energy of the portal.");	
								
							}
							
							
						}else if(hit_wallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
							if(PortalOpen === false){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Huge slabs create a precarious path around the chamber");
								}else if(PhraseCounter == 1){
									PhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fractal structures blend into the stone, and then reemerge.");
									
								}else if(PhraseCounter == 2){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walkway narrows precipitously as it snakes around the chamber walls.");	
									
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stones are pulsating...");	
								
							}
							
						}else if(hit_wallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
							
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A cacophony of shapes bleed from all directions.");
							}else if(PhraseCounter == 1){
								PhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I can see a pattern in the chaos.");
								
							}else if(PhraseCounter == 2){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What in the world is this place?");	
								
							}
							
							
						}
						
						
						/*
						private var hit_steps:Shape;
						private var hit_wallOne:Shape;
						private var hit_wallTwo:Shape;
						*/
					}
				}
			}
		}
		
		private function GoToOutto():void{
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Darkness",0,1.0,'stop');
			(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("TenseOut",0,1.0,'stop');
			(stage.getChildAt(0) as Object).MusicObj.LoadLightBeam(true,0);
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
			FadeOut((OuttroStars as Class), 
				(stage.getChildAt(0) as Object).screenGamePlayHandler.OuttroStarsObj,true
			);
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
			
			
			this.assets.removeTexture("chamber_bg",true);
			this.assets.removeTexture("Chamber_Sprite",true);
			this.assets.removeTexture("Chamber_Sprite_02",true);
			this.assets.removeTextureAtlas("Chamber_Sprite",true);
			this.assets.removeTextureAtlas("Chamber_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("chamber_01");
			(stage.getChildAt(0) as Object).falseAsset("chamber_02");
			(stage.getChildAt(0) as Object).falseAsset("chamber_03");
			(stage.getChildAt(0) as Object).falseAsset("chamber_04");
			(stage.getChildAt(0) as Object).falseAsset("chamber_05");
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