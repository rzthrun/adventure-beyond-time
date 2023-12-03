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
	import starling.utils.AssetManager;
	
	public class CliffMonsterCave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var mirror:Image;
		private var crystal:Image;
		private var potatoes:Image;
		private var dragonball:Image;
		private var eyes:MovieClip;
		
		private var hit_light:Shape;
		private var hit_pool:Shape;
		private var hit_roots:Shape;
		private var hit_rootsTwo:Shape;
		private var hit_stone:Shape;
		private var hit_stoneTwo:Shape;
		
		private var hit_crystal:Shape;
		private var hit_mirror:Shape;
		private var hit_monster:Shape;
	
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CliffMonsterCave(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cliffMonsterCave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterCave/cliffMonsterCave_bg.jpg'));
				game.TrackAssets('cliffMonsterCave_01');
			}
			if(game.CheckAsset('cliffMonsterCave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterCave/CliffMonsterCave_Sprite.png'));
				game.TrackAssets('cliffMonsterCave_02');
			}
			if(game.CheckAsset('cliffMonsterCave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterCave/CliffMonsterCave_Sprite.xml'));
				game.TrackAssets('cliffMonsterCave_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CliffMonsterCave","CliffMonsterCaveObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	SaveArray['Crystal'] = "b";
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
			
			bg = new Image(this.assets.getTexture('cliffMonsterCave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			crystal = new Image(this.assets.getTexture('crystal'));
			crystal.touchable = false;
			crystal.x = 579;
			crystal.y = 226;
			
			
			mirror = new Image(this.assets.getTexture('mirror'));
			mirror.touchable = false;
			mirror.x = 332;
			mirror.y = 217;
			
			
			potatoes = new Image(this.assets.getTexture('monster_potatos'));
			potatoes.touchable = false;
			potatoes.x = 167;
			potatoes.y = 234;
			
			
			dragonball = new Image(this.assets.getTexture('monster_dragonball'));
			dragonball.touchable = false;
			dragonball.x = 170;
			dragonball.y = 221;
			
			eyes = new MovieClip(this.assets.getTextures("monster_eyes_03"),3);
			eyes.x = 148;
			eyes.y = 179;
			
			eyes.touchable = false;
			eyes.loop = true; 
		//	eyes.play();
			
			eyes.addFrameAt(1,this.assets.getTexture("monster_eyes_02"), null, 0.1);
			eyes.addFrameAt(2,this.assets.getTexture("monster_eyes_01"), null, 0.1);
			eyes.addFrameAt(3,this.assets.getTexture("monster_eyes_00"), null, 5.0);			
			eyes.addFrameAt(4,this.assets.getTexture("monster_eyes_01"), null, 0.1);
			eyes.addFrameAt(5,this.assets.getTexture("monster_eyes_02"), null, 0.1);
			eyes.addFrameAt(6,this.assets.getTexture("monster_eyes_03"), null, 1.0);	
			eyes.addFrameAt(1,this.assets.getTexture("monster_eyes_02"), null, 0.1);
			eyes.addFrameAt(2,this.assets.getTexture("monster_eyes_01"), null, 0.1);
			eyes.addFrameAt(3,this.assets.getTexture("monster_eyes_00"), null, 2.0);
			eyes.addFrameAt(4,this.assets.getTexture("monster_eyes_01"), null, 0.1);
			eyes.addFrameAt(5,this.assets.getTexture("monster_eyes_02"), null, 0.1);
			eyes.addFrameAt(6,this.assets.getTexture("monster_eyes_03"), null, 1.0);
			
			eyes.play();


			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Crystal'] == 'PickedUp'){
					crystal.alpha = 0;
				}else{
					crystal.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Mirror'] == 'PickedUp'){
					mirror.alpha = 0;
				}else{
					mirror.alpha = 1;
				}
			}else{
				crystal.alpha = 1;
				mirror.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Potatoes'] == 'Attached'){
					potatoes.alpha = 1;
				}else{
					potatoes.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'Attached'){
					dragonball.alpha = 1;
				}else{
					dragonball.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Solved'] == 'Yes'){
					eyes.alpha = 0;
				}else{
					eyes.alpha = 1;
				}
			}else{
				potatoes.alpha = 0;
				dragonball.alpha = 0;
				eyes.alpha = 1;
			}
		
			
			
			this.addChildAt(crystal,1);
			this.addChildAt(mirror,2);
			this.addChildAt(potatoes,3);
			this.addChildAt(dragonball,4);
			this.addChildAt(eyes,5);
			
			Starling.juggler.add(eyes);
			/*
			
			private var mirror:Image;
			private var crystal:Image;
			private var potatoes:Image;
			private var dragonball:Image;
			private var eyes:MovieClip;
			*/
			//FadeOutOcean(1);
			CreateHitStoneTwo();
			CreateHitStone();
			CreateHitRootsTwo();
			CreateHitRoots();
			CreateHitPool();
			CreateHitLight();
			
			CreateHitCrystal();
			CreateHitMirror();
			CreateHitMonster();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waterfall",0,3.0,'stop');
		//	Starling.juggler.delayCall(function():void{
		//		(stage.getChildAt(0) as Object).MusicObj.LoadWaterfall(true,999);
		//		(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolume("Waterfall",((stage.getChildAt(0) as Object).MusicObj.globalVol/6),0.5);
		//	},0.5);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,1);
							
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,1);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}
			}
			
		}
		
		private function CreateHitStoneTwo():void{
			hit_stoneTwo = new Shape();
			hit_stoneTwo.touchable = false;
			hit_stoneTwo.graphics.beginFill(0xff0000);
			
			hit_stoneTwo.graphics.lineTo(0,327);	
			hit_stoneTwo.graphics.lineTo(162,294);	
			hit_stoneTwo.graphics.lineTo(795,304);	
			hit_stoneTwo.graphics.lineTo(601,512);	
			hit_stoneTwo.graphics.lineTo(0,512);	
			
			
			hit_stoneTwo.graphics.endFill(false);
			hit_stoneTwo.alpha = 0.0;
			
			hit_stoneTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_stoneTwo);
		}
		
		private function CreateHitStone():void{
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(156,0);	
			hit_stone.graphics.lineTo(644,0);	
			hit_stone.graphics.lineTo(800,275);	
			hit_stone.graphics.lineTo(300,342);	
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateHitRootsTwo():void{
			hit_rootsTwo = new Shape();
			hit_rootsTwo.touchable = false;
			hit_rootsTwo.graphics.beginFill(0xff0000);
			
			hit_rootsTwo.graphics.lineTo(0,0);	
			hit_rootsTwo.graphics.lineTo(151,0);	
			hit_rootsTwo.graphics.lineTo(93,273);	
			hit_rootsTwo.graphics.lineTo(0,281);	
			
			hit_rootsTwo.graphics.endFill(false);
			hit_rootsTwo.alpha = 0.0;
			
			hit_rootsTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_rootsTwo);
		}

		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(470,65);	
			hit_roots.graphics.lineTo(541,37);	
			hit_roots.graphics.lineTo(553,184);	
			hit_roots.graphics.lineTo(472,188);	
			
			hit_roots.graphics.endFill(false);
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitPool():void{
			hit_pool = new Shape();
			hit_pool.touchable = false;
			hit_pool.graphics.beginFill(0xff0000);
			
			hit_pool.graphics.lineTo(245,394);	
			hit_pool.graphics.lineTo(594,417);	
			hit_pool.graphics.lineTo(567,478);	
			hit_pool.graphics.lineTo(290,471);	
		
			hit_pool.graphics.endFill(false);
			hit_pool.alpha = 0.0;
			
			hit_pool.graphics.precisionHitTest = true;	
			this.addChild(hit_pool);
		}
		
		private function CreateHitLight():void{
			hit_light = new Shape();
			hit_light.touchable = false;
			hit_light.graphics.beginFill(0xff0000);
			
			hit_light.graphics.lineTo(426,0);	
			hit_light.graphics.lineTo(538,0);	
			hit_light.graphics.lineTo(555,48);	
			hit_light.graphics.lineTo(468,71);	
		
			hit_light.graphics.endFill(false);
			hit_light.alpha = 0.0;
			
			hit_light.graphics.precisionHitTest = true;	
			this.addChild(hit_light);
		}
		
		
		private function CreateHitMirror():void{
			hit_mirror = new Shape();
			hit_mirror.touchable = false;
			hit_mirror.graphics.beginFill(0xff0000);
			
			hit_mirror.graphics.lineTo(322,206);	
			hit_mirror.graphics.lineTo(423,195);	
			hit_mirror.graphics.lineTo(431,272);	
			hit_mirror.graphics.lineTo(316,288);	

			hit_mirror.graphics.endFill(false);
			hit_mirror.alpha = 0.0;
			
			hit_mirror.graphics.precisionHitTest = true;	
			this.addChild(hit_mirror);
		}
		
		private function CreateHitCrystal():void{
			hit_crystal = new Shape();
			hit_crystal.touchable = false;
			hit_crystal.graphics.beginFill(0xff0000);
			
			hit_crystal.graphics.lineTo(538,243);	
			hit_crystal.graphics.lineTo(590,188);	
			hit_crystal.graphics.lineTo(656,186);	
			hit_crystal.graphics.lineTo(708,234);	
			hit_crystal.graphics.lineTo(693,291);	
			hit_crystal.graphics.lineTo(645,351);	
			hit_crystal.graphics.lineTo(600,365);	
			hit_crystal.graphics.lineTo(552,332);	

			hit_crystal.graphics.endFill(false);
			hit_crystal.alpha = 0.0;
			
			hit_crystal.graphics.precisionHitTest = true;	
			this.addChild(hit_crystal);
		}
		
		
		private function CreateHitMonster():void{
			hit_monster = new Shape();
			hit_monster.touchable = false;
			hit_monster.graphics.beginFill(0xff0000);
			
			hit_monster.graphics.lineTo(108,163);	
			hit_monster.graphics.lineTo(147,82);	
			hit_monster.graphics.lineTo(233,99);	
			hit_monster.graphics.lineTo(293,162);	
			hit_monster.graphics.lineTo(278,289);	
			hit_monster.graphics.lineTo(167,295);	
			hit_monster.graphics.lineTo(119,256);	
			
			hit_monster.graphics.endFill(false);
			hit_monster.alpha = 0.0;
			
			hit_monster.graphics.precisionHitTest = true;	
			this.addChild(hit_monster);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						
						FadeOut((CliffCave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true
						);	
					}else if(hit_monster.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CliffMonsterMonster as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffMonsterMonsterObj,true
						);
					}else if(hit_mirror.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						MirrorHandler();
					}else if(hit_crystal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						CrystalHandler();
					}else if(hit_pool.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PoolHandler();
					}else if(hit_light.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Light shines in from a small opening in the roof of the cave.");

					}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Roots tumble in through the opening.");

					}else if(hit_rootsTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Strange roots creep through cracks in the rocks.");
					}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are scratch marks and abrasions all over the walls of the cave.");
					}else if(hit_stoneTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cave shows evidence of geologic shifts.");
					}
					
					
					/*
					
					private var hit_light:Shape;
					private var hit_pool:Shape;
					private var hit_roots:Shape;
					private var hit_rootsTwo:Shape;
					hit_stone
					hit_stoneTwo
					*/
				}
			}
		}
		
		
		private function PoolHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Gourd)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_GourdWater,
					'item_GourdWater',
					'inven_gourdWater_sm',
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Gourd,
					'item_Gourd'
				);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave;
				}
				SaveArray['Gourd'] = "Filled";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
			}else{
								
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small pool of water has collected at the bottom of the cave.");
			
				
			}
			
		}
		
		private function CrystalHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PickAxe)
			{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PickAxe,
								"item_PickAxe"
							);
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'Opened'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PickAxe,
								"item_PickAxe"
							);
					}
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false )
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't remove the crystal with that item.");

				}
				CrystalPickerUpper();
			}else{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Crystal'] == 'PickedUp'){
						
					}else{
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A large red crystal is growing out of the rock.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A large red crystal is growing out of the rock.");
				}
			}
		}
		
		private function CrystalPickerUpper():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Crystal'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Smaller crystals continue to grow.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClinkOne();
					crystal.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave;
					}
					SaveArray['Crystal'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalRed,
						'item_CrystalRed',
						'inven_crystalRed_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();

				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClinkOne();
				crystal.alpha = 0;
				SaveArray['Crystal'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalRed,
					'item_CrystalRed',
					'inven_crystalRed_sm'
				);	
			}
		}
		
		private function MirrorHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave['Mirror'] == 'PickedUp'){
					
				}else{
					mirror.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterCave;
					}
					SaveArray['Mirror'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Mirror,
						'item_Mirror',
						'inven_mirror_sm'
					);	
				}
			}else{
				mirror.alpha = 0;
				SaveArray['Mirror'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterCave',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Mirror,
					'item_Mirror',
					'inven_mirror_sm'
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
			
			
			this.assets.removeTexture("cliffMonsterCave_bg",true);
			this.assets.removeTexture("CliffMonsterCave_Sprite",true);
			this.assets.removeTextureAtlas("CliffMonsterCave_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterCave_01");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterCave_02");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterCave_03");
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