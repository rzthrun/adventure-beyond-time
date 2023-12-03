	package screens
{
	import flash.filesystem.File;
//	import flash.net.URLRequest;
//	import flash.net.navigateToURL;
	
	import screens.MenuResetDialogue;
//	import screens.hud.Hint;
	import screens.sounds.VolSlider;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	public class MainMenu extends Sprite
	{
		
		public var ResetDialogTween:Tween;
		
		private var assets:AssetManager;
		
		
		
		
		

		private var mainBg:Image;
		private var envCont:Sprite;
		private var envContTween:Tween;
		
		
		private var bg:Quad;
		private var sun:Image;
		private var skyHaze:Image;
		private var skyHaze2:Image;
	//	private var sunCont:Sprite;
	//	private var sunContTween:Tween;
		
		private var sunTween:Tween;
	
		
		private var MenuSprite:Sprite;
		private var MenuSpriteTween:Tween;
		
		private var optionsButton:Image;
		private var startButton:Image;
		private var moreGamesButton:Image;
		private var bol_RolledDown:Boolean = false;
		
		public var OptionsButtonTween:Tween;
		public var StartButtonTween:Tween;
		public var moreGamesButtonTween:Tween;
		
		private var hit_Options:Shape;
		private var hit_Start:Shape;
		private var hit_MoreGames:Shape;

		public var ShowOptionsTween:Tween;
		private var optionsSprite:Sprite;
		private var optionsBg:Image;
		
		
		private var ReturnToMainMenu:Image;
		private var ReturnToMainMenuTween:Tween;
		private var hit_ReturnToMain:Shape;
	//	private var ResetButton:Image;
	//	private var hit_Reset:Shape;
	
		private var TelescopeHillSprite:Sprite;
		private var TelescopeHillTitle:Image;
		private var TelescopeHillIcon:Image;
		private var TelescopeHillText:Image;
		private var TelescopeHillBg:Shape;
		private var TelescopeHillBackToMainMenu:Image;
		private var hit_TelescopeHillBackToMainMenu:Shape;
		private var TelescopeHillTween:Tween;
		
		//private var bg:Image;
		private var title:Image;
		public var TitleFadeTween:Tween;
		
		private var copyright:Image;
		public var CopyRightFadeTween:Tween;
		private var tapToStart:Image;
		public var TapToStartFadeTween:Tween;		
		public var RollDownTween:Tween;
		

		
	
		public var MusicVolSliderObj:VolSlider;
		private var MusicVolActive:Boolean = false;
		public var SoundFXVolSliderObj:VolSlider;
		private var SoundFXVolActive:Boolean = false;
		public var AmbientVolSliderObj:VolSlider;
		private var AmbientVolActive:Boolean = false;
		public var ResetButton:Image;
		private var hit_ResetButton:Shape;
		private var HintsButton:Image;
		private var hit_Hints:Shape;
		
		
		private var delayedCall:DelayedCall;
	
		private var ResetDialogue:MenuResetDialogue;
		
		public var rollUpTween:Tween;
		public var fadeOutTween:Tween;
	
		
//		private var titleLoaded:Boolean = false;
		private var MenuLoaded:Boolean = false;
		private var OptionsLoaded:Boolean = false;
		private var TelescopeHillLoaded:Boolean = false;		
		private var ResetLoaded:Boolean = false;
		private var ResetComplete:Boolean = false;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var _fromGame:Boolean = true;
		private var game:Game;
		private var animating:Boolean = false;
		public function MainMenu(_game:Game,_assets:AssetManager,fromGame:Boolean = true)
		{
			super();
			_fromGame = fromGame;
			game = _game;
			this.assets = _assets;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("	stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.DeclareSave:" +game.SavedGame.SavedGameObj.data.DeclareSave);
			
		}
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			trace("FALSE f FALSE");
			
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_01') === false){
				trace("FALSE DALSE FALSE");
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_01.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_01');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_01.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_02');
				
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_02.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_03');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_02.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_04');
				
			}
			
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_03.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_05');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_03.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_06');
				
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_07') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/mainMenu_bg.jpg'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_07');
			}
	//		if(game.CheckAsset('mainMenu_06') === false){
	//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/optionsBg.png'));
	//			game.TrackAssets('mainMenu_06');
	//		}
			
		
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_08') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_04.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_08');
				
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_09') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_04.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_09');
			}
			
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_10') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_05.png'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_10');
				
			}
			if((stage.getChildAt(0) as Object).CheckAsset('mainMenu_11') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/MainMenu/MainMenuSprite_05.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('mainMenu_11');
			}


			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					if(_fromGame === false){
						onLoadAssets();
					}else{
						onLoadAssetsFromGame();
					}
					
					
				}				
			});							
			
		}
		
		
		private function CreateMenuElements():void{
			
			
		}
		
		private function onLoadAssetsFromGame():void{
			(stage.getChildAt(0) as Object).MusicObj.LoadEmpty(true,int.MAX_VALUE);
			(stage.getChildAt(0) as Object).MusicObj.Play_MainTheme(999);
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol!= undefined){
				(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol);
				(stage.getChildAt(0) as Object).MusicObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol;
			}else{
				(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume(0.5);
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol!= undefined){
				(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol);
				(stage.getChildAt(0) as Object).SoundFXObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol;
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume(0.5);
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol!= undefined){
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol);
				(stage.getChildAt(0) as Object).AmbientObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol;
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume(0.5);
			}
			//switch(e.params.image
			
			//(stage.getChildAt(0) as Object).MusicObj.currentSong = null;
			bol_RolledDown = true;
			
			animating = true;
			
			bg = new Quad(800,512);
			bg.touchable = true;
			bg.setVertexColor(0, 0x000000);
			bg.setVertexColor(1, 0x000000);
			bg.setVertexColor(2, 0x000000);
			bg.setVertexColor(3, 0x000000);
			bg.alpha = 1;
			bg.x = 0;
			bg.y = 0;			
			this.addChildAt(bg,0);
			
			envCont = new Sprite();
			envCont.touchable = false;
			envCont.y = -337;
			envCont.alpha = 0;
			
			
			mainBg = new Image(this.assets.getTexture('mainMenu_bg'));
			mainBg.x = 0;
			mainBg.y = 0;
			mainBg.touchable = false;
			mainBg.alpha = 1;
			
			mainBg.touchable = false;
			
			envCont.addChildAt(mainBg,0);
			this.addChildAt(envCont,1);
			
		//	AddOptionButton();
		//	createOptions();
		//	createTelescopeHill();
			
			
			envContTween  = new Tween(envCont,2, Transitions.LINEAR);
			envContTween.fadeTo(1);
			//	envContTween.animate("y",-337);
			envContTween.onComplete = function():void{
				//animating = false;
				Starling.juggler.purge();
				AddOptionButton();
				createOptions();
				createTelescopeHill();
				AddTouchHandler();
				//RemoveSunAnimaEventList();
				//	startBoat();
			}
			Starling.juggler.add(envContTween);
			
			
			//AddTouchHandler();
			
		}
		
