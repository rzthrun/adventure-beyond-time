package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class CavePirateCannon extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lid:Image;
		private var powder_packed:Image;
		private var powder_spent:Image;
		private var wick:Image;
		
		private var mist:Image;
		private var spark:Image;
		private var smoke_chamber:Image;
		private var smoke_barrel:Image;
		private var smoke_string:Image;
		
		private var hit_lid:Shape;
		private var hit_wick:Shape;
		private var hit_chamber:Shape;
		
		private var hit_sky:Shape;
		
		private var LidOpen:Boolean = false;
		private var PowderAdded:Boolean = false;
		private var PowderSpent:Boolean = false;
		private var Animating:Boolean = false;
		
		private var SparkTween:Tween;
		private var SmokeStringTween:Tween;
		private var SmokeBarrelTween:Tween;
		private var MistTween:Tween;
		private var MistTweenTwo:Tween;
		public var delayedcall:DelayedCall;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CavePirateCannon(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('pirateCannon_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCannon/pirateCannon_bg.jpg'));
				game.TrackAssets('pirateCannon_01');
			}
			if(game.CheckAsset('pirateCannon_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCannon/CavePirateCannon_Sprite.atf'));
				game.TrackAssets('pirateCannon_02');
			}
			if(game.CheckAsset('pirateCannon_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCannon/CavePirateCannon_Sprite.xml'));
				game.TrackAssets('pirateCannon_03');
			}
			if(game.CheckAsset('pirateCannon_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCannon/CavePirateCannon_Sprite_Two.png'));
				game.TrackAssets('pirateCannon_04');
			}
			if(game.CheckAsset('pirateCannon_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCannon/CavePirateCannon_Sprite_Two.xml'));
				game.TrackAssets('pirateCannon_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateCannon","CavePirateCannonObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateCannon_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 455;
			lid.y = 217;
					
			powder_spent = new Image(this.assets.getTexture('packed_spent'));
			powder_spent.smoothing = TextureSmoothing.NONE;
			powder_spent.touchable = false;
			powder_spent.x = 486;
			powder_spent.y = 246;
	
			powder_packed = new Image(this.assets.getTexture('packed_powder'));
			powder_packed.smoothing = TextureSmoothing.NONE;
			powder_packed.touchable = false;
			powder_packed.x = 514;
			powder_packed.y = 279;
				
			wick = new Image(this.assets.getTexture('wick'));
			wick.smoothing = TextureSmoothing.NONE;
			wick.touchable = false;
			wick.x = 473;
			wick.y = 151;

			spark = new Image(this.assets.getTexture('spark'));
			//spark.smoothing = TextureSmoothing.NONE;
			spark.touchable = false;
			spark.x = 470;
			spark.y = 100;
									
			smoke_barrel = new Image(this.assets.getTexture('smoke_barrel'));
			
			smoke_barrel.touchable = false;
			smoke_barrel.x = 195;
			smoke_barrel.y = 0;
									
			smoke_chamber = new Image(this.assets.getTexture('smoke_chamber'));
			smoke_chamber.touchable = false;
			smoke_chamber.x = 500;
			smoke_chamber.y = 82;
			
			smoke_string = new Image(this.assets.getTexture('smoke_string'));
			smoke_string.touchable = false;
			smoke_string.x = 425;
			smoke_string.y = 0;

			mist = new Image(this.assets.getTexture('mist'));
			mist.touchable = false;
			mist.x = 0;
			mist.y = 0;
			mist.width = 800;
			mist.height = 512;
			mist.alpha = 0;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Lid'] == 'open'){
					LidOpen = true;
					lid.alpha = 1;		
					CreateLidHit(true);
					CreateChamberHit();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Added'){
						PowderAdded = true;
						powder_packed.alpha = 1;
					}else{
						
						powder_packed.alpha = 0;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Spent'){
						PowderAdded = true;
						PowderSpent = true;
						powder_spent.alpha = 1;
						//powder_packed.alpha = 0;
						wick.alpha = 0;
					}else{
						wick.alpha = 1;
						powder_spent.alpha = 0;
					//	powder_packed.alpha = 0;
					}
					
				}else{
					powder_spent.alpha = 0;
					powder_packed.alpha = 0;
					lid.alpha = 0;		
					CreateLidHit(false);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Added'){
						PowderAdded = true;
						wick.alpha = 1;	
					}
					else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Spent'){
						PowderAdded = true;
						PowderSpent = true;
						wick.alpha = 0;
					}else{
						wick.alpha = 1;
					}
				}
			}else{
				powder_packed.alpha = 0;
				powder_spent.alpha = 0;
				wick.alpha = 1;
				lid.alpha = 0;
				CreateLidHit(false);
			}
			
			
				
		
			
			
			spark.alpha = 0;
			smoke_barrel.alpha = 0;
			smoke_chamber.alpha = 0;
			smoke_string.alpha = 0;
			
			this.addChildAt(lid,1);
			this.addChildAt(powder_spent,2);
			this.addChildAt(powder_packed,3);
			this.addChildAt(wick,4);
			this.addChildAt(spark,5);
			this.addChildAt(smoke_barrel,6);
			this.addChildAt(smoke_chamber,7);
			this.addChildAt(smoke_string,8);
			this.addChildAt(mist,8);
			
			CreateSkyHit();
			CreateWickHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			},1);
			
		}
		//hit_sky
		private function CreateSkyHit():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(161,0);	
			hit_sky.graphics.lineTo(476,0);	
			hit_sky.graphics.lineTo(464,119);	
			hit_sky.graphics.lineTo(271,192);	
			hit_sky.graphics.lineTo(185,168);	
		
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateWickHit():void{
			hit_wick = new Shape();
			hit_wick.touchable = false;
			hit_wick.graphics.beginFill(0xff0000);
			
			hit_wick.graphics.lineTo(458,152);	
			hit_wick.graphics.lineTo(476,133);	
			hit_wick.graphics.lineTo(503,133);	
			hit_wick.graphics.lineTo(520,147);	
			hit_wick.graphics.lineTo(530,197);	
			hit_wick.graphics.lineTo(476,211);	
			hit_wick.graphics.lineTo(470,193);	

			hit_wick.graphics.endFill(false);
			hit_wick.alpha = 0.0;
			
			hit_wick.graphics.precisionHitTest = true;	
			this.addChild(hit_wick);
		}
		
		
		private function CreateChamberHit():void{
			hit_chamber = new Shape();
			hit_chamber.touchable = false;
			hit_chamber.graphics.beginFill(0xff0000);
			
			hit_chamber.graphics.lineTo(473,296);	
			hit_chamber.graphics.lineTo(517,241);	
			hit_chamber.graphics.lineTo(580,232);	
			hit_chamber.graphics.lineTo(617,261);	
			hit_chamber.graphics.lineTo(617,332);	
			hit_chamber.graphics.lineTo(585,369);	
			hit_chamber.graphics.lineTo(530,384);	
			hit_chamber.graphics.lineTo(485,355);	
				
			hit_chamber.graphics.endFill(false);
			hit_chamber.alpha = 0.0;
			
			hit_chamber.graphics.precisionHitTest = true;	
			this.addChild(hit_chamber);
		}
		
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				hit_lid.graphics.lineTo(455,261);
				hit_lid.graphics.lineTo(495,218);
				hit_lid.graphics.lineTo(547,205);
				hit_lid.graphics.lineTo(605,220);
				hit_lid.graphics.lineTo(639,261);
				hit_lid.graphics.lineTo(656,326);
				hit_lid.graphics.lineTo(626,394);
				hit_lid.graphics.lineTo(555,419);
				hit_lid.graphics.lineTo(484,400);
				hit_lid.graphics.lineTo(447,357);
				hit_lid.graphics.lineTo(441,295);

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(618,240);
				hit_lid.graphics.lineTo(644,216);
				hit_lid.graphics.lineTo(710,210);
				hit_lid.graphics.lineTo(760,229);
				hit_lid.graphics.lineTo(795,264);
				hit_lid.graphics.lineTo(795,366);
				hit_lid.graphics.lineTo(763,398);
				hit_lid.graphics.lineTo(690,413);
				hit_lid.graphics.lineTo(636,372);
				hit_lid.graphics.lineTo(617,336);
			
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			
		}		

		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CavePirateTopDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateTopDeckObj,true
							);
		
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							LidHandler();
						}else if(hit_wick.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							WickHandler();
						}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cannon is pointed toward the sea.");
							
						}else if(LidOpen === true){
							if(hit_chamber.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								ChamberHandler();
							}
						}else{
							
						}
					}
				}
			}
		}
		
		private function WickHandler():void{
			if(PowderSpent === false){
				if(LidOpen === false){
					if(PowderAdded === false){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_CannonTorchBurning)
							
						{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Igniting the wick is pointless unless there is a combustible inside the cannon's chamber.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This fuse is used to provide a delay and distance between the explosive substance inside the cannon and oneself.");
						}
					}else{
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_CannonTorchBurning)
							
						{
							trace("Torch_hit");
							
							
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
								.InventoryObj.removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_CannonTorchBurning,
									"item_CannonTorchBurning"
								);
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon;
							}
							SaveArray['Powder'] = 'Spent';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateCannon',SaveArray);	
							
							
							PowderSpent = true;
							SparkAnima();
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Now that the powder is added, and the breach is closed, I can try to ignite the fuse.");
						}
					}
				}else{
					if(PowderAdded === false){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_CannonTorchBurning)
							
						{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Igniting the wick is pointless unless there is a combustible inside the cannon's chamber.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This fuse is used to provide a delay and distance between the explosive substance inside the cannon and oneself.");
						}
					}else{
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_CannonTorchBurning)
							
						{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to close the breach of the cannon before trying to ignite the fuse... Otherwise I am very likely to get hurt.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This fuse is used to provide a delay and distance between the explosive substance inside the cannon and oneself.");
						}
					}
				}
			}else{				
				
			}
		}
		/*
		private var mist:Image;
		private var spark:Image;
		private var smoke_chamber:Image;
		private var smoke_barrel:Image;
		private var smoke_string:Image;
		
		private var SparkTween:Tween;
		private var SmokeStringTween:Tween;
		private var SmokeBarrelTwwen:Tween;
		private var MistTween:Tween;
		
		spark.x = 470;
		spark.y = 100;
		*/
		
		
		
		private function SparkAnima():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Match();
			Animating = true;
			
			spark.alpha = 1;
			SparkTween = new Tween(spark, 2, Transitions.EASE_IN_OUT);
			SparkTween.moveTo(479,132);
			SparkTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
				spark.alpha = 0;
				wick.alpha = 0;
				StringSmokeAnima(1,1);

			};
			Starling.juggler.add(SparkTween);
		}
		
		public function StringSmokeAnima(FadeToVal,Duration):void{
			SmokeStringTween = new Tween(smoke_string, Duration, Transitions.LINEAR);
			SmokeStringTween.fadeTo(FadeToVal);
			SmokeStringTween.onComplete = function():void{	
				BarrelSmokeAnima()
			}
			Starling.juggler.add(SmokeStringTween);
		}
		public function StringSmokeAnima_Two(FadeToVal,Duration):void{
			SmokeStringTween = new Tween(smoke_string, Duration, Transitions.LINEAR);
			SmokeStringTween.fadeTo(FadeToVal);
			SmokeStringTween.onComplete = function():void{	
				//BarrelSmokeAnima()
			}
			Starling.juggler.add(SmokeStringTween);
		}
		public function BarrelSmokeAnima():void{
			SmokeBarrelTween = new Tween(smoke_barrel, 1, Transitions.LINEAR);
			SmokeBarrelTween.fadeTo(1);
			SmokeBarrelTween.onComplete = function():void{	
				
				StringSmokeAnima_Two(0,3);
				MistAnima(1,2);
			}
			Starling.juggler.add(SmokeBarrelTween);
		}
		public function MistAnima(FadeToVal,Duration):void{
			MistTween = new Tween(mist, Duration, Transitions.LINEAR);
			MistTween.fadeTo(FadeToVal);
			MistTween.onComplete = function():void{	
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Lighting the cannon did nothing more than create a bunch of smoke... (COUGH! COUGH!) ..uhh.");
				
				delayedcall = new DelayedCall(MistAnimaTwo,2);
				Starling.juggler.add(delayedcall);
			}
			Starling.juggler.add(MistTween);
		}
		public function MistAnimaTwo():void{
		//	Starling.juggler.purge();
			MistTween = new Tween(mist, 2.5, Transitions.LINEAR);
			MistTween.fadeTo(0);
			MistTween.onComplete = function():void{	
				Animating = false;
				
			}
				
			SmokeBarrelTween = new Tween(smoke_barrel, 3.5, Transitions.LINEAR);
			SmokeBarrelTween.fadeTo(0);
			SmokeBarrelTween.onComplete = function():void{	
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					(stage.getChildAt(0) as Object).MusicObj.LoadDeepDrums(true,2);
				}	
				
				
			//	Starling.juggler.purge();
			}
				
			Starling.juggler.add(SmokeBarrelTween);
			Starling.juggler.add(MistTween);
		}
		
		
		private function ChamberHandler():void{
			if(PowderAdded === false){
				
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_BlackPowder)
					
				{
					PowderAdded = true;
					powder_packed.alpha = 1;
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_BlackPowder,
							"item_BlackPowder"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon;
					}
					SaveArray['Powder'] = 'Added';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateCannon',SaveArray);	
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed the black powder inside the chamber of the cannon.");
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cannon's breach.");

				}
				
			}else{
				if(PowderSpent === false){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_CannonTorchBurning)
						
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Igniting the powder directly is not a good idea. I am certain to get hurt.");
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Black powder is a combustible. It can be very dangerous in any quantity. I must be careful.");
					}
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){	
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['K2SO'] == 'PickedUp'){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The inside of the cannon is covered in the residue produced by the burning of the black powder.");
						}else{
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon;
							SaveArray['K2SO'] = "PickedUp";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateCannon',SaveArray);
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_K2SO,
								'item_K2SO',
								'inven_k2so_sm'
							);
							
						}
					}else{
						
						SaveArray['K2SO'] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateCannon',SaveArray);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_K2SO,
							'item_K2SO',
							'inven_k2so_sm'
						);
						
					}
				}
				

			}
		}
		
		
		private function LidHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Lid'] != 'open'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
					trace(1);
					SaveArray['Lid'] = 'open';
					
					lid.alpha = 1;
					hit_lid.graphics.clear();
					CreateLidHit(true);
					LidOpen = true;
					CreateChamberHit();
					
					//CreateJunkInteriorHit();
					if(PowderAdded === true){
						if(PowderSpent === true){
							powder_spent.alpha = 1;	
						}else{
							powder_packed.alpha = 1;
						}
					}else{
						powder_packed.alpha = 0;
					}
					
					
					if(PowderSpent === true){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['FirstChange'] == 'Yes'){
						}else{	
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon;
							SaveArray['FirstChange'] = 'Yes';

							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
							},1);
						}
					
					}
					
					
				//	
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyClose();
					trace(2);
					SaveArray['Lid'] = 'close';
					
					lid.alpha = 0;
					powder_packed.alpha = 0;
					powder_spent.alpha = 0;	
					
					removeChild(hit_chamber);
					hit_lid.graphics.clear();
					
					CreateLidHit(false);
					LidOpen = false;
				//	CelticTriangle.alpha = 0;
				}
				
			}else{
				trace(3);
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
				SaveArray['Lid'] = 'open';			
				lid.alpha = 1;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				CreateChamberHit();
				LidOpen = true;


				if(PowderAdded === true){
					if(PowderSpent === true){
						powder_spent.alpha = 1;	
						powder_packed.alpha = 0;
					}else{
						powder_packed.alpha = 1;
					}
				}else{
					powder_packed.alpha = 0;
				}
			
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateCannon',SaveArray);	
			
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
			
			
			this.assets.removeTexture("pirateCannon_bg",true);
			this.assets.removeTexture("CavePirateCannon_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateCannon_Sprite",true);
			this.assets.removeTexture("CavePirateCannon_Sprite_Two",true);
			this.assets.removeTextureAtlas("CavePirateCannon_Sprite_Two",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateCannon_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateCannon_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateCannon_03");
			(stage.getChildAt(0) as Object).falseAsset("pirateCannon_04");
			(stage.getChildAt(0) as Object).falseAsset("pirateCannon_05");
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
import screens.ingamescreens.CavePirateDeck;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

