package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class LabMachine extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var SaveArrayTwo:Array = new Array();
		
		private var bg:Image;
		
		private var printButton:Image;
		private var diskButton:Image;
		
		private var term_intialize:Image;
		private var term_00:Image;
		private var term_01:Image;
		private var term_02:Image;
		private var term_03:Image;
		private var term_04:Image;
		private var term_print:Image;
		
		private var screen:Image;
		private var screen_mc:MovieClip;
		
		private var hit_disk:Shape;
		private var hit_print:Shape;
		
		private var TermState:int = 0;
		
		private var hit_image:Shape;
		
		private var DiscAttached:Boolean = false;
		private var DiscHadAlgorithm:Boolean = false;
		private var HoseAttached:Boolean = false;
		private var MircoscopeData:Boolean = false;
		private var PrinterGoo:Boolean = false;
		private var PrinterStone:Boolean = false;
		
		private var Solved:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		public var delayedCall:DelayedCall;
		public var Animating:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function LabMachine(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labMachine_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMachine/labMachine_bg.jpg'));
				game.TrackAssets('labMachine_01');
			}
			if(game.CheckAsset('labMachine_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMachine/LabMachine_Sprite.png'));
				game.TrackAssets('labMachine_02');
			}
			if(game.CheckAsset('labMachine_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabMachine/LabMachine_Sprite.xml'));
				game.TrackAssets('labMachine_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabMachine","LabMachineObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			bg = new Image(this.assets.getTexture('labMachine_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			printButton = new Image(this.assets.getTexture('print_off'));
			printButton.touchable = false;
			printButton.x = 17;
			printButton.y = 45;
		
			diskButton = new Image(this.assets.getTexture('disk_but'));
			diskButton.touchable = false;
			diskButton.x = 200;
			diskButton.y = 11;
		
			
			term_intialize = new Image(this.assets.getTexture('term_initialize'));
			term_intialize.touchable = false;
			term_intialize.x = 22;
			term_intialize.y = 142;
			
			
			term_00 = new Image(this.assets.getTexture('term_line_00_success'));
			term_00.touchable = false;
			term_00.x = 22;
			term_00.y = 174;
			
			
			term_01 = new Image(this.assets.getTexture('term_line_01_success'));
			term_01.touchable = false;
			term_01.x = 22;
			term_01.y = 209;
			
			term_02 = new Image(this.assets.getTexture('term_line_02_success'));
			term_02.touchable = false;
			term_02.x = 22;
			term_02.y = 244;
			
			
			term_03 = new Image(this.assets.getTexture('term_line_03_success'));
			term_03.touchable = false;
			term_03.x = 22;
			term_03.y = 300;
			
			term_04 = new Image(this.assets.getTexture('term_line_04_success'));
			term_04.touchable = false;
			term_04.x = 22;
			term_04.y = 354;
		
			term_print = new Image(this.assets.getTexture('term_printing_progress'));
			term_print.touchable = false;
			term_print.x = 22;
			term_print.y = 399;
			
			screen = new Image(this.assets.getTexture('screen_default'));
			screen.touchable = false;
			screen.width = screen.width*2;
			screen.height = screen.height*2;
			screen.x = 317;
			screen.y = 125;
			
			
			screen_mc = new MovieClip(this.assets.getTextures("screen_anima_"),4);
			screen_mc.width = screen_mc.width*2;
			screen_mc.height = screen_mc.height*2;
			screen_mc.x = 317;
			screen_mc.y = 125;
			
			screen_mc.touchable = false;
			screen_mc.loop = true; 
			//	eyes.play();
			
			
			screen_mc.stop();
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Attached"){
					DiscAttached = true;
					diskButton.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
							DiscHadAlgorithm = true;
						}
					}
					
				}else{
					diskButton.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment["Hose"] == "Attached"){
					HoseAttached = true;
				}
			}else{
				diskButton.alpha = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMicroscope['Analyzed'] == 'Yes'){
					MircoscopeData = true;
				}
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					PrinterStone = true;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					PrinterGoo = true;
				}
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine['Solved'] == 'Yes'){
					screen.alpha = 0;
					TermState = 6;
					Solved = true;
					term_print.texture = this.assets.getTexture('term_printing_complete')
					screen_mc.alpha = 1;
					screen_mc.play();
					Starling.juggler.add(screen_mc);	
					
					term_intialize.alpha = 1;
					term_00.alpha = 1;
					term_01.alpha = 1;
					term_02.alpha = 1;
					term_03.alpha = 1;
					term_04.alpha = 1;
					term_print.alpha = 1;
				}else{
					screen_mc.alpha = 0;
					screen.alpha = 1;
					
					term_intialize.alpha = 0;
					term_00.alpha = 0;
					term_01.alpha = 0;
					term_02.alpha = 0;
					term_03.alpha = 0;
					term_04.alpha = 0;
					term_print.alpha = 0;
				}
			}else{
				screen_mc.alpha = 0;
				screen.alpha = 1;
				
				term_intialize.alpha = 0;
				term_00.alpha = 0;
				term_01.alpha = 0;
				term_02.alpha = 0;
				term_03.alpha = 0;
				term_04.alpha = 0;
				term_print.alpha = 0;
			}
			
			printButton.alpha = 1;
			
			
		//	screen_mc.alpha = 0;
			
			this.addChildAt(printButton,1);
			this.addChildAt(diskButton,2);			
			this.addChildAt(term_intialize,3);		
			this.addChildAt(term_00,4);			
			this.addChildAt(term_01,5);			
			this.addChildAt(term_02,6);			
			this.addChildAt(term_03,7);			
			this.addChildAt(term_04,8);		
			this.addChildAt(term_print,9);
			this.addChildAt(screen,10);
			this.addChildAt(screen_mc,11);
			
			
			
			/*
			private var term_intialize:Image;
			private var term_00:Image;
			private var term_01:Image;
			private var term_02:Image;
			private var term_03:Image;
			private var term_04:Image;
			private var term_print:Image;
			*/
			CreateHitImage();
			CreateHitDisk();
			CreateHitPrint();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crickets_01",((stage.getChildAt(0) as Object).MusicObj.globalVol/2),1.0);
		}
		//hit_image
		private function CreateHitImage():void{
			hit_image = new Shape();
			hit_image.touchable = false;
			hit_image.graphics.beginFill(0xff0000);
			
			hit_image.graphics.lineTo(283,128);							
			hit_image.graphics.lineTo(748,142);							
			hit_image.graphics.lineTo(755,382);							
			hit_image.graphics.lineTo(288,391);							
			hit_image.graphics.lineTo(288,391);							
			
			hit_image.graphics.endFill(false);
			
			hit_image.alpha = 0.0;
			
			hit_image.graphics.precisionHitTest = true;	
			this.addChild(hit_image);
		}
		private function CreateHitDisk():void{
			hit_disk = new Shape();
			hit_disk.touchable = false;
			hit_disk.graphics.beginFill(0xff0000);
			
			hit_disk.graphics.lineTo(199,7);							
			hit_disk.graphics.lineTo(305,7);							
			hit_disk.graphics.lineTo(305,117);							
			hit_disk.graphics.lineTo(199,117);							

			hit_disk.graphics.endFill(false);
			
			hit_disk.alpha = 0.0;
			
			hit_disk.graphics.precisionHitTest = true;	
			this.addChild(hit_disk);
		}
		
		private function CreateHitPrint():void{
			hit_print = new Shape();
			hit_print.touchable = false;
			hit_print.graphics.beginFill(0xff0000);
			
			hit_print.graphics.lineTo(14,41);							
			hit_print.graphics.lineTo(176,41);							
			hit_print.graphics.lineTo(176,114);							
			hit_print.graphics.lineTo(14,114);							

			hit_print.graphics.endFill(false);
			
			hit_print.alpha = 0.0;
			
			hit_print.graphics.precisionHitTest = true;	
			this.addChild(hit_print);
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
								(stage.getChildAt(0) as Object).screenGamePlayHandler.LabEquipmentObj,true
							);
						}else if(hit_disk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							DiskHandler();
						}else if(hit_print.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PrintHandler();
						}else if(hit_image.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(TermState == 0){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a picture of the printer on the screen.");

							}else if(TermState == 1){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("No data received from the microscope...");

							}else if(TermState == 2){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's telling me I need to load a disc with the proper algorithm.");
							}else if(TermState == 3){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A picture of the machine again? Looks like I have to connect the two devices.");
							}else if(TermState == 4){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The printer needs a shape to copy...");

							}else if(TermState == 5){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's default printing material cannot build what the data describes?");
							}else if(TermState == 6){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The console seems to be stuck in an endless loop...");
							}
						}	
						//TermState
					}
				}
			}
		}
		private function PrintHandler():void{
			if(Solved === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				screen.texture = this.assets.getTexture('screen_default');
				term_00.alpha = 0;
				term_01.alpha = 0;
				term_02.alpha = 0;
				term_03.alpha = 0;
				term_04.alpha = 0;
				Animating = true;
				printButton.texture = this.assets.getTexture('print_on');
				term_intialize.alpha = 1;
				delayedCall = new DelayedCall(function():void{
					if(MircoscopeData === true){
						ChangeTerm00Tex(true);
						PrintLineOne();
					}else{
						ChangeTerm00Tex(false);
						
						delayedCall = null;
						Animating = false;
					}	
				},1.5);
				Starling.juggler.add(delayedCall);	
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm done: I shouldn't try printing again right now.");
			}
		}
		
		private function ChangeTerm00Tex(SF:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if(SF === true){
				term_00.alpha = 1;
				term_00.texture = this.assets.getTexture('term_line_00_success');
				screen.texture = this.assets.getTexture('screen_00_success');
			}else{
				TermState = 1;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				term_00.alpha = 1;
				printButton.texture = this.assets.getTexture('print_off');
				term_00.texture = this.assets.getTexture('term_line_00_fail');
				screen.texture = this.assets.getTexture('screen_00_fail');
			}
				
		}
		
		private function PrintLineOne():void{
			trace("Printing Line One");
			
			delayedCall = new DelayedCall(function():void{
				if(DiscAttached === true){
					if(DiscHadAlgorithm === true){
						ChangeTerm01Tex(true);
						PrintLineTwo();
					}else{
						ChangeTerm01Tex(false);
						Animating = false;
					}
				}else{
					ChangeTerm01Tex(false);
					Animating = false;
				}
		
			},1.5);
			Starling.juggler.add(delayedCall);	
		}
		private function ChangeTerm01Tex(SF:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if(SF === true){
				
				term_01.texture = this.assets.getTexture('term_line_01_success');
				screen.texture = this.assets.getTexture('screen_01_success');
				term_01.alpha = 1;
			}else{
				TermState = 2;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				printButton.texture = this.assets.getTexture('print_off');
				term_01.texture = this.assets.getTexture('term_line_01_fail');
				screen.texture = this.assets.getTexture('screen_01_fail');
				term_01.alpha = 1;
			}
		}
		
		private function PrintLineTwo():void{
			delayedCall = new DelayedCall(function():void{
				
				if(HoseAttached === true){
					ChangeTerm02Tex(true);
					PrintLineThree();
				}else{
					ChangeTerm02Tex(false);
					Animating = false;
				}
				
				
			},1.5);
			Starling.juggler.add(delayedCall);	
		}	
		
		
		private function ChangeTerm02Tex(SF:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if(SF === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
				term_02.texture = this.assets.getTexture('term_line_02_success');
				screen.texture = this.assets.getTexture('screen_02_success');
				term_02.alpha = 1;
			}else{
				TermState = 3;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				printButton.texture = this.assets.getTexture('print_off');
				term_02.texture = this.assets.getTexture('term_line_02_fail');
				screen.texture = this.assets.getTexture('screen_02_fail');
				term_02.alpha = 1;
			}
		}
		
		
		private function PrintLineThree():void{
			
			delayedCall = new DelayedCall(function():void{			
				if(PrinterStone === true){
					ChangeTerm03Tex(true);
					PrintLineFour();
				}else{
					ChangeTerm03Tex(false);
					Animating = false;
				}
								
			},1.5);
			Starling.juggler.add(delayedCall);	
		}
		
		private function ChangeTerm03Tex(SF:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if(SF === true){
				
				term_03.texture = this.assets.getTexture('term_line_03_success');
				term_03.alpha = 1;
				screen.texture = this.assets.getTexture('screen_03_success');
			}else{			
				TermState = 4;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				printButton.texture = this.assets.getTexture('print_off');
				term_03.texture = this.assets.getTexture('term_line_03_fail');
				screen.texture = this.assets.getTexture('screen_03_fail');
				term_03.alpha = 1;
			}
		}
		
		
		private function PrintLineFour():void{
			delayedCall = new DelayedCall(function():void{			
				if(PrinterGoo === true){
					ChangeTerm04Tex(true);
					PrintComplete();
				}else{
					ChangeTerm04Tex(false);
					Animating = false;
				}
				
			},1.5);
			Starling.juggler.add(delayedCall);	
		}
		
		private function ChangeTerm04Tex(SF:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if(SF === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
				
				term_04.texture = this.assets.getTexture('term_line_04_success');
				term_04.alpha = 1;
				screen.texture = this.assets.getTexture('screen_04_success');
			}else{		
				TermState = 5;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				printButton.texture = this.assets.getTexture('print_off');
				term_04.texture = this.assets.getTexture('term_line_04_fail');
				screen.texture = this.assets.getTexture('screen_04_fail');
				term_04.alpha = 1;
			}
		}
		
		private function PrintComplete():void{
			TermState = 6;
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabMachine;
			}
			SaveArray['Solved'] = "Yes";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabMachine',SaveArray);	
			
			printButton.texture = this.assets.getTexture('print_off');
			screen.alpha = 0;
			term_print.alpha = 1;
			screen_mc.alpha = 1;
			screen_mc.play();
			Starling.juggler.add(screen_mc);	
			
			delayedCall = new DelayedCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeeps();
				
				FadeOut((LabEquipment as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.LabEquipmentObj,true
				);
			},3);
			Starling.juggler.add(delayedCall);	
			
		}
		
		private function DiskHandler():void{
			if(Solved === false){
				if(DiscAttached === true){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
					DiscAttached = false;
					diskButton.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
						SaveArrayTwo = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment;
					}
					SaveArrayTwo['Disk'] = "Out";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabEquipment',SaveArrayTwo);	
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Better to leave the disk inside the machine for now.");
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
			
			
			this.assets.removeTexture("labMachine_bg",true);
			this.assets.removeTexture("LabMachine_Sprite",true);
			this.assets.removeTextureAtlas("LabMachine_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labMachine_01");
			(stage.getChildAt(0) as Object).falseAsset("labMachine_02");
			(stage.getChildAt(0) as Object).falseAsset("labMachine_03");
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
