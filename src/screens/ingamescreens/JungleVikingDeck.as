package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class JungleVikingDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;

		private var trunk_lid:Image;
		private var tv_potatos:Image;
		private var tv_potatos_wires:Image;
		private var tv_lid:Image;
		private var tv_ball:Image;
		
		private var tv_screen:MovieClip;
		
		private var hit_trunk:Shape;
		private var hit_sheild:Shape;
		private var hit_tv:Shape;
		
		private var hit_rear:Shape;
		private var hit_floor:Shape;
		
		private var TrunkLidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var goback:GoBackButton;		
		
		public function JungleVikingDeck(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleVikingDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingDeck/jungleVikingDeck_bg.jpg'));
				game.TrackAssets('jungleVikingDeck_01');
			}
			if(game.CheckAsset('jungleVikingDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingDeck/JungleVikingDeck_Sprite.atf'));
				game.TrackAssets('jungleVikingDeck_02');
			}
			if(game.CheckAsset('jungleVikingDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingDeck/JungleVikingDeck_Sprite.xml'));
				game.TrackAssets('jungleVikingDeck_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingDeck","JungleVikingDeckObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleVikingDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			trunk_lid = new Image(this.assets.getTexture('trunk_lid'));
			trunk_lid.smoothing = TextureSmoothing.NONE;
			trunk_lid.touchable = false;
			trunk_lid.x = 1;
			trunk_lid.y = 171;

			tv_potatos_wires = new Image(this.assets.getTexture('tv_potato_wires'));
			tv_potatos_wires.smoothing = TextureSmoothing.NONE;
			tv_potatos_wires.touchable = false;
			tv_potatos_wires.x = 584;
			tv_potatos_wires.y = 146;
			
			
			tv_potatos = new Image(this.assets.getTexture('tv_potato'));
			tv_potatos.smoothing = TextureSmoothing.NONE;
			tv_potatos.touchable = false;
			tv_potatos.x = 593;
			tv_potatos.y = 160;
		
			
			tv_lid = new Image(this.assets.getTexture('tv_lid'));
			tv_lid.smoothing = TextureSmoothing.NONE;
			tv_lid.touchable = false;
			tv_lid.x = 591;
			tv_lid.y = 145;
		
			
			tv_ball = new Image(this.assets.getTexture('tv_ball'));
			tv_ball.smoothing = TextureSmoothing.NONE;
			tv_ball.touchable = false;
			tv_ball.x = 603;
			tv_ball.y = 159;
			
			
			tv_screen = new MovieClip(this.assets.getTextures("tv_screen"),12);
			tv_screen.smoothing = TextureSmoothing.NONE;
			tv_screen.x = 512;
			tv_screen.y = 113;
			
			tv_screen.touchable = false;
			tv_screen.smoothing = TextureSmoothing.NONE;
			tv_screen.loop = true; // default: true
			tv_screen.stop();
			
		
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Lid'] == 'open'){
					trunk_lid.alpha = 1;
					TrunkLidOpen = true;
				}else{
					trunk_lid.alpha = 0;
				}
			}else{
				trunk_lid.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
						tv_potatos.alpha = 0;
						tv_potatos_wires.alpha = 1;
						tv_screen.play();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Lid'] == 'Open'){
							tv_lid.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
								tv_ball.alpha = 0;
							}else{
								tv_ball.alpha = 1;
							}
						}else{
							tv_lid.alpha = 0;
							tv_ball.alpha = 0;
						}		
					}else{
						tv_potatos.alpha = 1;
						tv_potatos_wires.alpha = 0;
						tv_lid.alpha = 0;
						tv_ball.alpha = 0;
					}
				}else{
					tv_potatos_wires.alpha = 0;
					tv_potatos.alpha = 0;
					tv_lid.alpha = 0;
					tv_ball.alpha = 0;
				}
			}else{
				tv_potatos_wires.alpha = 0;
				tv_potatos.alpha = 0;
				tv_lid.alpha = 0;
				tv_ball.alpha = 0;
				tv_screen.alpha = 0;
			}
				
			
			
			
			this.addChildAt(trunk_lid,1);
			this.addChildAt(tv_potatos_wires,2);
			this.addChildAt(tv_potatos,3);
			this.addChildAt(tv_lid,4);
			this.addChildAt(tv_ball,5);
			this.addChildAt(tv_screen,6);	
		
			Starling.juggler.add(tv_screen);
			CreateHitRear();
			CreateHitFloor();
			CreateHitTV();
			CreateHitSheild();
			CreateTrunkHit(TrunkLidOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("BirdsOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("TVStatic",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
			
		}
	
		
		private function CreateHitFloor():void{
			hit_floor = new Shape();
			hit_floor.touchable = false;
			hit_floor.graphics.beginFill(0xff0000);
			
			hit_floor.graphics.lineTo(131,449);				
			hit_floor.graphics.lineTo(392,318);				
			hit_floor.graphics.lineTo(699,389);				
			hit_floor.graphics.lineTo(505,508);				
			hit_floor.graphics.lineTo(151,508);				
									
			hit_floor.graphics.endFill(false);
			hit_floor.alpha = 0.0;
			
			hit_floor.graphics.precisionHitTest = true;	
			this.addChild(hit_floor);
		}
		
		private function CreateHitRear():void{
			hit_rear = new Shape();
			hit_rear.touchable = false;
			hit_rear.graphics.beginFill(0xff0000);
			
			hit_rear.graphics.lineTo(46,176);				
			hit_rear.graphics.lineTo(91,111);				
			hit_rear.graphics.lineTo(455,67);				
			hit_rear.graphics.lineTo(460,173);				
			hit_rear.graphics.lineTo(21,283);				
		
			hit_rear.graphics.endFill(false);
			hit_rear.alpha = 0.0;
			
			hit_rear.graphics.precisionHitTest = true;	
			this.addChild(hit_rear);
		}
		
		private function CreateHitTV():void{
			hit_tv = new Shape();
			hit_tv.touchable = false;
			hit_tv.graphics.beginFill(0xff0000);
			
			hit_tv.graphics.lineTo(474,85);				
			hit_tv.graphics.lineTo(653,53);				
			hit_tv.graphics.lineTo(768,179);				
			hit_tv.graphics.lineTo(770,213);				
			hit_tv.graphics.lineTo(705,266);				
			hit_tv.graphics.lineTo(476,263);				
			hit_tv.graphics.lineTo(471,229);				
			hit_tv.graphics.lineTo(472,102);				
			
			hit_tv.graphics.endFill(false);
			hit_tv.alpha = 0.0;
			
			hit_tv.graphics.precisionHitTest = true;	
			this.addChild(hit_tv);
		}
		

		private function CreateHitSheild():void{
			hit_sheild = new Shape();
			hit_sheild.touchable = false;
			hit_sheild.graphics.beginFill(0xff0000);
			
			hit_sheild.graphics.lineTo(293,213);				
			hit_sheild.graphics.lineTo(308,160);				
			hit_sheild.graphics.lineTo(378,145);				
			hit_sheild.graphics.lineTo(438,166);				
			hit_sheild.graphics.lineTo(469,221);				
			hit_sheild.graphics.lineTo(448,288);				
			hit_sheild.graphics.lineTo(375,300);				
			hit_sheild.graphics.lineTo(313,257);				
		
			
			hit_sheild.graphics.endFill(false);
			hit_sheild.alpha = 0.0;
			
			hit_sheild.graphics.precisionHitTest = true;	
			this.addChild(hit_sheild);
		}
		
		
		private function CreateTrunkHit(open:Boolean = false):void{
			hit_trunk = new Shape();
			this.addChild(hit_trunk);
			if(open === false){
				
				hit_trunk.x = 0;
				hit_trunk.y = 0;
				hit_trunk.graphics.beginFill(0x0000FF);
				hit_trunk.graphics.lineTo(49,294);	
				hit_trunk.graphics.lineTo(248,243);	
				hit_trunk.graphics.lineTo(321,261);	
				hit_trunk.graphics.lineTo(337,355);	
				hit_trunk.graphics.lineTo(145,440);	
				hit_trunk.graphics.lineTo(72,395);		
			
				hit_trunk.graphics.endFill(false);
				
				hit_trunk.alpha = 0.0;
				
				hit_trunk.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_trunk.x = 0;
				hit_trunk.y = 0;
				hit_trunk.graphics.beginFill(0x0000FF);		
				hit_trunk.graphics.lineTo(44,205);	
				hit_trunk.graphics.lineTo(251,167);	
				hit_trunk.graphics.lineTo(268,181);	
				hit_trunk.graphics.lineTo(296,272);	
				hit_trunk.graphics.lineTo(321,285);	
				hit_trunk.graphics.lineTo(334,359);	
				hit_trunk.graphics.lineTo(144,444);	
				hit_trunk.graphics.lineTo(50,373);	
			
				hit_trunk.graphics.endFill(false);
				hit_trunk.alpha = 0.0;
				
				hit_trunk.graphics.precisionHitTest = true;				
			}
			hit_trunk.touchable = false;
			
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
					}else if(hit_trunk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleVikingTrunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingTrunkObj,true
						);
					}else if(hit_sheild.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleVikingSheild as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingSheildObj,true
						);
					}else if(hit_tv.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleVikingTV as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingTVObj,true
						);
					}else if(hit_rear.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rear of the boat has large holes torn through it.");	
					}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor is cracked and brittle.");	
					}
					
					/*
					private var hit_rear:Shape;
					private var hit_floor:Shape;
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
			
			
			this.assets.removeTexture("jungleVikingDeck_bg",true);
			this.assets.removeTexture("JungleVikingDeck_Sprite",true);
			this.assets.removeTextureAtlas("JungleVikingDeck_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingDeck_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
		
	}
}


