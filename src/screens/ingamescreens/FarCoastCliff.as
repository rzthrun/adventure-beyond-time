package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class FarCoastCliff extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var cut:Image;
		private var trunk_up:Image;
		private var trunk_down:Image;
		private var card:Image;
		
		private var waterFall_mc:MovieClip;
		
		private var hit_card:Shape;
		private var hit_cave:Shape;
		private var hit_trunk:Shape;
		private var hit_FarCoastCorner:Shape;
		
		private var hit_sea:Shape;
		private var hit_sky:Shape;
		private var hit_roots:Shape;
		private var hit_waterfall:Shape;
		
		private var TrunkDown:Boolean = false;
		private var TrunkState:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function FarCoastCliff(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('farCoastCliff_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCliff/farCoastCliff_bg.jpg'));
				game.TrackAssets('farCoastCliff_01');
			}
			if(game.CheckAsset('farCoastCliff_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCliff/FarCoastCliff_Sprite_01.png'));
				game.TrackAssets('farCoastCliff_02');
			}
			if(game.CheckAsset('farCoastCliff_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCliff/FarCoastCliff_Sprite_01.xml'));
				game.TrackAssets('farCoastCliff_03');
			}
			if(game.CheckAsset('farCoastCliff_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCliff/FarCoastCliff_Sprite_02.atf'));
				game.TrackAssets('farCoastCliff_04');
			}
			if(game.CheckAsset('farCoastCliff_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCliff/FarCoastCliff_Sprite_02.xml'));
				game.TrackAssets('farCoastCliff_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FarCoastCliff","FarCoastCliffObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff;
			}
			SaveArray['TrunkState'] = "No";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastCliff',SaveArray);
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jaw,
				'item_Jaw',
				'inven_jaw_sm'
			);	
			*/
			bg = new Image(this.assets.getTexture('farCoastCliff_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			waterFall_mc = new MovieClip(this.assets.getTextures("cliff_waterfall_"),3);
			
			//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
			waterFall_mc.x = 228;
			waterFall_mc.y = 125;
			waterFall_mc.width = 360;
			waterFall_mc.height = 244;
			waterFall_mc.alpha = 0.8;
			waterFall_mc.touchable = false;
			waterFall_mc.loop = true; // default: true
			//	waterFall_mc.play();
			this.addChildAt(waterFall_mc,1);	
			Starling.juggler.add(waterFall_mc);
			
			card = new Image(this.assets.getTexture('card'));
			card.smoothing = TextureSmoothing.NONE;
			card.touchable = false;
			card.x = 463;
			card.y = 368;
		
			trunk_up = new Image(this.assets.getTexture('trunk_up'));
			trunk_up.smoothing = TextureSmoothing.NONE;
			trunk_up.touchable = false;
			trunk_up.x = 95;
			trunk_up.y = 1;
	
			trunk_down = new Image(this.assets.getTexture('trunk_down'));
			trunk_down.smoothing = TextureSmoothing.NONE;
			trunk_down.touchable = false;
			trunk_down.x = 106;
			trunk_down.y = 58;
	
			cut = new Image(this.assets.getTexture('chopped_01'));
			cut.smoothing = TextureSmoothing.NONE;
			cut.touchable = false;
			cut.x = 113;
			cut.y = 72;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['Card'] == 'PickedUp'){
					card.alpha = 0;
				}else{
					card.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '1'){
					TrunkState = 1;
					trunk_down.alpha = 0;
					trunk_up.alpha = 1;
					cut.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '2'){
					TrunkState = 2;
					trunk_down.alpha = 0;
					trunk_up.alpha = 1;
					cut.alpha = 1;
					cut.texture = this.assets.getTexture('chopped_02');
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '3'){
					TrunkState = 3;
					trunk_down.alpha = 0;
					trunk_up.alpha = 1;
					cut.alpha = 1;
					cut.texture = this.assets.getTexture('chopped_03');
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '4'){
					TrunkState = 4;
					cut.alpha = 0;
					trunk_up.alpha = 0;
					trunk_down.alpha = 1;
					TrunkDown = true;
				}else{
					cut.alpha = 0;
					trunk_up.alpha = 1;
					trunk_down.alpha = 0;
				}
			}else{
				cut.alpha = 0;
				card.alpha = 1;
				trunk_up.alpha = 1;
				trunk_down.alpha = 0;
			}
			

			
			this.addChildAt(card,2);	
			this.addChildAt(trunk_up,3);	
			this.addChildAt(trunk_down,4);	
			this.addChildAt(cut,5);
			
			CreateHitSky();
			CreateHitSea();
			CreateHitWaterFall();
			CreateHitRoots();
			CreateHitCard();
			CreateHitTrunk(TrunkDown);
			CreateHitFarCoastCorner();
			CreateHitCave();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Jungle_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			if((stage.getChildAt(0) as Object).AmbientObj.currentAmbient == 'Waterfall'){
				trace("BARK1");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999,2);
			
				},0.7);
			}else{
				trace("BARK2");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999,2);
					
				},0.7);
			}
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waterfall';
			
		}
		
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(358,0);																																																																																																																														
			hit_sky.graphics.lineTo(608,3);																																																																																																																														
			hit_sky.graphics.lineTo(577,128);																																																																																																																														
			hit_sky.graphics.lineTo(447,159);																																																																																																																														
			hit_sky.graphics.lineTo(367,126);																																																																																																																														
																																																																																																																																			
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateHitSea():void{
			hit_sea = new Shape();
			hit_sea.touchable = false;
			hit_sea.graphics.beginFill(0xff0000);
			
			hit_sea.graphics.lineTo(637,106);																																																																																																																														
			hit_sea.graphics.lineTo(800,122);																																																																																																																														
			hit_sea.graphics.lineTo(800,257);																																																																																																																														
			hit_sea.graphics.lineTo(627,165);																																																																																																																														
			
			hit_sea.alpha = 0.0;
			
			hit_sea.graphics.precisionHitTest = true;	
			this.addChild(hit_sea);
		}
		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(0,212);																																																																																																																														
			hit_roots.graphics.lineTo(51,202);																																																																																																																														
			hit_roots.graphics.lineTo(133,234);																																																																																																																														
			hit_roots.graphics.lineTo(198,216);																																																																																																																														
			hit_roots.graphics.lineTo(260,359);																																																																																																																														
			hit_roots.graphics.lineTo(264,423);																																																																																																																														
			hit_roots.graphics.lineTo(394,512);																																																																																																																														
			hit_roots.graphics.lineTo(0,512);																																																																																																																														
			
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitWaterFall():void{
			hit_waterfall = new Shape();
			hit_waterfall.touchable = false;
			hit_waterfall.graphics.beginFill(0xff0000);
			
			hit_waterfall.graphics.lineTo(288,162);																																																																																																																														
			hit_waterfall.graphics.lineTo(376,147);																																																																																																																														
			hit_waterfall.graphics.lineTo(438,351);																																																																																																																														
			hit_waterfall.graphics.lineTo(318,341);																																																																																																																														
			
			hit_waterfall.alpha = 0.0;
			
			hit_waterfall.graphics.precisionHitTest = true;	
			this.addChild(hit_waterfall);
		}
		
		private function CreateHitCave():void{
			hit_cave = new Shape();
			hit_cave.touchable = false;
			hit_cave.graphics.beginFill(0xff0000);
			
			hit_cave.graphics.lineTo(232,14);																																																																																																																														
			hit_cave.graphics.lineTo(288,10);																																																																																																																														
			hit_cave.graphics.lineTo(330,46);																																																																																																																														
			hit_cave.graphics.lineTo(341,147);																																																																																																																														
			hit_cave.graphics.lineTo(271,153);																																																																																																																														
			hit_cave.graphics.lineTo(236,121);																																																																																																																														
			hit_cave.graphics.lineTo(216,76);																																																																																																																														

			hit_cave.alpha = 0.0;
			
			hit_cave.graphics.precisionHitTest = true;	
			this.addChild(hit_cave);
		}
		
		
		private function CreateHitFarCoastCorner():void{
			hit_FarCoastCorner = new Shape();
			hit_FarCoastCorner.touchable = false;
			hit_FarCoastCorner.graphics.beginFill(0xff0000);
			
			hit_FarCoastCorner.graphics.lineTo(451,175);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(561,139);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(800,264);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(800,512);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(611,512);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(609,398);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(571,366);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(519,354);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(450,352);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(420,238);																																																																																																																														
																																																																																																																													
			
			hit_FarCoastCorner.alpha = 0.0;
			
			hit_FarCoastCorner.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastCorner);
		}
		
		private function CreateHitCard():void{
			hit_card = new Shape();
			hit_card.touchable = false;
			hit_card.graphics.beginFill(0xff0000);
			
			hit_card.graphics.lineTo(438,369);																																																																																																																														
			hit_card.graphics.lineTo(506,359);																																																																																																																														
			hit_card.graphics.lineTo(532,363);																																																																																																																														
			hit_card.graphics.lineTo(570,385);																																																																																																																														
			hit_card.graphics.lineTo(570,397);																																																																																																																														
			hit_card.graphics.lineTo(503,426);																																																																																																																														
	
			hit_card.alpha = 0.0;
			
			hit_card.graphics.precisionHitTest = true;	
			this.addChild(hit_card);
		}
		/*
		private var hit_card:Shape;
		private var hit_Cave:Shape;
		private var hit_trunk:Shape;
		private var hit_FarCoastCorner:Shape;
		*/
		private function CreateHitTrunk(open:Boolean = false):void{
			hit_trunk = new Shape();
			this.addChild(hit_trunk);
			if(open === false){
				
				hit_trunk.x = 0;
				hit_trunk.y = 0;
				hit_trunk.graphics.beginFill(0x0000FF);
				hit_trunk.graphics.lineTo(113,0);
				hit_trunk.graphics.lineTo(207,0);
				hit_trunk.graphics.lineTo(194,207);
				hit_trunk.graphics.lineTo(135,222);
				hit_trunk.graphics.lineTo(57,192);
				hit_trunk.graphics.lineTo(95,140);
				
				hit_trunk.graphics.endFill(false);
				
				hit_trunk.alpha = 0.0;
				
				hit_trunk.graphics.precisionHitTest = true;	
			}else{
				
				hit_trunk.x = 0;
				hit_trunk.y = 0;
				hit_trunk.graphics.beginFill(0x0000FF);		
				hit_trunk.graphics.lineTo(112,85);
				hit_trunk.graphics.lineTo(153,46);
				hit_trunk.graphics.lineTo(201,58);
				hit_trunk.graphics.lineTo(235,125);
				hit_trunk.graphics.lineTo(252,138);
				hit_trunk.graphics.lineTo(265,168);
				hit_trunk.graphics.lineTo(233,190);
				hit_trunk.graphics.lineTo(188,238);
				hit_trunk.graphics.lineTo(117,232);
				hit_trunk.graphics.lineTo(65,195);
				hit_trunk.graphics.lineTo(96,145);
				
				hit_trunk.graphics.endFill(false);
				hit_trunk.alpha = 0.0;
				
				hit_trunk.graphics.precisionHitTest = true;				
			}
			hit_trunk.touchable = false;
			
		}		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JungleDeep as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleDeepObj,true
							);
						}else if(hit_FarCoastCorner.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((FarCoastCorner as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCornerObj,true
							);		
						}else if(hit_card.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CardHandler();
					
						}else if(TrunkDown === true){
							if(hit_trunk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree trunk precariously spans the gap between the ledges.");
							//	FadeOut((CliffCave as Class), 
							//		(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true
							//	);	
							}else if(hit_cave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((CliffCave as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true
								);	
							}else if(hit_waterfall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The waterfall is mesmerizing.');
							}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The roots cling to the stone...');
							}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Plants grow from the rocky cliff face.');
							}else if(hit_sea.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The sea and sky blend together toward the horizon.');
							}
						}else{
							if(hit_trunk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TrunkHandler();
							}else if(hit_cave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't get over there. I must find a way to span the gap.");
							}else if(hit_waterfall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The water cascades down into the ocean.');
							}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The roots grow into the rock like veins, searching for any hold they can find.");
							}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cliffs are steep and inaccessible.");
							}else if(hit_sea.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What ocean is this?");
							}
								
						}
					}
					
				}
			}
		}
		private function CardHandler():void{	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff['Card'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					card.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff;
					}
					SaveArray['Card'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastCliff',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Card,
						'item_Card',
						'inven_card_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				card.alpha = 0;
				SaveArray['Card'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastCliff',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Card,
					'item_Card',
					'inven_card_sm'
				);	
			}
		}
		
		
		private function TrunkHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastCliff;
			}
			
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Jaw)
			{
				if(TrunkState == 0){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Saw();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sharp teeth of the jaw bone have sawed away part of the tree trunk.");
					SaveArray['TrunkState'] = '1'; 
					TrunkState = 1;
					cut.alpha = 1;
				}else if(TrunkState == 1){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Saw();
					SaveArray['TrunkState'] = '2'; 
					TrunkState = 2
					cut.texture = this.assets.getTexture('chopped_02');
				}else if(TrunkState == 2){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Saw();
					SaveArray['TrunkState'] = '3'; 
					TrunkState = 3
					cut.texture = this.assets.getTexture('chopped_03');
				}else if(TrunkState == 3){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FallingTree();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Jaw,
							"item_Jaw"
						);
					
					SaveArray['TrunkState'] = '4'; 
					TrunkState = 4
					TrunkDown = true;
					Animating = true;
					hit_trunk.graphics.clear();
					CreateHitTrunk(TrunkDown);
					
					Starling.juggler.delayCall(function():void{
						Animating = false;
						trunk_up.alpha = 0;
						trunk_down.alpha = 1;
						cut.alpha = 0;
						//(stage.getChildAt(0) as Object).MusicObj.LoadWaterfall(true,999,2);
					},3.5);
					
					
			//	}else if(TrunkState == 4){
					
				}
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastCliff',SaveArray);
			
			}else{
				if(TrunkState == 0){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree seems to be dead and dry, but firmly planted by its roots.");
				}else if(TrunkState == 1){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've used the jaw to carve a notch in the trunk of the tree.");
				}else if(TrunkState == 2){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A large portion of the tree trunk has been removed.");
				}else if(TrunkState == 3){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree has almost been sawed all the way through.");
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
			
			
			this.assets.removeTexture("farCoastCliff_bg",true);		
			this.assets.removeTexture("FarCoastCliff_Sprite_01",true);			
			this.assets.removeTextureAtlas("FarCoastCliff_Sprite_01",true);						
			this.assets.removeTexture("FarCoastCliff_Sprite_02",true);			
			this.assets.removeTextureAtlas("FarCoastCliff_Sprite_02",true);
		
			(stage.getChildAt(0) as Object).falseAsset("farCoastCliff_01");
			(stage.getChildAt(0) as Object).falseAsset("farCoastCliff_02");
			(stage.getChildAt(0) as Object).falseAsset("farCoastCliff_03");
			(stage.getChildAt(0) as Object).falseAsset("farCoastCliff_04");
			(stage.getChildAt(0) as Object).falseAsset("farCoastCliff_05");
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