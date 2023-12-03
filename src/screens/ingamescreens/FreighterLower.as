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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class FreighterLower extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;		
		private var ladder:Image;
		private var oil_cap:Image;
		private var wall_open:Image;
				
		private var hit_RavineFreighterDeck:Shape;
		private var hit_FreighterWall:Shape;
		private var hit_Oil:Shape;
		private var hit_Ladder:Shape;
		private var hit_tanks:Shape;
		
		private var hit_engine:Shape;
		private var hit_thing:Shape;
		private var hit_roof:Shape;
		
		private var LadderAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function FreighterLower(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterLower_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLower/freighterLower_bg.jpg'));
				game.TrackAssets('freighterLower_01');
			}
			if(game.CheckAsset('freighterLower_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLower/FreighterLower_Sprite.png'));
				game.TrackAssets('freighterLower_02');
			}
			if(game.CheckAsset('freighterLower_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLower/FreighterLower_Sprite.xml'));
				game.TrackAssets('freighterLower_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterLower","FreighterLowerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterLower_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			ladder = new Image(this.assets.getTexture('ladder'));
		//	ladder.smoothing = TextureSmoothing.NONE;
			ladder.touchable = false;
			ladder.x = 482;
			ladder.y = 216;
	
			oil_cap = new Image(this.assets.getTexture('oil_cap'));
		//	oil_cap.smoothing = TextureSmoothing.NONE;
			oil_cap.touchable = false;
			oil_cap.x = 647;
			oil_cap.y = 211;
				
			wall_open = new Image(this.assets.getTexture('wall_open'));
		//	wall_open.smoothing = TextureSmoothing.NONE;
			wall_open.touchable = false;
			wall_open.x = 33;
			wall_open.y = 0;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower['Ladder'] == 'Attached'){
					LadderAttached = true;
					ladder.alpha = 1;
				}else{
					ladder.alpha = 0;
				}
			}else{
				ladder.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil['Cap'] = 'off'){
					oil_cap.alpha = 1;
				}else{
					oil_cap.alpha = 0;
				}
			}else{
				oil_cap.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall['Door'] == 'open'){
					wall_open.alpha = 1;
				}else{
					wall_open.alpha = 0;
				}
			}else{
				wall_open.alpha = 0;
			}
			
			
			
			
			this.addChildAt(ladder,1);
			this.addChildAt(oil_cap,2);
			this.addChildAt(wall_open,3);
		
			CreateTanksHit();
			CreateEngineHit();
			CreateThingHit();
			CreateRoofHit();
			CreateRavineFreighterDeck();
			CreateFreighterWall();
			CreateOilHit();
			CreateLadderHit();
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,1);
			
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLower',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,1);
						},0.4);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLower',SaveArray);
					Starling.juggler.delayCall(function():void{
						
						(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,1);
					},0.4);
				}
			}
			
			
			
		}
		//private var hit_tanks:Shape;
		
		private function CreateTanksHit():void{
			hit_tanks = new Shape();
			hit_tanks.touchable = false;
			hit_tanks.graphics.beginFill(0xff0000);
			
			hit_tanks.graphics.lineTo(176,88);	
			hit_tanks.graphics.lineTo(292,139);	
			hit_tanks.graphics.lineTo(270,274);	
			hit_tanks.graphics.lineTo(150,231);	
			
			hit_tanks.graphics.endFill(false);
			hit_tanks.alpha = 0.0;
			
			hit_tanks.graphics.precisionHitTest = true;	
			this.addChild(hit_tanks);
		}
		
		
		private function CreateRoofHit():void{
			hit_roof = new Shape();
			hit_roof.touchable = false;
			hit_roof.graphics.beginFill(0xff0000);
			
			hit_roof.graphics.lineTo(191,0);	
			hit_roof.graphics.lineTo(794,0);	
			hit_roof.graphics.lineTo(795,146);	
			hit_roof.graphics.lineTo(485,186);	
			hit_roof.graphics.lineTo(296,138);	
			
			hit_roof.graphics.endFill(false);
			hit_roof.alpha = 0.0;
			
			hit_roof.graphics.precisionHitTest = true;	
			this.addChild(hit_roof);
		}
		
		private function CreateThingHit():void{
			hit_thing = new Shape();
			hit_thing.touchable = false;
			hit_thing.graphics.beginFill(0xff0000);
			
			hit_thing.graphics.lineTo(0,254);	
			hit_thing.graphics.lineTo(179,294);	
			hit_thing.graphics.lineTo(200,315);	
			hit_thing.graphics.lineTo(166,483);	
			hit_thing.graphics.lineTo(0,512);	
		
			hit_thing.graphics.endFill(false);
			hit_thing.alpha = 0.0;
			
			hit_thing.graphics.precisionHitTest = true;	
			this.addChild(hit_thing);
		}
		
		private function CreateEngineHit():void{
			hit_engine = new Shape();
			hit_engine.touchable = false;
			hit_engine.graphics.beginFill(0xff0000);
			
			hit_engine.graphics.lineTo(268,455);	
			hit_engine.graphics.lineTo(449,345);	
			hit_engine.graphics.lineTo(631,402);	
			hit_engine.graphics.lineTo(605,506);	
			hit_engine.graphics.lineTo(330,508);	
			hit_engine.graphics.lineTo(330,508);	
			
			
			hit_engine.graphics.endFill(false);
			hit_engine.alpha = 0.0;
			
			hit_engine.graphics.precisionHitTest = true;	
			this.addChild(hit_engine);
		}
		
		private function CreateOilHit():void{
			hit_Oil = new Shape();
			hit_Oil.touchable = false;
			hit_Oil.graphics.beginFill(0xff0000);
			
			hit_Oil.graphics.lineTo(523,165);	
			hit_Oil.graphics.lineTo(576,136);	
			hit_Oil.graphics.lineTo(705,142);	
			hit_Oil.graphics.lineTo(800,158);	
			hit_Oil.graphics.lineTo(800,293);	
			hit_Oil.graphics.lineTo(505,222);	
			
			hit_Oil.graphics.endFill(false);
			hit_Oil.alpha = 0.0;
			
			hit_Oil.graphics.precisionHitTest = true;	
			this.addChild(hit_Oil);
		}
		
		private function CreateLadderHit():void{
			hit_Ladder = new Shape();
			hit_Ladder.touchable = false;
			hit_Ladder.graphics.beginFill(0xff0000);
			
			hit_Ladder.graphics.lineTo(555,236);	
			hit_Ladder.graphics.lineTo(637,256);	
			hit_Ladder.graphics.lineTo(572,423);	
			hit_Ladder.graphics.lineTo(522,409);	
			hit_Ladder.graphics.lineTo(521,381);	
			hit_Ladder.graphics.lineTo(498,358);	

			hit_Ladder.graphics.endFill(false);
			hit_Ladder.alpha = 0.0;
			
			hit_Ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_Ladder);
		}
		
		private function CreateRavineFreighterDeck():void{
			hit_RavineFreighterDeck = new Shape();
			hit_RavineFreighterDeck.touchable = false;
			hit_RavineFreighterDeck.graphics.beginFill(0xff0000);
			
			hit_RavineFreighterDeck.graphics.lineTo(38,0);	
			hit_RavineFreighterDeck.graphics.lineTo(190,0);	
		//	hit_RavineFreighterDeck.graphics.lineTo(159,64);	
			hit_RavineFreighterDeck.graphics.lineTo(171,69);	
			hit_RavineFreighterDeck.graphics.lineTo(185,192);	
			hit_RavineFreighterDeck.graphics.lineTo(145,234);	
			hit_RavineFreighterDeck.graphics.lineTo(85,215);	
			hit_RavineFreighterDeck.graphics.lineTo(73,127);	
			hit_RavineFreighterDeck.graphics.lineTo(20,110);	
			hit_RavineFreighterDeck.graphics.endFill(false);
			hit_RavineFreighterDeck.alpha = 0.0
			
			hit_RavineFreighterDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineFreighterDeck);
		}
		
		private function CreateFreighterWall():void{
			hit_FreighterWall = new Shape();
			addChild(hit_FreighterWall);
			hit_FreighterWall.graphics.beginFill(0x00FF00);
			hit_FreighterWall.graphics.lineTo(337,183);	
			hit_FreighterWall.graphics.lineTo(462,229);	
			hit_FreighterWall.graphics.lineTo(437,316);	
			hit_FreighterWall.graphics.lineTo(386,386);	
			hit_FreighterWall.graphics.lineTo(280,342);	
			hit_FreighterWall.graphics.lineTo(308,273);	
			hit_FreighterWall.graphics.endFill(false);
			hit_FreighterWall.graphics.endFill(false);
			hit_FreighterWall.touchable = false;
			hit_FreighterWall.alpha = 0.0;
			hit_FreighterWall.graphics.precisionHitTest = true;				
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(hit_RavineFreighterDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalSteps();
						FadeOut((RavineFreighterHatch as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterHatchObj,false
						);
					}else if(hit_FreighterWall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall != undefined){
							trace("1");
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall['Door'] == 'open'){
								FadeOut((RavineCanyonRear as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonRearObj,true
								);
							}else{
								FadeOut((FreighterWall as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterWallObj,true
								);
							}
						}else{
							FadeOut((FreighterWall as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterWallObj,true
							);
						}
						
						
					}else if(hit_Ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LadderHandler();	
					}else if(hit_Oil.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(LadderAttached === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((FreighterOil as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterOilObj,true
							);	
						}else{
							if((stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.armedItem
								== 
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.inventoryBarObj
								.item_Ladder)
							{	
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
									.InventoryObj.removeItemFromInventory(
										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.item_Ladder,
										"item_Ladder"
									);
								
								LadderAttached = true;
								ladder.alpha = 1;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower;			
								}
								SaveArray['Ladder'] = "Attached";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLower',SaveArray);
								
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't climb up there. It's too high.");
							}
						}
						/*
						private var hit_engine:Shape;
						private var hit_thing:Shape;
						private var hit_roof:Shape;
						*/
					}else if(hit_engine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's power generator... now, forever quiet.");
					}else if(hit_thing.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some sort of pump or filter.");
					}else if(hit_roof.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Small bits of rust and mold flake off the ceiling.");
					}else if(hit_tanks.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Tanks of some type... empty.");
					}
				}
			}
		}
		
		private function LadderHandler():void{
			if(LadderAttached === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				LadderAttached = false;
				ladder.alpha = 0;
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower;
				SaveArray['Ladder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLower',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ladder,
					'item_Ladder',
					'inven_ladder_sm'
				);
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Ladder)
				{	
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Ladder,
							"item_Ladder"
						);
					
					
					LadderAttached = true;
					ladder.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLower;			
					}
					SaveArray['Ladder'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLower',SaveArray);
					
				}else if(hit_Oil.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't climb up there. It's too high.");
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
			
			
			this.assets.removeTexture("freighterLower_bg",true);
			this.assets.removeTexture("FreighterLower_Sprite",true);
			this.assets.removeTextureAtlas("FreighterLower_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterLower_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterLower_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterLower_03");
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

