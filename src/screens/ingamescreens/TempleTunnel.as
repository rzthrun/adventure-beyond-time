package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class TempleTunnel extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ball_one:Image;
		private var ball_two:Image;
		private var ball_three:Image;
		private var ball_five:Image;
		private var ball_seven:Image;
		
		private var puzzleDoor:Image;
		
		private var hit_TempleTunnelLeft:Shape;
		private var hit_TempleTunnelRight:Shape;
		private var hit_TemplePascal:Shape;
		
		private var hit_wallOne:Shape;
		private var hit_wallTwo:Shape;
		private var hit_wallThree:Shape;		
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;			
		
		public function TempleTunnel(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('templeTunnel_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnel/templeTunnel_bg.jpg'));
				game.TrackAssets('templeTunnel_01');
			}
			if(game.CheckAsset('templeTunnel_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnel/TempleTunnel_Sprite.png'));
				game.TrackAssets('templeTunnel_02');
			}
			if(game.CheckAsset('templeTunnel_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnel/TempleTunnel_Sprite.xml'));
				game.TrackAssets('templeTunnel_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TempleTunnel","TempleTunnelObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('templeTunnel_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			puzzleDoor = new Image(this.assets.getTexture('puzzle_door'));
			puzzleDoor.touchable = false;
			puzzleDoor.x = 330;
			puzzleDoor.y = 188;
			
			
			ball_one = new Image(this.assets.getTexture('one'));
			ball_one.touchable = false;
			ball_one.x = 218;
			ball_one.y = 263;
						
			ball_two = new Image(this.assets.getTexture('two'));
			ball_two.touchable = false;
			ball_two.x = 175;
			ball_two.y = 282;
						
			ball_three = new Image(this.assets.getTexture('three'));
			ball_three.touchable = false;
			ball_three.x = 161;
			ball_three.y = 320;
						
			ball_five = new Image(this.assets.getTexture('five'));
			ball_five.touchable = false;
			ball_five.x = 614;
			ball_five.y = 312;

			ball_seven = new Image(this.assets.getTexture('seven'));
			ball_seven.touchable = false;
			ball_seven.x = 564;
			ball_seven.y = 288;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallThree'] == 'Attached'){
					ball_three.alpha = 1;
				}else{
					ball_three.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallTwo'] == 'Attached'){
					ball_two.alpha = 1;
				}else{
					ball_two.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallOne'] == 'Attached'){
					ball_one.alpha = 1;
				}else{
					ball_one.alpha = 0;
				}
			}else{
				ball_one.alpha = 0;
				ball_two.alpha = 0;
				ball_three.alpha = 0;
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallSeven'] == 'Attached'){
					ball_seven.alpha = 1;
				}else{
					ball_seven.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallFive'] == 'Attached'){
					ball_five.alpha = 1;
				}else{
					ball_five.alpha = 0;
				}
			
			}else{
				ball_five.alpha = 0;
				ball_seven.alpha = 0;
				
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['Solved'] == 'Yes'){
					puzzleDoor.alpha = 0;
				}else{
					puzzleDoor.alpha = 1;
				}
			}else{
				puzzleDoor.alpha = 1;
			}
		
			
			
			
			this.addChildAt(puzzleDoor,1);	
			this.addChildAt(ball_one,2);			
			this.addChildAt(ball_two,3);			
			this.addChildAt(ball_three,4);			
			this.addChildAt(ball_five,5);			
			this.addChildAt(ball_seven,6);
			/*
			private var ball_one:Image;
			private var ball_two:Image;
			private var ball_three:Image;
			private var ball_five:Image;
			private var ball_seven:Image;
			*/
			
			CreateHitWallOne();
			CreateHitWallTwo();
			CreateHitWallThree();
			CreateHitTempleTunnelLeft();
			CreateHitTempleTunnelRight();
			CreateHitTemplePascal();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnel != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnel['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnel;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnel',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnel',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,1);
					},0.5);
				}
			}
		}
		
		//hit_TemplePascal
		
		private function CreateHitWallThree():void{
			hit_wallThree = new Shape();
			hit_wallThree.touchable = false;
			hit_wallThree.graphics.beginFill(0xff0000);
			
			hit_wallThree.graphics.lineTo(438,0);																
			hit_wallThree.graphics.lineTo(640,0);																
			hit_wallThree.graphics.lineTo(800,165);																
			hit_wallThree.graphics.lineTo(800,344);																
			hit_wallThree.graphics.lineTo(537,277);																
			
			hit_wallThree.alpha = 0.0;
			
			hit_wallThree.graphics.precisionHitTest = true;	
			this.addChild(hit_wallThree);
		}
		
		private function CreateHitWallTwo():void{
			hit_wallTwo = new Shape();
			hit_wallTwo.touchable = false;
			hit_wallTwo.graphics.beginFill(0xff0000);
			
			hit_wallTwo.graphics.lineTo(172,214);																
			hit_wallTwo.graphics.lineTo(275,0);																
			hit_wallTwo.graphics.lineTo(335,0);																
			hit_wallTwo.graphics.lineTo(413,82);																
			hit_wallTwo.graphics.lineTo(288,304);																
		
			hit_wallTwo.alpha = 0.0;
			
			hit_wallTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_wallTwo);
		}
		
		private function CreateHitWallOne():void{
			hit_wallOne = new Shape();
			hit_wallOne.touchable = false;
			hit_wallOne.graphics.beginFill(0xff0000);
			
			hit_wallOne.graphics.lineTo(0,0);																
			hit_wallOne.graphics.lineTo(256,0);																
			hit_wallOne.graphics.lineTo(136,385);																
			hit_wallOne.graphics.lineTo(0,311);																
			
			hit_wallOne.alpha = 0.0;
			
			hit_wallOne.graphics.precisionHitTest = true;	
			this.addChild(hit_wallOne);
		}
		
		
		private function CreateHitTemplePascal():void{
			hit_TemplePascal = new Shape();
			hit_TemplePascal.touchable = false;
			hit_TemplePascal.graphics.beginFill(0xff0000);
			
			hit_TemplePascal.graphics.lineTo(303,321);																
			hit_TemplePascal.graphics.lineTo(407,126);																
			hit_TemplePascal.graphics.lineTo(433,128);																
			hit_TemplePascal.graphics.lineTo(527,293);																
			hit_TemplePascal.graphics.lineTo(522,347);																
			hit_TemplePascal.graphics.lineTo(471,369);																
			hit_TemplePascal.graphics.lineTo(336,360);																
																
			hit_TemplePascal.alpha = 0.0;
			
			hit_TemplePascal.graphics.precisionHitTest = true;	
			this.addChild(hit_TemplePascal);
		}
		
		private function CreateHitTempleTunnelLeft():void{
			hit_TempleTunnelLeft = new Shape();
			hit_TempleTunnelLeft.touchable = false;
			hit_TempleTunnelLeft.graphics.beginFill(0xff0000);
			
			hit_TempleTunnelLeft.graphics.lineTo(90,362);																
			hit_TempleTunnelLeft.graphics.lineTo(98,284);																
			hit_TempleTunnelLeft.graphics.lineTo(183,227);																
			hit_TempleTunnelLeft.graphics.lineTo(253,234);																
			hit_TempleTunnelLeft.graphics.lineTo(281,298);																
			hit_TempleTunnelLeft.graphics.lineTo(243,378);																
			hit_TempleTunnelLeft.graphics.lineTo(180,404);																
			
			hit_TempleTunnelLeft.alpha = 0.0;
			
			hit_TempleTunnelLeft.graphics.precisionHitTest = true;	
			this.addChild(hit_TempleTunnelLeft);
		}
		
		private function CreateHitTempleTunnelRight():void{
			hit_TempleTunnelRight = new Shape();
			hit_TempleTunnelRight.touchable = false;
			hit_TempleTunnelRight.graphics.beginFill(0xff0000);
			
			hit_TempleTunnelRight.graphics.lineTo(540,303);																
			hit_TempleTunnelRight.graphics.lineTo(556,248);																
			hit_TempleTunnelRight.graphics.lineTo(593,243);																
			hit_TempleTunnelRight.graphics.lineTo(684,275);																
			hit_TempleTunnelRight.graphics.lineTo(706,322);																
			hit_TempleTunnelRight.graphics.lineTo(664,394);																
			hit_TempleTunnelRight.graphics.lineTo(611,407);	
			hit_TempleTunnelRight.graphics.lineTo(543,369);	
			
			hit_TempleTunnelRight.alpha = 0.0;
			
			hit_TempleTunnelRight.graphics.precisionHitTest = true;	
			this.addChild(hit_TempleTunnelRight);
		}
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((MountainTemple as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainTempleObj,true
						);
					}else if(hit_TemplePascal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((TemplePascal as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TemplePascalObj,true
						);	
					}else if(hit_TempleTunnelLeft.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((TempleTunnelLeft as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TempleTunnelLeftObj,true
						);	
					}else if(hit_TempleTunnelRight.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((TempleTunnelRight as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TempleTunnelRightObj,true
						);	
					}else if(hit_wallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The triangles are made of many smaller triangles.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The large triangles look like they form an even bigger form half buried in the mountain.");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shapes get smaller and smaller, until they become invisible to the eye.");
							
						}
					}else if(hit_wallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Round shapes grow amongst the hard-edged forms.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I feel as though this place is aware of my presence");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It feels like it's waiting for something.");
							
						}
					}else if(hit_wallThree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls of the cave slant upward to form a vaulted ceiling.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The structure has the feeling of a temple.")
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Other than the wind, it is deathly still.");
							
						}
					}
					
					/*
					private var hit_wallOne:Shape;
					private var hit_wallTwo:Shape;
					private var hit_wallThree:Shape;	
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
			
			
			this.assets.removeTexture("templeTunnel_bg",true);
			this.assets.removeTexture("TempleTunnel_Sprite",true);
			this.assets.removeTextureAtlas("TempleTunnel_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("templeTunnel_01");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnel_02");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnel_03");
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
