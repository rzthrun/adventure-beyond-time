package screens.inventory
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	import screens.ingamescreens.Cave;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class InventoryDetail extends Sprite
	{
		private var assets:AssetManager;
		public var bg:Shape;
		public var LargeDetailImage:Image;
		public var hit_area:Shape;
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		private var goback:GoBackButton;
		
		public var animating:Boolean = false;
		
		public function InventoryDetail(_assets:AssetManager)
		{
			super();
			this.assets = _assets;
			/*
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v001.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v001.xml'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v002.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v002.xml'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v003.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v003.xml'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v004.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v004.xml'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v005.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/InventoryDetails/InvenDetails_SpriteSheet_v005.xml'));
			*/
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/IntroSequence'));
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					//		(stage.getChildAt(0) as Object).screenGamePlayHandler.hud.toggleGoBack(FrontDoorObj,true);
					onLoadAssets();

				}				
			});	
			
		}
		
		
		private function onLoadAssets():void{
			
			
			CreateBg();
			
			LargeDetailImage = new Image(this.assets.getTexture('inven_detail_mushroom'));	
			LargeDetailImage.width = 400;
			LargeDetailImage.height = 390;
			LargeDetailImage.x = 160;
			LargeDetailImage.y = 0;
			LargeDetailImage.touchable = false;
			this.addChild(LargeDetailImage);
			CreateAreaHit();
			goback = new GoBackButton(this.assets);	
			this.addChild(goback);
			this.addEventListener(TouchEvent.TOUCH,OnClickHandler);
			
		}
		private function OnClickHandler(e:TouchEvent):void{
			targ = e.target;
			
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.BEGAN) {
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmTwo();
						trace("GoBackClick");
						e.stopPropagation();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ToggleCloseUp();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
						
					}else if(hit_area.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						trace(touches[0].globalX+", "+touches[0].globalY);
						e.stopPropagation();
						
						if(animating === false){
							ReadOutReturns();
						}else{
							
						}
					}else if(bg.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmTwo();
						trace("GoBackClick");
						e.stopPropagation();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ToggleCloseUp();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
						//	trace('BG CLIK');
					/*	trace(touches[0].globalX+", "+touches[0].globalY);
						e.stopPropagation();
						
						if(animating === false){
							ReadOutReturns();
						}else{
							
						}
					*/
					}
					
				}
			}
		}		
		public function ChangeImageDetail():void{
			trace(" "+this.parent);
			trace("PARENT ARMED ITEM: "+this.parent["armedItem"]);


			
			if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Mushroom){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_mushroom');
				LargeDetailImage.x = 160;
				LargeDetailImage.y = 0;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Sticks){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_sticks');
				LargeDetailImage.x = 160;
				LargeDetailImage.y = 0;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Gourd){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_gourd');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 25;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Motor){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_motor');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Celtic){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_celtic');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Compass){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_compass');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
		//	}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Piggy){
		//		LargeDetailImage.texture = this.assets.getTexture('inven_detail_piggy');
		//		LargeDetailImage.x = 180;
		//		LargeDetailImage.y = 35;
		//		LargeDetailImage.width = 195*2;
		//		LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Puller){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_puller');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateTubeEmpty){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pirateTubeEmpty');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;

			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Glass){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_glass');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_RedStoneOne){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_redStoneOne');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_RedStoneTwo){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_redStoneTwo');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_WoodCircle){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_woodCircle');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Logs){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_logs');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateDisc){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pirateTubeDisc');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateTube){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pirateTubeFull');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Handle){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_handle');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Marcasite){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_marcasite');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Flint){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_flint');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Jaw){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_jaw');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_FlintAndMarcasite){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_flintandmarcasite');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ribbon){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_ribbon');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchStick){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_torchStick');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Torch){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_torch');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchTar){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_torchTar');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchBurning){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_torchBurning');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PlankOne){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_plankOne');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PlankTwo){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_plankTwo');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Jug){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_jug');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlackPowder){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_blackPowder');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Rope){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_rope');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CannonTorch){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_cannonTorch');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CannonTorchBurning){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_cannonTorchBurning');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_K2SO){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_k2so');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CausticJug){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_causticJug');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ladder){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_ladder');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Card){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_card');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Seal){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_seal');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallOne){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_dragonBallOne');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallThree){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_dragonBallThree');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallTwo){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_dragonBallTwo');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallSeven){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_dragonBallSeven');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_ArmMars){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_armMars');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_ArmSun){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_armSun');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;	
				
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateKey){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pirateKey');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlowTorch){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_blowtorch');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlowTorchLit){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_blowtorchLit');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Wrench){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_wrench');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinTiger){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_coinTiger');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinDragon){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_coinDragon');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Lever){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_lever');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Screwdriver){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_screwdriver');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Shovel){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_shovel');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Satellite){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_satellite');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Solder){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_solder');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinPhoenix){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_coinPhoenix');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinTurtle){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_coinTurtle');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;	
				
			//	
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_WireCutters){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_wireCutters');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Floppy){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_floppy');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SolarPanels){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_solarPanels');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Wires){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_wires');
				LargeDetailImage.x = 125;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 256*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Potatoes){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_potatoes');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PotatoesWired){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_potatoesWired');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ball){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_ball');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Fish){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_fish');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SlenderKey){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_slenderKey');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PickAxe){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pickAxe');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AncientCoinTwo){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_ancientCoinTwo');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AncientCoinOne){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_ancientCoinOne');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Human){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_human');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SculptTools){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_sculptTools');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Poker){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_poker');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Bucket){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_bucket');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BucketTar){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_bucketTar');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hammer){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_hammer');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Iridium){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_iridium');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Apple){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_apple');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallFive){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_dragonBallFive');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Trowel){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_trowel');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hominid){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_hominid');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Marble){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_marble');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Alien){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_alien');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Tricorder){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_tricorder');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AlienHand){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_alienHand');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hose){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_hose');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_HoseClean){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_hoseClean');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Mirror){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_mirror');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Bananas){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_bananas');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Plasma){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_plasma');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalRed){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_crystalRed');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalGreen){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_crystalGreen');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalBlue){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_crystalBlue');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalWhite){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_crystalWhite');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Slime){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_slime');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_GourdWater){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_gourdWater');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Pestle){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_pestal');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Flower){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_flower');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Alcohol){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_alcohol');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Slide){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_slide');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Shell){
				LargeDetailImage.texture = this.assets.getTexture('inven_detail_shell');
				LargeDetailImage.x = 180;
				LargeDetailImage.y = 35;
				LargeDetailImage.width = 195*2;
				LargeDetailImage.height = 191*2;					
			}
			
			
			
			
			/*
			item_Shell
			item_Slide
			item_Alcohol
			item_Flower
			item_Pestle
			item_GourdWater
			item_Slime
			public var item_CrystalGreen:Image;
			public var item_CrystalBlue:Image;
			public var item_CrystalWhite:Image;
			item_Plasma
			item_Bananas
			public var item_CrystalRed:Image;
			public var item_Mirror:Image;
			public var item_Hose:Image;
			public var item_HoseClean:Image;
			public var item_Trowel:Image;
			public var item_Hominid:Image;
			public var item_DragonBallFive:Image;
			public var item_Marble:Image;
			public var item_Alien:Image;
			public var item_Tricorder:Image;
			public var item_AlienHand:Image
			item_Apple
			item_Hammer
			item_BucketTar
			item_Bucket
			item_AncientCoinOne
			item_Poker
			public var item_SculptTools:Image;
			public var item_Human:Image;
			item_AncientCoinTwo
			item_PickAxe
			item_SlenderKey
			item_Fish
			item_Ball
			item_PotatoesWired
			item_Potatoes
			item_Wires
			item_SolarPanels
			item_Floppy
			item_WireCutters
			item_CoinPhoenix
			item_Solder
			item_Satellite
			item_CoinDragon
			public var item_Screwdriver:Image;
			public var item_Shovel:Image;
			item_Lever
			item_CoinTiger
			public var item_BlowTorch:Image;
			public var item_BlowTorchLit:Image;
			public var item_Wrench:Image;
			item_PirateKey
			public var item_DragonBallOne:Image;
			public var item_ArmMars:Image;
			item_Seal
			item_Card
			item_Ladder
			item_K2SO
			public var item_BlackPowder:Image;
			public var item_Rope:Image;
			public var item_CannonTorch:Image;
			public var item_CannonTorchBurning:Image;
			public var item_PlankOne:Image;
			public var item_PlankTwo:Image;
			public var item_Jug:Image;

			*/
			//item_TorchBurning
			//item_TorchStick
			//item_Ribbon
			//item_FlintAndMarcasite
		//item_Jaw
			//item_PirateDisc
			//public var item_Flint:Image;
			//public var item_Marcasite:Image;
		}
		
		public function ReadOutReturns():void{
			
			/*
		
			public var item_Celtic:Image;
			public var item_Compass:Image;
			public var item_Piggy:Image;
			public var item_Puller:Image;
			*/
			
			
			if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Mushroom){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A strange mushroom. Might be poisonous.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Sticks){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A bunch of dried twigs and sticks.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Gourd){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A hollow gourd with a hole carved near the top.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Motor){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The mortar and pestle full of the mashed mushrooms and flowers.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Pestle){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A pestle, used to grind and mash foods and medicines in a bowl.");			
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Celtic){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An ornamental medallion with an interweaving pattern made of bright emerald green gemstone.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Compass){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The needle of a compass. A piece of galvanized metal with a fine edge and point.");
				//	}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Piggy){
				//		(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A piggy bank belonging to the sailors of the freightship.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Puller){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A brass lever - or 'pull' - with a red wooden handle.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateTubeEmpty){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A corroded cylinder with two discs, embossed with morbid symbols. There is an empty slot.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateTube){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The corroded cylinder with all three discs featuring the pirate symbols.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Glass){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Broken shards of glass. The edges are jagged, but the surface is smooth.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_RedStoneOne){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A nearly cicular, hard stone with a deep rich red color. Maybe it's volcanic in origin.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_RedStoneTwo){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A red stone. It's very hard, but it seems to have been worked into a somewhat regular shape.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_WoodCircle){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A wood discus made from the core of a tree truck. The growth rings are clearly visible.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Logs){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A couple of dry timber logs.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateDisc){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A corroded metal disc, with pirate flags etched along the side.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Handle){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A white plastic handle.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Flint){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some sort of stone-age tool fashioned from a slick black stone. It's easy to hold and has many chip marks on its surface.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Marcasite){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A broken rock. Where it's been broken there's a regular and radial pattern. I think it's a type of geode.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Jaw){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The jaw bone of a large predatory animal. The teeth are razor sharp. It might make a good saw.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_FlintAndMarcasite){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These two stones produce sparks when struck together.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ribbon){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A length of coarse woven canvas.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchStick){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A long stick - the wood is very dense and hard. I think it was starting to petrify - turn to stone.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Torch){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've wrapped the canvas ribbon around one end the petrified stick.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchTar){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've dipped the canvas into the tar. If I can ignite this, it'll make an excellent torch.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_TorchBurning){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A burning torch - very helpful for seeing in the dark.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PlankOne){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A long plank of wood. It's about two meters long - roughly six and a half feet.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PlankTwo){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A wooden plank about two meters in length, or 6.5617 feet.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Jug){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A ceramic jug filled with vinegar. 'Vynegre' must be an old-time spelling.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlackPowder){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A gray-black powder. It reflects many colors of light. I assume it's gunpowder.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Rope){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A length of hemp rope. It's quite strong.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CannonTorch){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small hand torch. Probably used by the galleon's crew durning battles.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CannonTorchBurning){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've lit the small torch.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_K2SO){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A white powder produced by the reaction on the black powder. Maybe I can mix this with something later");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CausticJug){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Adding the white powder to the vinegar has created a bubbling acid mixture.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ladder){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An eight-step wooden ladder.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Card){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A 'security' card. It's made of plastic and has a magnetic stripe. It's pretty beat up.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Seal){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A shallow cylinder made of tarnished bronze. There is an insignia or symbol embossed on the front.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallOne){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A spherical rock. I think it's made of lava. There's a smooth circle on the surface.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallThree){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Another spherical stone with three smooth circles on one side.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallFive){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A perfectly round stone with five smooth areas. It weighs very little.");	
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallTwo){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A round stone with two smooth circles");	
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_DragonBallSeven){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A spherical stone with seven smooth circles arranged concentrically.");		
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_ArmMars){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A flattened brass pointer, with a painted circle at the tip.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_ArmSun){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A brass pointer, with a broad circular shape at the end painted a bright white. ");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PirateKey){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old steel key.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlowTorch){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old gasoline blowtorch. It's empty, but appears functional.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BlowTorchLit){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The blowtorch is now filled with gasoline. The heat it produces is enormous - I must be careful.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Wrench){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A wrench.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinTiger){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A heavy discus. It depicts a stylized tiger.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinDragon){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A heavy metal discus. It shows a stylized dragon. I think it's made of cast iron.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Lever){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It appears to be a lever or handle of some sort.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Screwdriver){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A phillips head screwdriver.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Shovel){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A rusty shovel. Still good though.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Satellite){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small satellite dish.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Solder){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A cordless soldering iron. The tip gets very hot.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinPhoenix){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A heavy metal discus. It has an image of a bird with long feathers.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CoinTurtle){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A heavy disc. It has an image of a turtle... and snake.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_WireCutters){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A pair of wire cutters. In good condition too.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Floppy){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some type of strange ancient technology.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SolarPanels){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Solar panels removed from the ocean bouy. Used for converting sun light into electrical energy.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Wires){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A bunch of black and red electrical wires.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Potatoes){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Potatoes, an excellent source of energy.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PotatoesWired){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("By connecting the wires to the potatoes, I've been able to create a crude electrochemical battery.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Ball){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small ball. I think it's marble. One half is black; one half is white...");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Fish){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A fish skeleton.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SlenderKey){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old slender key.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_PickAxe){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A pick axe: used for mining.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AncientCoinTwo){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An another antique coin... It looks like it's almost 2000 years old.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AncientCoinOne){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old coin... I think it's from ancient Rome.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_SculptTools){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Sculptor's tools, used for fine work.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Human){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A human skull... morbid.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Poker){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A harpoon.. or maybe a firepoker - it's long and has a hook on one end.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Bucket){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A wooden bucket... seems to have a lot of holes.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Bucket){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've filled the bucket with tar.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Iridium){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A kilogram bar of Iridium.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hammer){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A hammer, the back of the head has a \"cat's paw\" for removing nails.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Apple){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A sour apple.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Trowel){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A digging trowel, used for moving and shaping earth or soil.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hominid){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A skull, almost human looking, but too large a brain cavity for an ape....");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Marble){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A piece of petrified wood with five perfectly regular sides.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Alien){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A skull - it has big eye sockets and a very large cranial region.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Tricorder){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some sort of advanced sensor technology. Still seems to work.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_AlienHand){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hand bones, the fingers are incredibly long.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Hose){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A rubber hose. It's very dirty.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_HoseClean){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've cleaned the rubber hose.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Mirror){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A broken mirror.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Bananas){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A bunch of bananas.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Plasma){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal is moving! It keeps trying to crawl out of the tube!");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalRed){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A bright crimson red crystal. It feels like its vibrating.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalGreen){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A green crystal... produced from the slime from the mountain, and other organic materials.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalBlue){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A blue crystal... I can feel it pulsating in my hands.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalBlue){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A white crystal... It's incredably clear.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Slime){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ah... Slime... wonderful.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_GourdWater){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've filled the gourd with fresh water.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Flower){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A purple flower. It has a delightful smell.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Alcohol){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A tin bottle of rubbing alcohol.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Slide){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've made a slide of the slime using the broken glass fragments !");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_Shell){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A nautilus shell. Its curves form a beautiful spiral.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_CrystalWhite){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A clear crystal. Inside of it light refracts into an infinite number of colors.");
			}else if(this.parent["armedItem"] == (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.inventoryBarObj.item_BucketTar){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bucket is now filled with gooey tar.");
			}
			
			
			
			/*
			item_BucketTar
			item_Shell
			item_Slide
			item_Alcohol
			item_Flower
			item_GourdWater
			item_Slime
			public var item_CrystalGreen:Image;
			public var item_CrystalBlue:Image;
			public var item_CrystalWhite:Image;
			item_Plasma
			item_Bananas
			public var item_CrystalRed:Image;
			public var item_Mirror:Image;
			public var item_Hose:Image;
			public var item_HoseClean:Image;
			public var item_Trowel:Image;
			public var item_Hominid:Image;
			public var item_DragonBallFive:Image;
			public var item_Marble:Image;
			public var item_Alien:Image;
			public var item_Tricorder:Image;
			public var item_AlienHand:Image
			
			item_Apple
			item_Hammer
			item_Bucket
			item_AncientCoinOne
			public var item_SculptTools:Image;
			public var item_Human:Image;
			item_AncientCoinTwo
			item_PickAxe
			item_SlenderKey
			item_Fish
			item_Ball
			item_PotatoesWired
			item_Potatoes
			item_Wires
			item_Floppy
			item_CoinPhoenix
			item_Solder
			item_CoinDragon
			item_Satellite
			public var item_Screwdriver:Image;
			public var item_Shovel:Image
			item_Lever
			item_CoinTiger
			public var item_BlowTorch:Image;
			public var item_BlowTorchLit:Image;
			public var item_Wrench:Image;
			//item_PirateKey
			public var item_DragonBallOne:Image;
			public var item_ArmMars:Image;
			item_Seal
			item_Card
			item_Ladder
			item_CausticJug
			item_K2SO
			public var item_BlackPowder:Image;
			public var item_Rope:Image;
			public var item_CannonTorch:Image;
			public var item_CannonTorchBurning:Image;
			public var item_PlankOne:Image;
			public var item_PlankTwo:Image;
			public var item_Jug
			*/
			//item_TorchBurning
			//item_TorchTar
			//item_TorchStick
			//item_FlintAndMarcasite
			//item_Jaw
			////item_PirateTube
//item_PirateDisc
			//inven_detail_handle
			//public var item_Flint:Image;
			//public var item_Marcasite:Image;
		}
		
		
		private function CreateBg():void{
			bg = new Shape();
			this.addChildAt(bg,0);
			bg.graphics.beginFill(0x000000);
			bg.graphics.lineTo(0,0);	
			bg.graphics.lineTo(800,0);	
			bg.graphics.lineTo(800,512);	
			bg.graphics.lineTo(0,512);	
			bg.touchable = true;
			bg.graphics.endFill(false);
			bg.alpha = 0.5;
			//	openBookbg.graphics.precisionHitTest = true;				
			
		}
		private function CreateAreaHit():void{
			
			
			hit_area = new Shape();
			this.addChild(hit_area);
			hit_area.graphics.beginFill(0x000ff0);
			hit_area.graphics.lineTo(235,138);	
			hit_area.graphics.lineTo(310,70);	
			hit_area.graphics.lineTo(473,67);	
			hit_area.graphics.lineTo(575,165);	
			hit_area.graphics.lineTo(583,275);	
			hit_area.graphics.lineTo(495,346);	
			hit_area.graphics.lineTo(355,341);	
			hit_area.graphics.lineTo(242,280);	
		
			hit_area.touchable = true;
			hit_area.graphics.endFill(false);
			hit_area.alpha = 0.0;
			hit_area.graphics.precisionHitTest = true;	
		}
		
	}
}