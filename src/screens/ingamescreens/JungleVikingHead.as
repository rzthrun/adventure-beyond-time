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
	import starling.utils.AssetManager;
	
	public class JungleVikingHead extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_head:Shape;
		private var hit_neck:Shape;
		private var hit_sail:Shape;
		private var hit_air:Shape;
		private var hit_tree:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function JungleVikingHead(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleVikingHead_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingHead/jungleVikingHead_bg.jpg'));
				game.TrackAssets('jungleVikingHead_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingHead","JungleVikingHeadObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleVikingHead_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			CreateHitTrees();
			CreateHitAir();
			CreateHitNeck();
			CreateHitHead();
			CreateHitSail();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999,2);
			},0.7);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
		}
		
	
		private function CreateHitTrees():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(395,404);				
			hit_tree.graphics.lineTo(570,0);				
			hit_tree.graphics.lineTo(793,124);				
			hit_tree.graphics.lineTo(787,302);				
							
			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitAir():void{
			hit_air = new Shape();
			hit_air.touchable = false;
			hit_air.graphics.beginFill(0xff0000);
			
			hit_air.graphics.lineTo(0,0);				
			hit_air.graphics.lineTo(586,0);				
			hit_air.graphics.lineTo(281,298);				
			hit_air.graphics.lineTo(245,292);				
			hit_air.graphics.lineTo(0,131);				
			
			hit_air.graphics.endFill(false);
			hit_air.alpha = 0.0;
			
			hit_air.graphics.precisionHitTest = true;	
			this.addChild(hit_air);
		}
		
		private function CreateHitSail():void{
			hit_sail = new Shape();
			hit_sail.touchable = false;
			hit_sail.graphics.beginFill(0xff0000);
			
			hit_sail.graphics.lineTo(0,130);				
			hit_sail.graphics.lineTo(240,295);				
			hit_sail.graphics.lineTo(183,512);				
			hit_sail.graphics.lineTo(0,512);				
		
			hit_sail.graphics.endFill(false);
			hit_sail.alpha = 0.0;
			
			hit_sail.graphics.precisionHitTest = true;	
			this.addChild(hit_sail);
		}
		
		
		private function CreateHitNeck():void{
			hit_neck = new Shape();
			hit_neck.touchable = false;
			hit_neck.graphics.beginFill(0xff0000);
			
			hit_neck.graphics.lineTo(220,505);				
			hit_neck.graphics.lineTo(280,215);				
			hit_neck.graphics.lineTo(395,273);				
			hit_neck.graphics.lineTo(417,506);				
			
			hit_neck.graphics.endFill(false);
			hit_neck.alpha = 0.0;
			
			hit_neck.graphics.precisionHitTest = true;	
			this.addChild(hit_neck);
		}
		
		private function CreateHitHead():void{
			hit_head = new Shape();
			hit_head.touchable = false;
			hit_head.graphics.beginFill(0xff0000);
			
			hit_head.graphics.lineTo(290,71);				
			hit_head.graphics.lineTo(460,39);				
			hit_head.graphics.lineTo(512,67);				
			hit_head.graphics.lineTo(540,119);				
			hit_head.graphics.lineTo(536,198);				
			hit_head.graphics.lineTo(440,241);				
			hit_head.graphics.lineTo(286,208);				

			hit_head.graphics.endFill(false);
			hit_head.alpha = 0.0;
			
			hit_head.graphics.precisionHitTest = true;	
			this.addChild(hit_head);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleViking as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingObj,true
						);
					}else if(hit_head.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The head of a sea monster, carved from a slab of wood. ");
					}else if(hit_neck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The neck is inlayed with intricate patterns.");
					}else if(hit_sail.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sail is made from a coarse canvas.");
					}else if(hit_air.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The air is incredibly humid... like floating soup.");
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tiny eyes of creatures watch me from tree limbs...");
					}
					
					/*
					private var hit_head:Shape;
					private var hit_neck:Shape;
					private var hit_sail:Shape;
					private var hit_air:Shape;
					private var hit_tree:Shape;
					*/
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
			
			
			this.assets.removeTexture("jungleVikingHead_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingHead_01");
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
