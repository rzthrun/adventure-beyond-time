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
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class CavePirateJunk extends Sprite
	{
		
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		
		private var bg:Image;
		private var rope:Image;
		private var torch:Image;
		private var blackPowder:Image;
		private var blackPowderCorner:Image;
		private var barrel_hole:Image;
		
		private var hit_rope:Shape;
		private var hit_torch:Shape;
		private var hit_barrel:Shape;
		private var hit_powder:Shape;
		
		private var hit_cannon:Shape;
		private var hit_bin:Shape;
		
		private var powderTween:Tween;
		private var powderCornerTween:Tween;
		
		private var Animating:Boolean = false;
		private var BarrelOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CavePirateJunk(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('pirateJunk_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateJunk/pirateJunk_bg.jpg'));
				game.TrackAssets('pirateJunk_01');
			}
			if(game.CheckAsset('pirateJunk_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateJunk/CavePirateJunk_Sprite.atf'));
				game.TrackAssets('pirateJunk_02');
			}
			if(game.CheckAsset('pirateJunk_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateJunk/CavePirateJunk_Sprite.xml'));
				game.TrackAssets('pirateJunk_03');
			}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					trace("LOADING CAVEPIRATE JUNK COMPLETE");
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateJunk","CavePirateJunkObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateJunk_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			barrel_hole = new Image(this.assets.getTexture('barrel_hole'));
			barrel_hole.touchable = false;
			barrel_hole.x = 352;
			barrel_hole.y = 144;
						
			blackPowder = new Image(this.assets.getTexture('powder'));
			blackPowder.touchable = false;
			blackPowder.x = 243;
			blackPowder.y = 143;
					
			rope = new Image(this.assets.getTexture('rope'));
			rope.touchable = false;
			rope.x = 496;
			rope.y = 170;
			
			blackPowderCorner = new Image(this.assets.getTexture('powder_corner'));
			blackPowderCorner.touchable = false;
			blackPowderCorner.x = 454;
			blackPowderCorner.y = 224;

			torch = new Image(this.assets.getTexture('cannon_torch'));
			torch.touchable = false;
			torch.x = 109;
			torch.y = 170;
		
				
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk['Barrel'] == 'Open'){
					//barrel_hole.alpha = 0;
					BarrelOpen = true;
					blackPowder.alpha = 1;
					blackPowderCorner.alpha = 1;
				}else{
					barrel_hole.alpha = 0;
					blackPowder.alpha = 0;
					blackPowderCorner.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Torch"] == "PickedUp"){
					torch.alpha = 0;
				}else{
					torch.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Rope"] == "PickedUp"){
					rope.alpha = 0;
				}else{
					rope.alpha = 1;
				}
			}else{
				barrel_hole.alpha = 0;
				blackPowder.alpha = 0;
				blackPowderCorner.alpha = 0;
				torch.alpha = 1;
		
			}
			
			
			

			
			this.addChildAt(barrel_hole,1);
			this.addChildAt(blackPowder,2);
			this.addChildAt(rope,3);			
			this.addChildAt(blackPowderCorner,4);	
			this.addChildAt(torch,5);
			
			CreateCannonHit();
			CreateBinHit();
			CreateHitRope();
			CreateHitBarrel();
			CreateHitPowder();
			CreateHitTorch();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			},1);
		}
	//	private var hit_cannon:Shape;
	//	private var hit_bin:Shape;
		private function CreateCannonHit():void{
			hit_cannon = new Shape();
			hit_cannon.touchable = false;
			hit_cannon.graphics.beginFill(0xff0000);	
			
			hit_cannon.graphics.lineTo(393,417);	
			hit_cannon.graphics.lineTo(641,291);	
			hit_cannon.graphics.lineTo(652,248);	
			hit_cannon.graphics.lineTo(790,236);	
			hit_cannon.graphics.lineTo(786,363);	
			hit_cannon.graphics.lineTo(466,498);	
		
			hit_cannon.graphics.endFill(false);
			hit_cannon.alpha = 0.0;
			
			hit_cannon.graphics.precisionHitTest = true;	
			this.addChild(hit_cannon);
		}
		
		private function CreateBinHit():void{
			hit_bin = new Shape();
			hit_bin.touchable = false;
			hit_bin.graphics.beginFill(0xff0000);	
			
			hit_bin.graphics.lineTo(207,94);	
			hit_bin.graphics.lineTo(249,41);	
			hit_bin.graphics.lineTo(296,68);	
			hit_bin.graphics.lineTo(301,118);	
			hit_bin.graphics.lineTo(285,172);	
			hit_bin.graphics.lineTo(240,195);	
			hit_bin.graphics.lineTo(221,170);	
			
			hit_bin.graphics.endFill(false);
			hit_bin.alpha = 0.0;
			
			hit_bin.graphics.precisionHitTest = true;	
			this.addChild(hit_bin);
		}
		
		private function CreateHitRope():void{
			hit_rope = new Shape();
			hit_rope.touchable = false;
			hit_rope.graphics.beginFill(0xff0000);
			
			hit_rope.graphics.lineTo(480,177);	
			hit_rope.graphics.lineTo(526,144);	
			hit_rope.graphics.lineTo(631,159);	
			hit_rope.graphics.lineTo(661,203);	
			hit_rope.graphics.lineTo(623,298);	
			hit_rope.graphics.lineTo(554,320);	
			hit_rope.graphics.lineTo(485,280);	
	
			hit_rope.graphics.endFill(false);
			hit_rope.alpha = 0.0;
			
			hit_rope.graphics.precisionHitTest = true;	
			this.addChild(hit_rope);
		}
		
		private function CreateHitPowder():void{
			hit_powder = new Shape();
			hit_powder.touchable = false;
			hit_powder.graphics.beginFill(0xff0000);
			
			hit_powder.graphics.lineTo(238,211);	
			hit_powder.graphics.lineTo(346,144);	
			hit_powder.graphics.lineTo(378,144);	
			hit_powder.graphics.lineTo(465,212);	
			hit_powder.graphics.lineTo(443,274);	
			hit_powder.graphics.lineTo(392,308);	
			hit_powder.graphics.lineTo(290,312);	
			hit_powder.graphics.lineTo(233,247);	

			hit_powder.graphics.endFill(false);
			hit_powder.alpha = 0.0;
			
			hit_powder.graphics.precisionHitTest = true;	
			this.addChild(hit_powder);
		}
		
		private function CreateHitBarrel():void{
			hit_barrel = new Shape();
			hit_barrel.touchable = false;
			hit_barrel.graphics.beginFill(0xff0000);
			
			hit_barrel.graphics.lineTo(309,83);	
			hit_barrel.graphics.lineTo(329,53);	
			hit_barrel.graphics.lineTo(367,40);	
			hit_barrel.graphics.lineTo(398,46);	
			hit_barrel.graphics.lineTo(428,80);	
			hit_barrel.graphics.lineTo(431,116);	
			hit_barrel.graphics.lineTo(408,179);	
			hit_barrel.graphics.lineTo(365,192);	
			hit_barrel.graphics.lineTo(331,184);	
			hit_barrel.graphics.lineTo(308,154);	

			hit_barrel.graphics.endFill(false);
			hit_barrel.alpha = 0.0;
			
			hit_barrel.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel);
		}
		
		
		private function CreateHitTorch():void{
			hit_torch = new Shape();
			hit_torch.touchable = false;
			hit_torch.graphics.beginFill(0xff0000);
			
			hit_torch.graphics.lineTo(87,167);	
			hit_torch.graphics.lineTo(161,159);	
			hit_torch.graphics.lineTo(188,341);	
			hit_torch.graphics.lineTo(118,362);	

			hit_torch.graphics.endFill(false);
			hit_torch.alpha = 0.0;
			
			hit_torch.graphics.precisionHitTest = true;	
			this.addChild(hit_torch);
		}
		/*
		private var hit_rope:Shape;
		private var hit_torch:Shape;
		private var hit_barrel:Shape;
		private var hit_powder:Shape;
		
		*/
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CavePirateDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateDeckObj,true
							);
						}else if(BarrelOpen === false){
							if(hit_barrel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								BarrelHandler();
							}else if(hit_torch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TorchHandler();
							}else if(hit_rope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								RopeHandler();
							}else if(hit_bin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old washbin.");
							}else if(hit_cannon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fuselage of a broken cannon.");
							}
						}else{
							if(hit_powder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								PowderHandler();
							}else if(hit_torch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TorchHandler();
							}else if(hit_rope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								RopeHandler();
							}else if(hit_barrel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A wooden barrel, once a popular form of storage.");
							}else if(hit_bin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old washbin.");
							}else if(hit_cannon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fuselage of a broken cannon.");
							}


						}
					}
				}
			}
		}

		private function PowderHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["BlackPowder"] == "PickedUp"){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk;
					SaveArray['BlackPowder'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlackPowder,
						'item_BlackPowder',
						'inven_blackPowder_sm'
					);
				}
			}else{
				SaveArray['BlackPowder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlackPowder,
					'item_BlackPowder',
					'inven_blackPowder_sm'
				);
			}	
		}

		
		private function TorchHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Torch"] == "PickedUp"){
					
				}else{
					torch.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk;
					SaveArray['Torch'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorch,
						'item_CannonTorch',
						'inven_cannonTorch_sm'
					);
				}
			}else{
				torch.alpha = 0;
				SaveArray['Torch'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorch,
					'item_CannonTorch',
					'inven_cannonTorch_sm'
				);
			}	
		}
		
		private function RopeHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Rope"] == "PickedUp"){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					rope.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk;
					SaveArray['Rope'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Bucket,
						'item_Bucket',
						'inven_bucket_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				rope.alpha = 0;
				SaveArray['Rope'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Bucket,
					'item_Bucket',
					'inven_bucket_sm'
				);
			}	
		}
		
		private function BarrelHandler():void{
			Animating = true;
			barrel_hole.alpha = 1;
			//powderCornerTween
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GrainOne();
			},1);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk;
			}
			
			
			
			SaveArray['Barrel'] = "Open";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateJunk',SaveArray);
			
			
			powderTween = new Tween(blackPowder, 2.5, Transitions.LINEAR);
			powderTween.fadeTo(1);
			powderTween.onComplete = function():void{};
			
			powderCornerTween = new Tween(blackPowderCorner, 2.5, Transitions.LINEAR);
			powderCornerTween.fadeTo(1);
			powderCornerTween.onComplete = function():void{
				BarrelOpen = true;
				Animating = false;
			};
			
			Starling.juggler.add(powderTween);
			Starling.juggler.add(powderCornerTween);
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
			
			
			this.assets.removeTexture("pirateJunk_bg",true);
			this.assets.removeTexture("CavePirateJunk_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateJunk_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateJunk_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateJunk_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateJunk_03");
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


