package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
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
	
	
	public class RavineFreighterHatch extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		
		private var bg:Image;
		
		private var hatch:Image;
		private var hatch_rusty:Image;
		private var hatch_clean_rusty:Image;
		private var dust:Image;
		
		private var hit_hatch:Shape;
		private var hit_lowerlevel:Shape;
		
		
		private var HatchOpen:Boolean = false;
		private var HatchUnlocked:Boolean = false;
		private var DustApplied:Boolean = false;
		private var HalfCleaned:Boolean = false;
		private var Animating:Boolean = false;
		
		private var HalfCleanTween:Tween;
		private var RustyCleanTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		
		public function RavineFreighterHatch(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineFreighterHatch_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterHatch/ravineFreighterHatch_bg.jpg'));
				game.TrackAssets('ravineFreighterHatch_01');
			}
			if(game.CheckAsset('ravineFreighterHatch_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterHatch/RavineFreighterHatch_Sprite.atf'));
				game.TrackAssets('ravineFreighterHatch_02');
			}
			if(game.CheckAsset('ravineFreighterHatch_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterHatch/RavineFreighterHatch_Sprite.xml'));
				game.TrackAssets('ravineFreighterHatch_03');
			}
			if(game.CheckAsset('ravineFreighterHatch_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterHatch/RavineFreighterHatch_Sprite_02.png'));
				game.TrackAssets('ravineFreighterHatch_04');
			}
			if(game.CheckAsset('ravineFreighterHatch_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighterHatch/RavineFreighterHatch_Sprite_02.xml'));
				game.TrackAssets('ravineFreighterHatch_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineFreighterHatch","RavineFreighterHatchObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineFreighterHatch_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			hatch = new Image(this.assets.getTexture('lid_clean'));
			hatch.smoothing = TextureSmoothing.NONE;

			hatch.touchable = false;
			hatch.x = 163;
			hatch.y = 1;
			
			hatch_clean_rusty = new Image(this.assets.getTexture('lid_clean_rust'));
			hatch_clean_rusty.smoothing = TextureSmoothing.NONE;

			hatch_clean_rusty.touchable = false;
			hatch_clean_rusty.x = 163;
			hatch_clean_rusty.y = 1;
			
			hatch_rusty = new Image(this.assets.getTexture('lid_rust'));
			hatch_rusty.smoothing = TextureSmoothing.NONE;

			hatch_rusty.touchable = false;
			hatch_rusty.x = 163;
			hatch_rusty.y = 1;
			
			dust = new Image(this.assets.getTexture('dust'));
			dust.smoothing = TextureSmoothing.NONE;

			dust.touchable = false;
			dust.x = 173;
			dust.y = 72;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
				trace(1);
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Hatch'] == 'Unlocked'){
					trace(2);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Lid'] == 'open'){
						trace(3);
						hatch.alpha = 0;
						hatch_clean_rusty.alpha = 0;
						hatch_rusty.alpha = 0;
						dust.alpha = 0;
						HatchOpen = true;	
						HatchUnlocked = true;
						CreateHitLowerLevel();
					}else{
						trace(4);
						hatch.alpha = 1;
						hatch_clean_rusty.alpha = 0;
						hatch_rusty.alpha = 0;
						dust.alpha = 0;
						HatchUnlocked = true;
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Hatch'] == 'Half'){
					trace(5);
					hatch.alpha = 1;
					hatch_clean_rusty.alpha = 1;
					hatch_rusty.alpha = 0;
					HalfCleaned = true;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Dust'] == 'Applied'){
						trace(6);
						dust.alpha = 1;
						DustApplied = true;
					}else{
						trace(7);
						dust.alpha = 0;
					}		
					
				}else{
					trace(8);
					hatch.alpha = 1;
					hatch_clean_rusty.alpha = 1;
					hatch_rusty.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Dust'] == 'Applied'){
						trace(9);
						dust.alpha = 1;
						DustApplied = true;
					}else{
						trace(10);
						dust.alpha = 0;
					}		
				}				
				
			}else{
				trace(11);
				hatch.alpha = 1;
				hatch_clean_rusty.alpha = 1;
				hatch_rusty.alpha = 1;
				dust.alpha = 0;
			}

			this.addChildAt(hatch,1);
			this.addChildAt(hatch_clean_rusty,2);
			this.addChildAt(hatch_rusty,3);
			this.addChildAt(dust,4);
			
			CreateHatchHit(HatchOpen);
			
		
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipGroansOne",0,0.5,'stop');
		}
		//hit_lowerlevel
		
		private function CreateHitLowerLevel():void{
			hit_lowerlevel = new Shape();
			hit_lowerlevel.touchable = false;
			hit_lowerlevel.graphics.beginFill(0xff0000);
			
			hit_lowerlevel.graphics.lineTo(199,120);	
			hit_lowerlevel.graphics.lineTo(516,101);	
			hit_lowerlevel.graphics.lineTo(660,352);	
			hit_lowerlevel.graphics.lineTo(240,429);	

			hit_lowerlevel.graphics.endFill(false);
			hit_lowerlevel.alpha = 0.0;
			
			hit_lowerlevel.graphics.precisionHitTest = true;	
			this.addChild(hit_lowerlevel);
		}
		private function CreateHatchHit(open:Boolean = false):void{
			hit_hatch = new Shape();
			this.addChild(hit_hatch);
			if(open === false){
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);
				hit_hatch.graphics.lineTo(176,95);	
				hit_hatch.graphics.lineTo(527,72);	
				hit_hatch.graphics.lineTo(695,364);	
				hit_hatch.graphics.lineTo(679,383);	
				hit_hatch.graphics.lineTo(250,474);	
				hit_hatch.graphics.lineTo(211,454);	
				
				hit_hatch.graphics.endFill(false);
				
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;	
			}else{
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);		
				hit_hatch.graphics.lineTo(175,0);
				hit_hatch.graphics.lineTo(515,0);
				hit_hatch.graphics.lineTo(523,52);
				hit_hatch.graphics.lineTo(490,85);
				hit_hatch.graphics.lineTo(238,103);
				hit_hatch.graphics.lineTo(188,67);

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
						FadeOut((RavineFreighterDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterDeckObj,true
						);
					}if(HatchOpen === false){
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchHandler();
						}
					}else{
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchHandler();
						}else if(hit_lowerlevel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalSteps();

							FadeOut((FreighterLower as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLowerObj,false
							);
						}
					}
				}
			}
		}
		//CreateHitLowerLevel
		private function HatchHandler():void{
			trace("BARK 1");
			if(HatchOpen === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();
				HatchOpen = false;
				hatch.alpha = 1;
				hit_lowerlevel.graphics.clear();
				removeChild(hit_lowerlevel);
				hit_hatch.graphics.clear();
				CreateHatchHit(false);

				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
				}
				SaveArray['Lid'] = 'closed';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
				
			}else{
				if(HatchUnlocked === true){
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();
					HatchOpen = true;
					hatch.alpha = 0;
					hit_hatch.graphics.clear();
					CreateHatchHit(true);
					CreateHitLowerLevel();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
					}
					SaveArray['Lid'] = 'open';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
					
				}else{
					trace("BARK 4");
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_CausticJug)
						
					{
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CausticJug,
								"item_CausticJug"
							);
						
						trace("BARK 5");
						if(HalfCleaned === true){
							Animating = true;
							HatchUnlocked = true;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
							}
							SaveArray['Hatch'] = 'Unlocked';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
							
							HalfToFullCleanAnima();
						}else{
							Animating = true;
							HatchUnlocked = true;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
							}
							SaveArray['Hatch'] = 'Unlocked';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
							
							RustyToFullCleanAnima();
						}
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Jug)
					{
						
						if(DustApplied === true){
							
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
								.InventoryObj.removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Jug,
									"item_Jug"
								);
							
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
							if(HalfCleaned === true){
								Animating = true;
								HatchUnlocked = true;
								dust.alpha = 0;
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
								}
								SaveArray['Hatch'] = 'Unlocked';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
								
								HalfToFullCleanAnima();
							}else{
								dust.alpha = 0;
								Animating = true;
								HatchUnlocked = true;
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
								}
								SaveArray['Hatch'] = 'Unlocked';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
								
								RustyToFullCleanAnima();
							}
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
							if(HalfCleaned === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The vinegar can't remove anymore rust by itself.");
							}else{
								Animating = true;
								HalfCleaned = true;
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
								}
								SaveArray['Hatch'] = 'Half';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
								
								RustyToHalfCleanAnima();
							}
						}
						
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_K2SO)
						
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrainOne();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_K2SO,
								"item_K2SO"
							);
						
						DustApplied = true;
						dust.alpha = 1;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch;
						}
						SaveArray['Dust'] = 'Applied';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighterHatch',SaveArray);	
					}else{
						if(HalfCleaned === true){
						
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoorTwo();
							
							if((stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.armedItem
								!= false)
							{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help. I need an acid to remove the rust.");

							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I still can't open the hatch. I need to combine the vinegar with something...");

							}
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoorTwo();
							if(DustApplied === true){
								if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_GourdWater)
									
								{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Adding water would just wash the powder away.");

								}else if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									!= false)
								{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help. I need a strong acid to remove the rust.");
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The powder has weakened the rust, but only slightly. Combining it with something could create a stronger solvent.");
								}
							}else{
								if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_GourdWater)
									
								{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Adding water won't help remove the rust.");

								
								}else if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									!= false)
								{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help. I need to dissolve the rust.");
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hatch has rusted shut!");
								}
							}
							
						
							
							
						}
					}

				}
			}
		}
		/*
		private var HalfCleanTween:Tween;
		private var RustyCleanTween:Tween;
		private var hatch:Image;
		private var hatch_rusty:Image;
		private var hatch_clean_rusty:Image;
		*/
		private function RustyToHalfCleanAnima():void{
			
			hatch_clean_rusty.alpha = 1;
			RustyCleanTween = new Tween(hatch_rusty, 2, Transitions.LINEAR);
			RustyCleanTween.fadeTo(0);
			RustyCleanTween.onComplete = function():void{
				Animating = false
				hatch_rusty.alpha = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The vinegar has cleaned the hatch, but only slightly. It isn't strong enough to remove enough of the rust.");
			};
			Starling.juggler.add(RustyCleanTween);
		}
		private function RustyToFullCleanAnima():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Sizzle();
			hatch_clean_rusty.alpha = 0;
			hatch.alpha = 1;
			RustyCleanTween = new Tween(hatch_rusty, 3, Transitions.LINEAR);
			RustyCleanTween.fadeTo(0);
			RustyCleanTween.onComplete = function():void{
				Animating = false
				hatch_rusty.alpha = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hatch has been cleaned! Almost all of the rust has been removed.");
			};
			Starling.juggler.add(RustyCleanTween);
		}
		
		private function HalfToFullCleanAnima():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalSteps();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Sizzle();
			hatch_clean_rusty.alpha = 1;
			hatch.alpha = 1;
			HalfCleanTween = new Tween(hatch_clean_rusty, 3, Transitions.LINEAR);
			HalfCleanTween.fadeTo(0);
			HalfCleanTween.onComplete = function():void{
				Animating = false
				hatch_clean_rusty.alpha = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hatch has been cleaned! Almost all of the rust has been removed.");
			};
			Starling.juggler.add(HalfCleanTween);
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
			
			
			this.assets.removeTexture("ravineFreighterHatch_bg",true);
			this.assets.removeTexture("RavineFreighterHatch_Sprite",true);
			this.assets.removeTexture("RavineFreighterHatch_Sprite_02",true);
			this.assets.removeTextureAtlas("RavineFreighterHatch_Sprite",true);
			this.assets.removeTextureAtlas("RavineFreighterHatch_Sprite_02",true);
		
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterHatch_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterHatch_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterHatch_03");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterHatch_04");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighterHatch_05");
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