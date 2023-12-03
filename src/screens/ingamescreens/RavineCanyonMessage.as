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
	

	public class RavineCanyonMessage extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_message:Shape;
		private var hit_anchor:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function RavineCanyonMessage(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineCanyonMessage_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyonMessage/ravineCanyonMessage_bg.jpg'));
				game.TrackAssets('ravineCanyonMessage_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineCanyonMessage","RavineCanyonMessageObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineCanyonMessage_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			
			//FadeOutOcean(1);
			CreateHitAnchor();
			CreateHitMeassage();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonMessage != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonMessage['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonMessage;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanyonMessage',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanyonMessage',SaveArray);
			}
		}
		
		/*
		private var hit_message:Shape;
		private var hit_anchor:Shape;
		*/
		private function CreateHitAnchor():void{
			hit_anchor = new Shape();
			hit_anchor.touchable = false;
			hit_anchor.graphics.beginFill(0xff0000);
			
			hit_anchor.graphics.lineTo(105,386);			
			hit_anchor.graphics.lineTo(201,290);			
			hit_anchor.graphics.lineTo(278,333);			
			hit_anchor.graphics.lineTo(405,440);			
			hit_anchor.graphics.lineTo(394,507);			
			hit_anchor.graphics.lineTo(171,507);			
			hit_anchor.graphics.lineTo(120,416);			
			
			
			hit_anchor.alpha = 0.0;
			
			hit_anchor.graphics.precisionHitTest = true;	
			this.addChild(hit_anchor);
		}
		
		private function CreateHitMeassage():void{
			hit_message = new Shape();
			hit_message.touchable = false;
			hit_message.graphics.beginFill(0xff0000);
			
			hit_message.graphics.lineTo(75,0);			
			hit_message.graphics.lineTo(241,0);			
			hit_message.graphics.lineTo(450,74);			
			hit_message.graphics.lineTo(658,341);			
			hit_message.graphics.lineTo(632,454);			
			hit_message.graphics.lineTo(396,375);			
			hit_message.graphics.lineTo(76,126);			
			
			
			hit_message.alpha = 0.0;
			
			hit_message.graphics.precisionHitTest = true;	
			this.addChild(hit_message);
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
					}else if(hit_message.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("'Hatshepsut, Theodora, Zetian.'");
						
					}else if(hit_anchor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The anchor weighs hundreds of pounds... there's no way I can move it.");
						
					}
				}
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
			
			
			this.assets.removeTexture("ravineCanyonMessage_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineCanyonMessage_01");
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