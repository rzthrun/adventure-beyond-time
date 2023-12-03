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
	import starling.textures.TextureSmoothing;

	public class ChamberBlue extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var shell:Image;
		private var white:Image;
		private var crystal:Image;
		
		private var posSprite:Sprite;
		private var pos0:Image;
		private var pos1:Image;
		private var pos2:Image;
		private var pos3:Image;
		private var pos4:Image;
		private var pos5:Image;
		
		private var hit_nautilus:Shape;
		private var hit_crystal:Shape;
		private var hit_room:Shape;
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		private var ItIsLit:Boolean = false;
		private var ItIsWhite:Boolean = false;
		private var WhiteTween:Tween;
		private var CrystalTween:Tween;
		public var delayedCall:DelayedCall;
		private var goback:GoBackButton;
		
		public function ChamberBlue(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberBlue_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_03.jpg'));
				game.TrackAssets('chamberBlue_01');
			}
			if(game.CheckAsset('chamberBlue_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_03.xml'));
				game.TrackAssets('chamberBlue_02');
			}
			if(game.CheckAsset('chamberBlue_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_02.png'));
				game.TrackAssets('chamberBlue_03');
			}
			if(game.CheckAsset('chamberBlue_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_02.xml'));
				game.TrackAssets('chamberBlue_04');
			}
			if(game.CheckAsset('chamberBlue_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_01.atf'));
				game.TrackAssets('chamberBlue_05');
			}
			if(game.CheckAsset('chamberBlue_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlue/ChamberBlue_Sprite_01.xml'));
				game.TrackAssets('chamberBlue_06');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberBlue","ChamberBlueObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Blue'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						ItIsLit = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 4){
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
				bg = new Image(this.assets.getTexture('chamberBlue_bg'));
				shell  = new Image(this.assets.getTexture('nautilus_shell_white'));
				
				white  = new Image(this.assets.getTexture('white_white'));
				crystal  = new Image(this.assets.getTexture('crystal_white'));
			}else{
				bg = new Image(this.assets.getTexture('chamberBlue_bg_lit'));
				shell  = new Image(this.assets.getTexture('nautilus_shell_blue'));
				white  = new Image(this.assets.getTexture('white_blue'));
				crystal  = new Image(this.assets.getTexture('crystal_blue'));
			}

			bg.touchable = true;
			this.addChildAt(bg,0);
	
			MakePosSprite();
			
			shell.smoothing = TextureSmoothing.NONE;
			white.smoothing = TextureSmoothing.NONE;
			crystal.smoothing = TextureSmoothing.NONE;
			
			shell.touchable = false;
			shell.x = 398;
			shell.y = 162;
		
			white.touchable = false;
			white.x = 40;
			white.y = 201;
		
			crystal.touchable = false;
			crystal.x = 148;
			crystal.y = 276;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['Shell'] == 'Attached'){
					shell.alpha = 1;
					if(ItIsLit === true){
						posSprite.alpha = 1;
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos0'] != undefined){
						
							pos0.texture = this.assets.getTexture('sp_pos0c'+(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos0']);
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos1'] != undefined){
						
							pos1.texture = this.assets.getTexture('sp_pos1c'+	(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos1']);
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos2'] != undefined){
							
							pos2.texture = this.assets.getTexture('sp_pos2c'+(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos2'])
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos3'] != undefined){
							
							pos3.texture = this.assets.getTexture('sp_pos3c'+(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos3'])
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos4'] != undefined){
							
							pos4.texture = this.assets.getTexture('sp_pos4c'+(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos4'])
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos5'] != undefined){
							
							pos5.texture = this.assets.getTexture('sp_pos5c'+ (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos5'])
						}
						

						
					}else{
						posSprite.alpha = 0;
					}
					
				}else{
					posSprite.alpha = 0;
					shell.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue['White'] == 'Showing'){
							ItIsWhite = true;
							white.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue['Crystal'] == 'PickedUp'){
								crystal.alpha = 0;
							}else{
								crystal.alpha = 1;
							}
						}else{
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue;
							}
							SaveArray['White'] = "Showing";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
							ItIsWhite = true;
							Animating = true;
							crystal.alpha = 0;
							white.alpha = 0;
							delayedCall = new DelayedCall(FadeInWhite,2);
							Starling.juggler.add(delayedCall);
						}
					}else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue;
						}
						SaveArray['White'] = "Showing";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
						ItIsWhite = true;
						Animating = true;
						crystal.alpha = 0;
						white.alpha = 0;
						delayedCall = new DelayedCall(FadeInWhite,2);
						Starling.juggler.add(delayedCall);
					}
				}else{
					white.alpha = 0;
					crystal.alpha = 0;
				}
				
				
			}else{
				posSprite.alpha = 0;
				shell.alpha = 0;
				white.alpha = 0;
				crystal.alpha = 0;
			}
			
		
			
			this.addChildAt(shell,1);	
			this.addChildAt(white,2);			
			this.addChildAt(crystal,3);

			CreateHitRoom();
			CreateHitNautilus();
			CreateHitCrystal();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue['FirstTime'] == 'Yes'){
					
				}else{
					if(ItIsLit === true){
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue;
							SaveArray['FirstTime'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
								
							},1.5);
						}
					}
				}
			}else{
				if(ItIsLit === true){
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							//	Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
							//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
						},1.5);
					}
				}
			}
			
		}
		
		
		private function FadeInWhite():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();
			WhiteTween = new Tween(white, 2.5, Transitions.LINEAR);
			WhiteTween.fadeTo(1);
			WhiteTween.onComplete = function():void{
				FadeInCrystal();			
			}
			Starling.juggler.add(WhiteTween);
		}
		
		private function FadeInCrystal():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
			WhiteTween = null;
			CrystalTween = new Tween(crystal, 2, Transitions.LINEAR);
			CrystalTween.fadeTo(1);
			CrystalTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				Animating = false;
				CrystalTween = null;
				
				
				
			}
			Starling.juggler.add(CrystalTween);
		}
		
		private function MakePosSprite():void{
			posSprite = new Sprite();
			posSprite.touchable = false;
			posSprite.x =  0;
			posSprite.y = 0
			
			pos0 = new Image(this.assets.getTexture('sp_pos0c0'));
			pos0.touchable = false;
			pos0.x = 425;
			pos0.y = 167;
			
			pos1 = new Image(this.assets.getTexture('sp_pos1c0'));
			pos1.touchable = false;
			pos1.x = 399;
			pos1.y = 117;
			
			pos2 = new Image(this.assets.getTexture('sp_pos2c0'));
			pos2.touchable = false;
			pos2.x = 342;
			pos2.y = 120;
			
			pos3 = new Image(this.assets.getTexture('sp_pos3c0'));
			pos3.touchable = false;
			pos3.x = 342;
			pos3.y = 182;
			
			pos4 = new Image(this.assets.getTexture('sp_pos4c0'));
			pos4.touchable = false;
			pos4.x = 428;
			pos4.y = 149;
			
			pos5 = new Image(this.assets.getTexture('sp_pos5c0'));
			pos5.touchable = false;
			pos5.x = 392;
			pos5.y = 30;
			
			pos0.alpha = 1;
			pos1.alpha = 1;
			pos2.alpha = 1;
			pos3.alpha = 1;
			pos4.alpha = 1;
			pos5.alpha = 1;
			
			posSprite.addChildAt(pos0,0);			
			posSprite.addChildAt(pos1,1);	
			posSprite.addChildAt(pos2,2);						
			posSprite.addChildAt(pos3,3);				
			posSprite.addChildAt(pos4,4);
			posSprite.addChildAt(pos5,5);
			
			posSprite.alpha = 0;
			this.addChild(posSprite);
		}
		/*
		private var hit_room:Shape;
		private var PhraseCounter:Shape;
		*/
		private function CreateHitRoom():void{
			hit_room = new Shape();
			hit_room.touchable = false;
			hit_room.graphics.beginFill(0xff0000);
			
			hit_room.graphics.lineTo(36,215);												
			hit_room.graphics.lineTo(211,0);												
			hit_room.graphics.lineTo(589,0);												
			hit_room.graphics.lineTo(784,167);												
			hit_room.graphics.lineTo(694,376);												
			hit_room.graphics.lineTo(219,440);												
			
			hit_room.graphics.endFill(false);
			hit_room.alpha = 0.0;
			
			hit_room.graphics.precisionHitTest = true;	
			this.addChild(hit_room);
		}
		
		private function CreateHitCrystal():void{
			hit_crystal = new Shape();
			hit_crystal.touchable = false;
			hit_crystal.graphics.beginFill(0xff0000);
			
			hit_crystal.graphics.lineTo(79,315);												
			hit_crystal.graphics.lineTo(150,240);												
			hit_crystal.graphics.lineTo(216,268);												
			hit_crystal.graphics.lineTo(221,350);												
			hit_crystal.graphics.lineTo(166,417);												
			
			hit_crystal.graphics.endFill(false);
			hit_crystal.alpha = 0.0;
			
			hit_crystal.graphics.precisionHitTest = true;	
			this.addChild(hit_crystal);
		}
		
		
		private function CreateHitNautilus():void{
			hit_nautilus = new Shape();
			hit_nautilus.touchable = false;
			hit_nautilus.graphics.beginFill(0xff0000);
			
			hit_nautilus.graphics.lineTo(271,169);												
			hit_nautilus.graphics.lineTo(344,49);												
			hit_nautilus.graphics.lineTo(555,55);												
			hit_nautilus.graphics.lineTo(613,178);												
			hit_nautilus.graphics.lineTo(525,334);												
			hit_nautilus.graphics.lineTo(338,319);												
		
			hit_nautilus.graphics.endFill(false);
			hit_nautilus.alpha = 0.0;
			
			hit_nautilus.graphics.precisionHitTest = true;	
			this.addChild(hit_nautilus);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Chamber as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
						);
					}else if(hit_nautilus.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((ChamberBlueNautilus as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberBlueNautilusObj,true
						);
					
					}else if(hit_crystal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(ItIsWhite === true){
							CrystalHandler();
						}
					}else if(hit_room.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						if(ItIsLit === false){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The whole room feels like it's contorting in one great spiral.");

							}else if(PhraseCounter == 1){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This earth is not of this world.");
								PhraseCounter = 2;
							}else if(PhraseCounter == 2){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder if I will ever make it back home.");
							}
						}else{
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls pulse with a magnetic field");
							}else if(PhraseCounter == 1){
								PhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The the deep blue light reminds me of the ocean depths.");
							}else if(PhraseCounter == 2){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The spiral arms continue out of the chamber.");
							}
						}
						
						/*
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shape of this roome makes my head spin.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The small chamber is glowing a blood red.");
							}
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("All types of geometric forms cover walls.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can feel deep vibrations through my feet.");
							}
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pyramids, spheres and all types of polyhedrons fill dance across the rock.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think these bizarre shapes are part of the mountain... always have been...");
							}
						}*/
						
					}
				}
			}
		}
		
		private function CrystalHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue["Crystal"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Even the smaller crystals glow brilliantly");
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
					crystal.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue;
					}
					SaveArray['Crystal'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalWhite,
						'item_CrystalWhite',
						'inven_crystalWhite_sm'
					);
					
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
							
						},1.5);
					}
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				crystal.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlue;
				}
				SaveArray['Crystal'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlue',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalWhite,
					'item_CrystalWhite',
					'inven_crystalWhite_sm'
				);
				
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
						
					},1.5);
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
			
			this.assets.removeTexture("ChamberBlue_Sprite_01",true);
			this.assets.removeTextureAtlas("ChamberBlue_Sprite_01",true);
			this.assets.removeTexture("ChamberBlue_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberBlue_Sprite_02",true);
			this.assets.removeTexture("ChamberBlue_Sprite_03",true);
			this.assets.removeTextureAtlas("ChamberBlue_Sprite_03",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_04");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_05");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlue_06");
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