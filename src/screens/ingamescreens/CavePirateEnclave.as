package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;
	public class CavePirateEnclave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var plank:Image;
		private var skullChest_lid:Image;
		private var skullCoin_left:Image;
		private var skullCoin_right:Image;
		private var rightBarrel_hole:Image;
		private var rightBarrel_lid:Image;
		private var leftBarrel_lid:Image;
		
		
		
		private var hit_plank:Shape;
		private var hit_barrels:Shape;
		private var hit_chest:Shape;
	
		private var hit_wall:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CavePirateEnclave(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cavePirateEnclave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateEnclave/cavePirateEnclave_bg.jpg'));
				game.TrackAssets('cavePirateEnclave_01');
			}
			if(game.CheckAsset('cavePirateEnclave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateEnclave/CavePirateEnclave_Sprite.atf'));
				game.TrackAssets('cavePirateEnclave_02');
			}
			if(game.CheckAsset('cavePirateEnclave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateEnclave/CavePirateEnclave_Sprite.xml'));
				game.TrackAssets('cavePirateEnclave_03');
			}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateEnclave","CavePirateEnclaveObj");
				} 				
			});	

		}

		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cavePirateEnclave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			plank = new Image(this.assets.getTexture('plank'));
			plank.smoothing = TextureSmoothing.NONE;
			plank.touchable = false;
			plank.x = 577;
			plank.y = 104;
		
			skullChest_lid = new Image(this.assets.getTexture('skullChest_lid'));
			skullChest_lid.smoothing = TextureSmoothing.NONE;
			skullChest_lid.touchable = false;
			skullChest_lid.x = 338;
			skullChest_lid.y = 126;
						
			leftBarrel_lid = new Image(this.assets.getTexture('barrel_left_lid'));
			leftBarrel_lid.smoothing = TextureSmoothing.NONE;
			leftBarrel_lid.touchable = false;
			leftBarrel_lid.x = 68;
			leftBarrel_lid.y = 273;
						
			rightBarrel_hole = new Image(this.assets.getTexture('barrel_right_open'));
			rightBarrel_hole.smoothing = TextureSmoothing.NONE;
			rightBarrel_hole.touchable = false;
			rightBarrel_hole.x = 183;
			rightBarrel_hole.y = 192;
					
			rightBarrel_lid = new Image(this.assets.getTexture('barrel_right_lid'));
			rightBarrel_lid.smoothing = TextureSmoothing.NONE;
			rightBarrel_lid.touchable = false;
			rightBarrel_lid.x = 311;
			rightBarrel_lid.y = 275;
			
			skullCoin_left = new Image(this.assets.getTexture('chest_coin_left'));
			skullCoin_left.smoothing = TextureSmoothing.NONE;
			skullCoin_left.touchable = false;
			skullCoin_left.x = 415;
			skullCoin_left.y = 187;
			
			skullCoin_right = new Image(this.assets.getTexture('chest_coin_right'));
			skullCoin_right.smoothing = TextureSmoothing.NONE;
			skullCoin_right.touchable = false;
			skullCoin_right.x = 433;
			skullCoin_right.y = 190;
			
			/*
			private var skullCoin_left:Image;
			private var skullCoin_right:Image;
			*/
			//FadeOutOcean(1);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateEnclave != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateEnclave["Plank"] == "PickedUp"){
					plank.alpha = 0;
				}else{
					plank.alpha = 1;
				}
			}else{
				plank.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Lid'] == 'Open'){
					skullChest_lid.alpha = 0;
					skullCoin_right.alpha = 0;
					skullCoin_left.alpha = 0;
				}else{
					skullChest_lid.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['CoinRight'] == 'Attached'){
						trace("BARK 1");
						skullCoin_left.alpha = 1;
					}else{
						trace("BARK 2");
						skullCoin_left.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['CoinLeft'] == 'Attached'){
						trace("BARK 3");
						skullCoin_right.alpha = 1;
					}else{
						trace("BARK 4");
						skullCoin_right.alpha = 0;
					}
				}
			}else{
				skullChest_lid.alpha = 1;
				skullCoin_right.alpha = 0;
				skullCoin_left.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Right'] == 'Open'){
					rightBarrel_hole.alpha = 1;
					rightBarrel_lid.alpha = 1;
				}else{
					rightBarrel_hole.alpha = 0;
					rightBarrel_lid.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Left'] == 'Open'){
					leftBarrel_lid.alpha = 1;
				}else{
					leftBarrel_lid.alpha = 0;
				}
			}else{
				
				leftBarrel_lid.alpha = 0;
				
				rightBarrel_hole.alpha = 0;
				rightBarrel_lid.alpha = 0;
			}
				
	
		

			this.addChildAt(plank,1);
			this.addChildAt(skullChest_lid,2);
			this.addChildAt(leftBarrel_lid,3);
			this.addChildAt(rightBarrel_hole,4);
			this.addChildAt(rightBarrel_lid,5);
			this.addChildAt(skullCoin_left,6);
			this.addChildAt(skullCoin_right,7);
			
			CreateWallHit();
			CreatePlankHit();
			CreateChestHit();
			CreateBarrelsHit();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
		}
		//hit_wall
		private function CreateWallHit():void{
			hit_wall = new Shape();
			hit_wall.touchable = false;
			hit_wall.graphics.beginFill(0xff0000);
			
			hit_wall.graphics.lineTo(552,80);	
			hit_wall.graphics.lineTo(795,133);	
			hit_wall.graphics.lineTo(791,369);	
			hit_wall.graphics.lineTo(555,311);	
			hit_wall.graphics.lineTo(566,231);	
		
			hit_wall.graphics.endFill(false);
			
			hit_wall.alpha = 0.0;
			
			hit_wall.graphics.precisionHitTest = true;	
			this.addChild(hit_wall);
		}
		
		
		private function CreatePlankHit():void{
			hit_plank = new Shape();
			hit_plank.touchable = false;
			hit_plank.graphics.beginFill(0xff0000);
			
			hit_plank.graphics.lineTo(617,119);	
			hit_plank.graphics.lineTo(645,97);	
			hit_plank.graphics.lineTo(723,124);	
			hit_plank.graphics.lineTo(658,408);	
			hit_plank.graphics.lineTo(573,411);	
			hit_plank.graphics.lineTo(553,376);	
			
			hit_plank.graphics.endFill(false);
			
			hit_plank.alpha = 0.0;
			
			hit_plank.graphics.precisionHitTest = true;	
			this.addChild(hit_plank);
		}
		
		
		private function CreateChestHit():void{
			hit_chest = new Shape();
			hit_chest.touchable = false;
			hit_chest.graphics.beginFill(0xff0000);
			
			hit_chest.graphics.lineTo(325,164);	
			hit_chest.graphics.lineTo(353,133);	
			hit_chest.graphics.lineTo(531,160);	
			hit_chest.graphics.lineTo(554,248);	
			hit_chest.graphics.lineTo(550,293);	
			hit_chest.graphics.lineTo(373,289);	
			hit_chest.graphics.lineTo(324,246);	
			hit_chest.graphics.lineTo(324,245);	
			hit_chest.graphics.lineTo(315,201);	
			
			hit_chest.graphics.endFill(false);
			
			hit_chest.alpha = 0.0;
			
			hit_chest.graphics.precisionHitTest = true;	
			this.addChild(hit_chest);
		}
		
		
		private function CreateBarrelsHit():void{
			hit_barrels = new Shape();
			hit_barrels.touchable = false;
			hit_barrels.graphics.beginFill(0xff0000);
			
			hit_barrels.graphics.lineTo(58,266);	
			hit_barrels.graphics.lineTo(190,188);	
			hit_barrels.graphics.lineTo(269,181);	
			hit_barrels.graphics.lineTo(300,195);	
			hit_barrels.graphics.lineTo(315,222);	
			hit_barrels.graphics.lineTo(365,348);	
			hit_barrels.graphics.lineTo(160,464);	
			hit_barrels.graphics.lineTo(0,421);	
			
			hit_barrels.graphics.endFill(false);
			
			hit_barrels.alpha = 0.0;
			
			hit_barrels.graphics.precisionHitTest = true;	
			this.addChild(hit_barrels);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirate as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateObj,true
						);
					}else if(hit_chest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePirateChest as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateChestObj,true
						);

					}else if(hit_barrels.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePirateBarrels as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateBarrelsObj,true
						);
					}else if(hit_plank.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PlankHandler();
					
					}else if(hit_wall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock wall is covered with moss and moisture.");
						
					}
				}
			}
		}
		
		private function PlankHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateEnclave != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateEnclave["Plank"] == "PickedUp"){
					if(hit_wall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock wall is covered with moss and moisture.");
						
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
					plank.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateEnclave;
					SaveArray['Plank'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateEnclave',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PlankTwo,
						'item_PlankTwo',
						'inven_plankTwo_sm'
					);
					
					
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
				plank.alpha = 0;
				SaveArray['Plank'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateEnclave',SaveArray);	
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PlankTwo,
					'item_PlankTwo',
					'inven_plankTwo_sm'
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
			
			
			this.assets.removeTexture("cavePirateEnclave_bg",true);
			this.assets.removeTexture("CavePirateEnclave_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateEnclave_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cavePirateEnclave_01");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateEnclave_02");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateEnclave_03");
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