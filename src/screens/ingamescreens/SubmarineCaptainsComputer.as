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
	

	public class SubmarineCaptainsComputer extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var log_entry:Image;
		
		private var hit_log_six:Shape;
		private var hit_log_five:Shape;
		private var hit_log_four:Shape;
		private var hit_log_three:Shape;
		private var hit_log_two:Shape;
		private var hit_log_one:Shape;
			
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function SubmarineCaptainsComputer(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineCaptainsComputer_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsComputer/submarineCaptainsComputer_bg.jpg'));
				game.TrackAssets('submarineCaptainsComputer_01');
			}
			if(game.CheckAsset('submarineCaptainsComputer_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsComputer/SubmarineCaptainsComputer_Sprite.png'));
				game.TrackAssets('submarineCaptainsComputer_02');
			}
			if(game.CheckAsset('submarineCaptainsComputer_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsComputer/SubmarineCaptainsComputer_Sprite.xml'));
				game.TrackAssets('submarineCaptainsComputer_03');
			}
			//SubmarineCaptainsComputer_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineCaptainsComputer","SubmarineCaptainsComputerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}

		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineCaptainsComputer_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '1'){
					log_entry = new Image(this.assets.getTexture('page_01'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '2'){
					log_entry = new Image(this.assets.getTexture('page_02'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '3'){
					log_entry = new Image(this.assets.getTexture('page_03'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '4'){
					log_entry = new Image(this.assets.getTexture('page_04'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '5'){
					log_entry = new Image(this.assets.getTexture('page_05'));
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer['LogNum'] == '6'){
					log_entry = new Image(this.assets.getTexture('page_06'));
				}else{
					log_entry = new Image(this.assets.getTexture('page_01'));
				}
			}else{
				log_entry = new Image(this.assets.getTexture('page_01'));
			}
			
			
			log_entry.touchable = false;
			log_entry.x = 4;
			log_entry.y = 0;
			log_entry.alpha = 1;
			this.addChildAt(log_entry,1);
			//FadeOutOcean(1);
			
			CreateHitScreen();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);

			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		/*
		private var hit_log_six:Image;
		private var hit_log_five:Image;
		private var hit_log_four:Image;
		private var hit_log_three:Image;
		private var hit_log_two:Image;
		private var hit_log_one:Image;
		*/
		
		private function CreateHitScreen():void{
			hit_log_six = new Shape();
			hit_log_six.touchable = false;
			hit_log_six.graphics.beginFill(0x00ff00);
			
			hit_log_six.graphics.lineTo(16,338);	
			hit_log_six.graphics.lineTo(187,338);	
			hit_log_six.graphics.lineTo(187,384);	
			hit_log_six.graphics.lineTo(16,384);	

			hit_log_six.graphics.endFill(false);
			hit_log_six.alpha = 0.0;
			hit_log_six.graphics.precisionHitTest = true;	
			this.addChild(hit_log_six);
			
			hit_log_five = new Shape();
			hit_log_five.touchable = false;
			hit_log_five.graphics.beginFill(0x00ff00);
			
			hit_log_five.graphics.lineTo(16,286);	
			hit_log_five.graphics.lineTo(187,286);	
			hit_log_five.graphics.lineTo(187,332);	
			hit_log_five.graphics.lineTo(16,332);	
			
			hit_log_five.graphics.endFill(false);
			hit_log_five.alpha = 0.0;
			hit_log_five.graphics.precisionHitTest = true;	
			this.addChild(hit_log_five);
			
			hit_log_four = new Shape();
			hit_log_four.touchable = false;
			hit_log_four.graphics.beginFill(0x00ff00);
			
			hit_log_four.graphics.lineTo(16,238);	
			hit_log_four.graphics.lineTo(187,238);	
			hit_log_four.graphics.lineTo(187,282);	
			hit_log_four.graphics.lineTo(16,282);	
			
			hit_log_four.graphics.endFill(false);
			hit_log_four.alpha = 0.0;
			hit_log_four.graphics.precisionHitTest = true;	
			this.addChild(hit_log_four);
			
			hit_log_three = new Shape();
			hit_log_three.touchable = false;
			hit_log_three.graphics.beginFill(0x00ff00);
			
			hit_log_three.graphics.lineTo(16,188);	
			hit_log_three.graphics.lineTo(187,188);	
			hit_log_three.graphics.lineTo(187,232);	
			hit_log_three.graphics.lineTo(16,232);	
			
			hit_log_three.graphics.endFill(false);
			hit_log_three.alpha = 0.0;
			hit_log_three.graphics.precisionHitTest = true;	
			this.addChild(hit_log_three);
			
			hit_log_two = new Shape();
			hit_log_two.touchable = false;
			hit_log_two.graphics.beginFill(0x00ff00);
			
			hit_log_two.graphics.lineTo(16,136);	
			hit_log_two.graphics.lineTo(187,136);	
			hit_log_two.graphics.lineTo(187,181);	
			hit_log_two.graphics.lineTo(16,181);	
			
			hit_log_two.graphics.endFill(false);
			hit_log_two.alpha = 0.0;
			hit_log_two.graphics.precisionHitTest = true;	
			this.addChild(hit_log_two);
			
			hit_log_one = new Shape();
			hit_log_one.touchable = false;
			hit_log_one.graphics.beginFill(0x00ff00);
			
			hit_log_one.graphics.lineTo(16,85);	
			hit_log_one.graphics.lineTo(187,85);	
			hit_log_one.graphics.lineTo(187,130);	
			hit_log_one.graphics.lineTo(16,130);	
			
			hit_log_one.graphics.endFill(false);
			hit_log_one.alpha = 0.0;
			hit_log_one.graphics.precisionHitTest = true;	
			this.addChild(hit_log_one);
			
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineCaptainsTable as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsTableObj,true
						);
					}else if(hit_log_six.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('6');
					}else if(hit_log_five.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('5');
					}else if(hit_log_four.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('4');
					}else if(hit_log_three.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('3');
					}else if(hit_log_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('2');
					}else if(hit_log_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LogHandler('1');
					}
				}
			}
		}
		private function LogHandler(LogNum:String):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			log_entry.texture = this.assets.getTexture('page_0'+LogNum);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsComputer;
			}
			SaveArray['LogNum'] = LogNum;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsComputer',SaveArray);
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
			
			
			this.assets.removeTexture("submarineCaptainsComputer_bg",true);
			this.assets.removeTexture("SubmarineCaptainsComputer_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineCaptainsComputer_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsComputer_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsComputer_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsComputer_03");
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