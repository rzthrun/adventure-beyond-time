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
	
	public class RavineFreighterDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var SaveArrayTwo:Array = new Array();
		
		private var bg:Image;
		private var hatch:Image;
		private var door:Image;
		
		private var hit_hatch:Shape;
		private var hit_FreighterLower:Shape;
		private var hit_FreighterInterior:Shape;
		private var hit_door:Shape;

		private var hit_secondLevel:Shape;
		private var hit_plants:Shape;
		private var hit_cliff:Shape;
		
		private var hatchOpen:Boolean = false;
		private var doorOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineFreighterDeck(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineFreighterDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterDeck/ravineFreighterDeck_bg.jpg'));
				game.TrackAssets('ravineFreighterDeck_01');
			}
			if(game.CheckAsset('ravineFreighterDeck_02') === false){
				
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterDeck/RavineFreighterDeck_Sprite.png'));
				game.TrackAssets('ravineFreighterDeck_02');
			}
			if(game.CheckAsset('ravineFreighterDeck_03') === false){
				
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterDeck/RavineFreighterDeck_Sprite.xml'));
				game.TrackAssets('ravineFreighterDeck_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineFreighterDeck","RavineFreighterDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineFreighterDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			door = new Image(this.assets.getTexture('door'));
			door.touchable = false;
			door.x = 271;
			door.y = 162;
			
			
			hatch = new Image(this.assets.getTexture('hatch'));
			hatch.touchable = false;
			hatch.x = 110;
			hatch.y = 254;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck['Door'] == 'open'){
					door.alpha = 0;
					doorOpen = true;
					CreateDoorHit(true);
					CreateFrighterInteriorHit();
				}
				else{
					door.alpha = 1;
					doorOpen = false;
					CreateDoorHit(false);
					
				}
				
			}else{
				
				
				door.alpha = 1;
				doorOpen = false;
				CreateDoorHit(false);
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){	
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Lid'] == 'open'){
					hatch.alpha = 0;
					hatchOpen = true;
					CreateHatchHit(true);
					CreateFrighterLowerHit();
				}
				else{
					hatch.alpha = 1;
					hatchOpen = false;
					CreateHatchHit(false);
					
				}
			}else{
				hatch.alpha = 1;
				hatchOpen = false;
				CreateHatchHit(false);
			}
			
			
			this.addChildAt(door,1);
			this.addChildAt(hatch,2);
			
			CreateSecondLevelHit();
			CreateCliffHit();
			CreatePlantsHit();

			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipGroansOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
		}
		
		private function CreateCliffHit():void{
			hit_cliff = new Shape();
			hit_cliff.touchable = false;
			hit_cliff.graphics.beginFill(0x00FF00);
			
			hit_cliff.graphics.lineTo(0,140);	
			hit_cliff.graphics.lineTo(195,100);	
			hit_cliff.graphics.lineTo(265,112);	
			hit_cliff.graphics.lineTo(328,141);	
			hit_cliff.graphics.lineTo(311,256);	
			hit_cliff.graphics.lineTo(143,237);	
			hit_cliff.graphics.lineTo(0,234);	
			
			hit_cliff.graphics.endFill(false);
			
			hit_cliff.alpha = 0.0;
			hit_cliff.graphics.precisionHitTest = true;	
			this.addChild(hit_cliff);
			
		}
		
		private function CreatePlantsHit():void{
			hit_plants = new Shape();
			hit_plants.touchable = false;
			hit_plants.graphics.beginFill(0x00FF00);
			
			hit_plants.graphics.lineTo(474,352);	
			hit_plants.graphics.lineTo(548,300);	
			hit_plants.graphics.lineTo(573,300);	
			hit_plants.graphics.lineTo(579,201);	
			hit_plants.graphics.lineTo(628,129);	
			hit_plants.graphics.lineTo(768,145);	
			hit_plants.graphics.lineTo(791,290);	
			hit_plants.graphics.lineTo(590,473);	
			hit_plants.graphics.lineTo(495,463);	
	
			hit_plants.graphics.endFill(false);
			
			hit_plants.alpha = 0.0;
			hit_plants.graphics.precisionHitTest = true;	
			this.addChild(hit_plants);
			
		}
		
		private function CreateSecondLevelHit():void{
			hit_secondLevel = new Shape();
			hit_secondLevel.touchable = false;
			hit_secondLevel.graphics.beginFill(0x00FF00);
			
			hit_secondLevel.graphics.lineTo(343,99);	
			hit_secondLevel.graphics.lineTo(355,0);	
			hit_secondLevel.graphics.lineTo(658,0);	
			hit_secondLevel.graphics.lineTo(606,138);	
			
			hit_secondLevel.graphics.endFill(false);
			
			hit_secondLevel.alpha = 0.0;
			hit_secondLevel.graphics.precisionHitTest = true;	
			this.addChild(hit_secondLevel);
			
		}
		
		private function CreateFrighterLowerHit():void{
			hit_FreighterLower = new Shape();
			
			hit_FreighterLower.graphics.beginFill(0x00FF00);
			hit_FreighterLower.graphics.lineTo(146,375);	
			hit_FreighterLower.graphics.lineTo(262,368);	
			hit_FreighterLower.graphics.lineTo(355,419);	
			hit_FreighterLower.graphics.lineTo(225,428);	

			hit_FreighterLower.graphics.endFill(false);
			hit_FreighterLower.touchable = false;
			hit_FreighterLower.alpha = 0.0;
			hit_FreighterLower.graphics.precisionHitTest = true;	
			this.addChild(hit_FreighterLower);
			
		}
		
		private function CreateFrighterInteriorHit():void{
			hit_FreighterInterior = new Shape();
			
			hit_FreighterInterior.graphics.beginFill(0x00FF00);
			hit_FreighterInterior.graphics.lineTo(361,161);	
			hit_FreighterInterior.graphics.lineTo(438,177);	
			hit_FreighterInterior.graphics.lineTo(408,356);	
			hit_FreighterInterior.graphics.lineTo(348,329);	
		
			
			hit_FreighterInterior.graphics.endFill(false);
			hit_FreighterInterior.touchable = false;
			hit_FreighterInterior.alpha = 0.0;
			hit_FreighterInterior.graphics.precisionHitTest = true;		
			this.addChild(hit_FreighterInterior);
			
		}
		
		private function CreateDoorHit(open:Boolean = false):void{
			hit_door = new Shape();
			this.addChild(hit_door);
			if(open === false){
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);
				hit_door.graphics.lineTo(356,151);	
				hit_door.graphics.lineTo(446,169);	
				hit_door.graphics.lineTo(418,361);	
				hit_door.graphics.lineTo(335,324);	
		
				hit_door.graphics.endFill(false);
				
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);		
				hit_door.graphics.lineTo(310,160);
				hit_door.graphics.lineTo(356,164);
				hit_door.graphics.lineTo(341,330);
				hit_door.graphics.lineTo(291,334);
				hit_door.graphics.lineTo(291,325);

				hit_door.graphics.endFill(false);
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;				
			}
			hit_door.touchable = false;
			
		}		
		
		private function CreateHatchHit(open:Boolean = false):void{
			hit_hatch = new Shape();
			this.addChild(hit_hatch);
			if(open === false){
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);
				hit_hatch.graphics.lineTo(138,353);	
				hit_hatch.graphics.lineTo(270,349);	
				hit_hatch.graphics.lineTo(363,400);	
				hit_hatch.graphics.lineTo(361,423);	
				hit_hatch.graphics.lineTo(226,437);	
				
				hit_hatch.graphics.endFill(false);
				
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);		
				hit_hatch.graphics.lineTo(100,257);
				hit_hatch.graphics.lineTo(111,243);
				hit_hatch.graphics.lineTo(217,259);
				hit_hatch.graphics.lineTo(260,351);
				hit_hatch.graphics.lineTo(135,352);

				hit_hatch.graphics.endFill(false);
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;				
			}
			hit_hatch.touchable = false;
			
		}		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((RavineFreighter as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterObj,true
						);
					}else if(hit_plants.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's like the earth is slowly swallowing the ship.");

					}else if(hit_secondLevel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The freighter has an upper level... presumably the command bridge.");

					}else if(hatchOpen === true){
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchTouch();
							
						}else if(hit_FreighterLower.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((RavineFreighterHatch as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterHatchObj,true
							);
						}
					}else{
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchTouch();

						}
					}
					
					if(doorOpen === true){
						if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							//HatchTouch();
							DoorTouch()
						}
						else if(hit_FreighterInterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							FadeOut((FreighterInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterInteriorObj,false
							);
							
						}else if(hit_cliff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CliffHandler(true);
						}
					}else{
						if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							//HatchTouch();
							DoorTouch()
						}else if(hit_cliff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CliffHandler(false);
						}
					}
					
					
				
				}
			}
		}
		private function CliffHandler(flag:Boolean = false):void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Rope)
				
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rope is not long enough. I couldn't reach bottom.");
			}else{
				if(flag === false){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The canyon continues beyond the ship... it's a long way down.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Climbing along the cliffs is too risky...");
				}
			}
			
		}
		
		private function DoorTouch():void{
			//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch Door");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck['Door'] != 'open'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
					trace(1);
					SaveArray['Door'] = 'open';
					
					door.alpha = 0;
					hit_door.graphics.clear();
					CreateDoorHit(true);
					CreateFrighterInteriorHit();
			
					doorOpen = true;
					//CreateJunkInteriorHit();
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
					trace(2);
					SaveArray['Door'] = 'close';
					
					door.alpha = 1;
					
					removeChild(hit_FreighterInterior);
					hit_door.graphics.clear();
					
					CreateDoorHit(false);
					doorOpen = false;
					
				}
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
				trace(3)
				trace(1);
				SaveArray['Door'] = 'open';
				
				door.alpha = 0;
				hit_door.graphics.clear();
				CreateDoorHit(true);
				CreateFrighterInteriorHit();
				doorOpen = true;
				
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterDeck',SaveArray);	
		}
		
		private function HatchTouch():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Hatch'] == 'Unlocked'){
					
					trace("touch Hatch");
				//	if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck != undefined){
						SaveArrayTwo = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Lid'] != 'open'){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();
							trace(1);
							SaveArrayTwo['Lid'] = 'open';
							
							hatch.alpha = 0;
							hit_hatch.graphics.clear();
							CreateHatchHit(true);
							CreateFrighterLowerHit();
							hatchOpen = true;
							//CreateJunkInteriorHit();
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();
							trace(2);
							SaveArrayTwo['Lid'] = 'close';
							
							hatch.alpha = 1;
							
							removeChild(hit_FreighterLower);
							hit_hatch.graphics.clear();
							
							CreateHatchHit(false);
							hatchOpen = false;
							
						}
						
				/*	}else{
						trace(3)
						trace(1);
						SaveArrayTwo['Lid'] = 'open';
						
						hatch.alpha = 0;
						hit_hatch.graphics.clear();
						CreateHatchHit(true);
						CreateFrighterLowerHit();
						hatchOpen = true;
		
					}
				*/
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArrayTwo);
				}else{
					FadeOut((RavineFreighterHatch as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterHatchObj,true
					);
				}
			}else{
				FadeOut((RavineFreighterHatch as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterHatchObj,true
				);
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
			
			
			this.assets.removeTexture("ravineFreighterDeck_bg",true);
			this.assets.removeTexture("RavineFreighterDeck_Sprite",true);
			this.assets.removeTextureAtlas("RavineFreighterDeck_Sprite",true);
			
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterDeck_03");
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
