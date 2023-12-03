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
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class CliffMonsterMonster extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var bananas:Image;
		private var fish:Image;
		private var apple:Image;
		private var potatoes:Image;
		private var dragonball:Image;
		
		private var hand_bananas_mc:MovieClip;
		private var hand_apple_mc:MovieClip;
		private var hand_fish_mc:MovieClip;
		private var hand_dragonball_mc:MovieClip;
		private var eyes_mc:MovieClip;
		
		private var PhraseCounter:int = 0;
		
		private var hit_hole:Shape;
		private var hit_foods:Shape;
		
		private var Animating:Boolean = false;
		private var BananasAttached:Boolean = false;
		private var FishAttached:Boolean = false;
		private var AppleAttached:Boolean = false;
		private var PotatoesAttached:Boolean = false;
		private var DragonBallAttached:Boolean = false;
		private var Solved:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		public var delayedcall:DelayedCall;
		
		private var goback:GoBackButton;		
		
		
		
		public function CliffMonsterMonster(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cliffMonsterMonster_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterMonster/cliffMonsterMonster_bg.jpg'));
				game.TrackAssets('cliffMonsterMonster_01');
			}
			if(game.CheckAsset('cliffMonsterMonster_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterMonster/CliffMonsterMonster_Sprite_01.atf'));
				game.TrackAssets('cliffMonsterMonster_02');
			}
			if(game.CheckAsset('cliffMonsterMonster_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterMonster/CliffMonsterMonster_Sprite_01.xml'));
				game.TrackAssets('cliffMonsterMonster_03');
			}
			if(game.CheckAsset('cliffMonsterMonster_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterMonster/CliffMonsterMonster_Sprite_02.png'));
				game.TrackAssets('cliffMonsterMonster_04');
			}
			if(game.CheckAsset('cliffMonsterMonster_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffMonsterMonster/CliffMonsterMonster_Sprite_02.xml'));
				game.TrackAssets('cliffMonsterMonster_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CliffMonsterMonster","CliffMonsterMonsterObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*
			SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
			SaveArray['FirstTime'] = 'Yes';
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
		
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Fish,
				'item_Fish',
				'inven_fish_sm'
			);
			*/
			bg = new Image(this.assets.getTexture('cliffMonsterMonster_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			bananas = new Image(this.assets.getTexture('bananas'));
			bananas.smoothing = TextureSmoothing.NONE;
			bananas.touchable = false;
			bananas.x = 337;
			bananas.y = 323;
		
			hand_bananas_mc = new MovieClip(this.assets.getTextures("hand_00"),6);
			hand_bananas_mc.x = 280;
			hand_bananas_mc.y = 269;
			hand_bananas_mc.touchable = false;
			hand_bananas_mc.loop = true; 
	
			hand_bananas_mc.addFrameAt(1,this.assets.getTexture("hand_01"), null, 0.15);
			hand_bananas_mc.addFrameAt(2,this.assets.getTexture("hand_02"), null, 0.15);
			hand_bananas_mc.addFrameAt(3,this.assets.getTexture("hand_03"), null, 0.15);
			hand_bananas_mc.addFrameAt(4,this.assets.getTexture("hand_04"), null, 0.15);
			hand_bananas_mc.addFrameAt(5,this.assets.getTexture("hand_05"), null, 0.3);
			hand_bananas_mc.addFrameAt(6,this.assets.getTexture("handBanana_06"), null, 0.2);
			hand_bananas_mc.addFrameAt(7,this.assets.getTexture("handBanana_07"), null, 0.15);
			hand_bananas_mc.addFrameAt(8,this.assets.getTexture("handBanana_08"), null, 0.15);
			hand_bananas_mc.addFrameAt(9,this.assets.getTexture("handBanana_09"), null, 0.15);
	
			
		

			apple = new Image(this.assets.getTexture('apple'));
			apple.smoothing = TextureSmoothing.NONE;
			apple.touchable = false;
			apple.x = 378;
			apple.y = 364;
			
			
			hand_apple_mc = new MovieClip(this.assets.getTextures("hand_00"),6);

			hand_apple_mc.x = 280;
			hand_apple_mc.y = 269;
			hand_apple_mc.touchable = false;
			hand_apple_mc.loop = false; 
				
			hand_apple_mc.addFrameAt(1,this.assets.getTexture("hand_01"), null, 0.15);
			hand_apple_mc.addFrameAt(2,this.assets.getTexture("hand_02"), null, 0.15);
			hand_apple_mc.addFrameAt(3,this.assets.getTexture("hand_03"), null, 0.15);
			hand_apple_mc.addFrameAt(4,this.assets.getTexture("hand_04"), null, 0.15);
			hand_apple_mc.addFrameAt(5,this.assets.getTexture("hand_05"), null, 0.3);
			hand_apple_mc.addFrameAt(6,this.assets.getTexture("handApple_06"), null, 0.2);
			hand_apple_mc.addFrameAt(7,this.assets.getTexture("handApple_07"), null, 0.15);
			hand_apple_mc.addFrameAt(8,this.assets.getTexture("handApple_08"), null, 0.15);
			hand_apple_mc.addFrameAt(9,this.assets.getTexture("handApple_09"), null, 0.15);
				
	
			fish = new Image(this.assets.getTexture('fish'));
			fish.smoothing = TextureSmoothing.NONE;
			fish.touchable = false;
			fish.x = 304;
			fish.y = 382;
		
			hand_fish_mc = new MovieClip(this.assets.getTextures("hand_00"),6);
			hand_fish_mc.x = 280;
			hand_fish_mc.y = 269;
			hand_fish_mc.touchable = false;
			hand_fish_mc.loop = false; 
			
			hand_fish_mc.addFrameAt(1,this.assets.getTexture("hand_01"), null, 0.15);
			hand_fish_mc.addFrameAt(2,this.assets.getTexture("hand_02"), null, 0.15);
			hand_fish_mc.addFrameAt(3,this.assets.getTexture("hand_03"), null, 0.15);
			hand_fish_mc.addFrameAt(4,this.assets.getTexture("hand_04"), null, 0.15);
			hand_fish_mc.addFrameAt(5,this.assets.getTexture("hand_05"), null, 0.3);
			hand_fish_mc.addFrameAt(6,this.assets.getTexture("handFish_06"), null, 0.2);
			hand_fish_mc.addFrameAt(7,this.assets.getTexture("handFish_07"), null, 0.15);
			hand_fish_mc.addFrameAt(8,this.assets.getTexture("handFish_08"), null, 0.15);
			hand_fish_mc.addFrameAt(9,this.assets.getTexture("handFish_09"), null, 0.15);
			

			eyes_mc = new MovieClip(this.assets.getTextures("eyes_03"),3);
			eyes_mc.smoothing = TextureSmoothing.NONE;
			eyes_mc.x = 371;
			eyes_mc.y = 182;
			
			eyes_mc.touchable = false;
			eyes_mc.loop = true; 
			
			eyes_mc.addFrameAt(1,this.assets.getTexture("eyes_02"), null, 0.1);
			eyes_mc.addFrameAt(2,this.assets.getTexture("eyes_01"), null, 0.1);
			eyes_mc.addFrameAt(3,this.assets.getTexture("eyes_00"), null, 5.0);			
			eyes_mc.addFrameAt(4,this.assets.getTexture("eyes_01"), null, 0.1);
			eyes_mc.addFrameAt(5,this.assets.getTexture("eyes_02"), null, 0.1);
			eyes_mc.addFrameAt(6,this.assets.getTexture("eyes_03"), null, 1.0);	
			eyes_mc.addFrameAt(7,this.assets.getTexture("eyes_02"), null, 0.1);
			eyes_mc.addFrameAt(8,this.assets.getTexture("eyes_01"), null, 0.1);
			eyes_mc.addFrameAt(9,this.assets.getTexture("eyes_00"), null, 2.0);
			eyes_mc.addFrameAt(10,this.assets.getTexture("eyes_01"), null, 0.1);
			eyes_mc.addFrameAt(11,this.assets.getTexture("eyes_02"), null, 0.1);
			eyes_mc.addFrameAt(12,this.assets.getTexture("eyes_03"), null, 1.0);
			
			potatoes = new Image(this.assets.getTexture('potatos'));
			potatoes.smoothing = TextureSmoothing.NONE;
			potatoes.touchable = false;
			potatoes.x = 348;
			potatoes.y = 339;
						
			dragonball = new Image(this.assets.getTexture('dragonball'));
			dragonball.smoothing = TextureSmoothing.NONE;
			dragonball.touchable = false;
			dragonball.x = 346;
			dragonball.y = 310;
			
			
			hand_dragonball_mc = new MovieClip(this.assets.getTextures("handDragonball_01"),6);
			hand_dragonball_mc.x = 267;
			hand_dragonball_mc.y = 259;
			hand_dragonball_mc.touchable = false;
			hand_dragonball_mc.loop = false; 
			
			hand_dragonball_mc.addFrameAt(1,this.assets.getTexture("handDragonball_02"), null, 0.15);
			hand_dragonball_mc.addFrameAt(2,this.assets.getTexture("handDragonball_03"), null, 0.15);
			hand_dragonball_mc.addFrameAt(3,this.assets.getTexture("handDragonball_04"), null, 0.3);
			hand_dragonball_mc.addFrameAt(4,this.assets.getTexture("handDragonball_05"), null, 0.2);
			hand_dragonball_mc.addFrameAt(5,this.assets.getTexture("handDragonball_06"), null, 0.15);
			hand_dragonball_mc.addFrameAt(6,this.assets.getTexture("handDragonball_07"), null, 0.15);
			hand_dragonball_mc.addFrameAt(7,this.assets.getTexture("handDragonball_08"), null, 0.15);
			hand_dragonball_mc.addFrameAt(8,this.assets.getTexture("handDragonball_09"), null, 0.15);
			hand_dragonball_mc.addFrameAt(9,this.assets.getTexture("handDragonball_10"), null, 0.15);
			
			
			hand_bananas_mc.stop();
			hand_apple_mc.stop();
			hand_fish_mc.stop();
			hand_dragonball_mc.stop();
			eyes_mc.play();
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Potatoes'] == 'Attached'){
					PotatoesAttached = true;
					potatoes.alpha = 1;
				}else{
					potatoes.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Fish'] == 'Attached'){
					FishAttached = true;
				}else{
					
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Apple'] == 'Attached'){
					AppleAttached = true;
				}else{
					
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Bananas'] == 'Attached'){
					BananasAttached = true;
				}else{
					
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'Attached'){
					DragonBallAttached = true;
					dragonball.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'PickedUp'){
					dragonball.alpha = 0;
				}else{
					dragonball.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['Solved'] == 'Yes'){
					Solved = true;
					eyes_mc.alpha = 0;
					eyes_mc.stop();
				}else{
					eyes_mc.alpha = 1;
				}
				
			}else{
				potatoes.alpha = 0;
				dragonball.alpha = 0;
				eyes_mc.alpha = 1;
			}
			
			
			bananas.alpha = 0;
			hand_bananas_mc.alpha = 0; 
			apple.alpha = 0;
			hand_apple_mc.alpha = 0; 
			fish.alpha = 0;
			hand_fish_mc.alpha = 0; 
			
			
			
			hand_dragonball_mc.alpha = 0;
			
			//	Starling.juggler.add(hand_bananas_mc);
			//	Starling.juggler.add(hand_apple_mc);
			//	Starling.juggler.add(hand_fish_mc);
			Starling.juggler.add(hand_dragonball_mc);
			Starling.juggler.add(eyes_mc);
			
			this.addChildAt(bananas,1);
			this.addChildAt(hand_bananas_mc,2);			
			this.addChildAt(apple,3);			
			this.addChildAt(hand_apple_mc,4);		
			this.addChildAt(fish,5);		
			this.addChildAt(hand_fish_mc,6);			
			this.addChildAt(eyes_mc,7);			
			this.addChildAt(potatoes,8);	
			this.addChildAt(dragonball,9);	
			this.addChildAt(hand_dragonball_mc,10);	

			CreateHitFood();
			CreateHitHole();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
				
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
			
			
			
		}
		private function CreateHitHole():void{
			hit_hole = new Shape();
			hit_hole.touchable = false;
			hit_hole.graphics.beginFill(0x00ff00);
			
			hit_hole.graphics.lineTo(160,154);	
			hit_hole.graphics.lineTo(302,16);	
			hit_hole.graphics.lineTo(515,21);	
			hit_hole.graphics.lineTo(644,158);	
			hit_hole.graphics.lineTo(660,256);	
			hit_hole.graphics.lineTo(628,334);	
			hit_hole.graphics.lineTo(472,293);	
			hit_hole.graphics.lineTo(382,289);	
			hit_hole.graphics.lineTo(255,326);	

			hit_hole.graphics.endFill(false);
			hit_hole.alpha = 0.0;
			
			hit_hole.graphics.precisionHitTest = true;	
			this.addChild(hit_hole);
		}
		
		private function CreateHitFood():void{
			hit_foods = new Shape();
			hit_foods.touchable = false;
			hit_foods.graphics.beginFill(0xff0000);
			
			hit_foods.graphics.lineTo(258,334);	
			hit_foods.graphics.lineTo(381,297);	
			hit_foods.graphics.lineTo(466,299);	
			hit_foods.graphics.lineTo(636,345);	
			hit_foods.graphics.lineTo(641,412);	
			hit_foods.graphics.lineTo(518,506);	
			hit_foods.graphics.lineTo(359,507);	
			hit_foods.graphics.lineTo(263,423);	
	
			hit_foods.graphics.endFill(false);
			hit_foods.alpha = 0.0;
			
			hit_foods.graphics.precisionHitTest = true;	
			this.addChild(hit_foods);
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
							FadeOut((CliffMonsterCave as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffMonsterCaveObj,true
							);
						}else if(hit_foods.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PotatoesAttached === false){
								if(DragonBallAttached === false){
									FoodHandler();
								}else{
									DragonBallHandler();
								}
							}else{
								if(DragonBallAttached === false){
									PotatoHandler();
								}else{
									DragonBallHandler();
								}
							}
							
						}else if(hit_hole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HoleHandlder();
						}
					}
				}
			}
		}
		private function HoleHandlder():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Fish)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlTwo();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe I should leave the fish on the ground for it?");

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Bananas)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe I should leave the bananas on the ground for it?");

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Apple)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlTwo();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe I should leave the apple on the ground for it?");

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Potatoes)
			{	
				if(Solved === false){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe it likes potatoes...?");

				}else{
					
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_BlowTorchLit)
			{	
				if(Solved === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlDeep();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Using the blowtorch probably isn't a good idea...");

				}else{
					
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_BlowTorch)
			{		
				if(Solved === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlDeep();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Even if the blowtorch was working, that still isn't a good idea...");
					
				}else{
					
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Poker)
			{	
				if(Solved === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlDeep();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think that's a good idea...");
					
				}else{
					
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				!= false)
			{	
				if(Solved === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlDeep();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It doesn't seem interested in that item...");
					
				}else{
					
				}
			}else{
				if(Solved === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlDeep();
					
					if(PhraseCounter == 0){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("...um ...");
						PhraseCounter = 1;
					}else if(PhraseCounter == 1){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("...ahh ...");
						PhraseCounter = 2;
					}else if(PhraseCounter == 2){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's staring at me with glowing green eyes...");
						PhraseCounter = 3;
					}else if(PhraseCounter == 3){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Not in a good mood...");
						PhraseCounter = 4;
					}else if(PhraseCounter == 4){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm not going in there.");
						PhraseCounter = 0;
					}
					
				}else{
					if(PhraseCounter == 0){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The creature is gone.");
						PhraseCounter = 1;
					}else if(PhraseCounter == 1){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder where it went ?");
						PhraseCounter = 2;
					}else if(PhraseCounter == 2){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe it's sleeping off the food.");
						PhraseCounter = 3;
					}else if(PhraseCounter == 3){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It really wasn't that scary... Oh! What was that ?");
						PhraseCounter = 4;
					}else if(PhraseCounter == 4){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe I have a friend.... maybe?");
						PhraseCounter = 0;
					}
				}
			}
		}
		
		private function DragonBallHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			dragonball.alpha = 0;
			DragonBallAttached = false;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
			}
			SaveArray["DragonBall"] = "PickedUp";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallSeven,
				'item_DragonBallSeven',
				'inven_dragonBallSeven_sm'
			);
		}
		
		private function PotatoHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					potatoes.alpha = 0;
					PotatoesAttached = false;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
					}
					SaveArray["Potatoes"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Potatoes,
						'item_Potatoes',
						'inven_potatoes_sm'
					);
			
		}
		
		private function FoodHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Fish)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				FishAttached = true;
				fish.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Fish,
						"item_Fish"
					);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
				}
				SaveArray['Fish'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
				
				
				delayedcall = new DelayedCall(function():void{
					FoodAnimator('FISH');
					delayedcall = null;
				},2);
				Starling.juggler.add(delayedcall)
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Bananas)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				BananasAttached = true;
				bananas.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Bananas,
						"item_Bananas"
					);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
				}
				SaveArray["Bananas"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
				
				delayedcall = new DelayedCall(function():void{
					FoodAnimator('BANANAS');
					delayedcall = null;
				},2);
				Starling.juggler.add(delayedcall)
				
				

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Apple)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				AppleAttached = true;
				apple.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Apple,
						"item_Apple"
					);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
				}
				SaveArray["Apple"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
				
				delayedcall = new DelayedCall(function():void{
					FoodAnimator('APPLE');
					delayedcall = null;
				},2);
				Starling.juggler.add(delayedcall)
					
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Potatoes)
			{	
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
				}
				SaveArray["Potatoes"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
				
				PotatoesAttached = true;
				potatoes.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Potatoes,
						"item_Potatoes"
					);
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is empty space at the opening of the cave.");

			}
			
		}
		
		
		private function FoodAnimator(Food:String):void{
			if(Food === 'FISH'){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlTwo();
				this.addEventListener(EnterFrameEvent.ENTER_FRAME,removeFish);
				hand_fish_mc.addEventListener(Event.COMPLETE, completeFish);
				hand_fish_mc.alpha = 1;
				hand_fish_mc.play();
				Starling.juggler.add(hand_fish_mc);
			}else if(Food === 'BANANAS'){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlOne();
				this.addEventListener(EnterFrameEvent.ENTER_FRAME,removeBananas);
				hand_bananas_mc.addEventListener(Event.COMPLETE, completeBananas);
				hand_bananas_mc.alpha = 1;
				hand_bananas_mc.play();
				Starling.juggler.add(hand_bananas_mc);
			}else if(Food === 'APPLE'){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrowlTwo();
				this.addEventListener(EnterFrameEvent.ENTER_FRAME,removeApple);
				hand_apple_mc.addEventListener(Event.COMPLETE, completeApple);
				hand_apple_mc.alpha = 1;
				hand_apple_mc.play();
				Starling.juggler.add(hand_apple_mc);
			}
		}
		
		private function removeFish(e:Event):void{
			if(hand_fish_mc.currentFrame == 6){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
				this.removeEventListener(EnterFrameEvent.ENTER_FRAME,removeFish);
				fish.alpha = 0;				
			}
		}
		private function completeFish(e:Event):void{
			PlayMonsterBeat();
			hand_fish_mc.removeEventListener(Event.COMPLETE, completeFish);
			hand_fish_mc.stop();
			hand_fish_mc.alpha = 0;
		//	Starling.juggler.purge();
			Starling.juggler.add(eyes_mc);
			Solve();
		}
		
		private function removeBananas(e:Event):void{
			if(hand_bananas_mc.currentFrame == 6){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
				this.removeEventListener(EnterFrameEvent.ENTER_FRAME,removeBananas);
				bananas.alpha = 0;				
			}
		}
		private function completeBananas(e:Event):void{
			PlayMonsterBeat();
			hand_bananas_mc.removeEventListener(Event.COMPLETE, completeBananas);
			hand_bananas_mc.stop();
			hand_bananas_mc.alpha = 0;
		//	Starling.juggler.purge();
			Starling.juggler.add(eyes_mc);
			Solve();
		}
		
		private function removeApple(e:Event):void{
			if(hand_apple_mc.currentFrame == 6){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
				this.removeEventListener(EnterFrameEvent.ENTER_FRAME,removeApple);
				apple.alpha = 0;				
			}
		}
		private function completeApple(e:Event):void{
			PlayMonsterBeat();
			hand_apple_mc.removeEventListener(Event.COMPLETE, completeApple);
			hand_apple_mc.stop();
			hand_apple_mc.alpha = 0;
		//	Starling.juggler.purge();
			Starling.juggler.add(eyes_mc);
			Solve();
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
		
		
		private function Solve():void{
			if(FishAttached === true){
				if(AppleAttached === true){
					if(BananasAttached === true){
						DragonBallAttached = true;
						Solved = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
						}
						SaveArray["DragonBall"] = "Attached";
						SaveArray["Solved"] = "Yes";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
						
						delayedcall = new DelayedCall(function():void{
							DragonballAnimator();
							delayedcall = null;
							
						},2);
						Starling.juggler.add(delayedcall)
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Chewing();
						Animating = false;
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Chewing();
					Animating = false;
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Chewing();
				Animating = false;
			}
		}
		
		private function DragonballAnimator():void{
			this.addEventListener(EnterFrameEvent.ENTER_FRAME,AddDragonBall);
			hand_dragonball_mc.addEventListener(Event.COMPLETE, completeDragonball);
			hand_dragonball_mc.alpha = 1;
			hand_dragonball_mc.play();
			Starling.juggler.add(hand_dragonball_mc);
		}
		
		private function AddDragonBall(e:Event):void{
			if(hand_dragonball_mc.currentFrame == 4){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				this.removeEventListener(EnterFrameEvent.ENTER_FRAME,AddDragonBall);
				dragonball.alpha = 1;				
			}
		}
		private function completeDragonball(e:Event):void{
			hand_dragonball_mc.removeEventListener(Event.COMPLETE, completeDragonball);
			hand_dragonball_mc.stop();
			hand_dragonball_mc.alpha = 0;
			eyes_mc.loop = false;
			eyes_mc.currentFrame = 8;
			Starling.juggler.purge();
			Starling.juggler.add(eyes_mc);
			Animating = false;
			
		}
		
		private function PlayMonsterBeat():void{
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster['MonsterBeat'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffMonsterMonster;
						SaveArray['MonsterBeat'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMonsterBeat(true,0);
						//	Starling.juggler.purge();
						},2.0);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['MonsterBeat'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffMonsterMonster',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMonsterBeat(true,0);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
						//Starling.juggler.purge();
					},2.0);
				}
			}
			
		}
		
		
		public function Exit(blackOut:Boolean = false):void{
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("cliffMonsterMonster_bg",true);
			this.assets.removeTexture("CliffMonsterMonster_Sprite_01",true);
			this.assets.removeTextureAtlas("CliffMonsterMonster_Sprite_01",true);
			this.assets.removeTexture("CliffMonsterMonster_Sprite_02",true);
			this.assets.removeTextureAtlas("CliffMonsterMonster_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterMonster_01");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterMonster_02");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterMonster_03");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterMonster_04");
			(stage.getChildAt(0) as Object).falseAsset("cliffMonsterMonster_05");
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