package screens.ingamescreens
{

	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class LabComputer extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var SaveArrayTwo:Array = new Array();
		
		private var bg:Image;
		private var icon_disc:Image;
		private var window_pascal:Image;
		private var window_green:Image;
				
		private var hit_icon_iss:Shape;
		private var hit_icon_disc:Shape;
		private var hit_icon_green:Shape;
		private var hit_icon_pascal:Shape;

		private var hit_menu:Shape;
		private var hit_notes:Shape;
		
		private var issSprite:Sprite;
		private var issbg:Image;
		private var issDisc:Image;
		private var issSuccessFail:Image;
		private var issSignal:Image;
		private var issPrimes:Image;
		
		private var hit_iss_signal:Shape;
		private var hit_iss_disc:Shape;
		private var hit_iss_terminal:Shape;
		
		private var discSprite:Sprite;
		private var discbg:Image;
		private var discSoundIcon:Image;
		private var hit_disc_eject:Shape;
		private var hit_disc_files:Shape;
		
				
		private var WindowOpen:Boolean = false
		private var WindowThatsOpen:String = null;
		private var WrittenToDisc:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var SatAttached:Boolean = false;
		private var DiscAttached:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function LabComputer(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labComputer_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabComputer/labComputer_bg.jpg'));
				game.TrackAssets('labComputer_01');
			}
			if(game.CheckAsset('labComputer_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabComputer/LabComputer_Sprite.png'));
				game.TrackAssets('labComputer_02');
			}
			if(game.CheckAsset('labComputer_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabComputer/LabComputer_Sprite.xml'));
				game.TrackAssets('labComputer_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabComputer","LabComputerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					SatAttached = true;
				}
			}
			
			bg = new Image(this.assets.getTexture('labComputer_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			icon_disc = new Image(this.assets.getTexture('disk_icon'));
			icon_disc.touchable = false;
			icon_disc.x = 19;
			icon_disc.y = 171;
			
			
			window_pascal = new Image(this.assets.getTexture('page_pascal'));
			window_pascal.touchable = false;
			window_pascal.x = 95;
			window_pascal.y = 16;
			
			window_green = new Image(this.assets.getTexture('page_crystal'));
			window_green.touchable = false;
			window_green.x = 85;
			window_green.y = 16;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Disk"] == "Attached"){
					DiscAttached = true;
					icon_disc.alpha = 1;
				}else{
					icon_disc.alpha = 0;
				}
			}else{
				icon_disc.alpha = 0;
			}
			
			
			
			window_pascal.alpha = 0;
			window_green.alpha = 0;
			
			this.addChildAt(icon_disc,1);
			this.addChildAt(window_pascal,2);
			this.addChildAt(window_green,3);
			//FadeOutOcean(1);
			CreateIconHits();
			CreateMenuHit();
			
			MakeDiscSprite();
			MakeISSSprite();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
					WrittenToDisc = true;
					discSoundIcon.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Window'] == undefined){
					WindowOpen = false;
					WindowThatsOpen = null;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Window'] == 'ISS'){
					WindowOpen = true;
					WindowThatsOpen = 'ISS';
					issSprite.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Window'] == 'Disc'){
					WindowOpen = true;
					WindowThatsOpen = 'Disc';
					discSprite.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Window'] == 'Pascal'){
					WindowOpen = true;
					WindowThatsOpen = 'Pascal';
					window_pascal.alpha = 1;
					CreateNotesHit();
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Window'] == 'Green'){
					WindowOpen = true;
					WindowThatsOpen = 'Green';
					window_green.alpha = 1;
					CreateNotesHit();
				}else{
					WindowOpen = false;
					WindowThatsOpen = null;
				}
				
			}else{
				
			}
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crickets_01",((stage.getChildAt(0) as Object).MusicObj.globalVol/2),1.0);
			
		}
		
		private function MakeISSSprite():void{
			/*
			private var issSprite:Sprite;
			private var issbg:Image;
			private var issDisc:Image;
			private var issSuccessFail:Image;
			private var issSignal:Image;
			private var issPrimes:Image;
			*/
			issSprite = new Sprite();
			issSprite.touchable = false;
			issSprite.x = 0;
			issSprite.y = 0;
			issSprite.alpha = 0;
			
			issbg = new Image(this.assets.getTexture('page_iss'));
			issbg.touchable = false;
			issbg.x = 85;
			issbg.y = 16;
			issbg.alpha = 1;
			issSprite.addChildAt(issbg,0);
		
			issDisc = new Image(this.assets.getTexture('iss_disk'));
			issDisc.touchable = false;
			issDisc.x = 397;
			issDisc.y = 265;
			
			
			issSuccessFail = new Image(this.assets.getTexture('iss_fail'));
			issSuccessFail.touchable = false;
			issSuccessFail.x = 402;
			issSuccessFail.y = 362;
			
			
			issSignal = new Image(this.assets.getTexture('iss_signal'));
			issSignal.touchable = false;
			issSignal.x = 88;
			issSignal.y = 72;
			
			issPrimes = new Image(this.assets.getTexture('iss_primes'));
			issPrimes.touchable = false;
			issPrimes.x = 101;
			issPrimes.y = 267;
			
			if(SatAttached === true){
				issSignal.alpha = 1;
				issPrimes.alpha = 1;
			}else{
				issSignal.alpha = 0;
				issPrimes.alpha = 0;
			}
			
			if(DiscAttached === true){
				issDisc.alpha = 1;
			}else{
				issDisc.alpha = 0;
			}
			
			
			issSuccessFail.alpha = 0;
			
				
			issSprite.addChildAt(issDisc,1);			
			issSprite.addChildAt(issSuccessFail,2);			
			issSprite.addChildAt(issSignal,3);						
			issSprite.addChildAt(issPrimes,4);
			
			
			hit_iss_signal = new Shape();
			hit_iss_signal.touchable = false;
			hit_iss_signal.graphics.beginFill(0xff0000);
			
			hit_iss_signal.graphics.lineTo(86,71);								
			hit_iss_signal.graphics.lineTo(546,71);								
			hit_iss_signal.graphics.lineTo(546,239);								
			hit_iss_signal.graphics.lineTo(86,239);								
			hit_iss_signal.graphics.endFill(false);
			
			hit_iss_signal.alpha = 0.0;
			
			hit_iss_signal.graphics.precisionHitTest = true;	
			issSprite.addChild(hit_iss_signal);
			
			
			hit_iss_disc = new Shape();
			hit_iss_disc.touchable = false;
			hit_iss_disc.graphics.beginFill(0xff0000);
			
			hit_iss_disc.graphics.lineTo(373,257);								
			hit_iss_disc.graphics.lineTo(681,257);								
			hit_iss_disc.graphics.lineTo(681,457);								
			hit_iss_disc.graphics.lineTo(373,457);								
				hit_iss_disc.graphics.endFill(false);
			
			hit_iss_disc.alpha = 0.0;
			
			hit_iss_disc.graphics.precisionHitTest = true;	
			issSprite.addChild(hit_iss_disc);
			
			
			hit_iss_terminal = new Shape();
			hit_iss_terminal.touchable = false;
			hit_iss_terminal.graphics.beginFill(0xff0000);
			
			hit_iss_terminal.graphics.lineTo(93,263);								
			hit_iss_terminal.graphics.lineTo(353,263);								
			hit_iss_terminal.graphics.lineTo(353,459);								
			hit_iss_terminal.graphics.lineTo(93,459);								
								
			hit_iss_terminal.graphics.endFill(false);
			
			hit_iss_terminal.alpha = 0.0;
			
			hit_iss_terminal.graphics.precisionHitTest = true;	
			issSprite.addChild(hit_iss_terminal);
			
			
			
			this.addChildAt(issSprite,3);
		}
		
		private function MakeDiscSprite():void{
			/*
			private var discSprite:Sprite;
			private var discbg:Image;
			private var discSoundIcon:Image;
			*/
			
			discSprite = new Sprite();
			discSprite.touchable = false;
			discSprite.x = 0;
			discSprite.y = 0;
			discSprite.alpha = 0;
			
			discbg = new Image(this.assets.getTexture('page_disc'));
			discbg.touchable = false;
			discbg.x = 85;
			discbg.y = 16;
			discbg.alpha = 1;
			discSprite.addChildAt(discbg,0);
			
			discSoundIcon = new Image(this.assets.getTexture('sound_icon'));
			discSoundIcon.touchable = false;
			discSoundIcon.x = 239;
			discSoundIcon.y = 249;
			
			
			if(WrittenToDisc === true){
				discSoundIcon.alpha = 1;
			}else{
				discSoundIcon.alpha = 0;
			}
			
			discSprite.addChildAt(discSoundIcon,1);
			
			hit_disc_eject = new Shape();
			hit_disc_eject.touchable = false;
			hit_disc_eject.graphics.beginFill(0xff0000);
			
			hit_disc_eject.graphics.lineTo(541,76);								
			hit_disc_eject.graphics.lineTo(683,76);								
			hit_disc_eject.graphics.lineTo(683,209);								
			hit_disc_eject.graphics.lineTo(541,209);								

			hit_disc_eject.graphics.endFill(false);
			
			hit_disc_eject.alpha = 0.0;
			
			hit_disc_eject.graphics.precisionHitTest = true;	
			discSprite.addChild(hit_disc_eject);
			
			
			hit_disc_files = new Shape();
			hit_disc_files.touchable = false;
			hit_disc_files.graphics.beginFill(0xff0000);
			
			hit_disc_files.graphics.lineTo(106,78);															
			hit_disc_files.graphics.lineTo(521,78);															
			hit_disc_files.graphics.lineTo(521,443);															
			hit_disc_files.graphics.lineTo(106,443);															
			
			hit_disc_files.graphics.endFill(false);
			
			hit_disc_files.alpha = 0.0;
			
			hit_disc_files.graphics.precisionHitTest = true;	
			discSprite.addChild(hit_disc_files);
			
			this.addChildAt(discSprite,2);
			
		}
		
		//hit_notes
		private function CreateNotesHit():void{
			hit_notes = new Shape();
			hit_notes.touchable = false;
			hit_notes.graphics.beginFill(0xff0000);
			
			hit_notes.graphics.lineTo(98,73);								
			hit_notes.graphics.lineTo(661,74);								
			hit_notes.graphics.lineTo(707,112);								
			hit_notes.graphics.lineTo(706,406);								
			hit_notes.graphics.lineTo(602,446);								
			hit_notes.graphics.lineTo(106,446);								
			
			hit_notes.graphics.endFill(false);
			
			hit_notes.alpha = 0.0;
			
			hit_notes.graphics.precisionHitTest = true;	
			this.addChild(hit_notes);
		}
		
		
		private function CreateMenuHit():void{
			hit_menu = new Shape();
			hit_menu.touchable = false;
			hit_menu.graphics.beginFill(0xff0000);
			
			hit_menu.graphics.lineTo(93,12);								
			hit_menu.graphics.lineTo(671,12);								
			hit_menu.graphics.lineTo(671,67);								
			hit_menu.graphics.lineTo(93,67);								
			
			hit_menu.graphics.endFill(false);
			
			hit_menu.alpha = 0.0;
			
			hit_menu.graphics.precisionHitTest = true;	
			this.addChild(hit_menu);
		}
		
		private function CreateIconHits():void{
			/*	private var hit_icon_iss:Shape;
			private var hit_icon_disc:Shape;
			private var hit_icon_green:Shape;
			private var hit_icon_pascal:Shape;
			*/
			
			hit_icon_iss = new Shape();
			hit_icon_iss.touchable = false;
			hit_icon_iss.graphics.beginFill(0xff0000);
			
			hit_icon_iss.graphics.lineTo(10,0);				
			hit_icon_iss.graphics.lineTo(135,0);				
			hit_icon_iss.graphics.lineTo(135,154);				
			hit_icon_iss.graphics.lineTo(10,154);				
			
			hit_icon_iss.graphics.endFill(false);
			
			hit_icon_iss.alpha = 0.0;
			
			hit_icon_iss.graphics.precisionHitTest = true;	
			this.addChild(hit_icon_iss);

			
			hit_icon_disc = new Shape();
			hit_icon_disc.touchable = false;
			hit_icon_disc.graphics.beginFill(0xff0000);
			
			hit_icon_disc.graphics.lineTo(10,168);				
			hit_icon_disc.graphics.lineTo(135,168);				
			hit_icon_disc.graphics.lineTo(135,298);				
			hit_icon_disc.graphics.lineTo(10,298);				

			hit_icon_disc.graphics.endFill(false);
			
			hit_icon_disc.alpha = 0.0;
			
			hit_icon_disc.graphics.precisionHitTest = true;	
			this.addChild(hit_icon_disc);
			
			
			hit_icon_green = new Shape();
			hit_icon_green.touchable = false;
			hit_icon_green.graphics.beginFill(0xff0000);
			
			hit_icon_green.graphics.lineTo(399,64);				
			hit_icon_green.graphics.lineTo(535,64);				
			hit_icon_green.graphics.lineTo(535,220);				
			hit_icon_green.graphics.lineTo(399,220);				

			hit_icon_green.graphics.endFill(false);
			
			hit_icon_green.alpha = 0.0;
			
			hit_icon_green.graphics.precisionHitTest = true;	
			this.addChild(hit_icon_green);
			
			
			hit_icon_pascal = new Shape();
			hit_icon_pascal.touchable = false;
			hit_icon_pascal.graphics.beginFill(0xff0000);
			
			hit_icon_pascal.graphics.lineTo(200,234);				
			hit_icon_pascal.graphics.lineTo(326,234);				
			hit_icon_pascal.graphics.lineTo(326,387);				
			hit_icon_pascal.graphics.lineTo(200,387);				

			hit_icon_pascal.graphics.endFill(false);
			
			hit_icon_pascal.alpha = 0.0;
			
			hit_icon_pascal.graphics.precisionHitTest = true;	
			this.addChild(hit_icon_pascal);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((LabDesk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.LabDeskObj,true
						);
					}else if(WindowOpen === false){	
						
						if(hit_icon_iss.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
							ISSHandler();
						}else if(hit_icon_pascal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
							PascalHandler();
						}else if(hit_icon_green.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
							GreenHandler();
						}else if(DiscAttached === true){
							if(hit_icon_disc.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
							
								DiscHandler();
							}
						}
					}else{
						if(hit_menu.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(WindowThatsOpen == 'Pascal'){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
								this.removeChild(hit_notes);
								window_pascal.alpha = 0;
							}else if(WindowThatsOpen == 'Green'){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
								window_green.alpha = 0;
								this.removeChild(hit_notes);
							}else if(WindowThatsOpen == 'Disc'){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
								discSprite.alpha = 0;
							}else if(WindowThatsOpen == 'ISS'){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
								issSuccessFail.alpha = 0;
								issSprite.alpha = 0;
							}
							WindowOpen = false;
							WindowThatsOpen = null;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
							}
							SaveArray['Window'] = null;
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);
							
							
						}else if(WindowThatsOpen == 'Pascal'){
							if(hit_notes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Information on French mathematician Blaise Pascal.");
							}
						}else if(WindowThatsOpen == 'Green'){
							if(hit_notes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It appears to be Dr. Von Awesome's notes on creating a green crystal.");
							}
						}else if(WindowThatsOpen == 'Disc'){
							if(hit_disc_eject.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
								icon_disc.alpha = 0;
								DiscAttached = false;
								WindowOpen = false;
								WindowThatsOpen = null;
								discSprite.alpha = 0;
								issDisc.alpha = 0;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
								}
								SaveArray['Window'] = null;
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);
								
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
									SaveArrayTwo = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk;
								}
								SaveArrayTwo['Disk'] = "Out";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDesk',SaveArrayTwo);	
								
							}else if(hit_disc_files.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(WrittenToDisc === false){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is nothing on the floppy disk.");
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a file called 'Algorithm' on the floppy disk.");
								}
							}
						}else if(WindowThatsOpen == 'ISS'){
							if(hit_iss_signal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(SatAttached === false){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think it's a wave display of some sort, but all it shows is a flat line.");
								}else{
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeeps();
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That satellite dish is picking up a signal !");
								}
							}else if(hit_iss_terminal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(SatAttached === false){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's a command line interface. It says 'no signal.'");
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The command line is displaying an unending string of prime numbers...");
								}
							}else if(hit_iss_disc.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								ISSDiscHandler();
							}
							/*
							private var hit_iss_signal:Shape;
							private var hit_iss_disc:Shape;
							private var hit_iss_terminal:Shape;
							*/
						}

					}
				}
			}
		}
		
		private function ISSDiscHandler():void{
			if(DiscAttached === true){
				if(SatAttached === true){
					discSoundIcon.alpha = 1;
					WrittenToDisc = true;
					issSuccessFail.texture = this.assets.getTexture('iss_success');
					issSuccessFail.alpha = 1;
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
					}
					SaveArray['Files'] = "Written";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);	
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
					issSuccessFail.texture = this.assets.getTexture('iss_fail');
					issSuccessFail.alpha = 1;
					
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Error();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to insert a disk before I can write files to it.");
			}
		}
		
		private function ISSHandler():void{
			WindowOpen = true;
			WindowThatsOpen = 'ISS';
			issSprite.alpha = 1;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
			}
			SaveArray['Window'] = "ISS";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);	
			
		}
		
		private function DiscHandler():void{
			WindowOpen = true;
			WindowThatsOpen = 'Disc';
			discSprite.alpha = 1;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
			}
			SaveArray['Window'] = "Disc";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);
			
		}
		
		private function PascalHandler():void{
			WindowOpen = true;
			WindowThatsOpen = 'Pascal';
			window_pascal.alpha = 1;
			CreateNotesHit();
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
			}
			SaveArray['PascalSeen'] = "SeenIt";
			SaveArray['Window'] = "Pascal";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);
			
		}
		
		private function GreenHandler():void{
			WindowOpen = true;
			WindowThatsOpen = 'Green';
			window_green.alpha = 1;
			CreateNotesHit();
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer;
			}
			SaveArray['Window'] = "Green";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabComputer',SaveArray);
			
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
			
			
			this.assets.removeTexture("labComputer_bg",true);
			this.assets.removeTexture("LabComputer_Sprite",true);
			this.assets.removeTextureAtlas("LabComputer_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labComputer_01");
			(stage.getChildAt(0) as Object).falseAsset("labComputer_02");
			(stage.getChildAt(0) as Object).falseAsset("labComputer_03");
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
