package screens.inventory
{
	import flash.filesystem.File;
	
	import screens.inventory.InventoryBar;
	
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
	
	public class Inventory extends Sprite
	{
		private var assets:AssetManager;
		
		private var SaveArray:Array = new Array();
		
		public var toggleButton:Image;

		public var armedHighlight:Image;
		public var inventoryBarObj:InventoryBar = new InventoryBar();
		public var armedItem:Object = false;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		private var c_targ:Object;
		
		public var ToggleBar:Boolean = false;
		public var ToggleBarTween:Tween;
		
		
		public var item_Mushroom:Image;
		public var item_Sticks:Image;
		public var item_Gourd:Image;
		public var item_GourdWater:Image;
		public var item_Motor:Image;
		public var item_Celtic:Image;
		public var item_Compass:Image;
	//	public var item_Piggy:Image;
		public var item_Puller:Image;
		public var item_PirateTubeEmpty:Image;
		public var item_PirateTube:Image;
		public var item_Glass:Image;
		public var item_RedStoneOne:Image;
		public var item_RedStoneTwo:Image;
		public var item_WoodCircle:Image;
		public var item_Logs:Image;
		public var item_PirateDisc:Image;
		public var item_Handle:Image;
		public var item_Flint:Image;
		public var item_Marcasite:Image;
		public var item_Jaw:Image;
		public var item_FlintAndMarcasite:Image;
		public var item_Ribbon:Image;
		public var item_TorchStick:Image;
		public var item_Torch:Image;
		public var item_TorchTar:Image;
		public var item_TorchBurning:Image;
		public var item_PlankOne:Image;
		public var item_PlankTwo:Image;
		public var item_Jug:Image;
		public var item_BlackPowder:Image;
		public var item_Rope:Image;
		public var item_CannonTorch:Image;
		public var item_CannonTorchBurning:Image;
		public var item_K2SO:Image;
		public var item_CausticJug:Image;
		public var item_Ladder:Image;
		public var item_Card:Image;
		public var item_Seal:Image;
		public var item_BlowTorch:Image;
		public var item_BlowTorchLit:Image;
		public var item_Wrench:Image;
		public var item_Lever:Image;		
		public var item_DragonBallOne:Image;		
		public var item_DragonBallThree:Image;		
		public var item_DragonBallTwo:Image;		
		public var item_DragonBallSeven:Image;		
		public var item_ArmMars:Image;
		public var item_ArmSun:Image;		
		public var item_CoinTiger:Image;
		public var item_CoinDragon:Image;
		public var item_CoinPhoenix:Image;
		public var item_CoinTurtle:Image;	
		public var item_PirateKey:Image;	
		public var item_Screwdriver:Image;
		public var item_Shovel:Image;
		public var item_Satellite:Image;
		public var item_Solder:Image;
		public var item_WireCutters:Image;
		public var item_Floppy:Image;		
		public var item_SolarPanels:Image;
		public var item_Wires:Image;		
		public var item_Potatoes:Image;
		public var item_PotatoesWired:Image;
		public var item_Ball:Image;		
		public var item_Fish:Image;
		public var item_SlenderKey:Image;		
		public var item_PickAxe:Image;
		public var item_AncientCoinTwo:Image;
		public var item_AncientCoinOne:Image;	
		public var item_SculptTools:Image;
		public var item_Human:Image;		
		public var item_Poker:Image;
		public var item_Bucket:Image;
		public var item_BucketTar:Image;		
		public var item_Iridium:Image;
		public var item_Hammer:Image;		
		public var item_Apple:Image;
		
		public var item_Trowel:Image;
		public var item_Hominid:Image;
		public var item_DragonBallFive:Image;
		public var item_Marble:Image;
		public var item_Alien:Image;
		public var item_Tricorder:Image;
		public var item_AlienHand:Image
		
		public var item_Hose:Image;
		public var item_HoseClean:Image;
		
		public var item_CrystalRed:Image;
		public var item_CrystalGreen:Image;
		public var item_CrystalBlue:Image;
		public var item_CrystalWhite:Image;
		public var item_Mirror:Image;
		public var item_Bananas:Image;
		public var item_Plasma:Image;
		public var item_Slime:Image;
		public var item_Pestle:Image;
		public var item_Flower:Image;
		public var item_Alcohol:Image;
		public var item_Slide:Image;
		public var item_Shell:Image;
		
		//item_PirateTubeEmpty
		//item_PirateDisc		
		public var currentSet:int = 1;
		public var InvenPuzzleFlag:String = null;
		
		public var DetailSprite:Sprite;
		private var detailBg:Image;
		private var detailImage:Image;
		private var hit_Detail:Shape; 
		
		private var DetailObj:InventoryDetail;
		private var DetailObjTween:Tween;
		private var DetailLoaded:Boolean = false;
		
		public var game:Game;
		
		public function Inventory(_game:Game,_assets:AssetManager)
		{
			super();
			this.game = _game;
			this.assets = _assets;
			inventoryBarObj.name = "InvenBar";
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		
			//this.assets = new AssetManager();
	/*		if((stage.getChildAt(0) as Object).CheckAsset('inventory_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Inventory/Inventory_SpriteSheet_01.png'));
				(stage.getChildAt(0) as Object).TrackAssets('inventory_01');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('inventory_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Inventory/Inventory_SpriteSheet_01.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('inventory_02');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('inventory_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Inventory/Inventory_SpriteSheet_02.png'));
				(stage.getChildAt(0) as Object).TrackAssets('inventory_03');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('inventory_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Inventory/Inventory_SpriteSheet_02.xml'));
				(stage.getChildAt(0) as Object).TrackAssets('inventory_04');
			}
			if((stage.getChildAt(0) as Object).CheckAsset('inventory_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Inventory/armedItem_bg_v002a001.png'));
				(stage.getChildAt(0) as Object).TrackAssets('inventory_05');
			}
	*/
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/IntroSequence'));
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});						
			
		}		
		private function onLoadAssets():void{
			DetailObj = new InventoryDetail(this.assets);
			//DetailObj.touchable = false;
			DetailSprite = new Sprite();
			DetailSprite.x = 601;
			DetailSprite.y = 382;
			this.addChild(DetailSprite);
			
			detailBg = new Image(this.assets.getTexture('armedItem_bg_v002a001'));
			detailBg.alpha =1;
			detailBg.x = 0;
			detailBg.y = 0;
			detailBg.touchable = false;
			this.DetailSprite.addChild(detailBg);
			
			detailImage = new Image(this.assets.getTexture('inven_mushroom_sm'));
			detailImage.alpha =0;
			detailImage.x = 24;
			detailImage.y = 50;
			detailImage.touchable = true;
			this.DetailSprite.addChild(detailImage);
			CreateDetailHit();

			
			/*
			---------------------------------
			*/
		
			/*
			---------------------------------
			*/
			
			//toggleButton = new Image(this.assets.getTexture('inventory_v06'));
			toggleButton = new Image(this.assets.getTexture('invenToggleClosed_v003a001'));
			toggleButton.x = 0;
			toggleButton.y = 400;
			this.addChild(toggleButton);
			
			inventoryBarObj.addBg(new Image(this.assets.getTexture('inventory_v06')));
			inventoryBarObj.x = 65;
			inventoryBarObj.y = 512;
			inventoryBarObj.width = 557;
			inventoryBarObj.height = 89;
			
			inventoryBarObj.touchable = true;
			this.addChild(inventoryBarObj);
			

			inventoryBarObj.addLeftArrow(new Image(this.assets.getTexture('arrow_left_v001a002')));
			inventoryBarObj.addRightArrow(new Image(this.assets.getTexture('arrow_right_v001a002')));
			
			
			armedHighlight = new Image(this.assets.getTexture('element_ArmedHighlight_v001a001'));
			
			//	SourceImage = new Image(this.assets.getTexture('element_hud_goBack_v003a001'));
		//	this.addChild(SourceImage);
			
			CheckSavedState();
			
			this.addEventListener(TouchEvent.TOUCH,onClickHandler);	
			
			
		}		
		
	
		
		public function AddItemToInventory(item:Image,itemName:String,itemImage:String,ArrayPos:Number = -1,SaveIt:Boolean = true):void{
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Inventory != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Inventory;
				
				var pos:Number = CalculatePos();
				trace("CalcPos pos = :"+pos);
				if(ArrayPos > -1){
					pos = ArrayPos;
				}
				trace("CalcPos pos = :"+pos);
			}else{
				pos = 0;
			}
			
			
			trace("pos: "+pos);
			if(((pos+1)/6) <= 1){
				trace("Set 01");
				currentSet = 1;
			}else if(((pos+1)/6) > 1 && ((pos+1)/6) <= 2){
				trace("Set 02");
				currentSet = 2;
			}else if(((pos+1)/6) > 2 && ((pos+1)/6) <= 3){
				trace("Set 03");
				currentSet = 3;
			}else if(((pos+1)/6) > 3 && ((pos+1)/6) <= 4){
				trace("Set 04");
				currentSet = 4;
			}else if(((pos+1)/6) > 4 && ((pos+1)/6) <= 5){
				trace("Set 05");
				currentSet = 5;
			}
				
			item = new Image(this.assets.getTexture(itemImage));
			item.x = ((pos*70)-(420*(currentSet-1)));
			this[itemName] = item;
			inventoryBarObj.addItem(item,itemName,currentSet);
			

			if(SaveIt === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPickUp();
				SaveArray.push(new Array(itemName,itemImage,pos,currentSet));
				(stage.getChildAt(0) as Object).SavedGame.SaveInventoryData(SaveArray);
				armedItem = item;
				trace("ArmedItem: "+armedItem);
				armedHighlight.x = armedItem.x;
				ArmItem();
				if(DetailLoaded === false){
					ToggleCloseUp();
				}else{
					DetailObj.ChangeImageDetail();
					DetailObj.ReadOutReturns();
				}
				if(ToggleBar === false){
					
					toggleInvetory();
				}
			}
			
			
			
		}
		
		public function ChangeInventoryItem(item:Image,itemName:String,itemImage:String,targetRef:Image,targetName:String):void{
			for(var i:Number in SaveArray){
				if(targetName == SaveArray[i][0]){
				//	ArmItem();
					trace('itemName: '+itemName);
					if(itemName == 'item_PipetteFilled'){
						armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PipetteFilled;
					}else if(itemName == 'item_Pot'){
						armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Pot;
					}else if(itemName == 'item_GreenTestTube'){
						armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_GreenTestTube;
					}else if(itemName == 'item_PirateTube'){
						armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTube;
					}
					
					AddItemToInventory(item,itemName,itemImage, SaveArray[i][2],true);
					removeItemFromInventory(targetRef,targetName,true);
					
					
					
				//	armedItem = item;
					ArmItem();
				}
			}
		}
		
		
		private function CalculatePos():Number{
			var p:Number = 0;
			var iCount:Number = 0;
			var total:Number = 0;
			if(SaveArray.length > 0){
				
				var tmp_array: Array = new Array();
				for(var i:Number in SaveArray){
					tmp_array[i] = SaveArray[i][2];
				}
				trace("TMP_ARR: "+ tmp_array);
				p = findInArray();
				
				return p;
				
			}else{
				trace("P IS: "+p);
				return p;
			}
			
			function findInArray():Number {
				for(var i2:int = 0; i2 < tmp_array.length; i2++){
					if(tmp_array[i2] == i2){
						trace("found it at index: " + i2);
						
					}else{
						if(tmp_array.indexOf(i2) >= 0){
							
						}else{
							return i2;
						}		
					}
				}
				return (tmp_array.length);
			}			
			
			
			
		}		
		
		public function removeItemFromInventory(item,itemName,ArmThis:Boolean = false):void{
			for(var i:int in SaveArray){
				if(SaveArray[i][0] == itemName){
					
					inventoryBarObj.removeItem(item,itemName,SaveArray[i][3]);
					inventoryBarObj["Set_0"+SaveArray[i][3]].removeChild(armedHighlight);
					SaveArray.splice(i,1);
					
					trace(itemName+" removed from Inventory");
				}else{
					trace(SaveArray[i][0]+" not a match");
				}
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveInventoryData(SaveArray);
			this[itemName].dispose();
			this[itemName] = null;
			if(ArmThis === false){
				armedItem = false;
			}else{
			//	armedItem = ArmThis;
			//	ArmItem();
			}
			detailImage.alpha = 0;
			//inventoryBarObj.removeChild(armedHighlight);
		}
		
		
		
		public function CheckSavedState():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Inventory != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Inventory;
				var SavedInven:Array = 	(stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Inventory;
				for(var i:int in SavedInven){
			//		var SavedInven[i][0] =   
					var img:Image = SavedInven[i][0] as Image;
					AddItemToInventory(
								img,
								SavedInven[i][0],
								SavedInven[i][1],
								SavedInven[i][2],
								false
					);
				}
			}
		}
		
		private function CreateDetailHit():void{
			hit_Detail = new Shape();
			
			this.DetailSprite.addChild(hit_Detail);
			hit_Detail.graphics.beginFill(0x00FF00);
			hit_Detail.graphics.lineTo(10,80);	
			hit_Detail.graphics.lineTo(30,40);	
			hit_Detail.graphics.lineTo(100,40);	
			hit_Detail.graphics.lineTo(100,150);	
			hit_Detail.graphics.lineTo(10,150);	
			hit_Detail.touchable = false;
			hit_Detail.graphics.endFill(false);
			hit_Detail.alpha = 0.0;
			hit_Detail.graphics.precisionHitTest = true;	
		}
		
		private function onClickHandler(e:TouchEvent):void{
			targ = e.target;
		//	c_targ = e.currentTarget;
			touches = e.getTouches(this);
			if (touches.length > 0){
				
				if (touches[0].phase == TouchPhase.BEGAN) {
					trace("HELLO: "+touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == toggleButton){
						trace(targ);
						toggleInvetory();
						return;
					}else if(inventoryBarObj.hit_LeftArrow.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
						var cSet:Number = currentSet-1;
						if(cSet == 0){
							cSet = 5;
						}
						currentSet = cSet;
						
						if(currentSet == 1){
							
							inventoryBarObj.Set_01.touchable = true;
							inventoryBarObj.Set_01.alpha = 1;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 2){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = true;
							inventoryBarObj.Set_02.alpha = 1;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 3){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = true;
							inventoryBarObj.Set_03.alpha = 1;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 4){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = true;
							inventoryBarObj.Set_04.alpha = 1;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 5){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = true;
							inventoryBarObj.Set_05.alpha = 1;
						}
					}
					
					
					else if(inventoryBarObj.hit_RightArrow.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
						var cSet:Number = currentSet+1;
						if(cSet == 6){
							cSet = 1;
						}
						currentSet = cSet;
						
						if(currentSet == 1){
							
							inventoryBarObj.Set_01.touchable = true;
							inventoryBarObj.Set_01.alpha = 1;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 2){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = true;
							inventoryBarObj.Set_02.alpha = 1;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 3){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = true;
							inventoryBarObj.Set_03.alpha = 1;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 4){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = true;
							inventoryBarObj.Set_04.alpha = 1;
							
							inventoryBarObj.Set_05.touchable = false;
							inventoryBarObj.Set_05.alpha = 0;
						}
						if(currentSet == 5){
							inventoryBarObj.Set_01.touchable = false;
							inventoryBarObj.Set_01.alpha = 0;
							
							inventoryBarObj.Set_02.touchable = false;
							inventoryBarObj.Set_02.alpha = 0;
							
							inventoryBarObj.Set_03.touchable = false;
							inventoryBarObj.Set_03.alpha = 0;
							
							inventoryBarObj.Set_04.touchable = false;
							inventoryBarObj.Set_04.alpha = 0;
							
							inventoryBarObj.Set_05.touchable = true;
							inventoryBarObj.Set_05.alpha = 1;
						}
					}
					
					else if(targ == detailImage){
//					if(targ == detailBg){
						if(hit_Detail.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							if(armedItem === false){
								trace("No Item");
								
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmTwo();
								ToggleCloseUp();
							}
						}
					}
					else if(targ != inventoryBarObj.bg 
						&& targ != toggleButton 
						&& targ != inventoryBarObj.leftArrow 
						&& targ != inventoryBarObj.rightArrow
						&& targ != inventoryBarObj
				//		&& targ != DetailObj.goBack

					){
						trace("TARG: "+targ);
						trace("An Item Was Clicked");
						if(targ == armedItem){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
							armedItem = false;
							detailImage.alpha = 0;
							
							InvenPuzzleFlag = null;
							inventoryBarObj["Set_0"+currentSet].removeChild(armedHighlight);
							trace("item disarmed");
							
							if(DetailLoaded === true){
								ToggleCloseUp();
							}
							
						}else{
							
							if(armedItem == item_PirateTubeEmpty && targ == item_PirateDisc){
								trace('item_PirateTubeEmpty Armed, item_PirateDisc Clicked');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTube,
									'item_PirateTube',
									'inven_pirateTubefull_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateDisc,
									'item_PirateDisc'
								);

								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_PirateTubeEmpty,
									"item_PirateTubeEmpty"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['pirateTube'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTube;
								ArmItem();
								
								
							}else if(armedItem == item_PirateDisc && targ == item_PirateTubeEmpty){
								trace('item_PirateDisc Armed, item_PirateTubeEmpty Clicked');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTube,
									'item_PirateTube',
									'inven_pirateTubefull_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTubeEmpty,
									'item_PirateTubeEmpty'
								);
								
								
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_PirateDisc,
									"item_PirateDisc"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['pirateTube'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTube;
								ArmItem();
								
								
							}
							/*
							 *Puzzle  
							*/
							//else if(armedItem == item_PirateTubeEmpty && targ == item_PirateDisc){
							else if(armedItem == item_Flint && targ == item_Marcasite){
								trace('item_PirateTubeEmpty Armed, item_PirateDisc Clicked');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_FlintAndMarcasite,
									'item_FlintAndMarcasite',
									'inven_flintandmarcasite_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Marcasite,
									'item_Marcasite'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Flint,
									"item_Flint"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['flintAndMarcasite'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_FlintAndMarcasite;
								ArmItem();
								
								
							}else if(armedItem == item_Marcasite && targ == item_Flint){
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_FlintAndMarcasite,
									'item_FlintAndMarcasite',
									'inven_flintandmarcasite_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Flint,
									'item_Flint'
								);
								
								
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Marcasite,
									"item_Marcasite"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['flintAndMarcasite'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_FlintAndMarcasite;
								ArmItem();
								
								
							}
							
							else if(armedItem == item_Ribbon && targ == item_TorchStick){
								trace('armedItem == item_Flint && targ == item_Marcasite');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Torch,
									'item_Torch',
									'inven_torch_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchStick,
									'item_TorchStick'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Ribbon,
									"item_Ribbon"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['torch'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Torch;
								ArmItem();
							}else if(armedItem == item_TorchStick && targ == item_Ribbon){
								trace('armedItem == item_Marcasite && targ == item_Flint');
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Torch,
									'item_Torch',
									'inven_torch_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ribbon,
									'item_Ribbon'
								);
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_TorchStick,
									"item_TorchStick"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['torch'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Torch;
								ArmItem();
							}
							
							else if(armedItem == item_Jug && targ == item_K2SO){
								trace('armedItem == item_Ribbon && targ == item_TorchStick');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CausticJug,
									'item_CausticJug',
									'inven_causticJug_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_K2SO,
									'item_K2SO'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Jug,
									"item_Jug"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['causticJug'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CausticJug;
								ArmItem();
							}else if(armedItem == item_K2SO && targ == item_Jug){
								trace('armedItem == item_TorchStick && targ == item_Ribbon');
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CausticJug,
									'item_CausticJug',
									'inven_causticJug_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jug,
									'item_Jug'
								);
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_K2SO,
									"item_K2SO"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['causticJug'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CausticJug;
								ArmItem();
							}
							
							/////////////////////////////////////////////
								
							else if(armedItem == item_Wires && targ == item_Potatoes){
								trace('armedItem == item_Jug && targ == item_K2SO');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PotatoesWired,
									'item_PotatoesWired',
									'inven_potatoesWired_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Potatoes,
									'item_Potatoes'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Wires,
									"item_Wires"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['PotatoesWired'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PotatoesWired;
								ArmItem();
							}else if(armedItem == item_Potatoes && targ == item_Wires){
								trace('armedItem == item_K2SO && targ == item_Jug');
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PotatoesWired,
									'item_PotatoesWired',
									'inven_potatoesWired_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Wires,
									'item_Wires'
								);
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Potatoes,
									"item_Potatoes"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['PotatoesWired'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PotatoesWired;
								ArmItem();
							}
							
							
							
								/////////////////////////////////////////////
								
							else if(armedItem == item_Glass && targ == item_Slime){
								trace('armedItem == item_Wires && targ == item_Potatoes');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slide,
									'item_Slide',
									'inven_slide_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slime,
									'item_Slime'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Glass,
									"item_Glass"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['SlideMade'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slide;
								ArmItem();
							}else if(armedItem == item_Slime && targ == item_Glass){
								trace('armedItem == item_Potatoes && targ == item_Wires');
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slide,
									'item_Slide',
									'inven_slide_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Glass,
									'item_Glass'
								);
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Slime,
									"item_Slime"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['SlideMade'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slide;
								ArmItem();
							}
							
								/////////////////////////////////////////////
								
							else if(armedItem == item_Hose && targ == item_Alcohol){
								trace('armedItem == item_Glass && targ == item_Slime');
								
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_HoseClean,
									'item_HoseClean',
									'inven_hoseClean_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alcohol,
									'item_Alcohol'
								);
								
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Hose,
									"item_Hose"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['HoseCleaned'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_HoseClean;
								ArmItem();
							}else if(armedItem == item_Alcohol && targ == item_Hose){
								trace('armedItem == item_Slime && targ == item_Glass');
								ChangeInventoryItem(
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_HoseClean,
									'item_HoseClean',
									'inven_hoseClean_sm',
									(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hose,
									'item_Hose'
								);
								removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Alcohol,
									"item_Alcohol"
								);
								var PuzzleSaveArry:Array = new Array();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
									PuzzleSaveArry = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.InvenPuzzle;
								}
								PuzzleSaveArry['HoseCleaned'] = 'yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('InvenPuzzle',PuzzleSaveArry);
								
								armedItem = (stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_HoseClean;
								ArmItem();
							}
							
							
							//////////////////////////////////////////////
							else{
								
								armedHighlight.x= targ.x;
								armedItem = targ;
								ArmItem();
								
							}

						}
					
					}
				//	trace("hitTest: "+hitTest(new Point(touches[0].globalX, touches[0].globalY)));
					else if(targ as Sprite == inventoryBarObj){
						trace("Iven Bar Click "+inventoryBarObj);
					}
				
				}
			}
		}
		
		public function ArmItem():void{
		
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickTiny();
			//item_PirateTubeEmpty
			//item_PirateDisc
			//item_Ribbon
			//item_TorchStick
			//item_Torch
			if(armedItem == 'item_Ribbon'){
				InvenPuzzleFlag = 'item_TorchStick';
			}
			else if(armedItem == 'item_TorchStick'){
				InvenPuzzleFlag = 'item_Ribbon';
			}
			else if(armedItem == 'item_PirateTubeEmpty'){
				InvenPuzzleFlag = 'item_PirateDisc';
			}
			else if(armedItem == 'item_PirateDisc'){
				InvenPuzzleFlag = 'item_PirateTubeEmpty';
			}
			else if(armedItem == 'item_Flint'){
				InvenPuzzleFlag = 'item_Marcasite';
			}
			else if(armedItem == 'item_Marcasite'){
				InvenPuzzleFlag = 'item_Flint';
			}
			else if(armedItem == 'item_Jug'){
				InvenPuzzleFlag = 'item_K2SO';
			}
			else if(armedItem == 'item_K2SO'){
				InvenPuzzleFlag = 'item_Jug';
			}
			
			else if(armedItem == 'item_Potatoes'){
				InvenPuzzleFlag = 'item_Wires';
			}
			else if(armedItem == 'item_Wires'){
				InvenPuzzleFlag = 'item_Potatoes';
			}
			
			else if(armedItem == 'item_Slime'){
				InvenPuzzleFlag = 'item_Glass';
			}
			else if(armedItem == 'item_Glass'){
				InvenPuzzleFlag = 'item_Slime';
			}
			
			else if(armedItem == 'item_Hose'){
				InvenPuzzleFlag = 'item_Alcohol';
			}
			else if(armedItem == 'item_Alcohol'){
				InvenPuzzleFlag = 'item_Hose';
			}
			/*
			armedItem == item_Potatoes && targ == item_Wires
			item_Jug
			item_CausticJug
			item_K2SO
			*/
			
			/*
			if(armedItem == item_GreenTestTube){
				InvenPuzzleFlag = 'item_TubeGreen';
			}
			if(armedItem == item_TubeGreen){
				InvenPuzzleFlag = 'item_GreenTestTube';
			}
			*/
			trace("Armed Item: "+targ);
			inventoryBarObj["Set_0"+currentSet].addChildAt(armedHighlight,0);
			ChangeDetail();
			if(DetailLoaded === true){
				DetailObj.ChangeImageDetail();
			}
		}
		
		public function ToggleCloseUp():void{
			trace("Item is Armed");
			if(DetailLoaded === false){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
				if(DetailObj.animating === false){
					DetailObj.animating = true;
					DetailObj.alpha = 0;
					this.addChildAt(DetailObj,0);
					trace("Detail is False;");
					DetailLoaded = true;
					DetailObj.ChangeImageDetail();
					DetailObj.ReadOutReturns();
					DetailObjTween = new Tween(DetailObj,0.5,Transitions.LINEAR);
					DetailObjTween.fadeTo(1);
					DetailObjTween.onComplete = function():void{
						DetailObj.animating = false;
						
					};
					Starling.juggler.add(DetailObjTween);
					//	closeUpSprite.alpha = 1;
				}
			}else{
				if(DetailObj.animating === false){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
					DetailObj.animating = true;
					DetailLoaded = false;
					
					DetailObjTween = new Tween(DetailObj,0.5,Transitions.LINEAR);
					DetailObjTween.fadeTo(0);
					DetailObjTween.onComplete = function():void{
						removeChild(DetailObj);
						DetailObj.animating = false;
					};
					Starling.juggler.add(DetailObjTween);
					
					
					trace("Detail is true;");
					//	closeUpSprite.alpha = 0;
				}
			}
			
		}
		
		private function ChangeDetail():void{
			
			trace('DETAIL DETAIL');
			trace("ArMeD iTeM:"+ armedItem);
			
			/*
			public var item_Celtic:Image;
			public var item_Compass:Image;
			public var item_Piggy:Image;
			public var item_Puller:Image;
			*/
			
			if(armedItem == item_Mushroom){
				trace("item_FrontDoorKey:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_mushroom_sm');
			}
			else if(armedItem == item_Sticks){
				trace("item_Sticks:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_sticks_sm');
			}
			else if(armedItem == item_Gourd){
				trace("item_Sticks:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_gourd_sm');
			}
			//item_GourdWater
			else if(armedItem == item_GourdWater){
				trace("item_GourdWater:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_gourdWater_sm');
			}
			else if(armedItem == item_Motor){
				trace("item_Sticks:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_motor_sm');
			}			
			//item_Pestle
			else if(armedItem == item_Pestle){
				trace("item_Pestle:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pestal_sm');
			}
			else if(armedItem == item_Celtic){
				trace("item_Celtic:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_celtic_sm');
			}
			else if(armedItem == item_Compass){
				trace("item_Compass:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_compass_sm');
			}
		//	else if(armedItem == item_Piggy){
		//		trace("item_Piggy:"+ armedItem);
		//		detailImage.texture = this.assets.getTexture('inven_piggy_sm');
		//	}
			else if(armedItem == item_Puller){
				trace("item_Puller:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_puller_sm');
			}
			else if(armedItem == item_PirateTubeEmpty){
				trace("item_PirateTubeEmpty:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pirateTubeEmpty_sm');
			}
			else if(armedItem == item_PirateTube){
				trace("item_PirateTube:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pirateTubefull_sm');
			}
			else if(armedItem == item_Glass){
				trace("item_Glass:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_glass_sm');
			}
			else if(armedItem == item_RedStoneOne){
				trace("item_RedStoneOne:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_redStoneOne_sm');
			} 
			else if(armedItem == item_RedStoneTwo){
				trace("item_RedStoneTwo:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_redStoneTwo_sm');
			} 
			else if(armedItem == item_WoodCircle){
				trace("item_WoodCircle:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_woodCircle_sm');
			} 
			else if(armedItem == item_Logs){
				trace("item_Logs:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_logs_sm');
			}
			else if(armedItem == item_PirateDisc){
				trace("item_PirateDisc:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pirateTubeDisc_sm');
			}
			else if(armedItem == item_Handle){
				trace("item_Handle:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_handle_sm');
			}
			else if(armedItem == item_Marcasite){
				trace("item_Marcasite:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_marcasite_sm');
			}
			else if(armedItem == item_Flint){
				trace("item_Flint:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_flint_sm');
			}
			else if(armedItem == item_Jaw){
				trace("item_Jaw:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_jaw_sm');
			}
			else if(armedItem == item_FlintAndMarcasite){
				trace("item_FlintAndMarcasite:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_flintandmarcasite_sm');
			}
			else if(armedItem == item_Ribbon){
				trace("item_Ribbon:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_ribbon_sm');
			}
			else if(armedItem == item_TorchStick){
				trace("item_TorchStick:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_torchStick_sm');
			}
			else if(armedItem == item_Torch){
				trace("item_Torch:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_torch_sm');
			}
			else if(armedItem == item_TorchTar){
				trace("item_TorchTar:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_torchTar_sm');
			}
			else if(armedItem == item_TorchBurning){
				trace("item_TorchBurning:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_torchBurning_sm');
			}
			else if(armedItem == item_PlankOne){
				trace("item_PlankOne:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_plankOne_sm');
			}
			else if(armedItem == item_PlankTwo){
				trace("item_PlankTwo:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_plankTwo_sm');
			}
			else if(armedItem == item_Jug){
				trace("item_Jug:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_jug_sm');
			}
			else if(armedItem == item_BlackPowder){
				trace("item_BlackPowder:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_blackPowder_sm');
			}
			else if(armedItem == item_Rope){
				trace("item_Rope:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_rope_sm');
			}
			else if(armedItem == item_CannonTorch){
				trace("item_CannonTorch:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_cannonTorch_sm');
			}
			else if(armedItem == item_CannonTorchBurning){
				trace("item_CannonTorchBurning:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_cannonTorchBurning_sm');
			}
			else if(armedItem == item_K2SO){
				trace("item_K2SO:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_k2so_sm');
			}
			else if(armedItem == item_CausticJug){
				trace("item_CausticJug:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_causticJug_sm');
			}
			else if(armedItem == item_Ladder){
				trace("item_Ladder:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_ladder_sm');
			}
			else if(armedItem == item_Card){
				trace("item_Card:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_card_sm');
			}
			else if(armedItem == item_Seal){
				trace("item_Seal:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_seal_sm');
			}
			else if(armedItem == item_DragonBallOne){
				trace("item_DragonBallOne:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_dragonBallOne_sm');
			}
			else if(armedItem == item_DragonBallThree){
				trace("item_DragonBallThree:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_dragonBallThree_sm');
			}
			//item_DragonBallFive
			else if(armedItem == item_DragonBallFive){
				trace("item_DragonBallFive:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_dragonBallFive_sm');
			}
			else if(armedItem == item_DragonBallTwo){
				trace("item_DragonBallTwo:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_dragonBallTwo_sm');
			}
			else if(armedItem == item_DragonBallSeven){
				trace("item_DragonBallSeven:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_dragonBallSeven_sm');
			}
			
			else if(armedItem == item_ArmMars){
				trace("item_ArmMars:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_armMars_sm');
			}
			else if(armedItem == item_ArmSun){
				trace("item_ArmSun:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_armSun_sm');
			}
			//item_ArmSun
			else if(armedItem == item_PirateKey){
				trace("item_PirateKey:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pirateKey_sm');
			}
			else if(armedItem == item_BlowTorch){
				trace("item_BlowTorch:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_blowtorch_sm');
			}
			else if(armedItem == item_BlowTorchLit){
				trace("item_BlowTorchLit:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_blowtorchLit_sm');
			}
			else if(armedItem == item_Wrench){
				trace("item_Wrench:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_wrench_sm');
			}
			else if(armedItem == item_CoinTiger){
				trace("item_CoinTiger:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_coinTiger_sm');
			}
			else if(armedItem == item_CoinDragon){
				trace("item_CoinDragon:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_coinDragon_sm');
			}
			else if(armedItem == item_Lever){
				trace("item_Lever:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_lever_sm');
			}
			else if(armedItem == item_Screwdriver){
				trace("item_Lever:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_screwdriver_sm');
			}
			else if(armedItem == item_Shovel){
				trace("item_Lever:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_shovel_sm');
			}
			else if(armedItem == item_Satellite){
				trace("item_Lever:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_satellite_sm');
			}
			else if(armedItem == item_Solder){
				trace("item_Solder:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_solder_sm');
			}
			else if(armedItem == item_CoinPhoenix){
				trace("item_CoinPhoenix:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_coinPhoenix_sm');
			}
			else if(armedItem == item_CoinTurtle){
				trace("item_CoinPhoenix:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_coinTurtle_sm');
			}
			else if(armedItem == item_WireCutters){
				trace("item_WireCutters:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_wireCutters_sm');
			}
			else if(armedItem == item_Floppy){
				trace("item_Floppy:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_floppy_sm');
			}
			else if(armedItem == item_SolarPanels){
				trace("item_SolarPanels:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_solarPanals_sm');
			}
			else if(armedItem == item_Wires){
				trace("item_Wires:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_wires_sm');
			}
			else if(armedItem == item_Potatoes){
				trace("item_Potatoes:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_potatoes_sm');
			}
			else if(armedItem == item_PotatoesWired){
				trace("item_PotatoesWired:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_potatoesWired_sm');
			}
			else if(armedItem == item_Ball){
				trace("item_Ball:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_ball_sm');
			}
			else if(armedItem == item_Fish){
				trace("item_Fish:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_fish_sm');
			}
			else if(armedItem == item_SlenderKey){
				trace("item_SlenderKey:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_slenderKey_sm');
			}
			else if(armedItem == item_PickAxe){
				trace("item_PickAxe:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_pickAxe_sm');
			}
			else if(armedItem == item_AncientCoinTwo){
				trace("item_AncientCoinTwo:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_ancientCoinTwo_sm');
			}
			else if(armedItem == item_AncientCoinOne){
				trace("item_AncientCoinOne:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_ancientCoinOne_sm');
			}
			
			else if(armedItem == item_SculptTools){
				trace("item_SculptTools:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_sculptTools_sm');
			}
			else if(armedItem == item_Human){
				trace("item_Human:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_human_sm');
			}
			else if(armedItem == item_Poker){
				trace("item_Poker:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_poker_sm');
			}
			else if(armedItem == item_Bucket){
				trace("item_Bucket:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_bucket_sm');
			}
			else if(armedItem == item_BucketTar){
				trace("item_Bucket:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_bucketTar_sm');
			}
			else if(armedItem == item_Iridium){
				trace("item_Iridium:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_iridium_sm');
			}
			else if(armedItem == item_Hammer){
				trace("item_Hammer:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_hammer_sm');
			}
			else if(armedItem == item_Apple){
				trace("item_Apple:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_apple_sm');
			}
			else if(armedItem == item_Trowel){
				trace("item_Trowel:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_trowel_sm');
			}
			else if(armedItem == item_Hominid){
				trace("item_Hominid:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_hominid_sm');
			}
			else if(armedItem == item_Marble){
				trace("item_Marble:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_marble_sm');
			}
			else if(armedItem == item_Alien){
				trace("item_Alien:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_alien_sm');
			}
			else if(armedItem == item_Tricorder){
				trace("item_Tricorder:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_tricorder_sm');
			}
			else if(armedItem == item_AlienHand){
				trace("item_AlienHand:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_alienHand_sm');
			}
			else if(armedItem == item_Hose){
				trace("item_Hose:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_hose_sm');
			}
			else if(armedItem == item_HoseClean){
				trace("item_HoseClean:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_hoseClean_sm');
			}
			
			else if(armedItem == item_Mirror){
				trace("item_Mirror:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_mirror_sm');
			}
			else if(armedItem == item_Bananas){
				trace("item_Bananas:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_bananas_sm');
			}
			else if(armedItem == item_Plasma){
				trace("item_Plasma:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_plasma_sm');
			}
			
			else if(armedItem == item_CrystalRed){
				trace("item_CrystalRed:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_crystalRed_sm');
			}
			else if(armedItem == item_CrystalGreen){
				trace("item_CrystalGreen:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_crystalGreen_sm');
			}
			else if(armedItem == item_CrystalBlue){
				trace("item_CrystalBlue:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_crystalBlue_sm');
			}
			else if(armedItem == item_CrystalWhite){
				trace("item_CrystalWhite:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_crystalWhite_sm');
			}
			else if(armedItem == item_Slime){
				trace("item_Slime:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_slime_sm');
			}
			else if(armedItem == item_Flower){
				trace("item_Flower:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_flower_sm');
			}
			else if(armedItem == item_Alcohol){
				trace("item_Alcohol:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_alcohol_sm');
			}
			else if(armedItem == item_Slide){
				trace("item_Slide:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_slide_sm');
			}
			else if(armedItem == item_Shell){
				trace("item_Slide:"+ armedItem);
				detailImage.texture = this.assets.getTexture('inven_shell_sm');
			}
			
			/*

	
			*/
			detailImage.alpha = 1;

			
		}
		
		public function addBook():void{
			
		}

		
		public function toggleInvetory():void{
			/*
			Move the inventory bar in/out of view
			*/
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_InvenOpen();
			if(ToggleBar === false){
				toggleButton.texture = this.assets.getTexture('invenToggleOpen_v003a001');
			//	game.screenGamePlayHandler.NoteBookObj.ShowButton(ToggleBar);
				ToggleBar = true;
				
				ToggleBarTween = new Tween(inventoryBarObj,0.25,Transitions.LINEAR);
				ToggleBarTween.animate("y",424);
				ToggleBarTween.onComplete = null;
				
				
//				noteBookTween = new Tween(noteBookButton,0.25,Transitions.LINEAR);
//				noteBookTween.animate("y",345);
//				noteBookTween.onComplete = null;
				
				
//				Starling.juggler.add(noteBookTween);
				Starling.juggler.add(ToggleBarTween);
				
			}else{
				toggleButton.texture = this.assets.getTexture('invenToggleClosed_v003a001');
		//		game.screenGamePlayHandler.NoteBookObj.ShowButton(ToggleBar);
		//		game.screenGamePlayHandler.NoteBookObj.ToggleNoteBook(true);
				ToggleBar = false;
				
				ToggleBarTween = new Tween(inventoryBarObj,0.25,Transitions.LINEAR);
				ToggleBarTween.animate("y",512);
				ToggleBarTween.onComplete = null;
				
//				noteBookTween = new Tween(noteBookButton,0.25,Transitions.LINEAR);
//				noteBookTween.animate("y",400);
//				noteBookTween.onComplete = null;
				
//				Starling.juggler.add(noteBookTween);
				Starling.juggler.add(ToggleBarTween);
				
			}
				//	toggleButton.readjustSize();
			this.addChild(toggleButton);
		}
		
	}
}