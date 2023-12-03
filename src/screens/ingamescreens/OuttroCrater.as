package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class OuttroCrater extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var text_00:Image;
		private var text_01:Image;
		private var text_02:Image;
		private var text_03:Image;
		private var text_04:Image;
		private var text_04_0:Image;
		private var text_04_1:Image;
		private var text_05_0:Image;
		private var text_05_1:Image;
		private var text_05_2:Image;
		private var text_05_3:Image;
		private var text_05_4:Image;
		
		private var part_04_Sprite:Sprite;
		private var part_05_Sprite:Sprite;
		
		private var hit_MainBlock:Shape;
		private var hit_part_04_yes:Shape;
		private var hit_part_04_no:Shape;
		private var hit_part_05_yes:Shape;
		private var hit_part_05_no:Shape;
		
		private var TextState:int = 0;
		
		private var TextFadeInTween:Tween;
		private var TextFadeOutTween:Tween;
		private var Animating:Boolean = false;
		public var delayedCall:DelayedCall;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		public function OuttroCrater(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('outtroCrater_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroCrater/outtroCrater_bg.jpg'));
				game.TrackAssets('outtroCrater_01');
			}
			if(game.CheckAsset('outtroCrater_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroCrater/OuttroCrater_Sprite.png'));
				game.TrackAssets('outtroCrater_02');
			}
			if(game.CheckAsset('outtroCrater_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroCrater/OuttroCrater_Sprite.xml'));
				game.TrackAssets('outtroCrater_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Chamber","ChamberObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars;
			}
			SaveArray['FromCrater'] = "Yes";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('OuttroStars',SaveArray);
			
			
			Animating = true;
			bg = new Image(this.assets.getTexture('outtroCrater_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			text_00 = new Image(this.assets.getTexture('dia_part_00'));
			text_00.touchable = false;
			text_00.x = 281;
			text_00.y = 149;
			text_00.alpha = 0;
			this.addChildAt(text_00,1);
			
			text_01 = new Image(this.assets.getTexture('dia_part_01'));
			text_01.touchable = false;
			text_01.x = 323;
			text_01.y = 163;
			text_01.alpha = 0;
			this.addChildAt(text_01,2);
			
			text_02 = new Image(this.assets.getTexture('dia_part_02'));
			text_02.touchable = false;
			text_02.x = 289;
			text_02.y = 159;
			text_02.alpha = 0;
			this.addChildAt(text_02,3);
			
			text_03 = new Image(this.assets.getTexture('dia_part_03'));
			text_03.touchable = false;
			text_03.x = 303;
			text_03.y = 128;
			text_03.alpha = 0;
			this.addChildAt(text_03,4);

			part_04_Sprite = new Sprite();
			part_04_Sprite.touchable = false;
			part_04_Sprite.alpha = 0;
	
			text_04 = new Image(this.assets.getTexture('dia_part_04'));
			text_04.touchable = false;
			text_04.x = 312;
			text_04.y = 146;
			text_04.alpha = 1;
			part_04_Sprite.addChildAt(text_04,0);
			
			text_04_0 = new Image(this.assets.getTexture('dia_part_04_0'));
			text_04_0.touchable = false;
			text_04_0.x = 66;
			text_04_0.y = 321;
			text_04_0.alpha = 1;
			part_04_Sprite.addChildAt(text_04_0,1);
			
			text_04_1 = new Image(this.assets.getTexture('dia_part_04_1'));
			text_04_1.touchable = false;
			text_04_1.x = 385;
			text_04_1.y = 323;
			text_04_1.alpha = 1;
			part_04_Sprite.addChildAt(text_04_1,2);
				
			this.addChildAt(part_04_Sprite,5);
			
			part_05_Sprite = new Sprite();
			part_05_Sprite.touchable = false;
			part_05_Sprite.alpha = 0;
			
			text_05_0 = new Image(this.assets.getTexture('dia_part_05_0'));
			text_05_0.touchable = false;
			text_05_0.x = 313;
			text_05_0.y = 150;
			text_05_0.alpha = 0;
			part_05_Sprite.addChildAt(text_05_0,0);
				
			text_05_1 = new Image(this.assets.getTexture('dia_part_05_1'));
			text_05_1.touchable = false;
			text_05_1.x = 310;
			text_05_1.y = 141;
			text_05_1.alpha = 0;
			part_05_Sprite.addChildAt(text_05_1,1);
			
			text_05_2 = new Image(this.assets.getTexture('dia_part_05_2'));
			text_05_2.touchable = false;
			text_05_2.x = 354;
			text_05_2.y = 219;
			text_05_2.alpha = 1;
			part_05_Sprite.addChildAt(text_05_2,2);
			
			text_05_3 = new Image(this.assets.getTexture('dia_part_05_3'));
			text_05_3.touchable = false;
			text_05_3.x = 367;
			text_05_3.y = 306;
			text_05_3.alpha = 1;
			part_05_Sprite.addChildAt(text_05_3,3);
			
			text_05_4 = new Image(this.assets.getTexture('dia_part_05_4'));
			text_05_4.touchable = false;
			text_05_4.x = 582;
			text_05_4.y = 310;
			text_05_4.alpha = 1;
			part_05_Sprite.addChildAt(text_05_4,4);
			
			
			this.addChildAt(part_05_Sprite,6);
			
			CreateHitMainTextBlock();
			
			delayedCall = new DelayedCall(function():void{
				FadeInText("text_00");
			},2);
			Starling.juggler.add(delayedCall);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		
			
		}
		
		private function FadeInText(TextName:String):void{
			TextFadeInTween = new Tween(this[''+TextName], 1.25, Transitions.LINEAR);
			TextFadeInTween.fadeTo(1);
			TextFadeInTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				Animating = false;
				TextFadeInTween = null;
				
			}
			Starling.juggler.add(TextFadeInTween);
		}
		
		private function FadeOutText(TextOutName:String,TextInName:String):void{
			Animating = true;
			TextFadeOutTween = new Tween(this[''+TextOutName], 1.25, Transitions.LINEAR);
			TextFadeOutTween.fadeTo(0);
			TextFadeOutTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				FadeInText(TextInName);
				TextFadeOutTween = null;
				
			}
			Starling.juggler.add(TextFadeOutTween);
		}
		//	private var hit_part_04_yes:Shape;
		//private var hit_part_04_no:Shape;
		
		private function CreateHitpart5():void{
			hit_part_05_yes = new Shape();
			hit_part_05_yes.touchable = false;
			hit_part_05_yes.graphics.beginFill(0xff0000);
			
			hit_part_05_yes.graphics.lineTo(355,305);												
			hit_part_05_yes.graphics.lineTo(501,307);												
			hit_part_05_yes.graphics.lineTo(495,391);												
			hit_part_05_yes.graphics.lineTo(352,384);												
	
			hit_part_05_yes.graphics.endFill(false);
			hit_part_05_yes.alpha = 0.0;
			
			hit_part_05_yes.graphics.precisionHitTest = true;	
			this.addChild(hit_part_05_yes);
			
			hit_part_05_no = new Shape();
			hit_part_05_no.touchable = false;
			hit_part_05_no.graphics.beginFill(0xff0000);
			
			hit_part_05_no.graphics.lineTo(575,305);												
			hit_part_05_no.graphics.lineTo(705,314);												
			hit_part_05_no.graphics.lineTo(703,376);												
			hit_part_05_no.graphics.lineTo(566,371);												
	
			hit_part_05_no.graphics.endFill(false);
			hit_part_05_no.alpha = 0.0;
			
			hit_part_05_no.graphics.precisionHitTest = true;	
			this.addChild(hit_part_05_no);
		}
		
		private function CreateHitpart4():void{
			hit_part_04_yes = new Shape();
			hit_part_04_yes.touchable = false;
			hit_part_04_yes.graphics.beginFill(0xff0000);
			
			hit_part_04_yes.graphics.lineTo(58,382);												
			hit_part_04_yes.graphics.lineTo(161,313);												
			hit_part_04_yes.graphics.lineTo(269,321);												
			hit_part_04_yes.graphics.lineTo(369,382);												
			hit_part_04_yes.graphics.lineTo(358,444);												
			hit_part_04_yes.graphics.lineTo(66,435);												
		
			hit_part_04_yes.graphics.endFill(false);
			hit_part_04_yes.alpha = 0.0;
			
			hit_part_04_yes.graphics.precisionHitTest = true;	
			this.addChild(hit_part_04_yes);
			
			hit_part_04_no = new Shape();
			hit_part_04_no.touchable = false;
			hit_part_04_no.graphics.beginFill(0xff0000);
			
			hit_part_04_no.graphics.lineTo(386,381);												
			hit_part_04_no.graphics.lineTo(517,322);												
			hit_part_04_no.graphics.lineTo(596,323);												
			hit_part_04_no.graphics.lineTo(723,389);												
			hit_part_04_no.graphics.lineTo(678,447);												
			hit_part_04_no.graphics.lineTo(379,438);												
			
			hit_part_04_no.graphics.endFill(false);
			hit_part_04_no.alpha = 0.0;
			
			hit_part_04_no.graphics.precisionHitTest = true;	
			this.addChild(hit_part_04_no);
		}
		
		private function CreateHitMainTextBlock():void{
			hit_MainBlock = new Shape();
			hit_MainBlock.touchable = false;
			hit_MainBlock.graphics.beginFill(0xff0000);
			
			hit_MainBlock.graphics.lineTo(281,121);												
			hit_MainBlock.graphics.lineTo(797,121);												
			hit_MainBlock.graphics.lineTo(797,300);												
			hit_MainBlock.graphics.lineTo(281,300);												

			hit_MainBlock.graphics.endFill(false);
			hit_MainBlock.alpha = 0.0;
			
			hit_MainBlock.graphics.precisionHitTest = true;	
			this.addChild(hit_MainBlock);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(TextState == 4){
							if(hit_part_04_yes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();

								TextState = 5;
								this.removeChild(hit_part_04_yes);
								this.removeChild(hit_part_04_no);
								CreateHitpart5();
								text_05_1.alpha = 1;
								FadeOutText('part_04_Sprite','part_05_Sprite');
							}else if(hit_part_04_no.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();

								TextState = 5;
								this.removeChild(hit_part_04_yes);
								this.removeChild(hit_part_04_no);
								CreateHitpart5();
								text_05_0.alpha = 1;
								FadeOutText('part_04_Sprite','part_05_Sprite');
							}
						}else if(TextState == 5){
							if(hit_part_05_yes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
								(stage.getChildAt(0) as Object).MusicObj.LoadLightBeam(true,0);
								FadeOut((OuttroStars as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.OuttroStarsObj,true
								);
							}else if(hit_part_05_no.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
								(stage.getChildAt(0) as Object).MusicObj.LoadLightBeam(true,0);
								FadeOut((OuttroStars as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.OuttroStarsObj,true
								);
							}
						}else if(hit_MainBlock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();

							if(TextState == 0){
								TextState = 1;
								FadeOutText('text_00','text_01');
							}else if(TextState == 1){
								TextState = 2;
								FadeOutText('text_01','text_02');
							}else if(TextState == 2){
								TextState = 3;
								FadeOutText('text_02','text_03');
							}else if(TextState == 3){
								TextState = 4;
								CreateHitpart4();
								FadeOutText('text_03','part_04_Sprite');
						//	}else if(TextState == 4){
						//		TextState = 5;
						//		FadeOutText('part_04_Sprite','part_05_Sprite');
							}
						
						}
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
			
			
			
			this.assets.removeTexture("outtroCrater_bg",true);
			this.assets.removeTexture("OuttroCrater_Sprite",true);
			this.assets.removeTextureAtlas("OuttroCrater_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("outtroCrater_01");
			(stage.getChildAt(0) as Object).falseAsset("outtroCrater_02");
			(stage.getChildAt(0) as Object).falseAsset("outtroCrater_03");

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