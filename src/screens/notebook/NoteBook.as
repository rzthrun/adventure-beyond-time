package screens.notebook
{
	import flash.filesystem.File;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.utils.AssetManager;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	public class NoteBook extends Sprite
	{
		public var assets:AssetManager;
		
		public var NoteBookDetailsObj:NoteBookDetails;
		public var NoteBookDetailTween:Tween;
	//	public var bg:Shape;
	//	public var openbookBg:Image;
		
		public var noteBookButton:Image;
		private var noteBookTween:Tween;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		
		public var game:Game;
		
		public var Toggle:Boolean = false;
		public var animating:Boolean = false;
		public function NoteBook(_game:Game, _assets:AssetManager)
		{
			super();
			this.assets = _assets;
			this.game = _game;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});						
		}
		private function onLoadAssets():void{
		//	CreateBg();
			NoteBookDetailsObj = new NoteBookDetails(assets);
			
			noteBookButton  = new Image(this.assets.getTexture('noteBook_icon'));
			noteBookButton.alpha =1 ;
			noteBookButton.x = 5;
			noteBookButton.y = 400;
			noteBookButton.touchable = false;
			noteBookButton.alpha = 0;
			this.addChild(noteBookButton);
			
			this.addEventListener(TouchEvent.TOUCH,onClickHandler);	
		}		
		
		public function ActivateNoteBook():void{
			noteBookButton.touchable = true;
			noteBookButton.alpha = 1;
		}
		
		private function onClickHandler(e:TouchEvent):void{
			targ = e.target;
			//	c_targ = e.currentTarget;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						if(targ == noteBookButton){
							ToggleNoteBook(Toggle);
						}
					}
				}
			}
		}
		
		public function ToggleNoteBook(ToogleOnOff:Boolean):void{
			if(ToogleOnOff === false){
				animating = true;
				Toggle = true;
				NoteBookDetailsObj.alpha = 0;
				this.addChildAt(NoteBookDetailsObj,0);
				
				NoteBookDetailTween = new Tween(NoteBookDetailsObj,0.25,Transitions.LINEAR);
				NoteBookDetailTween.fadeTo(1);
				NoteBookDetailTween.onComplete = function():void{
					animating = false;
				}
				
				Starling.juggler.add(NoteBookDetailTween);
				
			}else{
				animating = true;
				Toggle = false;
				
				NoteBookDetailTween = new Tween(NoteBookDetailsObj,0.25,Transitions.LINEAR);
				NoteBookDetailTween.fadeTo(0);
				NoteBookDetailTween.onComplete = function():void{
					animating = false;
					removeDetail();
				}
				
				Starling.juggler.add(NoteBookDetailTween);
				
				
			}
		}
		
		private function removeDetail():void{
			this.removeChild(NoteBookDetailsObj);
		}
		
		public function ShowButton(ToggleBar:Boolean):void{
			if(ToggleBar === false){
				animating = true;
				noteBookTween = new Tween(noteBookButton,0.25,Transitions.LINEAR);
				noteBookTween.animate("y",335);
				noteBookTween.onComplete = function():void{
					animating = false;
				}
			}else{
				animating = true;
				noteBookTween = new Tween(noteBookButton,0.25,Transitions.LINEAR);
				noteBookTween.animate("y",400);
				noteBookTween.onComplete = function():void{
					animating = false;
				}			
			}
			
			Starling.juggler.add(noteBookTween);
		}
		
		
		
		
		
		
		
	
	}
}


