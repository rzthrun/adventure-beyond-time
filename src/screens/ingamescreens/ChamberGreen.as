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
	
	
	
	public class ChamberGreen extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var blue_crystals:Image;
		private var crystal:Image;
		private var tube:Image;
		private var sparks:Image;
		
		private var hit_crystals:Shape;
		private var hit_tree:Shape;
		
		private var hit_growth:Shape;
		private var hit_room:Shape;
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var ItIsLit:Boolean = false;
		private var ItIsBlue:Boolean = false;
		private var Animating:Boolean = false;
		private var BlueTween:Tween;
		private var CrystalTween:Tween;
		public var delayedCall:DelayedCall;
		
		
		private var goback:GoBackButton;
		
		public function ChamberGreen(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberGreen_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreen/ChamberGreen_Sprite_02.jpg'));
				game.TrackAssets('chamberGreen_01');
			}
			if(game.CheckAsset('chamberGreen_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreen/ChamberGreen_Sprite_02.xml'));
				game.TrackAssets('chamberGreen_02');
			}
			if(game.CheckAsset('chamberGreen_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreen/ChamberGreen_Sprite.atf'));
				game.TrackAssets('chamberGreen_03');
			}
			if(game.CheckAsset('chamberGreen_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreen/ChamberGreen_Sprite.xml'));
				game.TrackAssets('chamberGreen_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberGreen","ChamberGreenObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
	//		SaveArray['Blue'] = "no";
	//		(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Green'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 0){
						ItIsLit = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						ItIsLit = true;			
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
							ItIsLit = true;
						}
					}
				}
			}

			
			if(ItIsLit === false){
				bg = new Image(this.assets.getTexture('chamberGreen_bg'));
				
			}else{
				bg = new Image(this.assets.getTexture('chamberGreen_bg_lit'));
			}
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			crystal = new Image(this.assets.getTexture('crystal'));
			sparks = new Image(this.assets.getTexture('tree_sparks'));
			
			crystal.smoothing = TextureSmoothing.NONE;
			sparks.smoothing = TextureSmoothing.NONE;

			if(ItIsLit === false){
				tube = new Image(this.assets.getTexture('tree_tube_white'));
				blue_crystals = new Image(this.assets.getTexture('blue_white'));
			}else{
				tube = new Image(this.assets.getTexture('tree_tube_green'));
				blue_crystals = new Image(this.assets.getTexture('blue_green'));
			}
			
			blue_crystals.touchable = true;
			blue_crystals.x = 420;
			blue_crystals.y = 53;
			blue_crystals.smoothing = TextureSmoothing.NONE;
			
			
			crystal.touchable = true;
			crystal.x = 513;
			crystal.y = 131;
	
			
			tube.touchable = true;
			tube.x = 241;
			tube.y = 269;
			tube.smoothing = TextureSmoothing.NONE;
			
			sparks.touchable = true;
			sparks.x = 132;
			sparks.y = 289;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree['Plasma'] == 'Attached'){
					tube.alpha = 1;
				}else{
					tube.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen['Blue'] == 'Showing'){
							ItIsBlue = true;
							blue_crystals.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen['Crystal'] == 'PickedUp'){								
								crystal.alpha = 0;
							}else{
								crystal.alpha = 1;
							}
							
						}else{
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen;
							}
							SaveArray['Blue'] = "Showing";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
							ItIsBlue = true;
							Animating = true;
							crystal.alpha = 0;
							blue_crystals.alpha = 0;
							delayedCall = new DelayedCall(FadeInBlue,2);
							Starling.juggler.add(delayedCall);
						}
					}else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen;
						}
						SaveArray['Blue'] = "Showing";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
						ItIsBlue = true;
						Animating = true;
						crystal.alpha = 0;
						blue_crystals.alpha = 0;
						delayedCall = new DelayedCall(FadeInBlue,2);
						Starling.juggler.add(delayedCall);
					}
					if(ItIsLit == true){
						sparks.alpha = 1;
					}else{
						sparks.alpha = 0;
					}
				}else{
					sparks.alpha = 0;
					blue_crystals.alpha = 0;
					crystal.alpha = 0;
					blue_crystals.alpha = 0;
				}
				
			}else{
				blue_crystals.alpha = 0;
				crystal.alpha = 0;
				tube.alpha = 0;
				sparks.alpha = 0;
			}
			
			
			
			this.addChildAt(blue_crystals,1);
			this.addChildAt(crystal,2);		
			this.addChildAt(tube,3);			
			this.addChildAt(sparks,4);
			CreateHitRoom();
			CreateHitGrowth();
			CreateHitTree();
			CreateHitCrystals();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen['FirstTime'] == 'Yes'){
					
				}else{
					if(ItIsLit === true){
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen;
							SaveArray['FirstTime'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
								
							},1.5);
						}
					}
				}
			}else{
				if(ItIsLit === true){
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							//	Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
							//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
						},1.5);
					}
				}
			}

		}
		
		private function FadeInBlue():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();
			BlueTween = new Tween(blue_crystals, 2.5, Transitions.LINEAR);
			BlueTween.fadeTo(1);
			BlueTween.onComplete = function():void{
				FadeInCrystal();
				
			}
			Starling.juggler.add(BlueTween);
		}
		
		private function FadeInCrystal():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
			BlueTween = null;
			CrystalTween = new Tween(crystal, 2, Transitions.LINEAR);
			CrystalTween.fadeTo(1);
			CrystalTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				Animating = false;
				CrystalTween = null;
			}
			Starling.juggler.add(CrystalTween);
		}
		
		private function CreateHitRoom():void{
			hit_room = new Shape();
			hit_room.touchable = false;
			hit_room.graphics.beginFill(0xff0000);
			
			hit_room.graphics.lineTo(47,123);												
			hit_room.graphics.lineTo(153,0);												
			hit_room.graphics.lineTo(629,0);												
			hit_room.graphics.lineTo(772,183);												
			hit_room.graphics.lineTo(678,360);												
			hit_room.graphics.lineTo(95,304);												
			
			hit_room.graphics.endFill(false);
			hit_room.alpha = 0.0;
			
			hit_room.graphics.precisionHitTest = true;	
			this.addChild(hit_room);
		}
		
		private function CreateHitGrowth():void{
			hit_growth = new Shape();
			hit_growth.touchable = false;
			hit_growth.graphics.beginFill(0xff0000);
			
			hit_growth.graphics.lineTo(0,288);												
			hit_growth.graphics.lineTo(371,284);												
			hit_growth.graphics.lineTo(465,350);												
			hit_growth.graphics.lineTo(420,424);												
			hit_growth.graphics.lineTo(275,495);												
			hit_growth.graphics.lineTo(0,504);												
			
			hit_growth.graphics.endFill(false);
			hit_growth.alpha = 0.0;
			
			hit_growth.graphics.precisionHitTest = true;	
			this.addChild(hit_growth);
		}
		
		
		private function CreateHitTree():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(113,250);												
			hit_tree.graphics.lineTo(358,253);												
			hit_tree.graphics.lineTo(366,317);												
			hit_tree.graphics.lineTo(290,391);												
			hit_tree.graphics.lineTo(100,383);												
		
			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitCrystals():void{
			hit_crystals = new Shape();
			hit_crystals.touchable = false;
			hit_crystals.graphics.beginFill(0xff0000);
			
			hit_crystals.graphics.lineTo(453,176);												
			hit_crystals.graphics.lineTo(486,99);												
			hit_crystals.graphics.lineTo(578,95);												
			hit_crystals.graphics.lineTo(603,172);												
			hit_crystals.graphics.lineTo(524,242);												
			
			hit_crystals.graphics.endFill(false);
			hit_crystals.alpha = 0.0;
			
			hit_crystals.graphics.precisionHitTest = true;	
			this.addChild(hit_crystals);
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
							FadeOut((Chamber as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
							);
						}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((ChamberGreenTree as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberGreenTreeObj,true
							);
						}else if(hit_crystals.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ItIsBlue === true){
								CrystalHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a smooth surface on the cave wall.");
							}
						}else if(hit_growth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ItIsLit === false){
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A group of balls cluster around the singular shape.");
									
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere resembles a bacteria or another simple life form.");
									
								}
							}else{
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("In the green light, the spheres almost appear to be moving.");
									
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shapes undulate like waves.");
									
								}
							}
						}else if(hit_room.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ItIsLit === false){
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The five-sided surfaces abound everywhere.");
									
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This entire chamber seems to be constructed out of multitudes of smaller and smaller pieces.");
									
								}
							}else{
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An echoing resonance can be felt through the walls.");
									
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("ahh... this place is creepy");
									
								}
							}

						}
						
						/*
						private var hit_growth:Shape;
						private var hit_room:Shape;
						private var PhraseCounter:int = 0;
						*/
					}
				}
			}
		}
		
		private function CrystalHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen ["Crystal"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Smaller crystals continue to grow out of the rock...");

				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
					crystal.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen;
					}
					SaveArray['Crystal'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalBlue,
						'item_CrystalBlue',
						'inven_crystalBlue_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				crystal.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreen;
				}
				SaveArray['Crystal'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreen',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalBlue,
					'item_CrystalBlue',
					'inven_crystalBlue_sm'
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
			
			

			this.assets.removeTexture("ChamberGreen_Sprite_02",true);
			this.assets.removeTexture("ChamberGreen_Sprite",true);
			this.assets.removeTextureAtlas("ChamberGreen_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberGreen_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberGreen_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreen_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreen_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreen_04");
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