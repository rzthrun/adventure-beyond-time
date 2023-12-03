package screens.inventory
{
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class InventoryBar extends Sprite
	{
		public var bg:Image;
		public var item_Mushroom:Image;
		public var item_Sticks:Image;
		public var item_Gourd:Image;
		public var item_GourdWater:Image;
		public var item_Motor:Image;
		public var item_Pestle:Image;
		public var item_Celtic:Image;
		public var item_Compass:Image;
		//public var item_Piggy:Image;
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
		public var item_DragonBallOne:Image;
		public var item_DragonBallThree:Image;
		public var item_DragonBallFive:Image;
		public var item_DragonBallTwo:Image;		
		public var item_DragonBallSeven:Image;
		public var item_ArmMars:Image;
		public var item_ArmSun:Image;
		public var item_PirateKey:Image;
		public var item_BlowTorch:Image;
		public var item_BlowTorchLit:Image;
		public var item_Wrench:Image;
		public var item_CoinTiger:Image;
		public var item_Lever:Image;
		public var item_Screwdriver:Image;
		public var item_Shovel:Image;
		public var item_CoinDragon:Image;
		public var item_Satellite:Image;
		public var item_Solder:Image;
		public var item_CoinPhoenix:Image;
		public var item_CoinTurtle:Image;
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
		public var item_Flower:Image;
		public var item_Alcohol:Image;
		public var item_Slide:Image;
		public var item_Shell:Image;
		
		public var Set_01:Sprite;
		public var Set_02:Sprite;
		public var Set_03:Sprite;
		public var Set_04:Sprite;
		public var Set_05:Sprite;
		
		public var leftArrow:Image;
		public var hit_LeftArrow:Shape;
		public var rightArrow:Image;
		public var hit_RightArrow:Shape;
		
		
		public function InventoryBar()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			Set_01 = new Sprite();
			Set_02 = new Sprite();
			Set_03 = new Sprite();
			Set_04 = new Sprite();
			Set_05 = new Sprite();
			
			this.addChild(Set_01);
			Set_01.x = 70;
			Set_01.y = 18;
			Set_01.touchable = true;
			Set_01.alpha = 1;
			this.addChild(Set_02);
			Set_02.x = 70;
			Set_02.y = 18;
			Set_02.touchable = false;
			Set_02.alpha = 0;
			this.addChild(Set_03);
			Set_03.x = 70;
			Set_03.y = 18;
			Set_03.touchable = false;
			Set_03.alpha = 0;
			this.addChild(Set_04);
			Set_04.x = 70;
			Set_04.y = 18;
			Set_04.touchable = false;
			Set_04.alpha = 0;
			this.addChild(Set_05);
			Set_05.x = 70;
			Set_05.y = 18;
			Set_05.touchable = false;
			Set_05.alpha = 0;
			

		}
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);

		}
		public function addBg(_bg:Image):void{
			bg = _bg;
			this.addChildAt(bg,0);
		}
		public function addLeftArrow(_arrow:Image):void{
			leftArrow = _arrow;
			
			leftArrow.x = 20;
			leftArrow.y = 18;
			leftArrow.touchable = false;
			this.addChildAt(leftArrow,1);
			
			hit_LeftArrow = new Shape();
			addChildAt(hit_LeftArrow,2);
			hit_LeftArrow.graphics.beginFill(0x00FF00);
			hit_LeftArrow.graphics.lineTo(20,18);	
			hit_LeftArrow.graphics.lineTo(55,18);	
			hit_LeftArrow.graphics.lineTo(55,88);	
			hit_LeftArrow.graphics.lineTo(20,88);	
			hit_LeftArrow.touchable = false;
			hit_LeftArrow.graphics.endFill(false);
			hit_LeftArrow.alpha = 0.0;
			hit_LeftArrow.graphics.precisionHitTest = true;	
		}
		
		public function addRightArrow(_arrow:Image):void{
			rightArrow = _arrow;
			rightArrow.x = 500;
			rightArrow.y = 18;
			rightArrow.touchable = false;
			this.addChildAt(rightArrow,1);
			
			hit_RightArrow = new Shape();
			addChildAt(hit_RightArrow,2);
			hit_RightArrow.graphics.beginFill(0x00FF00);
			hit_RightArrow.graphics.lineTo(500,18);	
			hit_RightArrow.graphics.lineTo(535,18);	
			hit_RightArrow.graphics.lineTo(535,88);	
			hit_RightArrow.graphics.lineTo(500,88);	
			
			hit_RightArrow.graphics.endFill(false);
			hit_RightArrow.alpha = 0.0;
			hit_RightArrow.touchable = false;
			hit_RightArrow.graphics.precisionHitTest = true;	
		}
		
		public function addItem(item,itemName,currentSet):void{
			this[itemName] = item;
			if(currentSet == 1){
				this.Set_01.addChild(item);
				Set_01.touchable = true;
				Set_01.alpha = 1;
				Set_02.touchable = false;
				Set_02.alpha = 0;
				Set_03.touchable = false;
				Set_03.alpha = 0;
				Set_04.touchable = false;
				Set_04.alpha = 0;
				Set_05.touchable = false;
				Set_05.alpha = 0;
			}
			if(currentSet == 2){
				this.Set_02.addChild(item);
				Set_01.touchable = false;
				Set_01.alpha = 0;
				Set_02.touchable = true;
				Set_02.alpha = 1;
				Set_03.touchable = false;
				Set_03.alpha = 0;
				Set_04.touchable = false;
				Set_04.alpha = 0;
				Set_05.touchable = false;
				Set_05.alpha = 0;
			}
			if(currentSet == 3){
				this.Set_03.addChild(item);
				Set_01.touchable = false;
				Set_01.alpha = 0;
				Set_02.touchable = false;
				Set_02.alpha = 0;
				Set_03.touchable = true;
				Set_03.alpha = 1;
				Set_04.touchable = false;
				Set_04.alpha = 0;
				Set_05.touchable = false;
				Set_05.alpha = 0;
			}
			if(currentSet == 4){
				this.Set_04.addChild(item);
				Set_01.touchable = false;
				Set_01.alpha = 0;
				Set_02.touchable = false;
				Set_02.alpha = 0;
				Set_03.touchable = false;
				Set_03.alpha = 0;
				Set_04.touchable = true;
				Set_04.alpha = 1;
				Set_05.touchable = false;
				Set_05.alpha = 0;
			}
			if(currentSet == 5){
				this.Set_05.addChild(item);
				Set_01.touchable = false;
				Set_01.alpha = 0;
				Set_02.touchable = false;
				Set_02.alpha = 0;
				Set_03.touchable = false;
				Set_03.alpha = 0;
				Set_04.touchable = false;
				Set_04.alpha = 0;
				Set_05.touchable = true;
				Set_05.alpha = 1;
			}
		}
		public function removeItem(item,itemName,currentSet):void{
			this["Set_0"+currentSet].removeChild(item);
			
			
		}
		
	}
}