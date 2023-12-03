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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class RavineFreighter extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var Sticks:Image;
		private var deck_door:Image;
		private var deck_hatch:Image;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var hit_RavineCanyon:Shape;
		private var hit_RavineFreighterDeck:Shape;
		private var hit_Sticks:Shape;
		
		private var goback:GoBackButton;		
		
		public function RavineFreighter(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineFreighter_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighter/ravineFreighter_bg.jpg'));
				game.TrackAssets('ravineFreighter_01');
			}
			if(game.CheckAsset('ravineFreighter_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighter/RavineFreighter_SpriteSheet.atf'));
				game.TrackAssets('ravineFreighter_02');
			}
			if(game.CheckAsset('ravineFreighter_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineFreighter/RavineFreighter_SpriteSheet.xml'));
				game.TrackAssets('ravineFreighter_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineFreighter","RavineFreighterObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineFreighter_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			deck_door = new Image(this.assets.getTexture('deck_door'));
			
			deck_door.smoothing = TextureSmoothing.NONE;
			deck_door.touchable = false;
			deck_door.x = 344;
			deck_door.y = 103;
			deck_door.alpha = 0;
			
			
			
			deck_hatch = new Image(this.assets.getTexture('deck_hatch'));
			deck_hatch.smoothing = TextureSmoothing.NONE;
			deck_hatch.touchable = false;
			deck_hatch.x = 246;
			deck_hatch.y = 116;
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){	
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterHatch['Lid'] == 'open'){
					deck_hatch.alpha = 1;
					
				}
				else{
					deck_hatch.alpha = 0;
					
					
				}
			}else{
				deck_hatch.alpha = 0;
				
			}
			
			
			
			
			Sticks = new Image(this.assets.getTexture('sticks'));
			Sticks.smoothing = TextureSmoothing.NONE;
			Sticks.touchable = false;
			Sticks.x = 576;
			Sticks.y = 138;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighter != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighter["Sticks"] == "PickedUp"){
					Sticks.alpha = 0;
				}else{
					Sticks.alpha = 1;
				}
			}else{
				Sticks.alpha = 1;
			}
			
			

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck['Hatch'] == 'open'){
					deck_hatch.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighterDeck['Door'] == 'open'){
					deck_door.alpha = 1;
				}
			}
			this.addChildAt(deck_door,1);
			this.addChildAt(deck_hatch,2);
			this.addChildAt(Sticks,3);
			CreateHitSticks();
			
			CreateHitRavineFreighterDeck();
			CreateHitRavineCanyon();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipGroansOne",0,0.5,'stop');

		}
		
		private function CreateHitRavineCanyon():void{
			hit_RavineCanyon = new Shape();
			hit_RavineCanyon.touchable = false;
			hit_RavineCanyon.graphics.beginFill(0xff0000);
			
			hit_RavineCanyon.graphics.lineTo(0,191);	
			hit_RavineCanyon.graphics.lineTo(95,176);	
			hit_RavineCanyon.graphics.lineTo(131,266);	
			hit_RavineCanyon.graphics.lineTo(241,366);	
			hit_RavineCanyon.graphics.lineTo(333,386);	
			hit_RavineCanyon.graphics.lineTo(345,506);	
			hit_RavineCanyon.graphics.lineTo(0,512);	
			hit_RavineCanyon.alpha = 0.0;
			
			hit_RavineCanyon.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineCanyon);
		}		
		
		private function CreateHitSticks():void{
			hit_Sticks = new Shape();
			hit_Sticks.touchable = false;
			hit_Sticks.graphics.beginFill(0xff0000);
			
			hit_Sticks.graphics.lineTo(581,192);	
			hit_Sticks.graphics.lineTo(634,142);	
			hit_Sticks.graphics.lineTo(730,166);	
			hit_Sticks.graphics.lineTo(753,232);	
			hit_Sticks.graphics.lineTo(690,332);	
			hit_Sticks.graphics.lineTo(640,359);	
			hit_Sticks.graphics.lineTo(611,358);	
			hit_Sticks.graphics.lineTo(591,288);	
			hit_Sticks.alpha = 0.0;
			
			hit_Sticks.graphics.precisionHitTest = true;	
			this.addChild(hit_Sticks);
		}		
		//hit_RavineFreighterDeck
		private function CreateHitRavineFreighterDeck():void{
			hit_RavineFreighterDeck = new Shape();
			hit_RavineFreighterDeck.touchable = false;
			hit_RavineFreighterDeck.graphics.beginFill(0xff0000);
			
			hit_RavineFreighterDeck.graphics.lineTo(141,79);	
			hit_RavineFreighterDeck.graphics.lineTo(148,80);	
			hit_RavineFreighterDeck.graphics.lineTo(281,83);	
			hit_RavineFreighterDeck.graphics.lineTo(398,119);	
			hit_RavineFreighterDeck.graphics.lineTo(443,42);	
			hit_RavineFreighterDeck.graphics.lineTo(478,46);	
			hit_RavineFreighterDeck.graphics.lineTo(496,67);	
			hit_RavineFreighterDeck.graphics.lineTo(471,268);	
			hit_RavineFreighterDeck.graphics.lineTo(468,291);	
			hit_RavineFreighterDeck.graphics.lineTo(390,359);	
			hit_RavineFreighterDeck.graphics.lineTo(286,298);	
			hit_RavineFreighterDeck.graphics.lineTo(178,208);	
			hit_RavineFreighterDeck.graphics.lineTo(97,129);	
			hit_RavineFreighterDeck.alpha = 0.0;
			
			hit_RavineFreighterDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineFreighterDeck);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleStump as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleStumpObj,true
						);
					}else if(hit_RavineCanyon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineCanyon as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonObj,true
						);
					}else if(hit_RavineFreighterDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineFreighterDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterDeckObj,true
						);
					}else if(hit_Sticks.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						trace("MUSHROOM CLICKED");
						SticksHandler();
					}
				}
			}
		}
		
		
		
		private function SticksHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighter != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineFreighter["Sticks"] == "PickedUp"){
					
				}else{
					Sticks.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStump;
					SaveArray['Sticks'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighter',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Sticks,
						'item_Sticks',
						'inven_sticks_sm'
					);
					
					
				}
			}else{
				Sticks.alpha = 0;
				SaveArray['Sticks'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineFreighter',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Sticks,
					'item_Sticks',
					'inven_sticks_sm'
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
			
			
			this.assets.removeTexture("ravineFreighter_bg",true);
			this.assets.removeTexture("RavineFreighter_SpriteSheet",true);
			this.assets.removeTextureAtlas("RavineFreighter_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighter_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighter_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineFreighter_03");
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