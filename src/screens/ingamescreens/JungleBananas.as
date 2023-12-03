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
	import starling.utils.AssetManager;
	
	public class JungleBananas extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var bananas:Image;
		private var hit_bananas:Shape;
		private var hit_trunk:Shape;
		
		private var hit_leavesOne:Shape;
		private var hit_leavesTwo:Shape;
		private var hit_Mountain:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleBananas(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleBananas_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleBananas/jungleBananas_bg.jpg'));
				game.TrackAssets('jungleBananas_01');
			}
			if(game.CheckAsset('jungleBananas_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleBananas/JungleBananas_Sprite.png'));
				game.TrackAssets('jungleBananas_02');
			}
			if(game.CheckAsset('jungleBananas_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleBananas/JungleBananas_Sprite.xml'));
				game.TrackAssets('jungleBananas_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleBananas","JungleBananasObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleBananas_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			bananas = new Image(this.assets.getTexture('bananas'));
			bananas.touchable = false;
			bananas.x = 284;
			bananas.y = 84;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					bananas.alpha = 0;
				}
				else{
					bananas.alpha = 1;
				}
			}else{
				bananas.alpha = 1;
			}
			
			
			this.addChildAt(bananas,1);
			//FadeOutOcean(1);
			CreateHitLeavesOne();
			CreateHitLeavesTwo();
			CreateHitMountain();
			CreateHitBananas();
			CreateHitTrunk();
			
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999,2);
			},0.7);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
		}
		//hit_trunk
		//hit_leavesOne
		//hit_Mountain
		private function CreateHitMountain():void{
			hit_Mountain = new Shape();
			hit_Mountain.touchable = false;
			hit_Mountain.graphics.beginFill(0xff0000);
			
			hit_Mountain.graphics.lineTo(610,271);	
			hit_Mountain.graphics.lineTo(673,246);	
			hit_Mountain.graphics.lineTo(775,287);	
			hit_Mountain.graphics.lineTo(780,320);	
			hit_Mountain.graphics.lineTo(649,360);	
			
			hit_Mountain.graphics.endFill(false);
			hit_Mountain.alpha = 0.0;
			
			hit_Mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_Mountain);
		}
		
		private function CreateHitLeavesTwo():void{
			hit_leavesTwo = new Shape();
			hit_leavesTwo.touchable = false;
			hit_leavesTwo.graphics.beginFill(0xff0000);
			
			hit_leavesTwo.graphics.lineTo(410,85);	
			hit_leavesTwo.graphics.lineTo(446,0);	
			hit_leavesTwo.graphics.lineTo(662,0);	
			hit_leavesTwo.graphics.lineTo(656,220);	
			hit_leavesTwo.graphics.lineTo(487,360);	
						
			hit_leavesTwo.graphics.endFill(false);
			hit_leavesTwo.alpha = 0.0;
			
			hit_leavesTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_leavesTwo);
		}
		
		private function CreateHitLeavesOne():void{
			hit_leavesOne = new Shape();
			hit_leavesOne.touchable = false;
			hit_leavesOne.graphics.beginFill(0xff0000);
			
			hit_leavesOne.graphics.lineTo(0,0);	
			hit_leavesOne.graphics.lineTo(401,0);	
			hit_leavesOne.graphics.lineTo(321,250);	
			hit_leavesOne.graphics.lineTo(118,403);	
			hit_leavesOne.graphics.lineTo(83,372);	
			hit_leavesOne.graphics.lineTo(76,173);	
			hit_leavesOne.graphics.lineTo(0,65);	
			
			hit_leavesOne.graphics.endFill(false);
			hit_leavesOne.alpha = 0.0;
			
			hit_leavesOne.graphics.precisionHitTest = true;	
			this.addChild(hit_leavesOne);
		}
		
		
		private function CreateHitTrunk():void{
			hit_trunk = new Shape();
			hit_trunk.touchable = false;
			hit_trunk.graphics.beginFill(0xff0000);
			
			hit_trunk.graphics.lineTo(352,261);	
			hit_trunk.graphics.lineTo(439,202);	
			hit_trunk.graphics.lineTo(461,220);	
			hit_trunk.graphics.lineTo(515,506);	
			hit_trunk.graphics.lineTo(357,505);	

			hit_trunk.graphics.endFill(false);
			hit_trunk.alpha = 0.0;
			
			hit_trunk.graphics.precisionHitTest = true;	
			this.addChild(hit_trunk);
		}
		
		private function CreateHitBananas():void{
			hit_bananas = new Shape();
			hit_bananas.touchable = false;
			hit_bananas.graphics.beginFill(0xff0000);
			
			hit_bananas.graphics.lineTo(265,136);	
			hit_bananas.graphics.lineTo(335,53);	
			hit_bananas.graphics.lineTo(442,111);	
			hit_bananas.graphics.lineTo(436,202);	
			hit_bananas.graphics.lineTo(350,261);	
			hit_bananas.graphics.lineTo(278,207);	
		
			hit_bananas.graphics.endFill(false);
			hit_bananas.alpha = 0.0;
			
			hit_bananas.graphics.precisionHitTest = true;	
			this.addChild(hit_bananas);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleDeep as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleDeepObj,true
						);
					}else if(hit_bananas.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						BananaHandler();
					}else if(hit_trunk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						TrunkHandler();
					}else if(hit_leavesOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree's leaves are broad and waxy.");
					}else if(hit_Mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The summit in the distance.");
					}else if(hit_leavesTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Water droplets roll off the leaves.");
					}
					
					//hit_leavesOne
					//hit_Mountain
				}
			}
		}
		private function TrunkHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Ladder)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground below is steep and unstable; there's no way to safely place the ladder.");
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree trunk is long and narrow.");
			}
		}
		
		private function BananaHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Poker)
			{
				
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Poker,
						"item_Poker"
					);
				
				BananaPickerUpper();
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Ladder)
			{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground below is steep and unstable; there's no way to safely place the ladder.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground below is steep and unstable; there's no way to safely place the ladder.");
				}

			}else{
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are no more bananas...");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bananas are too high, I can't reach them !");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bananas are too high, I can't reach them !");
				}
			}
		}
		
		private function BananaPickerUpper():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					
				}else{
					bananas.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas;
					}
					SaveArray['Bananas'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleBananas',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Bananas,
						'item_Bananas',
						'inven_bananas_sm'
					);	
				}
			}else{
				bananas.alpha = 0;
				SaveArray['Bananas'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleBananas',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Bananas,
					'item_Bananas',
					'inven_bananas_sm'
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
			
			
			this.assets.removeTexture("jungleBananas_bg",true);
			this.assets.removeTexture("jungleBananas_bg",true);
			this.assets.removeTextureAtlas("JungleBananas_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleBananas_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleBananas_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleBananas_03");
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