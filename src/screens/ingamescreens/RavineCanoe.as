package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class RavineCanoe extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var Motor:Image;
		private var Gourd:Image;
		
		private var hit_Gourd:Shape;
		private var hit_Motor:Shape;
		private var hit_bird:Shape;
		private var hit_canoeOne:Shape;
		private var hit_canoeTwo:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function RavineCanoe(_assets:AssetManager,_game:Game)
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
				if(game.CheckAsset('ravineCanoe_01') === false){
					this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanoe/ravineCanoe_bg.jpg'));
					game.TrackAssets('ravineCanoe_01');
				}
				if(game.CheckAsset('ravineCanoe_02') === false){
					this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanoe/RavineCanoe_SpriteSheet.png'));
					game.TrackAssets('ravineCanoe_02');
				}
				if(game.CheckAsset('ravineCanoe_03') === false){
					this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanoe/RavineCanoe_SpriteSheet.xml'));
					game.TrackAssets('ravineCanoe_03');
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
						(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineCanoe","RavineCanoeObj");
					} 				
				});	
				//	goback = new GoBackButton();
				//	goback.alpha = 0;
			}
			
			private function onLoadAssets():void{
				bg = new Image(this.assets.getTexture('ravineCanoe_bg'));
				bg.touchable = true;
				this.addChildAt(bg,0);
				
				Motor = new Image(this.assets.getTexture('pestal'));
				Motor.touchable = false;
				Motor.x = 559;
				Motor.y = 303;
				Motor.alpha = 1;
				
				Gourd = new Image(this.assets.getTexture('gourd'));
				Gourd.touchable = false;
				Gourd.x = 80;
				Gourd.y = 180;

				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe["Gourd"] == "PickedUp"){
						Gourd.alpha = 0;
					}else{
						Gourd.alpha = 1;
					}	
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe["Motor"] == "PickedUp"){
						Motor.alpha = 0;
					}else{
						Motor.alpha = 1;
					}	
				}else{
					Gourd.alpha = 1;
					Motor.alpha = 1;
				}
				this.addChildAt(Motor,1);
				this.addChildAt(Gourd,2);
				
				
				
				CreateHitGourd();
				CreateHitMotor();
				CreateHitBird();
				CreateHitCanoeTwo();
				CreateHitCanoeOne();
				//FadeOutOcean(1);
				
				goback = new GoBackButton(this.assets);
				this.addChild(goback);
				
				
				this.addEventListener(TouchEvent.TOUCH,TouchHandler);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe['SeenIt'] == 'Yes'){
						
					}else{
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe;
						SaveArray['SeenIt'] = 'Yes';					
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);				
					}				
				}else{
					SaveArray['SeenIt'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);
				}
				
				
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			}
			
			private function CreateHitCanoeTwo():void{
				hit_canoeTwo = new Shape();
				hit_canoeTwo.touchable = false;
				hit_canoeTwo.graphics.beginFill(0xff0000);
				
				hit_canoeTwo.graphics.lineTo(466,198);			
				hit_canoeTwo.graphics.lineTo(538,82);			
				hit_canoeTwo.graphics.lineTo(612,0);			
				hit_canoeTwo.graphics.lineTo(678,0);			
				hit_canoeTwo.graphics.lineTo(688,132);			
				hit_canoeTwo.graphics.lineTo(631,246);			
				
				hit_canoeTwo.alpha = 0.0;
				
				hit_canoeTwo.graphics.precisionHitTest = true;	
				this.addChild(hit_canoeTwo);
			}
			
			private function CreateHitCanoeOne():void{
				hit_canoeOne = new Shape();
				hit_canoeOne.touchable = false;
				hit_canoeOne.graphics.beginFill(0xff0000);
				
				hit_canoeOne.graphics.lineTo(78,377);			
				hit_canoeOne.graphics.lineTo(271,274);			
				hit_canoeOne.graphics.lineTo(423,221);			
				hit_canoeOne.graphics.lineTo(416,275);			
				hit_canoeOne.graphics.lineTo(478,429);			
				hit_canoeOne.graphics.lineTo(291,504);			
				hit_canoeOne.graphics.lineTo(127,506);			
		
				hit_canoeOne.alpha = 0.0;
				
				hit_canoeOne.graphics.precisionHitTest = true;	
				this.addChild(hit_canoeOne);
			}
			
			private function CreateHitBird():void{
				hit_bird = new Shape();
				hit_bird.touchable = false;
				hit_bird.graphics.beginFill(0xff0000);
				
				hit_bird.graphics.lineTo(91,57);			
				hit_bird.graphics.lineTo(223,16);			
				hit_bird.graphics.lineTo(325,78);			
				hit_bird.graphics.lineTo(328,201);			
				hit_bird.graphics.lineTo(245,197);			
				hit_bird.graphics.lineTo(178,164);			
				hit_bird.graphics.lineTo(103,166);			
				
				hit_bird.alpha = 0.0;
				
				hit_bird.graphics.precisionHitTest = true;	
				this.addChild(hit_bird);
			}
			
			
			private function CreateHitGourd():void{
				hit_Gourd = new Shape();
				hit_Gourd.touchable = false;
				hit_Gourd.graphics.beginFill(0xff0000);
				
				hit_Gourd.graphics.lineTo(76,238);			
				hit_Gourd.graphics.lineTo(104,177);			
				hit_Gourd.graphics.lineTo(170,174);			
				hit_Gourd.graphics.lineTo(246,206);			
				hit_Gourd.graphics.lineTo(249,248);			
				hit_Gourd.graphics.lineTo(164,297);			
				hit_Gourd.graphics.lineTo(164,297);			
				hit_Gourd.graphics.lineTo(101,288);			
				
				hit_Gourd.alpha = 0.0;
				
				hit_Gourd.graphics.precisionHitTest = true;	
				this.addChild(hit_Gourd);
			}
			
			
			private function CreateHitMotor():void{
				hit_Motor = new Shape();
				hit_Motor.touchable = false;
				hit_Motor.graphics.beginFill(0xff0000);
				
				hit_Motor.graphics.lineTo(524,364);				
				hit_Motor.graphics.lineTo(530,273);				
				hit_Motor.graphics.lineTo(661,275);				
				hit_Motor.graphics.lineTo(656,400);				
				
				
				hit_Motor.alpha = 0.0;
				
				hit_Motor.graphics.precisionHitTest = true;	
				this.addChild(hit_Motor);
			}
			
			private function TouchHandler(e:TouchEvent):void{
				targ = e.target;
				touches = e.getTouches(this);
				if (touches.length > 0){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((RavineCanyon as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonObj,true
							);
						}else if(hit_Gourd.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							trace("MUSHROOM CLICKED");
							GourdHandler();
						}else if(hit_Motor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							trace("MUSHROOM CLICKED");
							MotorHandler();
						}else if(hit_bird.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An abstract painting of a red bird with a long tail.");

						}else if(hit_canoeOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The canoe was made from wood and animal skins.");

						}else if(hit_canoeTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The canoe is a wreck.");

						}
						
					}
				}
			}
			
			private function MotorHandler():void{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe["Motor"] == "PickedUp"){
						
					}else{
						Motor.alpha = 0;
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe;
						SaveArray['Motor'] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Pestle,
							'item_Pestle',
							'inven_pestal_sm'
						);
						
						
					}
				}else{
					Motor.alpha = 0;
					SaveArray['Motor'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Pestle,
						'item_Pestle',
						'inven_pestal_sm'
					);
				}
			}
			
			
			private function GourdHandler():void{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe["Gourd"] == "PickedUp"){
						
					}else{
						Gourd.alpha = 0;
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanoe;
						SaveArray['Gourd'] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Gourd,
							'item_Gourd',
							'inven_gourd_sm'
						);
						
						
					}
				}else{
					Gourd.alpha = 0;
					SaveArray['Gourd'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanoe',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Gourd,
						'item_Gourd',
						'inven_gourd_sm'
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
				
				
				this.assets.removeTexture("ravineCanoe_bg",true);
				this.assets.removeTexture("RavineCanoe_SpriteSheet",true);
				this.assets.removeTextureAtlas("RavineCanoe_SpriteSheet",true);
				(stage.getChildAt(0) as Object).falseAsset("ravineCanoe_01");
				(stage.getChildAt(0) as Object).falseAsset("ravineCanoe_02");
				(stage.getChildAt(0) as Object).falseAsset("ravineCanoe_03");
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