//		private function RemoveWhiteOut():void{
//			this.removeChild(WhiteOut);
//			this.removeChild(title);
//		}
		
		private function AddTouchHandler():void{
			trace("ADDING TOUC HANDLER");
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		private function onLoadAssets():void{
				(stage.getChildAt(0) as Object).MusicObj.LoadEmpty(true,int.MAX_VALUE);
		//	Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).MusicObj.Play_MainTheme(999);
		//	},1.65);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol!= undefined){
				(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol);
				(stage.getChildAt(0) as Object).MusicObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol;
			}else{
				(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume(0.5);
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol!= undefined){
				(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol);
				(stage.getChildAt(0) as Object).SoundFXObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol;
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume(0.5);
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol!= undefined){
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol);
				(stage.getChildAt(0) as Object).AmbientObj.globalVol = (stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol;
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume(0.5);
			}
			//switch(e.params.image
			
		//	(stage.getChildAt(0) as Object).MusicObj.currentSong = null;
			

		
			
			animating = true;
			
			
			bg = new Quad(800,512);
			bg.touchable = true;
			bg.setVertexColor(0, 0x000000);
			bg.setVertexColor(1, 0x000000);
			bg.setVertexColor(2, 0x000000);
			bg.setVertexColor(3, 0x000000);
			bg.alpha = 1;
			bg.x = 0;
			bg.y = 0;			
			this.addChildAt(bg,0);
			
			
			
			envCont = new Sprite();
			envCont.touchable = false;
			envCont.y = 512;
			this.addChildAt(envCont,1);
			
			mainBg = new Image(this.assets.getTexture('mainMenu_bg'));
			mainBg.x = 0;
			mainBg.y = 0;
			mainBg.touchable = false;
			mainBg.alpha = 1;
			
			mainBg.touchable = false;
			
			envCont.addChild(mainBg);
			
			FadeInTitle();
			
		}
		private function sunAnimation(event:Event):void{
			sun.rotation = sun.rotation+deg2rad(1);
			skyHaze.rotation = skyHaze.rotation-deg2rad(1);
			skyHaze2.rotation = skyHaze2.rotation+deg2rad(1);
			
			
		}
		
		
		private function FadeInTitle():void{
			//this.addEventListener(TouchEvent.TOUCH,forceFadeOutCompany);
			
		//	this.removeChild(WhiteOut);
			
			title = new Image(this.assets.getTexture('Title_three'));
			title.x = 0;
			title.y = 35;
			title.alpha = 0;
			title.touchable = false;
			this.addChild(title);	
			
	
			
			tapToStart = new Image(this.assets.getTexture('TapToStart'));
			tapToStart.x = 169;
			tapToStart.y = 358;
			tapToStart.alpha = 0;
			tapToStart.touchable = false;
			this.addChild(tapToStart);	
			
			copyright = new Image(this.assets.getTexture('copyright'));
			copyright.x = 78;
			copyright.y = 478;
			copyright.alpha = 0;
			copyright.touchable = false;
			this.addChild(copyright);		
			
			TitleFadeTween = new Tween(title, 2, Transitions.LINEAR);
			TitleFadeTween.fadeTo(1);
			TitleFadeTween.onComplete = addTitleElement;
			Starling.juggler.add(TitleFadeTween);
			
		//	this.addEventListener(TouchEvent.TOUCH,skipTitle);
			
		}
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
		//	trace("touch");
			if(animating === false){
				if (touches.length > 0){
					if (touches[0].phase == TouchPhase.BEGAN) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(bol_RolledDown === false){
							bol_RolledDown = true;
							animating = true;
							trace("touched");
							
							//	delayedCall = Starling.juggler.delayCall(RollDown,1.5);
						//	this.addEventListener(Event.ENTER_FRAME, boatAnimation);
							Starling.juggler.purge();
							
							FadeOutMenuExtras();
							//RollDown();
						}
						else{
							if(MenuLoaded === true){
///REMEMBER THIS PLACE	
								
							
								if(hit_Start.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gong();
									animating = true;
									MenuLoaded = false;
									trace("StartClicked");
									RemoveMenuHits();
									
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.DeclareSave === true){
										fadeOut();
									}else{
										RollUp();
									}

									
								}else if(hit_Options.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
									animating = true;
									MenuLoaded = false;
									
									trace("OptionsClicked");
									RemoveMenuHits();
									showOptions();
									
								}else if(hit_MoreGames.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
									animating = true;
									MenuLoaded = false;
									trace("MoreGamesClicked");
									RemoveMenuHits();
									showTelescopeHill();
								//	navigateToURL(new URLRequest("https://play.google.com/store/apps/details?id=air.aircampgames.games.telescopehill"), "_blank");
								}
								
/// END REMEMBER THIS PLACE									
							}else if(OptionsLoaded === true){
								if(ResetLoaded === false){
									if(hit_ResetButton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
										animating = true;
										ResetDialogue = new MenuResetDialogue(this.assets);
										ResetDialogue.x = 0;
										ResetDialogue.y = 0;
										ResetDialogue.alpha = 0;								
										this.addChild(ResetDialogue);
										ResetDialogTween = new Tween(ResetDialogue, 1, Transitions.LINEAR);
										ResetDialogTween.fadeTo(1);
										ResetDialogTween.onComplete = function():void{
											//Starling.juggler.purge();
											animating = false;
											ResetLoaded = true;
										}
										Starling.juggler.add(ResetDialogTween);	
										
									}else if(hit_ReturnToMain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
										animating = true;
										
										OptionsLoaded = false;
										
										ReturnToMainMenuFunc();
									}else if(MusicVolSliderObj.hit_slider.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										trace("VOL SLIDER");
										MusicVolActive = true;
									}else if(SoundFXVolSliderObj.hit_slider.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										trace("VOL SLIDER");
										SoundFXVolActive = true;
									}else if(AmbientVolSliderObj.hit_slider.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										trace("Ambient VOL SLIDER");
										AmbientVolActive = true;
									}
									
								/* START DISABLE CLICK HANDLER FOR
									HINTS */
									else if(hit_Hints.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
										if((stage.getChildAt(0) as Object).SavedGame.SavedHintObj.data.Enabled != undefined){
											if((stage.getChildAt(0) as Object).SavedGame.SavedHintObj.data.Enabled === true){
												(stage.getChildAt(0) as Object).SavedGame.SaveHintsToggle(false);
												HintsButton.texture = this.assets.getTexture('HintsDisabled');
												HintsButton.width = 230;
												HintsButton.height = 122;
												HintsButton.x = 500;
												
											}else{
												(stage.getChildAt(0) as Object).SavedGame.SaveHintsToggle(true);
												HintsButton.texture = this.assets.getTexture('HintsEnabled');
												HintsButton.width = 206;
												HintsButton.height = 122;
												HintsButton.x = 512;
											}
										}else{
											(stage.getChildAt(0) as Object).SavedGame.SaveHintsToggle(true);
											HintsButton.texture = this.assets.getTexture('HintsEnabled');
											HintsButton.width = 206;
											HintsButton.height = 122;
											HintsButton.x = 512;
										}
										
									}
								
								/*
									END DISABLE
									*/
									
								}else if(ResetComplete === false){
									if(ResetDialogue.hit_no.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										//this.removeChild(ResetDialogue);
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
										
										animating = true;
										
										ResetDialogTween = new Tween(ResetDialogue, 1, Transitions.LINEAR);
										ResetDialogTween.fadeTo(0);
										ResetDialogTween.onComplete = function():void{
											//Starling.juggler.purge();
											animating = false;
											RemoveResetDialog();
											ResetLoaded = false;
											ResetComplete = false;
										}
										Starling.juggler.add(ResetDialogTween);	
										
										
									}
									else if(ResetDialogue.hit_yes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
									//	startButton.x = 40;
									//	startButton.y = 950;
										startButton.x = 30;
										startButton.y = 40;
										startButton.texture = this.assets.getTexture('NewGame');
										startButton.readjustSize();
									//	this.addChild(startButton);
									//	hit_Start._graphics.clear();
									//	hit_Options._graphics.clear();
										//CreateMenuHit(true);
										ResetDialogue.ResetGame();
										
										ResetComplete = true;
										//	this.removeChild(ResetDialogue);
										
										//	ResetLoaded = false;
									}
									
									
								}else{
									if(ResetDialogue.transbg.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
										animating = true;
										
										ResetDialogTween = new Tween(ResetDialogue, 1, Transitions.LINEAR);
										ResetDialogTween.fadeTo(0);
										ResetDialogTween.onComplete = function():void{
											//Starling.juggler.purge();
											animating = false;
											RemoveResetDialog();
											ResetLoaded = false;
											ResetComplete = false;
										}
										Starling.juggler.add(ResetDialogTween);	
										
										
									}
									/*	startButton.texture = this.assets.getTexture('menu_element_start_v003a001');
									
									*/
								}
							}else if(TelescopeHillLoaded === true){
								if(hit_TelescopeHillBackToMainMenu.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									animating = true;
									
									TelescopeHillLoaded = false;
								
									ReturnToMainMenuFuncFromTelescopeHill();
								}
							}
							
						//	if(hit_Start.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						//	if(bol_emailIn === false){
								
						//		bol_emailIn = true;
						//		animating = true;
						//		fadeInEmail();
						//	}
						}
					}
					if(touches[0].phase == TouchPhase.ENDED){
						trace("END TOUCH");
						MusicVolActive = false;
						SoundFXVolActive = false;
						AmbientVolActive = false;
					}
					if(SoundFXVolActive === true){
						trace("SoundFXVolActive: "+SoundFXVolActive);
						trace("BARK 0")
						if(touches[0].phase == TouchPhase.MOVED){
							//	if(MusicVolSliderObj.sliderHolder.x <
							trace("SOUND FX SLIDER");
							trace(SoundFXVolSliderObj.x);
							trace(SoundFXVolSliderObj.sliderHolder.x);
							if((touches[0].globalX-SoundFXVolSliderObj.x) >= (13+24.5) && (touches[0].globalX-SoundFXVolSliderObj.x) <= (413+24.5)){
								SoundFXVolSliderObj.sliderHolder.x = touches[0].globalX-SoundFXVolSliderObj.x-24.5;
								
								var vol:Number = Math.floor((((SoundFXVolSliderObj.sliderHolder.x-13)/4)));
								
								
								vol = vol/10;
								if(vol <= 0.025){
									(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume(0);
									//(stage.getChildAt(0) as Object).SoundFXObj.soundManager.muteAll();
									vol = 0.0;
								}else if(vol >= 9.975){
									(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume(1);
									vol = 1.0;
								}
								else{
									vol = vol/10;
									(stage.getChildAt(0) as Object).SoundFXObj.soundManager.setGlobalVolume((vol));
								}
								
								
								(stage.getChildAt(0) as Object).SoundFXObj.globalVol = vol;
								
								
								(stage.getChildAt(0) as Object).SavedGame.SaveSoundFXVol(vol);
								
								
							}else if((touches[0].globalX-SoundFXVolSliderObj.x) < 13){
								(stage.getChildAt(0) as Object).SavedGame.SaveSoundFXVol(0);
							}else if((touches[0].globalX-SoundFXVolSliderObj.x) > 413){
								(stage.getChildAt(0) as Object).SavedGame.SaveSoundFXVol(1);
							}
							
						}
						
					}
					
					if(MusicVolActive === true){
						if(touches[0].phase == TouchPhase.MOVED){
							
							if((touches[0].globalX-MusicVolSliderObj.x) >= (13+24.5) && (touches[0].globalX-MusicVolSliderObj.x) <= (413+24.5)){
								MusicVolSliderObj.sliderHolder.x = touches[0].globalX-MusicVolSliderObj.x-24.5;
								
								var vol:Number = Math.floor((((MusicVolSliderObj.sliderHolder.x-13)/4)));
								
								vol = vol/10;
								if(vol <= 0.025){
									(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume(0);
									vol = 0.0;
								}else if(vol >= 9.975){
									(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume(1);
									vol = 1.0;
								}
								else{
									vol = vol/10;
									(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((vol));
								}
								
								(stage.getChildAt(0) as Object).MusicObj.globalVol = vol;
								
								(stage.getChildAt(0) as Object).SavedGame.SaveMusicVol(vol);
								
								
							}else if((touches[0].globalX-MusicVolSliderObj.x) < 13){
								(stage.getChildAt(0) as Object).SavedGame.SaveMusicVol(0);
							}else if((touches[0].globalX-MusicVolSliderObj.x) > 413){
								(stage.getChildAt(0) as Object).SavedGame.SaveMusicVol(1);
							}
							
							
							
						}
					}
					
					if(AmbientVolActive === true){
						if(touches[0].phase == TouchPhase.MOVED){
							
							if((touches[0].globalX-AmbientVolSliderObj.x) >= (13+24.5) && (touches[0].globalX-AmbientVolSliderObj.x) <= (413+24.5)){
								AmbientVolSliderObj.sliderHolder.x = touches[0].globalX-AmbientVolSliderObj.x-24.5;
								
								var vol:Number = Math.floor((((AmbientVolSliderObj.sliderHolder.x-13)/4)));
								
								vol = vol/10;
								if(vol <= 0.025){
									(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume(0);
									vol = 0.0;
								}else if(vol >= 9.975){
									(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume(1);
									vol = 1.0;
								}
								else{
									vol = vol/10;
									(stage.getChildAt(0) as Object).AmbientObj.soundManager.setGlobalVolume((vol));
								}
								
								(stage.getChildAt(0) as Object).AmbientObj.globalVol = vol;
								
								(stage.getChildAt(0) as Object).SavedGame.SaveAmbientVol(vol);
								
								
							}else if((touches[0].globalX-AmbientVolSliderObj.x) < 13){
								(stage.getChildAt(0) as Object).SavedGame.SaveAmbientVol(0);
							}else if((touches[0].globalX-AmbientVolSliderObj.x) > 413){
								(stage.getChildAt(0) as Object).SavedGame.SaveAmbientVol(1);
							}
							
							
							
						}
					}
				}
			}
		}
		private function RollUp():void{
		
			envContTween  = new Tween(envCont,2, Transitions.EASE_IN_OUT);
			envContTween.animate("y",512);
			envContTween.onComplete = function():void{
				fadeOut();
			}
			
			MenuSpriteTween  = new Tween(MenuSprite,2, Transitions.EASE_IN_OUT);
			MenuSpriteTween.animate("y",512);
			MenuSpriteTween.onComplete = function():void{

			}

			Starling.juggler.add(MenuSpriteTween);	
			
			Starling.juggler.add(envContTween);
		}
		
		
		private function RemoveMenuHits():void{
			this.MenuSprite.removeChild(hit_Start);
			this.MenuSprite.removeChild(hit_Options);
			this.MenuSprite.removeChild(hit_MoreGames);
			
			
		}
	
	
		
		private function createTelescopeHill():void{
			TelescopeHillSprite = new Sprite();
			TelescopeHillSprite.touchable = false;
			TelescopeHillSprite.x = 800;
			TelescopeHillSprite.y = 0;
			
			TelescopeHillBg = new Shape();
			TelescopeHillBg.graphics.beginFill(0x000000);
			TelescopeHillBg.graphics.lineTo(800,0);	
			TelescopeHillBg.graphics.lineTo(800,512);	
			TelescopeHillBg.graphics.lineTo(0,512);	
			TelescopeHillBg.graphics.lineTo(0,0);	

			TelescopeHillBg.touchable = true;
			TelescopeHillBg.graphics.endFill(false);
			TelescopeHillBg.alpha = 1.0;
	//		TelescopeHillBg.graphics.precisionHitTest = true;	

			
			TelescopeHillTitle = new Image(this.assets.getTexture('TelescopeHillTitle'));
			TelescopeHillTitle.pivotX = (TelescopeHillTitle.width)/2;
			//TelescopeHillTitle.width = TelescopeHillTitle.width*0.88;
		//TelescopeHillTitle.height = TelescopeHillTitle.height*0.88;
			TelescopeHillTitle.x = 400;
			TelescopeHillTitle.y = 0;
			TelescopeHillTitle.touchable = false;
			
			TelescopeHillIcon = new Image(this.assets.getTexture('TelescopeHillIcon'));
			TelescopeHillIcon.width = (TelescopeHillIcon.width)/2;
			TelescopeHillIcon.height = (TelescopeHillIcon.height)/2;
			TelescopeHillIcon.pivotX = (TelescopeHillIcon.width);
			TelescopeHillIcon.x = 400;
			TelescopeHillIcon.y = 305;
			TelescopeHillIcon.touchable = false;
			
			
			TelescopeHillText = new Image(this.assets.getTexture('AvailableOnAmazonAppstore'));
	//		TelescopeHillText = new Image(this.assets.getTexture('AvailableOnGooglePlay'));
			TelescopeHillText.pivotX = (TelescopeHillText.width)/2;
			TelescopeHillText.x = 400;
			TelescopeHillText.y = 450;
			TelescopeHillText.touchable = false;
			
			TelescopeHillBackToMainMenu = new Image(this.assets.getTexture('back_arrow'));
			TelescopeHillBackToMainMenu.x = 20;
			TelescopeHillBackToMainMenu.y = 390;
			
			TelescopeHillBackToMainMenu.touchable = false;
			
			TelescopeHillSprite.addChildAt(TelescopeHillBg,0);
			TelescopeHillSprite.addChildAt(TelescopeHillTitle,1);
			TelescopeHillSprite.addChildAt(TelescopeHillIcon,2);
			TelescopeHillSprite.addChildAt(TelescopeHillText,3);
			TelescopeHillSprite.addChildAt(TelescopeHillBackToMainMenu,4);
		//	private var hit_TelescopeHillBackToMainMenu:Shape;
			
			this.addChild(TelescopeHillSprite);
			
			
		}
		
		private function createOptions():void{
			optionsSprite = new Sprite();
			optionsSprite.x= 0;
			optionsSprite.y = 512;
			
		//	optionsBg = new Image(this.assets.getTexture('optionsBg'));
		//	optionsBg.width = 800;
		//	optionsBg.height = 538;
			//this.optionsSprite.addChildAt(optionsBg,0);
			
			ReturnToMainMenu = new Image(this.assets.getTexture('mainMenu'));
			ReturnToMainMenu.touchable = false;
			ReturnToMainMenu.x = 85;
			ReturnToMainMenu.y = 415;
			
			this.optionsSprite.addChildAt(ReturnToMainMenu,0);
			
			
			MusicVolSliderObj = new VolSlider(this.assets,"Music");
			MusicVolSliderObj.x = 305;
			MusicVolSliderObj.y = 15;
			MusicVolSliderObj.touchable = false;
			this.optionsSprite.addChild(MusicVolSliderObj);
						
			AmbientVolSliderObj = new VolSlider(this.assets,"Ambient");
			AmbientVolSliderObj.x = 305;
			AmbientVolSliderObj.y = 110;
			AmbientVolSliderObj.touchable = false;
			this.optionsSprite.addChild(AmbientVolSliderObj);
			
			SoundFXVolSliderObj = new VolSlider(this.assets,"SoundFX");
			SoundFXVolSliderObj.x = 305;
			SoundFXVolSliderObj.y = 205;
			SoundFXVolSliderObj.touchable = false;
			this.optionsSprite.addChild(SoundFXVolSliderObj);
			
			ResetButton = new Image(this.assets.getTexture('Reset'));
			ResetButton.x = 25;
			ResetButton.y = 315;
			ResetButton.touchable = false;
			this.optionsSprite.addChild(ResetButton);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedHintObj.data.Enabled != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedHintObj.data.Enabled === true){
					HintsButton = new Image(this.assets.getTexture('HintsEnabled'));
					HintsButton.width = 206;
					HintsButton.height = 122;
					HintsButton.x = 512;
				}else{
					HintsButton = new Image(this.assets.getTexture('HintsDisabled'));
					HintsButton.width = 230;
					HintsButton.height = 122;
					HintsButton.x = 500;
					
				}
			}else{
				HintsButton = new Image(this.assets.getTexture('HintsDisabled'));
				HintsButton.width = 230;
				HintsButton.height = 122;
				HintsButton.x = 500;
				
			}
			HintsButton.y = 330;
			
			/*
			DISABLED HINTS: - hide button
			*/
		//	HintsButton.alpha = 0;
			
			/*END hide button*/
			HintsButton.touchable = false;
			this.optionsSprite.addChild(HintsButton);
			
			
			this.addChildAt(optionsSprite,2);
			
		}
		private function showTelescopeHill():void{
			envContTween  = new Tween(envCont,2, Transitions.EASE_IN_OUT);
			envContTween.animate("x",-800);
			envContTween.onComplete = function():void{
			}
			
			MenuSpriteTween  = new Tween(MenuSprite,2, Transitions.EASE_IN_OUT);
			MenuSpriteTween.animate("x",-800);
			MenuSpriteTween.onComplete = function():void{
			}
			
			TelescopeHillTween= new Tween(TelescopeHillSprite,2, Transitions.EASE_IN_OUT);
			TelescopeHillTween.animate("x",0);
			TelescopeHillTween.onComplete = function():void{
				
				animating = false;
				TelescopeHillLoaded = true;
				createTelescopeHillHits();
				//createOptionsHits();
			}
			
			Starling.juggler.add(TelescopeHillTween);	
			Starling.juggler.add(MenuSpriteTween);	
			
			Starling.juggler.add(envContTween);
		}
		
		
		
		private function showOptions():void{
			//this.removeEventListener(Event.ENTER_FRAME, boatAnimation);
			
			
			envContTween  = new Tween(envCont,2, Transitions.EASE_IN_OUT);
			envContTween.animate("y",-849);
			envContTween.onComplete = function():void{
			}
				
			MenuSpriteTween  = new Tween(MenuSprite,2, Transitions.EASE_IN_OUT);
			MenuSpriteTween.animate("y",-512);
			MenuSpriteTween.onComplete = function():void{
			}
				
			ShowOptionsTween= new Tween(optionsSprite,2, Transitions.EASE_IN_OUT);
			ShowOptionsTween.animate("y",0);
			ShowOptionsTween.onComplete = function():void{
			
				animating = false;
				OptionsLoaded = true;
				createOptionsHits();
			}
			
			Starling.juggler.add(ShowOptionsTween);	
			Starling.juggler.add(MenuSpriteTween);	
				
			Starling.juggler.add(envContTween);
		}
		
		private function createTelescopeHillHits():void{
		
			
			hit_TelescopeHillBackToMainMenu = new Shape();
			hit_TelescopeHillBackToMainMenu.graphics.beginFill(0x00FF00);
			
			hit_TelescopeHillBackToMainMenu.graphics.lineTo(TelescopeHillBackToMainMenu.width,0);	
			hit_TelescopeHillBackToMainMenu.graphics.lineTo(TelescopeHillBackToMainMenu.width,TelescopeHillBackToMainMenu.height);	
			hit_TelescopeHillBackToMainMenu.graphics.lineTo(0,TelescopeHillBackToMainMenu.height);	
			hit_TelescopeHillBackToMainMenu.graphics.lineTo(0,0);	
			
			hit_TelescopeHillBackToMainMenu.alpha = 0.0;
			hit_TelescopeHillBackToMainMenu.x = TelescopeHillBackToMainMenu.x;
			hit_TelescopeHillBackToMainMenu.y = TelescopeHillBackToMainMenu.y;	
			hit_TelescopeHillBackToMainMenu.touchable = false;
			hit_TelescopeHillBackToMainMenu.graphics.precisionHitTest = true;	
			this.TelescopeHillSprite.addChildAt(hit_TelescopeHillBackToMainMenu,3);
		}
		
		
		private function createOptionsHits():void{
		
			
			hit_ReturnToMain = new Shape();
			hit_ReturnToMain.graphics.beginFill(0x00FF00);
			
			hit_ReturnToMain.graphics.lineTo(ReturnToMainMenu.width,0);	
			hit_ReturnToMain.graphics.lineTo(ReturnToMainMenu.width,ReturnToMainMenu.height);	
			hit_ReturnToMain.graphics.lineTo(0,ReturnToMainMenu.height);	
			hit_ReturnToMain.graphics.lineTo(0,0);	
			
			hit_ReturnToMain.alpha = 0.0;
			hit_ReturnToMain.x = ReturnToMainMenu.x;
			hit_ReturnToMain.y = ReturnToMainMenu.y;	
			hit_ReturnToMain.touchable = false;
			hit_ReturnToMain.graphics.precisionHitTest = true;	
			this.optionsSprite.addChildAt(hit_ReturnToMain,1);
			
			hit_Hints = new Shape();
			hit_Hints.graphics.beginFill(0x00FF00);
			
			hit_Hints.graphics.lineTo(506,316+10);	
			hit_Hints.graphics.lineTo(732,316+10);	
			hit_Hints.graphics.lineTo(732,458+10);	
			hit_Hints.graphics.lineTo(506,458+10);	
			
			hit_Hints.alpha = 0.0;
		//	hit_Hints.x = ReturnToMainMenu.x;
		//	hit_Hints.y = ReturnToMainMenu.y;	
			hit_Hints.touchable = false;
			hit_Hints.graphics.precisionHitTest = true;	
			
			this.optionsSprite.addChildAt(hit_Hints,1);
			
			hit_ResetButton = new Shape();
			hit_ResetButton.graphics.beginFill(0x00FF00);
			
			hit_ResetButton.graphics.lineTo(40,296+30);	
			hit_ResetButton.graphics.lineTo(423,296+30);	
			hit_ResetButton.graphics.lineTo(423,384);	
			hit_ResetButton.graphics.lineTo(40,384);	
		
			hit_ResetButton.alpha = 0.0;
			//	hit_Hints.x = ReturnToMainMenu.x;
			//	hit_Hints.y = ReturnToMainMenu.y;	
			hit_ResetButton.touchable = false;
			hit_ResetButton.graphics.precisionHitTest = true;	
			
			this.optionsSprite.addChildAt(hit_ResetButton,1);
		}
		private function ReturnToMainMenuFuncFromTelescopeHill():void{
			this.TelescopeHillSprite.removeChild(hit_TelescopeHillBackToMainMenu);
			envContTween  = new Tween(envCont,2, Transitions.EASE_IN_OUT);
			envContTween.animate("x",0);
			envContTween.onComplete = function():void{
			}
			
			MenuSpriteTween  = new Tween(MenuSprite,2, Transitions.EASE_IN_OUT);
			MenuSpriteTween.animate("x",0);
			MenuSpriteTween.onComplete = function():void{
				
				
			}
			
			TelescopeHillTween= new Tween(TelescopeHillSprite,2, Transitions.EASE_IN_OUT);
			TelescopeHillTween.animate("x",800);
			TelescopeHillTween.onComplete = function():void{
				TelescopeHillLoaded = false;
				animating = false;
				MenuLoaded = true;
				CreateMenuHit();
				//		addSceneEnterFrame();
			}
			
			Starling.juggler.add(TelescopeHillTween);	
			Starling.juggler.add(MenuSpriteTween);	
			
			Starling.juggler.add(envContTween);	
			
		}
		private function ReturnToMainMenuFunc():void{
			//this.addEventListener(Event.ENTER_FRAME, boatAnimation);
			this.optionsSprite.removeChild(hit_ReturnToMain);
			this.optionsSprite.removeChild(hit_Hints);
			this.optionsSprite.removeChild(hit_ResetButton);
			envContTween  = new Tween(envCont,2, Transitions.EASE_IN_OUT);
			envContTween.animate("y",-337);
			envContTween.onComplete = function():void{
			}
			
			MenuSpriteTween  = new Tween(MenuSprite,2, Transitions.EASE_IN_OUT);
			MenuSpriteTween.animate("y",0);
			MenuSpriteTween.onComplete = function():void{
				
			
			}
			
			ShowOptionsTween= new Tween(optionsSprite,2, Transitions.EASE_IN_OUT);
			ShowOptionsTween.animate("y",538);
			ShowOptionsTween.onComplete = function():void{
				animating = false;
				MenuLoaded = true;
				CreateMenuHit();
		//		addSceneEnterFrame();
			}
			
			Starling.juggler.add(ShowOptionsTween);	
			Starling.juggler.add(MenuSpriteTween);	
			
			Starling.juggler.add(envContTween);	
			
		}
		
	
		
		
		
	
		
		private function FadeOutMenuExtras():void{
			TapToStartFadeTween = new Tween(tapToStart, 1, Transitions.EASE_IN);
			TapToStartFadeTween.fadeTo(0);
			TapToStartFadeTween.onComplete = null;
			
			CopyRightFadeTween = new Tween(copyright, 1, Transitions.LINEAR);
			CopyRightFadeTween.fadeTo(0);
			CopyRightFadeTween.onComplete = FadeOutMenuExtrasOnComplete;
			Starling.juggler.add(CopyRightFadeTween);			

			
			Starling.juggler.add(TapToStartFadeTween);		
		}
		
		private function FadeOutMenuExtrasOnComplete():void{
			this.removeChild(copyright);
			this.removeChild(tapToStart);
			
			TitleFadeTween = new Tween(title, 1.5, Transitions.LINEAR);
			TitleFadeTween.fadeTo(0);
			TitleFadeTween.onComplete = function():void{
				Starling.juggler.purge();
				RollDown();
			}
			
			Starling.juggler.add(TitleFadeTween);
		
		}
		
		
		
		
		private function RollDown():void{
			
			this.removeChild(title);
		//	sunContTween = new Tween(sunCont,2, Transitions.EASE_IN);
		//	sunContTween.animate("y",-620);
			
		//	sunContTween.onComplete = function():void{
				
				envContTween  = new Tween(envCont,3, Transitions.EASE_OUT);
				envContTween.animate("y",-337);
				envContTween.onComplete = function():void{
					
					//Starling.juggler.purge();
					AddOptionButton();
					createOptions();
					createTelescopeHill();
					AddTouchHandler();
					//RemoveSunAnimaEventList();
					//	startBoat();
				}
				Starling.juggler.add(envContTween);
		//	};
		//	Starling.juggler.add(sunContTween);
		}
		
	
		
		private function AddOptionButton():void{
			
			MenuSprite = new Sprite();
			trace("	stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.DeclareSave:" +(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.DeclareSave);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.DeclareSave === true)
			{	
				startButton = new Image(this.assets.getTexture('Resume'));
				startButton.x = 55;
				startButton.y = 50;
			}else{
				startButton = new Image(this.assets.getTexture('NewGame'));
				startButton.x = 30;
				startButton.y = 40;
			}
			
			
			startButton.touchable = false;
			startButton.alpha = 0;
			
			this.MenuSprite.addChildAt(startButton,0);
			
			optionsButton = new Image(this.assets.getTexture('Options'));
			optionsButton.x = 85;
			optionsButton.y = 170;
			optionsButton.touchable = false;
			optionsButton.alpha = 0;
			
			this.MenuSprite.addChildAt(optionsButton,1);
			
			
			moreGamesButton = new Image(this.assets.getTexture('OtherGames'));
			moreGamesButton.x = 40;
			moreGamesButton.y = 400;
			moreGamesButton.touchable = false;
			moreGamesButton.alpha = 0;
			this.MenuSprite.addChildAt(moreGamesButton,2);
			
			this.addChildAt(MenuSprite,2);
			
			OptionsButtonTween = new Tween(optionsButton, 2, Transitions.LINEAR);
			OptionsButtonTween.fadeTo(1);
			OptionsButtonTween.onComplete = function():void{
			};
			
			
			StartButtonTween = new Tween(startButton, 1.5, Transitions.LINEAR);
			StartButtonTween.fadeTo(1);
			StartButtonTween.onComplete = function():void{
			};
			
			moreGamesButtonTween = new Tween(moreGamesButton, 2, Transitions.LINEAR);
			moreGamesButtonTween.fadeTo(1);
			moreGamesButtonTween.onComplete = function():void{
				CreateMenuHit();
				animating = false;
				MenuLoaded = true;
			};
			
			
			Starling.juggler.add(moreGamesButtonTween);	
			Starling.juggler.add(OptionsButtonTween);	
			Starling.juggler.add(StartButtonTween);	
		}
		
		
		
		
		private function addTitleElement():void{
			
			animating = false;
			trace("ADDING Title Elements");
			//CreateGeneralHit();
			addTapToStart();
			addCopyRight();
		//	titleLoaded = true;
		//	CreateGeneralHit();
			
			AddTouchHandler();
//			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
	//		this.addEventListener(TouchEvent.TOUCH,onClickHandler);	
		}
		
		private function RemoveResetDialog():void{
			this.removeChild(ResetDialogue);
			ResetDialogue.dispose();
		}
		
		
		
		private function CreateMenuHit(NewLay:Boolean = false):void{
			if(NewLay === false){
				trace("NEWLAY NEWLAY");
				
				hit_Start = new Shape();
				hit_Start.graphics.beginFill(0x00FF00);
				
		//		hit_Start.graphics.lineTo(startButton.width,0);	
		//		hit_Start.graphics.lineTo(startButton.width,startButton.height);	
		//		hit_Start.graphics.lineTo(0,startButton.height);	
		//		hit_Start.graphics.lineTo(0,0);	
				
				hit_Start.graphics.beginFill(0x00FF00);
				hit_Start.graphics.lineTo(28,39);	
				hit_Start.graphics.lineTo(119,40);	
				hit_Start.graphics.lineTo(420,128);	
				hit_Start.graphics.lineTo(420,192);	
				hit_Start.graphics.lineTo(340,191);	
				hit_Start.graphics.lineTo(30,138);	
				
				hit_Start.alpha = 0.0;
		//		hit_Start.x = startButton.x;
		//		hit_Start.y = startButton.y;	
				hit_Start.touchable = false;
				hit_Start.graphics.precisionHitTest = true;	
				this.MenuSprite.addChild(hit_Start);
				
				
			}else{
				trace("OLDLAY OLDLAY");
				hit_Start = new Shape();
				hit_Start.graphics.beginFill(0x00FF00);
				hit_Start.graphics.lineTo(28,39);	
				hit_Start.graphics.lineTo(119,40);	
				hit_Start.graphics.lineTo(420,128);	
				hit_Start.graphics.lineTo(420,192);	
				hit_Start.graphics.lineTo(340,191);	
				hit_Start.graphics.lineTo(30,138);		
				
				hit_Start.alpha = 0.0;
			//	hit_Start.x = startButton.x;
			//	hit_Start.y = startButton.y;	
				hit_Start.touchable = false;
				hit_Start.graphics.precisionHitTest = true;	
				this.MenuSprite.addChild(hit_Start);
			}
			optionsButton.width,optionsButton.height
				
			hit_Options = new Shape();
			hit_Options.graphics.beginFill(0x00FF00);
			hit_Options.graphics.lineTo(79,181);	
			hit_Options.graphics.lineTo(103,161);	
			hit_Options.graphics.lineTo(346,211);	
			hit_Options.graphics.lineTo(344,285);	
			hit_Options.graphics.lineTo(83,262);	
			hit_Options.graphics.lineTo(76,229);	
					
			hit_Options.alpha = 0.0;
		//	hit_Options.x = optionsButton.x;
		//	hit_Options.y = optionsButton.y;
			hit_Options.graphics.precisionHitTest = true;	
			hit_Options.touchable = false;

			this.MenuSprite.addChild(hit_Options);
			
			
			hit_MoreGames = new Shape();
			hit_MoreGames.graphics.beginFill(0x00FF00);
			
			hit_MoreGames.graphics.lineTo(moreGamesButton.width,0);	
			hit_MoreGames.graphics.lineTo(moreGamesButton.width,moreGamesButton.height);	
			hit_MoreGames.graphics.lineTo(0,moreGamesButton.height);	
			hit_MoreGames.graphics.lineTo(0,0);	
			
			hit_MoreGames.alpha = 0.0;
			hit_MoreGames.x = moreGamesButton.x;
			hit_MoreGames.y = moreGamesButton.y;	
			hit_MoreGames.touchable = false;
			hit_MoreGames.graphics.precisionHitTest = true;	
			this.MenuSprite.addChild(hit_MoreGames);
		}
		
		
	
		private function addTapToStart():void{

			TapToStartFadeTween = new Tween(tapToStart, 2, Transitions.LINEAR);
			TapToStartFadeTween.fadeTo(1);
			TapToStartFadeTween.onComplete = FadeOutTapToStart;
			Starling.juggler.add(TapToStartFadeTween);			
			
		}
		public function FadeOutTapToStart():void{
			TapToStartFadeTween = new Tween(tapToStart, 2, Transitions.EASE_IN);
			TapToStartFadeTween.fadeTo(0);
			TapToStartFadeTween.onComplete = FadeInTapToStart;
			Starling.juggler.add(TapToStartFadeTween);		
		}
		public function FadeInTapToStart():void{
			TapToStartFadeTween = new Tween(tapToStart, 2, Transitions.EASE_OUT);
			TapToStartFadeTween.fadeTo(1);
			TapToStartFadeTween.onComplete = FadeOutTapToStart;
			Starling.juggler.add(TapToStartFadeTween);		
		}
		
		private function addCopyRight():void{
	
			CopyRightFadeTween = new Tween(copyright, 2, Transitions.LINEAR);
			CopyRightFadeTween.fadeTo(1);
			CopyRightFadeTween.onComplete = null;
			Starling.juggler.add(CopyRightFadeTween);			

		}
	
	
		private function fadeOut():void{
			(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("MainTheme",0,2,"stop");

			(stage.getChildAt(0) as Object).BlackOutRectangleFade(1,1,this.Exit);

			trace("EnterGamePlay");
			
		}

		
	
		
		
		private function Exit():void{
			trace("Exiting MainMenu");
			this.removeEventListeners();
			//	optionsButton.texture.dispose();
			optionsButton.dispose();
			//	startButton.texture.dispose();
			//startButton.texture.dispose();
			startButton.dispose();
			//ReturnToMainMenu.dispose();
			this.removeChild(optionsButton,true);
			this.removeChild(ReturnToMainMenu,true);
			//	this.removeChild(ResetButton,true);
			this.removeChild(startButton,true);			
			
			
			this.removeChild(bg);
			//	Starling.juggler.purge();
			
			//	this.assets.dispose();	
			//	this.assets = null;
			//	bg.texture.dispose()
			
			
			bg.dispose();
			
			targ.dispose();			
			bg				 	= null;
			title				= null;
			TitleFadeTween		= null;
			copyright			= null;
			CopyRightFadeTween	= null;
			tapToStart			= null;
			TapToStartFadeTween	= null;		
			RollDownTween		= null;
			optionsButton		= null;
			OptionsButtonTween	= null;
			startButton			= null;
			StartButtonTween	= null;
			ShowOptionsTween	= null;
			ReturnToMainMenu	= null;
			ReturnToMainMenuTween	 = null;
			delayedCall			= null;
			rollUpTween			= null;
			fadeOutTween		= null;
			touches				= null;
			targ				= null;
			super.dispose();
			(stage.getChildAt(0) as Object).addGamePlay();
		}
		
		

		

	
				 
		
		
	}
}