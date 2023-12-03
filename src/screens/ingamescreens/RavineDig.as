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
	
	public class RavineDig extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var skull:Image;
		private var hand:Image;
		private var tricorder:Image;
		
		private var hit_skull:Shape;
		private var hit_hand:Shape;
		private var hit_tricorder:Shape;
		private var hit_post:Shape;
		
		private var hit_dirt:Shape;
		private var hit_suit:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineDig(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineDig_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDig/ravineDig_bg.jpg'));
				game.TrackAssets('ravineDig_01');
			}
			if(game.CheckAsset('ravineDig_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDig/RavineDig_Sprite.png'));
				game.TrackAssets('ravineDig_02');
			}
			if(game.CheckAsset('ravineDig_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDig/RavineDig_Sprite.xml'));
				game.TrackAssets('ravineDig_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineDig","RavineDigObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineDig_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			skull = new Image(this.assets.getTexture('skull_full'));
	//		skull.smoothing = TextureSmoothing.NONE;

			skull.touchable = false;
			skull.x = 146;
			skull.y = 138;
			
			
			hand = new Image(this.assets.getTexture('hand_full'));
		//	hand.smoothing = TextureSmoothing.NONE;

			hand.touchable = false;
			hand.x = 408;
			hand.y = 183;
			
			
			tricorder = new Image(this.assets.getTexture('tricorder'));
		//	tricorder.smoothing = TextureSmoothing.NONE;

			tricorder.touchable = false;
			tricorder.x = 461;
			tricorder.y = 272;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
					skull.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'Opened'){
					skull.texture = this.assets.getTexture('skull_half');
					skull.alpha = 1;
				}else{
					skull.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'PickedUp'){
					hand.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'Opened'){
					hand.texture = this.assets.getTexture('hand_half');
					hand.alpha = 1;
				}else{
					hand.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Tricorder'] == 'PickedUp'){
					tricorder.alpha = 0;
				}else{
					tricorder.alpha = 1;
				}
			}else{
				skull.alpha = 1;
				hand.alpha = 1;
				tricorder.alpha = 1;
			}
			
			this.addChildAt(skull,1);
			this.addChildAt(hand,2);
			this.addChildAt(tricorder,3);
			
			
			CreateDirtHit();
			CreatePostHit();
			CreateSuitHit();
			CreateHandHit();
			CreateTricorderHit();
			CreateSkullHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'BirdsOne';
			},0.7);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
					},0.5);
				}
			}

		}
		//hit_post
		private function CreatePostHit():void{
			hit_post = new Shape();
			hit_post.touchable = false;
			hit_post.graphics.beginFill(0xff0000);
			
			hit_post.graphics.lineTo(0,0);	
			hit_post.graphics.lineTo(40,0);	
			hit_post.graphics.lineTo(91,373);	
			hit_post.graphics.lineTo(45,370);	
			
			hit_post.alpha = 0.0;
			
			hit_post.graphics.precisionHitTest = true;	
			this.addChild(hit_post);
		}
		
		private function CreateSuitHit():void{
			hit_suit = new Shape();
			hit_suit.touchable = false;
			hit_suit.graphics.beginFill(0xff0000);
			
			hit_suit.graphics.lineTo(95,273);	
			hit_suit.graphics.lineTo(341,174);	
			hit_suit.graphics.lineTo(431,162);	
			hit_suit.graphics.lineTo(465,195);	
			hit_suit.graphics.lineTo(413,218);	
			hit_suit.graphics.lineTo(388,213);	
			hit_suit.graphics.lineTo(218,290);	
			hit_suit.graphics.lineTo(146,302);	
			
			hit_suit.alpha = 0.0;
			
			hit_suit.graphics.precisionHitTest = true;	
			this.addChild(hit_suit);
		}
		
		private function CreateDirtHit():void{
			hit_dirt = new Shape();
			hit_dirt.touchable = false;
			hit_dirt.graphics.beginFill(0xff0000);
			
			hit_dirt.graphics.lineTo(65,150);	
			hit_dirt.graphics.lineTo(266,104);	
			hit_dirt.graphics.lineTo(683,119);	
			hit_dirt.graphics.lineTo(773,344);	
			hit_dirt.graphics.lineTo(576,506);	
			hit_dirt.graphics.lineTo(263,505);	
			
			hit_dirt.alpha = 0.0;
			
			hit_dirt.graphics.precisionHitTest = true;	
			this.addChild(hit_dirt);
		}
		
		private function CreateTricorderHit():void{
			hit_tricorder = new Shape();
			hit_tricorder.touchable = false;
			hit_tricorder.graphics.beginFill(0xff0000);
			
			hit_tricorder.graphics.lineTo(455,331);	
			hit_tricorder.graphics.lineTo(533,252);	
			hit_tricorder.graphics.lineTo(630,289);	
			hit_tricorder.graphics.lineTo(633,312);	
			hit_tricorder.graphics.lineTo(548,406);	
			
			hit_tricorder.alpha = 0.0;
			
			hit_tricorder.graphics.precisionHitTest = true;	
			this.addChild(hit_tricorder);
		}
		
		private function CreateHandHit():void{
			hit_hand = new Shape();
			hit_hand.touchable = false;
			hit_hand.graphics.beginFill(0xff0000);
			
			hit_hand.graphics.lineTo(396,200);	
			hit_hand.graphics.lineTo(477,164);	
			hit_hand.graphics.lineTo(535,207);	
			hit_hand.graphics.lineTo(538,227);	
			hit_hand.graphics.lineTo(476,279);	
			hit_hand.graphics.lineTo(401,271);	

			hit_hand.alpha = 0.0;
			
			hit_hand.graphics.precisionHitTest = true;	
			this.addChild(hit_hand);
		}
		
		private function CreateSkullHit():void{
			hit_skull = new Shape();
			hit_skull.touchable = false;
			hit_skull.graphics.beginFill(0xff0000);
			
			hit_skull.graphics.lineTo(156,163);	
			hit_skull.graphics.lineTo(242,138);	
			hit_skull.graphics.lineTo(326,177);	
			hit_skull.graphics.lineTo(363,231);	
			hit_skull.graphics.lineTo(373,264);	
			hit_skull.graphics.lineTo(344,298);	
			hit_skull.graphics.lineTo(238,288);	
			hit_skull.graphics.lineTo(170,256);	
	
			hit_skull.alpha = 0.0;
			
			hit_skull.graphics.precisionHitTest = true;	
			this.addChild(hit_skull);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleRavine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						);
					}else if(hit_skull.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						SkullHandler();
					}else if(hit_hand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						HandHandler();
					}else if(hit_tricorder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						TricorderHandler();
					}else if(hit_suit.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The suit of the being is made from material I've never seen. It hasn't aged at all.");
					}else if(hit_post.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wooden posts indicate this was an archeological site.");
					}else if(hit_dirt.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This area looks recently unearthed.");
					}
					
					//hit_dirt
					//hit_suit
				}
			}
		}
		
		private function SkullHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder how long the skull was in the ground... but..?");

				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'Opened'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					skull.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
					}
					SaveArray['Skull'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AlienHand,
						'item_Alien',
						'inven_alien_sm'
					);	
				}else{
					SkullItemHandler();
				}
			}else{
				SkullItemHandler();
			}
		}
		
		
		private function SkullItemHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Trowel)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelTwo();
				
				skull.texture = this.assets.getTexture('skull_half')
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'PickedUp'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Trowel,
								"item_Trowel"
							);
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'Opened'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Trowel,
								"item_Trowel"
							);
					}
					
				}
				SaveArray['Skull'] = 'Opened';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SculptTools)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmm... I need something better for removing soil than sculpting tools.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Shovel)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shovel is too crude, it will certainly damage the skull.");
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A elongated skull. It is very fragile. I'll need to remove the soil before trying to take it out.");
			}
		}
		
		
		
		
		private function HandHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The imprint of the hand is still visible.");
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'Opened'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					hand.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
					}
					SaveArray['Hand'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AlienHand,
						'item_AlienHand',
						'inven_alienHand_sm'
					);	
				}else{
					HandItemHandler();
				}
			}else{
				HandItemHandler();
			}
		}
		
		
		
		
		
		private function HandItemHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Trowel)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelTwo();
			
				hand.texture = this.assets.getTexture('hand_half')
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Trowel,
								"item_Trowel"
							);
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'Opened'){
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Trowel,
								"item_Trowel"
							);
					}
					
				}
				SaveArray['Hand'] = 'Opened';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);

				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SculptTools)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmm... I need something better for removing soil than the sculpting tools.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Shovel)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Using the shovel would destroy the delicate hand bones.");
			
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These bones are very delicate. I'll need to remove the soil before trying to take them out.");
			}
		}
		
		private function TricorderHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Tricorder'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole left by the device.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
					
					tricorder.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig;
					}
					SaveArray['Tricorder'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Tricorder,
						'item_Tricorder',
						'inven_tricorder_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
				
				tricorder.alpha = 0;
				SaveArray['Tricorder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDig',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Tricorder,
					'item_Tricorder',
					'inven_tricorder_sm'
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
			
			
			this.assets.removeTexture("ravineDig_bg",true);
			this.assets.removeTexture("RavineDig_Sprite",true);
			this.assets.removeTextureAtlas("RavineDig_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineDig_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineDig_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineDig_03");
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
