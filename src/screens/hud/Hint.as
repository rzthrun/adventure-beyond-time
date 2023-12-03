package screens.hud
{
	import flash.filesystem.File;
	
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
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Hint extends Sprite
	{
		private var assets:AssetManager;
		private var goback:GoBackButton;
		private var HintButton:Image;
		
		private var HintDialogueSprite:Sprite;
		private var dialogueBgImage:Image;
		private var HintText:TextField;
		private var HintTitle:TextField;
		private var hit_hintTitle:Shape;
		private var SolutionText:TextField
		private var HintTween:Tween;
		private var bg:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		
		private var animating:Boolean = false;
		private var toggled:Boolean = false;
		
		private var HintGenObj:HintGenerator;
		private var SolutionGenObj:HintSolutionGenerator;
		
		public var SolutionImage:Image;
		
		private var game:Game;
		
		
		public function Hint(_assets:AssetManager,_game:Game)
		{
			super();
			assets = _assets;
			game = _game;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			//		if((stage.getChildAt(0) as Object).CheckAsset('hud_menu') === false){
			//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Menu/element_hud_menu_v003a001.png'));
			//			(stage.getChildAt(0) as Object).TrackAssets('hud_menu');
			//		}
			
					this.assets.loadQueue(function(n:Number):void{
						if(n==1){
			onLoadAssets();
						}				
					});						
			
		}		
		private function onLoadAssets():void{
			HintGenObj = new HintGenerator(game);
			SolutionGenObj = new HintSolutionGenerator(game);
			
			HintButton = new Image(this.assets.getTexture('questionMake_v001a001'));
			HintButton.x = 740;
			HintButton.y = 310;
			this.addChild(HintButton);
	
			
			HintDialogueSprite = new Sprite();
			HintDialogueSprite.alpha = 0;
			dialogueBgImage = new Image(this.assets.getTexture('hint_bg_03a002'));
			dialogueBgImage.y = 40;
			
			//dialogueBgImage.width = 800;
			//dialogueBgImage.height = 480;
			this.HintDialogueSprite.addChild(dialogueBgImage);
			
			
			HintText = new TextField(638,130,"No Hint at this time.","Arial", 28, 0xffff00);
			HintText.hAlign = starling.utils.HAlign.CENTER;
		//	HintText.vAlign = starling.utils.VAlign.TOP;
			HintText.fontSize = 28;
			HintText.x = 80;
			HintText.y = 100;
			HintText.touchable = false;
			this.HintDialogueSprite.addChild(HintText);
			
			HintTitle = new TextField(250,100,"See Solution?","Arial", 28, 0xffff00);
			HintText.hAlign = starling.utils.HAlign.CENTER;
			//	HintText.vAlign = starling.utils.VAlign.TOP;
			HintTitle.fontSize = 28;
			HintTitle.x = 270;
			HintTitle.y = 240;
			HintTitle.touchable = false;
			this.HintDialogueSprite.addChild(HintTitle);
			
			SolutionText = new TextField(638,260,"Solution Text","Arial", 24, 0xffff00);
			SolutionText.hAlign = starling.utils.HAlign.CENTER;
			//SolutionText.vAlign = starling.utils.VAlign.CENTER;
			SolutionText.fontSize = 24;
			SolutionText.x = 72;
			SolutionText.y = 85;
			SolutionText.touchable = false;
			this.HintDialogueSprite.addChild(SolutionText);
			
			//SolutionImage = 
			
			CreateBg();
			CreateHintTitleHit();
			
		//	goback = new GoBackButton(this.assets);	
		//	this.HintDialogueSprite.addChild(goback);
			
			
			
			this.addEventListener(TouchEvent.TOUCH,OnClickHandler);
		}
		
		private function CreateHintTitleHit():void{
			hit_hintTitle = new Shape();
			this.HintDialogueSprite.addChild(hit_hintTitle);
			hit_hintTitle.graphics.beginFill(0x0000ff);
			hit_hintTitle.graphics.lineTo(291-25,240);	
			hit_hintTitle.graphics.lineTo(516+5,240);	
			hit_hintTitle.graphics.lineTo(516+5,330);	
			hit_hintTitle.graphics.lineTo(291-25,330);	
			
			hit_hintTitle.touchable = false;
			hit_hintTitle.graphics.endFill(false);
			hit_hintTitle.alpha = 0.0;
			hit_hintTitle.graphics.precisionHitTest = true;			
		}
		
		private function CreateBg():void{
			bg = new Shape();
			this.HintDialogueSprite.addChildAt(bg,0);
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
		
		private function OnClickHandler(e:TouchEvent):void{
			targ = e.target;	
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.BEGAN) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(animating === false){
						if(toggled === false){
							if(targ == HintButton){
								SolutionText.text = "";
								game.screenGamePlayHandler.ReadOutObj.HideReadOut();			
								toggled = true;
								animating = true;
								var HText:String = HintGenObj.GetHint();
								
								HintText.text = HText;
								HintText.alpha = 1; 
								HintTitle.alpha = 1; 
								SolutionText.alpha = 0; 
								this.addChild(HintDialogueSprite);
								HintTween = new Tween(HintDialogueSprite,0.5,Transitions.LINEAR);
								HintTween.fadeTo(1);
								HintTween.onComplete = function():void{
									animating = false;

								};
								Starling.juggler.add(HintTween);
							
							}
						}else{
							if(hit_hintTitle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(SolutionText.alpha == 0){
									trace("SOLUTION HIT");
									var SText:String = SolutionGenObj.GetSolution();
									HintText.alpha = 0; 
									HintTitle.alpha = 0; 
									SolutionText.alpha = 1; 
									SolutionText.text = SText;
								}else{
									toggled = false;
									animating = true;
									this.addChild(HintDialogueSprite);
									HintTween = new Tween(HintDialogueSprite,0.5,Transitions.LINEAR);
									HintTween.fadeTo(0);
									HintTween.onComplete = function():void{
										removeDialouge();
										animating = false;
										
									};
									Starling.juggler.add(HintTween);
								}
							}
							
							else if(targ == dialogueBgImage){
								
								toggled = false;
								animating = true;
								this.addChild(HintDialogueSprite);
								HintTween = new Tween(HintDialogueSprite,0.5,Transitions.LINEAR);
								HintTween.fadeTo(0);
								HintTween.onComplete = function():void{
									removeDialouge();
									animating = false;
									
								};
								Starling.juggler.add(HintTween);
							}else{
								toggled = false;
								animating = true;
								this.addChild(HintDialogueSprite);
								HintTween = new Tween(HintDialogueSprite,0.5,Transitions.LINEAR);
								HintTween.fadeTo(0);
								HintTween.onComplete = function():void{
									removeDialouge();
									animating = false;
									
								};
								Starling.juggler.add(HintTween);
							}
						}
					}
				}	
			}
		}
		
		private function removeDialouge():void{
			this.removeChild(HintDialogueSprite);
		}
		
		
		
		
//-----------------------------
	}
}