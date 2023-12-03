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
	
	
	public class RavinePlane extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var left_on:Image;
		private var left_off:Image;
		private var hose:Image;
		private var right_on:Image;
		private var right_off:Image;
		
		private var hit_right:Shape;
		private var hit_left:Shape;
		private var hit_hose:Shape;
		
		private var hit_propellerOne:Shape;
		private var hit_propellerTwo:Shape;
		private var hit_cap:Shape;
		private var hit_plant:Shape;		
		private var hit_dirt:Shape;
		
		private var LeftOpen:Boolean = false;
		private var RightOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function RavinePlane(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravinePlane_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavinePlane/ravinePlane_bg.jpg'));
				game.TrackAssets('ravinePlane_01');
			}
			if(game.CheckAsset('ravinePlane_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavinePlane/RavinePlane_Sprite.atf'));
				game.TrackAssets('ravinePlane_02');
			}
			if(game.CheckAsset('ravinePlane_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavinePlane/RavinePlane_Sprite.xml'));
				game.TrackAssets('ravinePlane_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavinePlane","RavinePlaneObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravinePlane_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			right_off = new Image(this.assets.getTexture('right_off'));
			right_off.smoothing = TextureSmoothing.NONE;

			right_off.touchable = false;
			right_off.x = 415;
			right_off.y = 368;
			
			
			right_on = new Image(this.assets.getTexture('right_on'));
			right_on.smoothing = TextureSmoothing.NONE;

			right_on.touchable = false;
			right_on.x = 355;
			right_on.y = 261;
		
			
			hose = new Image(this.assets.getTexture('hose'));
			hose.smoothing = TextureSmoothing.NONE;

			hose.touchable = false;
			hose.x = 256;
			hose.y = 213;
			
			
			left_off = new Image(this.assets.getTexture('left_off'));
			left_off.smoothing = TextureSmoothing.NONE;

			left_off.touchable = false;
			left_off.x = 0;
			left_off.y = 264;
			
			
			left_on = new Image(this.assets.getTexture('left_on'));
			left_on.smoothing = TextureSmoothing.NONE;

			left_on.touchable = false;
			left_on.x = 219;
			left_on.y = 131;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Left'] == 'Open'){
					LeftOpen = true;
					left_off.alpha = 1;
					left_on.alpha = 0;
					CreateHoseHit();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Hose'] == 'PickedUp'){
						hose.alpha = 0;
					}else{
						hose.alpha = 1;
					}
				}else{
					hose.alpha = 0;
					left_off.alpha = 0;
					left_on.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Right'] == 'Open'){
					RightOpen = true;
					right_off.alpha = 1;
					right_on.alpha = 0;
				}else{
					right_off.alpha = 0;
					right_on.alpha = 1;
				}
				
			}else{
				right_off.alpha = 0;
				right_on.alpha = 1;
				hose.alpha = 0;
				left_off.alpha = 0;
				left_on.alpha = 1;
			}
			
			
		
			
			
			this.addChildAt(right_off,1);
			this.addChildAt(right_on,2);
			this.addChildAt(hose,3);		
			this.addChildAt(left_off,4);		
			this.addChildAt(left_on,5);
			/*
			private var left_on:Image;
			private var left_off:Image;
			private var hose:Image;
			private var right_on:Image;
			private var right_off:Image;
			*/
			//FadeOutOcean(1);
			CreateDirtHit();
			CreateCapHit();
			CreatePlantHit();
			CreatePropellerOneHit();
			CreatePropellerTwoHit();
			
			CreateRightHit(RightOpen);
			CreateLeftHit(LeftOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Crows';
			},0.7);
		}
		private function CreateDirtHit():void{
			hit_dirt = new Shape();
			hit_dirt.touchable = false;
			hit_dirt.graphics.beginFill(0xff0000);
			
			hit_dirt.graphics.lineTo(413,0);	
			hit_dirt.graphics.lineTo(800,0);	
			hit_dirt.graphics.lineTo(800,266);	
			
			hit_dirt.graphics.endFill(false);
			hit_dirt.alpha = 0.0;
			
			hit_dirt.graphics.precisionHitTest = true;	
			this.addChild(hit_dirt);
		}
		
		private function CreatePlantHit():void{
			hit_plant = new Shape();
			hit_plant.touchable = false;
			hit_plant.graphics.beginFill(0xff0000);
			
			hit_plant.graphics.lineTo(0,0);	
			hit_plant.graphics.lineTo(67,7);	
			hit_plant.graphics.lineTo(179,142);	
			hit_plant.graphics.lineTo(190,371);	
			hit_plant.graphics.lineTo(0,371);	
		
			hit_plant.graphics.endFill(false);
			hit_plant.alpha = 0.0;
			
			hit_plant.graphics.precisionHitTest = true;	
			this.addChild(hit_plant);
		}
		
		private function CreateCapHit():void{
			hit_cap = new Shape();
			hit_cap.touchable = false;
			hit_cap.graphics.beginFill(0xff0000);
			
			hit_cap.graphics.lineTo(320,157);	
			hit_cap.graphics.lineTo(384,97);	
			hit_cap.graphics.lineTo(495,130);	
			hit_cap.graphics.lineTo(505,243);	
			hit_cap.graphics.lineTo(400,282);	
						
			hit_cap.graphics.endFill(false);
			hit_cap.alpha = 0.0;
			
			hit_cap.graphics.precisionHitTest = true;	
			this.addChild(hit_cap);
		}
		
		private function CreatePropellerTwoHit():void{
			hit_propellerTwo = new Shape();
			hit_propellerTwo.touchable = false;
			hit_propellerTwo.graphics.beginFill(0xff0000);
			
			hit_propellerTwo.graphics.lineTo(509,179);	
			hit_propellerTwo.graphics.lineTo(608,229);	
			hit_propellerTwo.graphics.lineTo(705,305);	
			hit_propellerTwo.graphics.lineTo(684,336);	
			hit_propellerTwo.graphics.lineTo(589,298);	
			hit_propellerTwo.graphics.lineTo(507,234);	
			
			hit_propellerTwo.graphics.endFill(false);
			hit_propellerTwo.alpha = 0.0;
			
			hit_propellerTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_propellerTwo);
		}
		
		private function CreatePropellerOneHit():void{
			hit_propellerOne = new Shape();
			hit_propellerOne.touchable = false;
			hit_propellerOne.graphics.beginFill(0xff0000);
			
			hit_propellerOne.graphics.lineTo(75,27);	
			hit_propellerOne.graphics.lineTo(110,7);	
			hit_propellerOne.graphics.lineTo(379,128);	
			hit_propellerOne.graphics.lineTo(357,165);	
			
			
			hit_propellerOne.graphics.endFill(false);
			hit_propellerOne.alpha = 0.0;
			
			hit_propellerOne.graphics.precisionHitTest = true;	
			this.addChild(hit_propellerOne);
		}
		
		private function CreateHoseHit():void{
			hit_hose = new Shape();
			hit_hose.touchable = false;
			hit_hose.graphics.beginFill(0xff0000);
			
			hit_hose.graphics.lineTo(237,254);	
			hit_hose.graphics.lineTo(292,197);	
			hit_hose.graphics.lineTo(338,201);	
			hit_hose.graphics.lineTo(435,275);	
			hit_hose.graphics.lineTo(415,320);	
			hit_hose.graphics.lineTo(316,291);	
			hit_hose.graphics.lineTo(253,289);	

			hit_hose.graphics.endFill(false);
			hit_hose.alpha = 0.0;
			
			hit_hose.graphics.precisionHitTest = true;	
			this.addChild(hit_hose);
		}
		
		
		private function CreateRightHit(open:Boolean = false):void{
			
			hit_right = new Shape();
			hit_right.touchable = false
			
			if(open === false){
				hit_right.x = 0;
				hit_right.y = 0;
				
				hit_right.graphics.beginFill(0x00FF00);
				
				hit_right.graphics.lineTo(367,430);		
				hit_right.graphics.lineTo(446,311);		
				hit_right.graphics.lineTo(450,284);		
				hit_right.graphics.lineTo(511,247);		
				hit_right.graphics.lineTo(520,264);		
				hit_right.graphics.lineTo(448,417);		
				
				hit_right.graphics.endFill(false);
				hit_right.alpha = 0.0;
				hit_right.graphics.precisionHitTest = true;
			}else{
				hit_right.x = 0;
				hit_right.y = 0;
				
				hit_right.graphics.beginFill(0x00FF00);
				
				hit_right.graphics.lineTo(478,355);	
				hit_right.graphics.lineTo(698,383);	
				hit_right.graphics.lineTo(673,480);	
				hit_right.graphics.lineTo(433,465);	
				
				hit_right.graphics.endFill(false);
				hit_right.alpha = 0.0;
				hit_right.graphics.precisionHitTest = true;	
			}
			
			addChild(hit_right);
		}

		private function CreateLeftHit(open:Boolean = false):void{
			
			hit_left = new Shape();
			hit_left.touchable = false
			
			if(open === false){
				hit_left.x = 0;
				hit_left.y = 0;
				
				hit_left.graphics.beginFill(0x00FF00);
				
				hit_left.graphics.lineTo(216,281);		
				hit_left.graphics.lineTo(258,167);		
				hit_left.graphics.lineTo(304,141);		
				hit_left.graphics.lineTo(318,161);		
				hit_left.graphics.lineTo(337,233);		
				hit_left.graphics.lineTo(396,286);		
				hit_left.graphics.lineTo(443,296);		
				hit_left.graphics.lineTo(360,430);		
				hit_left.graphics.lineTo(298,433);		
				hit_left.graphics.lineTo(247,387);		
				
				hit_left.graphics.endFill(false);
				hit_left.alpha = 0.0;
				hit_left.graphics.precisionHitTest = true;
			}else{
				hit_left.x = 0;
				hit_left.y = 0;
				
				hit_left.graphics.beginFill(0x00FF00);
				
				hit_left.graphics.lineTo(73,392);	
				hit_left.graphics.lineTo(200,277);	
				hit_left.graphics.lineTo(226,376);	
				hit_left.graphics.lineTo(323,471);	
				hit_left.graphics.lineTo(275,509);	
				hit_left.graphics.lineTo(63,505);	
				
				hit_left.graphics.endFill(false);
				hit_left.alpha = 0.0;
				hit_left.graphics.precisionHitTest = true;	
			}
			
			addChild(hit_left);
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
					}else if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LeftHandler();
					}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RightHandler();
					}else if(hit_propellerOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the plane's propeller blades.");
					}else if(hit_propellerTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The propeller is badly rusted.");
					}else if(hit_cap.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The front cap of a single engine plane.");
					}else if(hit_plant.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Tiny aphids crawl on the plant's leaves.");
					}else if(hit_dirt.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleRavine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						)
						
					}else if(LeftOpen === true){
						if(hit_hose.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HoseHandler();
						}
					}
					
					/*
					private var hit_propellerOne:Shape;
					private var hit_propellerTwo:Shape;
					private var hit_cap:Shape;
					private var hit_plant:Shape;		
					private var hit_dirt:Shape;
					*/

					
				}
			}
		}
		
		private function HoseHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Hose'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The engine has weathered into a solid mass of rust and dirt.");

				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();

					hose.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane;
					}
					SaveArray['Hose'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hose,
						'item_Hose',
						'inven_hose_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();

				hose.alpha = 0;
				SaveArray['Hose'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hose,
					'item_Hose',
					'inven_hose_sm'
				);	
			}
		}
		
		private function LeftHandler():void{
			if(LeftOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();

				trace("OPENING LEFT");
				LeftOpen = true;
				left_on.alpha = 0;
				left_off.alpha = 1;
				hit_left.graphics.clear();
				CreateLeftHit(true);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Hose'] == 'PickedUp'){
						hose.alpha = 0;
					}else{
						hose.alpha = 1;
					}
				}else{
					hose.alpha = 1;
				}
				CreateHoseHit();
				SaveArray['Left'] = 'Open';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();

				trace("CLOSEING LEFT");
				LeftOpen = false;
				left_on.alpha = 1;
				left_off.alpha = 0;
				hose.alpha = 0;
				this.removeChild(hit_hose);
				hit_left.graphics.clear();
				CreateLeftHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane;
				}
				SaveArray['Left'] = 'Closed';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
				
			}
		}
		
		private function RightHandler():void{
			if(RightOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();

				RightOpen = true;
				right_on.alpha = 0;
				right_off.alpha = 1;
				hit_right.graphics.clear();
				CreateRightHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane;
				}
				SaveArray['Right'] = 'Open';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();

				RightOpen = false;
				right_on.alpha = 1;
				right_off.alpha = 0;
				hit_right.graphics.clear();
				CreateRightHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane;
				}
				SaveArray['Right'] = 'Closed';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavinePlane',SaveArray);
				
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
			
			
			this.assets.removeTexture("ravinePlane_bg",true);
			this.assets.removeTexture("RavinePlane_Sprite",true);
			this.assets.removeTextureAtlas("RavinePlane_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravinePlane_01");
			(stage.getChildAt(0) as Object).falseAsset("ravinePlane_02");
			(stage.getChildAt(0) as Object).falseAsset("ravinePlane_03");
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
