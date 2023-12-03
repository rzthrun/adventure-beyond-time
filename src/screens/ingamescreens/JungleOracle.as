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
	
		
	public class JungleOracle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_tiger:Shape;
		private var hit_phoenix:Shape;
		private var hit_dragon:Shape;
		private var hit_turtle:Shape;
		private var hit_rock:Shape;
		
		private var BookSeen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleOracle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleOracle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleOracle/jungleOracle_bg.jpg'));
				game.TrackAssets('jungleOracle_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleOracle","JungleOracleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleOracle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains["Book"] != undefined){
					BookSeen = true;
				}
			}
			
			//FadeOutOcean(1);
			CreateHitRock();
			CreateHitTurtle();
			CreateHitDragon();
			CreateHitPhoenix();
			CreateHitTiger();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleOracle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleOracle['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleOracle;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleOracle',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleOracle',SaveArray);
			}
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
			
		}
		
		
		private function CreateHitRock():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(5,105);									
			hit_rock.graphics.lineTo(100,0);									
			hit_rock.graphics.lineTo(526,0);									
			hit_rock.graphics.lineTo(701,254);									
			hit_rock.graphics.lineTo(487,512);									
			hit_rock.graphics.lineTo(121,512);									
			hit_rock.graphics.lineTo(0,355);									
			
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function CreateHitTurtle():void{
			hit_turtle = new Shape();
			hit_turtle.touchable = false;
			hit_turtle.graphics.beginFill(0xff0000);
			
			hit_turtle.graphics.lineTo(313,400);									
			hit_turtle.graphics.lineTo(348,295);									
			hit_turtle.graphics.lineTo(442,336);									
			hit_turtle.graphics.lineTo(451,506);									
			hit_turtle.graphics.lineTo(365,506);									
										
			
			hit_turtle.graphics.endFill(false);
			hit_turtle.alpha = 0.0;
			
			hit_turtle.graphics.precisionHitTest = true;	
			this.addChild(hit_turtle);
		}
		
		private function CreateHitDragon():void{
			hit_dragon = new Shape();
			hit_dragon.touchable = false;
			hit_dragon.graphics.beginFill(0xff0000);
			
			hit_dragon.graphics.lineTo(378,223);									
			hit_dragon.graphics.lineTo(356,101);									
			hit_dragon.graphics.lineTo(435,98);									
			hit_dragon.graphics.lineTo(541,253);									
			hit_dragon.graphics.lineTo(516,332);									
		
			hit_dragon.graphics.endFill(false);
			hit_dragon.alpha = 0.0;
			
			hit_dragon.graphics.precisionHitTest = true;	
			this.addChild(hit_dragon);
		}
		
		private function CreateHitPhoenix():void{
			hit_phoenix = new Shape();
			hit_phoenix.touchable = false;
			hit_phoenix.graphics.beginFill(0xff0000);
			
			hit_phoenix.graphics.lineTo(142,18);									
			hit_phoenix.graphics.lineTo(232,3);									
			hit_phoenix.graphics.lineTo(333,190);									
			hit_phoenix.graphics.lineTo(176,143);									
		
			hit_phoenix.graphics.endFill(false);
			hit_phoenix.alpha = 0.0;
			
			hit_phoenix.graphics.precisionHitTest = true;	
			this.addChild(hit_phoenix);
		}
		
		private function CreateHitTiger():void{
			hit_tiger = new Shape();
			hit_tiger.touchable = false;
			hit_tiger.graphics.beginFill(0xff0000);
			
			hit_tiger.graphics.lineTo(58,327);									
			hit_tiger.graphics.lineTo(71,187);									
			hit_tiger.graphics.lineTo(155,173);									
			hit_tiger.graphics.lineTo(253,422);									
			hit_tiger.graphics.lineTo(112,450);									
			
			hit_tiger.graphics.endFill(false);
			hit_tiger.alpha = 0.0;
			
			hit_tiger.graphics.precisionHitTest = true;	
			this.addChild(hit_tiger);
		}
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
						);
					}else if(hit_tiger.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BookSeen === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe a creature of some sort?");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A tiger with its large jaws and striped coat.");
						}
					}else if(hit_phoenix.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BookSeen === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An odd geometric form made with hard lines.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It shows a phoenix with its flowing tail feathers.");
						}
					}else if(hit_dragon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BookSeen === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An abstract form... I don't know what it means.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A dragon with a long tail.");
						}
					}else if(hit_turtle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BookSeen === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The symbol has a criss-cross pattern.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's a turtle!");
						}
					}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BookSeen === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Strange markings have been carved into the stone.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("'Oracle Bones,' a very ancient form of Chinese characters, or Hanzi, have been carved into the stone.");	
						}
					}
					
					/*
					private var hit_tiger:Shape;
					private var hit_phoenix:Shape;
					private var hit_dragon:Shape;
					private var hit_turtle:Shape;
					hit_rock
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
			
			
			this.assets.removeTexture("jungleOracle_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleOracle_01");
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
