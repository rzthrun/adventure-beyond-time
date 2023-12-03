package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class JungleSubmarineDoor extends Sprite
	{
		
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var hit_Door:Shape;
		private var hit_interior:Shape;
		
		private var hit_beach:Shape;
		private var hit_sub:Shape;
		private var hit_sky:Shape;
		
		private var door:Image;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var animating:Boolean = false;
		private var delayedCall:DelayedCall;
		
		private var doorOpen:Boolean = false;
		private var DoorSolved:Boolean = false;
		
		private var goback:GoBackButton;	
		
		
		
		public function JungleSubmarineDoor(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleSubmarineDoor_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarineDoor/jungleSubmarineDoor_bg.jpg'));
				game.TrackAssets('jungleSubmarineDoor_01');
			}
			if(game.CheckAsset('jungleSubmarineDoor_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarineDoor/JungleSubmarineDoor_Sprite.atf'));
				game.TrackAssets('jungleSubmarineDoor_02');
			}
			if(game.CheckAsset('jungleSubmarineDoor_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarineDoor/JungleSubmarineDoor_Sprite.xml'));
				game.TrackAssets('jungleSubmarineDoor_03');
			}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleSubmarineDoor","JungleSubmarineDoorObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleSubmarineDoor_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			door = new Image(this.assets.getTexture('hatch_closed'));
			door.smoothing = TextureSmoothing.NONE;
			door.touchable = false;
			door.x = 106.5;
			door.y = 26.5;
			
			door.alpha = 1;
			this.addChild(door);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Solved'] == 'yes'){
					DoorSolved = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor['Door'] == 'open'){
							door.alpha = 0;		
							doorOpen = true;
							CreateInteriorHit();
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor['Door'] == 'closed'){
							door.alpha = 1;
						}else{
							doorOpen = true;
							animating = true;
							
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor;	
							SaveArray['Door'] = 'open';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
							
							delayedCall = new DelayedCall(function():void{
								openDoor();
							},2);
							Starling.juggler.add(delayedCall);
						}
					}else{
						animating = true;
						doorOpen = true;
						SaveArray['Door'] = 'open';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
						delayedCall = new DelayedCall(function():void{
							openDoor();
						},2);
						Starling.juggler.add(delayedCall);
					}
				}else{
				//	CreateLeoHit();
				}
			}else{
			//	CreateLeoHit();
			}
		//	DoorSolved = true;
			CreateSubHit();
			CreateBeachHit();
			CreateSkyHit();
			CreateHitDoorHit(doorOpen);
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
		//	(stage.getChildAt(0) as Object).MusicObj.LoadWindOne(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipGroansOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			},0.7);
		
		//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolume("WindOne",((stage.getChildAt(0) as Object).MusicObj.globalVol*0.2),0.1);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
						},0.3);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
					},0.3);
				}
			}
			
		}
		
		private function openDoor():void{
			
			game.SoundFXObj.PlaySFX_MetalBoxOpen();
			game.SoundFXObj.PlaySFX_AirRelease();
			CreateInteriorHit();
			door.alpha = 0;
			animating = false;

		//	game.MusicObj.LoadTheThing(true,1,2);
			
			
			
		}
		
		//hit_interior
		private function CreateSkyHit():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(418,0);									
			hit_sky.graphics.lineTo(664,0);									
			hit_sky.graphics.lineTo(725,197);									
			hit_sky.graphics.lineTo(405,197);									
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		
		private function CreateBeachHit():void{
			hit_beach = new Shape();
			hit_beach.touchable = false;
			hit_beach.graphics.beginFill(0xff0000);
			
			hit_beach.graphics.lineTo(406,200);									
			hit_beach.graphics.lineTo(733,203);									
			hit_beach.graphics.lineTo(716,277);									
			hit_beach.graphics.lineTo(610,288);									
			hit_beach.graphics.lineTo(475,254);									
			hit_beach.graphics.lineTo(401,250);									
			
			hit_beach.graphics.endFill(false);
			hit_beach.alpha = 0.0;
			
			hit_beach.graphics.precisionHitTest = true;	
			this.addChild(hit_beach);
		}
		
		
		private function CreateSubHit():void{
			hit_sub = new Shape();
			hit_sub.touchable = false;
			hit_sub.graphics.beginFill(0xff0000);
			
			hit_sub.graphics.lineTo(403,288);									
			hit_sub.graphics.lineTo(495,261);									
			hit_sub.graphics.lineTo(560,274);									
			hit_sub.graphics.lineTo(574,445);									
			hit_sub.graphics.lineTo(390,391);									
			
							
			hit_sub.graphics.endFill(false);
			hit_sub.alpha = 0.0;
			
			hit_sub.graphics.precisionHitTest = true;	
			this.addChild(hit_sub);
		}
		
		
		private function CreateInteriorHit():void{
			hit_interior = new Shape();
			hit_interior.touchable = false;
			hit_interior.graphics.beginFill(0xff0000);
			
			hit_interior.graphics.lineTo(95,23);									
			hit_interior.graphics.lineTo(254,65);									
			hit_interior.graphics.lineTo(248,336);									
			hit_interior.graphics.lineTo(98,386);									
			hit_interior.graphics.endFill(false);
			hit_interior.alpha = 0.0;
			
			hit_interior.graphics.precisionHitTest = true;	
			this.addChild(hit_interior);
		}
		
		private function CreateHitDoorHit(open:Boolean = false):void{
			
			
			
			hit_Door = new Shape();
			hit_Door.touchable = false
			
			if(open === false){
				hit_Door.x = 0;
				hit_Door.y = 0;
				hit_Door.graphics.beginFill(0x00FF00);
				hit_Door.graphics.lineTo(95,23);									
				hit_Door.graphics.lineTo(254,65);									
				hit_Door.graphics.lineTo(248,336);									
				hit_Door.graphics.lineTo(98,386);									
				hit_Door.graphics.endFill(false);
				hit_Door.alpha = 0.0;
				hit_Door.graphics.precisionHitTest = true;
			}else{
				hit_Door.x = 0;
				hit_Door.y = 0;
				
				hit_Door.graphics.beginFill(0x00FF00);
				hit_Door.graphics.lineTo(240,74);	
				hit_Door.graphics.lineTo(379,91);	
				hit_Door.graphics.lineTo(361,342);	
				hit_Door.graphics.lineTo(233,332);	
			
				
				hit_Door.graphics.endFill(false);
				hit_Door.alpha = 0.0;
				hit_Door.graphics.precisionHitTest = true;	
			}
			
			addChild(hit_Door);
		}
		
		
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							
							FadeOut((JungleSubmarine as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineObj,true
							);
						}else if(hit_Door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							DoorHandler();
						}else if(hit_beach.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((FarCoast as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
							);
						}else if(hit_sub.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Grass and dirt cover the hull of the submarine.");
						}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Cumulus clouds cover the sky.");
						}else if(doorOpen === true){
							if(hit_interior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalSteps();
								FadeOut((SubmarineInterior as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineInteriorObj,false
								);
							}
						}
				
					}
				}
			}
		}
		
		private function DoorHandler():void{
			if(DoorSolved === true){
				if(doorOpen === false){
					
					game.SoundFXObj.PlaySFX_MetalBoxOpen();
					game.SoundFXObj.PlaySFX_AirRelease();
					doorOpen = true;
					door.alpha = 0;
					hit_Door._graphics.clear();
					CreateInteriorHit();
					CreateHitDoorHit(true);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor;	
					}
					SaveArray['Door'] = 'open';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
				}else{
					game.SoundFXObj.PlaySFX_MetalBoxClose();
					doorOpen = false;
					door.alpha = 1;
					hit_Door._graphics.clear();
					this.removeChild(hit_interior);
					CreateHitDoorHit(false);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor;	
					}
					SaveArray['Door'] = 'closed';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarineDoor',SaveArray);
				}
			}else{
				
				FadeOut((SubmarineHatchPuzzle as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineHatchPuzzleObj,true
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
			
			
			this.assets.removeTexture("jungleSubmarineDoor_bg",true);
			this.assets.removeTexture("JungleSubmarineDoor_Sprite",true);
			this.assets.removeTextureAtlas("JungleSubmarineDoor_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarineDoor_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarineDoor_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarineDoor_03");
			
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

