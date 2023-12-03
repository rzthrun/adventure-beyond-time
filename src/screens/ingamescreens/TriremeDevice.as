package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
//	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
//	import starling.utils.rad2deg;
	
	public class TriremeDevice extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var coin:Image;
		private var gear_one:Image;
		private var gear_two:Image;
		private var gear_three:Image;
		private var gear_four:Image;
		private var disc:Image;
		private var cross:Image;
		private var lid:Image;
		private var lid_open:Image;
		private var moon_mc:MovieClip;
		
		private var arm_01:Image;
		private var arm_02:Image;
		private var arm_03:Image;
		private var arm_04:Image;
		private var arm_05:Image;
		private var arm_06:Image;
		
		private var hit_arm_01:Shape;
		private var hit_arm_02:Shape;
		private var hit_arm_03:Shape;
		private var hit_arm_04:Shape;
		private var hit_arm_05:Shape;
		private var hit_arm_06:Shape;
		
		private var arm_01_sprite:Sprite;
		private var arm_02_sprite:Sprite;
		private var arm_03_sprite:Sprite;
		private var arm_04_sprite:Sprite;
		private var arm_05_sprite:Sprite;
		private var arm_06_sprite:Sprite;
		
		private var cap:Image;
		
		private var hit_dial:Shape;
		private var hit_face:Shape;
		
		private var hit_moon:Shape;
		
		private var hand_multiplier:int = 0;
		private var hand_multiplier_dir:Number = 1;	
		private var HandFlag:String = null;
		private var Solved:Boolean = false;
		private var WindUpPlaying:Boolean = false;
		private var DialActive:Boolean = false;
		
		private var MouseCurrentAngle:Number = 180;
		private var MousePrevAngle:Number = 180;
		
		private var BallAttached:Boolean = false;
		private var MarsAttached:Boolean = false;
		private var SunAttached:Boolean = false;
		private var Animating:Boolean = false;
		
		private var LidOpen:Boolean = false;
		
		private var delayedcall:DelayedCall;
		
		private var hit_coin:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function TriremeDevice(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('triremeDevice_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDevice/triremeDevice_bg.jpg'));
				game.TrackAssets('triremeDevice_01');
			}
		/*	if(game.CheckAsset('triremeDevice_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDevice/TriremeDevice_Sprite.png'));
				game.TrackAssets('triremeDevice_02');
			}
			if(game.CheckAsset('triremeDevice_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDevice/TriremeDevice_Sprite.xml'));
				game.TrackAssets('triremeDevice_03');
			}
		*/
			if(game.CheckAsset('triremeDevice_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDevice/TriremeDevice_Moon_Sprite.png'));
				game.TrackAssets('triremeDevice_02');
			}
			if(game.CheckAsset('triremeDevice_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDevice/TriremeDevice_Moon_Sprite.xml'));
				game.TrackAssets('triremeDevice_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TriremeDevice","TriremeDeviceObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('triremeDevice_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			coin = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('trireme_device_coin'));
			coin.touchable = false;
			coin.x = 70;
			coin.y = 1;
			
			gear_one = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('gear_one'));
			gear_one.touchable = false;
			gear_one.pivotX = 96;
			gear_one.pivotY = 100;
			gear_one.x = 406;
			gear_one.y = 112;
					
			gear_two = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('gear_two'));
			gear_two.touchable = false;
			gear_two.pivotX = 97;
			gear_two.pivotY = 99;
			gear_two.x = 518;
			gear_two.y = 354;
			
			gear_three = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('gear_three'));
			gear_three.touchable = false;
			gear_three.pivotX = 56;
			gear_three.pivotY = 56;
			gear_three.x = 406;
			gear_three.y = 440;
	
			gear_four = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('gear_four'));
			gear_four.touchable = false;
			gear_four.pivotX = 121;
			gear_four.pivotY = 120;
			gear_four.x = 238;
			gear_four.y = 390;

			disc = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('trireme_device_disc'));
			disc.touchable = false;
			disc.pivotX = 215;
			disc.pivotY = 189;
			disc.x = 355;
			disc.y = 252;

			cross = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('cross'));
			cross.touchable = false;
			cross.pivotX = 215;
			cross.pivotY = 215;
			cross.x = 352;
			cross.y = 256;
			
			lid = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('trireme_device_lid'));
			lid.touchable = false;
			lid.x = 26;
			lid.y = 0;

			moon_mc = new MovieClip(this.assets.getTextures('anima_'),12);
			//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
			moon_mc.x = 391;
			moon_mc.y= 234;	
			moon_mc.touchable = false;
			moon_mc.currentFrame = 55;
			moon_mc.loop = true; // default: true
			
			
			lid_open = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('trireme_device_lid_open'));
			lid_open.touchable = false;
			lid_open.x = 1;
			lid_open.y = 0;

	
			arm_06_sprite = new Sprite();
			arm_06_sprite.x = 353;
			arm_06_sprite.y = 257;
			arm_06_sprite.pivotX = 30;
			
			arm_06 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_06'));
			arm_06.touchable = false;
			arm_06_sprite.addChild(arm_06);
	
			arm_05_sprite = new Sprite();
			arm_05_sprite.x = 353;
			arm_05_sprite.y = 257;
			arm_05_sprite.pivotX = 30;
				
			arm_05 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_05'));
			arm_05.touchable = false;
			arm_05_sprite.addChild(arm_05);
		
			arm_04_sprite = new Sprite();
			arm_04_sprite.x = 353;
			arm_04_sprite.y = 257;
			arm_04_sprite.pivotX = 30;		
			arm_04 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_04'));
			arm_04.touchable = false;
			arm_04_sprite.addChild(arm_04);
			
			arm_03_sprite = new Sprite();
			arm_03_sprite.x = 350;
			arm_03_sprite.y = 257;
			arm_03_sprite.pivotX = 30;				
			arm_03 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_03'));
			arm_03.touchable = false;
			arm_03_sprite.addChild(arm_03)
			
			arm_02_sprite = new Sprite();
			arm_02_sprite.x = 353;
			arm_02_sprite.y = 257;
			arm_02_sprite.pivotX = 30;
				
			arm_02 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_02'));
			arm_02.touchable = false;
			arm_02_sprite.addChild(arm_02)

			arm_01_sprite = new Sprite();
			arm_01_sprite.x = 353;
			arm_01_sprite.y = 257;
			arm_01_sprite.pivotX = 30;
					
			arm_01 = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('arm_01'));
			arm_01.touchable = false;
			arm_01_sprite.addChild(arm_01)

			cap = new Image((stage.getChildAt(0) as Object).TriremeDeviceImages.assets.getTexture('trireme_device_cap'));
			cap.touchable = false;
			cap.x = 308;
			cap.y = 213;
			

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Ball'] == 'Attached'){
					moon_mc.alpha = 1;
					BallAttached = true;
				}else{
					moon_mc.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Mars'] == 'Attached'){
					arm_04_sprite.alpha = 1;
					MarsAttached = true;
				}else{
					arm_04_sprite.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Sun'] == 'Attached'){
					arm_03_sprite.alpha = 1;
					SunAttached = true;
				}else{
					arm_03_sprite.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_06_pos'] != undefined){
					 arm_01_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_01_pos'];
					 arm_02_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_02_pos'];
					 arm_03_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_03_pos'];
					 arm_04_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_04_pos'];
					 arm_05_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_05_pos'];
					 arm_06_sprite.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['arm_06_pos'];
				}else {
					arm_06_sprite.rotation = deg2rad(180);
					arm_05_sprite.rotation = deg2rad(240);
					arm_04_sprite.rotation = deg2rad(120);
					arm_03_sprite.rotation = deg2rad(300);
					arm_02_sprite.rotation = deg2rad(60);
					arm_01_sprite.rotation = deg2rad(0);
					
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Solved'] == 'Yes'){
					Solved = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Lid'] == 'Open'){
						LidOpen = true
						disc.alpha = 0;
						cross.alpha = 0;
						lid.alpha = 0;
						lid_open.alpha = 1;
						moon_mc.alpha = 0;
						cap.alpha = 0;
						arm_06_sprite.alpha = 0;	
						arm_05_sprite.alpha = 0;	
						arm_04_sprite.alpha = 0;	
						arm_03_sprite.alpha = 0;	
						arm_02_sprite.alpha = 0;	
						arm_01_sprite.alpha = 0;
						
						CreateCoinHit();
						
					}else{
						disc.alpha = 1;
						cross.alpha = 1;
						lid.alpha = 1;
						lid_open.alpha = 0;
						cap.alpha = 1;
						moon_mc.alpha = 1;
						arm_06_sprite.alpha = 1;	
						arm_05_sprite.alpha = 1;	
						arm_04_sprite.alpha = 1;	
						arm_03_sprite.alpha = 1;	
						arm_02_sprite.alpha = 1;	
						arm_01_sprite.alpha = 1;
					}
					
				}else{
					disc.alpha = 1;
					cross.alpha = 1;
					lid.alpha = 1;
					cap.alpha = 1;
					lid_open.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Coin'] == 'PickedUp'){
					coin.alpha = 0;
				}else{
					coin.alpha = 1;
				}
				
				
				
			}else{
				moon_mc.alpha = 0;
				arm_04_sprite.alpha = 0;
				arm_03_sprite.alpha = 0;	
				
				arm_06_sprite.rotation = deg2rad(180);
				arm_05_sprite.rotation = deg2rad(240);
				arm_04_sprite.rotation = deg2rad(120);
				arm_03_sprite.rotation = deg2rad(300);
				arm_02_sprite.rotation = deg2rad(60);

				
				coin.alpha = 1;
				
				disc.alpha = 1;
				cross.alpha = 1;
				lid.alpha = 1;
				lid_open.alpha = 0;
				
				arm_06_sprite.alpha = 1;	
				arm_05_sprite.alpha = 1;	
				
				arm_02_sprite.alpha = 1;	
				arm_01_sprite.alpha = 1;
				cap.alpha = 1;
				
			}
			
			gear_one.alpha = 1;
			gear_two.alpha = 1;
			gear_three.alpha = 1;
			gear_four.alpha = 1;
			
			//coin.alpha = 0;
			
			//---
			
			this.addChildAt(coin,1);
			this.addChildAt(gear_one,2);
			this.addChildAt(gear_two,3);
			this.addChildAt(gear_three,4);
			this.addChildAt(gear_four,5);
			this.addChildAt(disc,6);
			this.addChildAt(cross,7);
			this.addChildAt(lid,8);
			this.addChildAt(moon_mc,9);	
			this.addChildAt(arm_06_sprite,10);
			this.addChildAt(arm_05_sprite,11);
			this.addChildAt(arm_04_sprite,12);
			this.addChildAt(arm_03_sprite,13);
			this.addChildAt(arm_02_sprite,14);
			this.addChildAt(arm_01_sprite,15);
			this.addChildAt(cap,16);
			this.addChildAt(lid_open,17);
			
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			CreateMoonHit();
			CreateFaceHit(LidOpen);
			CreateArmHits();
			CreateDialHit();
		//	addEventListener(EnterFrameEvent.ENTER_FRAME, FrameTest);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			if((stage.getChildAt(0) as Object).AmbientObj.currentAmbient == 'Waterfall'){
				trace("BARK1");
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
			}else{
				trace("BARK2");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
				},0.7);
			}
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waterfall';
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waterfall",((stage.getChildAt(0) as Object).MusicObj.globalVol/2),1.0);
		}
		
		//hit_face
		
		private function CreateFaceHit(open:Boolean = false):void{
			hit_face = new Shape();
			hit_face.touchable = false;
			
			if(open === false){
				hit_face.x = 0;
				hit_face.y = 0;
				
				hit_face.graphics.beginFill(0x0000ff);
				
				hit_face.graphics.lineTo(75,0);	
				hit_face.graphics.lineTo(628,0);	
				hit_face.graphics.lineTo(628,512);	
				hit_face.graphics.lineTo(75,512);	
	
				hit_face.graphics.endFill(false);
				hit_face.alpha = 0.1;
			}else{
				hit_face.x = 0;
				hit_face.y = 0;
				
				hit_face.graphics.beginFill(0x0000ff);
				
				hit_face.graphics.lineTo(0,0);	
				hit_face.graphics.lineTo(73,0);	
				hit_face.graphics.lineTo(73,512);	
				hit_face.graphics.lineTo(0,512);	
				
				hit_face.graphics.endFill(false);
				hit_face.alpha = 0.0;
			}
			
			hit_face.graphics.precisionHitTest = true;	
			this.addChild(hit_face);
		}
		//hit_moon
		private function CreateMoonHit():void{
			hit_moon = new Shape();
			hit_moon.touchable = false;
			hit_moon.graphics.beginFill(0xff0000);
			
			hit_moon.graphics.lineTo(388,224);	
			hit_moon.graphics.lineTo(440,225);	
			hit_moon.graphics.lineTo(436,283);	
			hit_moon.graphics.lineTo(376,275);	
			
			hit_moon.graphics.endFill(false);
			hit_moon.alpha = 0.0;
			
			hit_moon.graphics.precisionHitTest = true;	
			this.addChild(hit_moon);
		}
		
		private function CreateDialHit():void{
			hit_dial = new Shape();
			hit_dial.touchable = false;
			hit_dial.graphics.beginFill(0xff0000);
			
			hit_dial.graphics.lineTo(680,110);	
			hit_dial.graphics.lineTo(796,104);	
			hit_dial.graphics.lineTo(796,375);	
			hit_dial.graphics.lineTo(675,381);	
			
			hit_dial.graphics.endFill(false);
			hit_dial.alpha = 0.0;
			
			hit_dial.graphics.precisionHitTest = true;	
			this.addChild(hit_dial);
		}
		
		private function CreateArmHits():void{	
			hit_arm_06 = new Shape();
			hit_arm_06.touchable = false;
			hit_arm_06.graphics.beginFill(0xff0000);

			hit_arm_06.graphics.lineTo(-20+32,32);	
			hit_arm_06.graphics.lineTo(16+32,32);	
			hit_arm_06.graphics.lineTo(25+32,246);	
			hit_arm_06.graphics.lineTo(-4+32,246);	
			hit_arm_06.graphics.lineTo(-31+32,242);	

			hit_arm_06.graphics.endFill(false);
			hit_arm_06.alpha = 0.0;
			
			hit_arm_06.graphics.precisionHitTest = true;	
			arm_06_sprite.addChild(hit_arm_06);
			
			
			hit_arm_05 = new Shape();
			hit_arm_05.touchable = false;
			hit_arm_05.graphics.beginFill(0xff0000);
			
			hit_arm_05.graphics.lineTo(-20+32,32);	
			hit_arm_05.graphics.lineTo(16+32,32);	
			hit_arm_05.graphics.lineTo(25+32,221);	
			hit_arm_05.graphics.lineTo(-3+32,223);	
			hit_arm_05.graphics.lineTo(-28+32,221);	
			
			hit_arm_05.graphics.endFill(false);
			hit_arm_05.alpha = 0.0;
			
			hit_arm_05.graphics.precisionHitTest = true;	
			arm_05_sprite.addChild(hit_arm_05);
			
			
			
			hit_arm_04 = new Shape();
			hit_arm_04.touchable = false;
			hit_arm_04.graphics.beginFill(0xff0000);
		
			hit_arm_04.graphics.lineTo(-20+32,32);	
			hit_arm_04.graphics.lineTo(16+32,32);	
			hit_arm_04.graphics.lineTo(25+32,192);	
			hit_arm_04.graphics.lineTo(-3+32,198);	
			hit_arm_04.graphics.lineTo(-28+32,192);	
			
			hit_arm_04.graphics.endFill(false);
			hit_arm_04.alpha = 0.0;
			
			hit_arm_04.graphics.precisionHitTest = true;	
			arm_04_sprite.addChild(hit_arm_04);
			
			
			
			hit_arm_03 = new Shape();
			hit_arm_03.touchable = false;
			hit_arm_03.graphics.beginFill(0xff0000);
			
			hit_arm_03.graphics.lineTo(-20+32,32);	
			hit_arm_03.graphics.lineTo(23+32,32);	
			hit_arm_03.graphics.lineTo(28+32,169);	
			hit_arm_03.graphics.lineTo(-0+32,175);	
			hit_arm_03.graphics.lineTo(-28+32,169);	
			
			hit_arm_03.graphics.endFill(false);
			hit_arm_03.alpha = 0.0;
			
			hit_arm_03.graphics.precisionHitTest = true;	
			arm_03_sprite.addChild(hit_arm_03);
			
			
			
			hit_arm_02 = new Shape();
			hit_arm_02.touchable = false;
			hit_arm_02.graphics.beginFill(0xff0000);
			
			hit_arm_02.graphics.lineTo(-20+32,32);	
			hit_arm_02.graphics.lineTo(16+32,32);	
			hit_arm_02.graphics.lineTo(25+32,139);	
			hit_arm_02.graphics.lineTo(-3+32,146);	
			hit_arm_02.graphics.lineTo(-30+32,137);	
			
			hit_arm_02.graphics.endFill(false);
			hit_arm_02.alpha = 0.0;
			
			hit_arm_02.graphics.precisionHitTest = true;	
			arm_02_sprite.addChild(hit_arm_02);
			
			
			hit_arm_01 = new Shape();
			hit_arm_01.touchable = false;
			hit_arm_01.graphics.beginFill(0xff0000);
			
			hit_arm_01.graphics.lineTo(-20+32,32);	
			hit_arm_01.graphics.lineTo(16+32,32);	
			hit_arm_01.graphics.lineTo(23+32,103);	
			hit_arm_01.graphics.lineTo(-3+32,123);	
			hit_arm_01.graphics.lineTo(-26+32,103);	
			
			hit_arm_01.graphics.endFill(false);
			hit_arm_01.alpha = 0.0;
			
			hit_arm_01.graphics.precisionHitTest = true;	
			arm_01_sprite.addChild(hit_arm_01);
			
		}
		
		
		
		
		private function CreateCoinHit():void{
			hit_coin = new Shape();
			hit_coin.touchable = false;
			hit_coin.graphics.beginFill(0xff0000);
			
			hit_coin.graphics.lineTo(99,62);	
			hit_coin.graphics.lineTo(180,5);	
			hit_coin.graphics.lineTo(283,11);	
			hit_coin.graphics.lineTo(335,90);	
			hit_coin.graphics.lineTo(334,192);	
			hit_coin.graphics.lineTo(260,244);	
			hit_coin.graphics.lineTo(165,239);	
			hit_coin.graphics.lineTo(163,242);	
			hit_coin.graphics.lineTo(103,174);	
		
			hit_coin.graphics.endFill(false);
			hit_coin.alpha = 0.0;
			
			hit_coin.graphics.precisionHitTest = true;	
			this.addChild(hit_coin);
		}
		
	
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.BEGAN) {
						//trace(touches[0].globalX+" ,"+touches[0].globalY);
						trace((touches[0].globalX)+" ,"+(touches[0].globalY));
					
						//trace("SPRITE: "+touches[0].arm_06_sprite.x+" ,"+touches[0].arm_06_sprite.y);
							
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((TriremeInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.TriremeInteriorObj,true
							);
						}else if(Solved === false){
							if(hit_face.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_Ball)
								{
									
									BallHandler();
								}else if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_ArmMars)
								{
									MarsHandler();
								}else if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_ArmSun)
								{
									SunHandler();
								}else{
									if(hit_arm_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
	//										((Math.atan2(touches[0].globalY-353, touches[0].globalX-257))
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_01";							
									}else if(hit_arm_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_02";							
									}else if(hit_arm_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_03";							
									}else if(hit_arm_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_04";							
									}else if(hit_arm_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_05";							
									}else if(hit_arm_06.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										MousePrevAngle = (
											((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
												*180
											)/ Math.PI
										)+180;
										HandFlag = "arm_06";							
									}else if(hit_moon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										if(BallAttached === false){
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a round hole near the center of the device.");
										}else{
											
										}
									}
								}
								
							}else if(hit_dial.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = touches[0].globalY;
								DialActive = true;							
							
							}
						}else if(Solved === true){
							if(hit_face.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								LidHandler();
								
							}else if(hit_dial.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = touches[0].globalY;
								DialActive = true;			
							
							}else if(LidOpen === true){
								if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									CoinHandler();
								}
							}
						}
					}else if(touches[0].phase == TouchPhase.MOVED){
						if(Solved === false){
							if(HandFlag != null){
								
								ArmHandler();
							}else if(DialActive === true){
								DialHandler();
							}
						}else{
							if(DialActive === true){
								DialHandler();
							}
						}
					}else if(touches[0].phase == TouchPhase.ENDED){
						WindUpPlaying = false;
						DialActive = false;
						MousePrevAngle = 180;
						MouseCurrentAngle = 180;
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("WindUp");
						
						if(Solved === false){
							HandFlag = null;
							Solve();
						}
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
						}
						SaveArray['arm_01_pos'] = arm_01_sprite.rotation;
						SaveArray['arm_02_pos'] = arm_02_sprite.rotation;
						SaveArray['arm_03_pos'] = arm_03_sprite.rotation;
						SaveArray['arm_04_pos'] = arm_04_sprite.rotation;
						SaveArray['arm_05_pos'] = arm_05_sprite.rotation;
						SaveArray['arm_06_pos'] = arm_06_sprite.rotation;
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
					}
				}
			}
		}
		
		private function CoinHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Coin'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					coin.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
					}
					SaveArray["Coin"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
						'item_CoinTurtle',
						'inven_coinTurtle_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				coin.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
				}
				SaveArray["Coin"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
					'item_CoinTurtle',
					'inven_coinTurtle_sm'
				);
			}
		}
		
		private function BallHandler():void{
			moon_mc.alpha = 1;
			BallAttached = true;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
			}
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			SaveArray['Ball'] = "Attached";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
			
			(stage.getChildAt(0) as Object)
			.screenGamePlayHandler
				.InventoryObj.removeItemFromInventory(
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.item_Ball,
					"item_Ball"
				);
			//Solve();
		}
		
		private function MarsHandler():void{
			arm_04_sprite.alpha = 1;
			MarsAttached = true;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
			}
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
			SaveArray['Mars'] = "Attached";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
			
			(stage.getChildAt(0) as Object)
			.screenGamePlayHandler
				.InventoryObj.removeItemFromInventory(
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.item_ArmMars,
					"item_ArmMars"
				);
		//	Solve();
			
		}
		
		
		private function SunHandler():void{
			arm_03_sprite.alpha = 1;
			SunAttached = true;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
			}
			SaveArray['Sun'] = "Attached";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
			
		
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
			
			(stage.getChildAt(0) as Object)
			.screenGamePlayHandler
				.InventoryObj.removeItemFromInventory(
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.item_ArmSun,
					"item_ArmSun"
				);
			
		//	Solve();
		}
		
		
		private function DialHandler():void{
			if(WindUpPlaying === false){
				WindUpPlaying = true;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
			}
			MouseCurrentAngle = touches[0].globalY;
			if(MousePrevAngle > MouseCurrentAngle){
				arm_01_sprite.rotation = arm_01_sprite.rotation-(deg2rad(1));	
				arm_02_sprite.rotation = arm_02_sprite.rotation-(deg2rad(0.8));	
				arm_03_sprite.rotation = arm_03_sprite.rotation-(deg2rad(0.6));	
				arm_04_sprite.rotation = arm_04_sprite.rotation-(deg2rad(0.4));	
				arm_05_sprite.rotation = arm_05_sprite.rotation-(deg2rad(0.2));	
				arm_06_sprite.rotation = arm_06_sprite.rotation-(deg2rad(0.1));	
				
				gear_one.rotation -= deg2rad(0.5);
				gear_two.rotation -= deg2rad(0.5);
				gear_three.rotation -= deg2rad(0.5);
				gear_four.rotation -= deg2rad(0.5);
				disc.rotation -= deg2rad(0.5);
				cross.rotation -= deg2rad(1);
				
				if(moon_mc.currentFrame == moon_mc.numFrames-1){
					moon_mc.currentFrame = 0;
				}else{
					moon_mc.currentFrame += 1;
				}
			}else if(MousePrevAngle < MouseCurrentAngle){
				//trace("BARK 1");
				arm_01_sprite.rotation = arm_01_sprite.rotation+(deg2rad(1));	
				arm_02_sprite.rotation = arm_02_sprite.rotation+(deg2rad(0.8));	
				arm_03_sprite.rotation = arm_03_sprite.rotation+(deg2rad(0.6));	
				arm_04_sprite.rotation = arm_04_sprite.rotation+(deg2rad(0.4));	
				arm_05_sprite.rotation = arm_05_sprite.rotation+(deg2rad(0.2));	
				arm_06_sprite.rotation = arm_06_sprite.rotation+(deg2rad(0.1));	
				
				gear_one.rotation += deg2rad(0.5);
				gear_two.rotation += deg2rad(0.5);
				gear_three.rotation += deg2rad(0.5);
				gear_four.rotation += deg2rad(0.5);
				disc.rotation += deg2rad(0.5);
				cross.rotation += deg2rad(1);
				
				if(moon_mc.currentFrame == 0){
				//	trace("BARK 2");
					moon_mc.currentFrame = moon_mc.numFrames-1
				}else{
				//	trace("BARK 3");
					moon_mc.currentFrame -= 1;
				}

			}
			MousePrevAngle = MouseCurrentAngle
				
			
				
		}
		
		private function ArmHandler():void{
			if(WindUpPlaying === false){
				WindUpPlaying = true;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
			}
			MouseCurrentAngle = (
				((Math.atan2(touches[0].globalY-257, touches[0].globalX-353))
					*180
				)/ Math.PI
			)+180;
			if(MousePrevAngle > MouseCurrentAngle){
			//trace("Prev Greater");
				this[(HandFlag+"_sprite")].rotation = this[(HandFlag+"_sprite")].rotation-(deg2rad(1));	
				//hand_multiplier_dir = -1;
			
				gear_one.rotation -= deg2rad(0.25);
				gear_two.rotation -= deg2rad(0.25);
				gear_three.rotation -= deg2rad(0.25);
				gear_four.rotation -= deg2rad(0.25);
				disc.rotation -= deg2rad(0.25);
				cross.rotation -= deg2rad(0.5);

				if(moon_mc.currentFrame == moon_mc.numFrames-1){
					moon_mc.currentFrame = 0;
				}else{
					moon_mc.currentFrame += 1;
				}
				
			}else if(MousePrevAngle < MouseCurrentAngle){
				//trace("Prev Less");
				this[(HandFlag+"_sprite")].rotation = this[(HandFlag+"_sprite")].rotation+(deg2rad(1));		
			//	hand_multiplier_dir = 1;

				gear_one.rotation += deg2rad(0.25);
				gear_two.rotation += deg2rad(0.25);
				gear_three.rotation += deg2rad(0.25);
				gear_four.rotation += deg2rad(0.25);
				disc.rotation += deg2rad(0.25);
				cross.rotation += deg2rad(0.5);
				
				if(moon_mc.currentFrame == 0){
					//trace("BARK 2");
					moon_mc.currentFrame = moon_mc.numFrames-1
				}else{
					//trace("BARK 3");
					moon_mc.currentFrame -= 1;
				}
			}
			//var tempRot:int = 
			//trace("arm_0"+HandFlag+"_sprite  :   "+tempRot)
			//trace("arm_0"+HandFlag+"_sprite  :   "+rad2deg(this[(HandFlag+"_sprite")].rotation))
			//trace("arm_0"+HandFlag+"_sprite  :   "+this[(HandFlag+"_sprite")].rotation)
			

					
			MousePrevAngle = MouseCurrentAngle;
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
				LidOpen = true;
				lid_open.alpha = 1;
				
				disc.alpha = 0;
				cross.alpha = 0;
				lid.alpha = 0;
				moon_mc.alpha = 0;
				cap.alpha = 0;
				arm_01_sprite.alpha = 0;
				arm_02_sprite.alpha = 0;
				arm_03_sprite.alpha = 0;
				arm_04_sprite.alpha = 0;
				arm_05_sprite.alpha = 0;
				arm_06_sprite.alpha = 0;
				
				hit_face.graphics.clear();
				CreateFaceHit(true);
				CreateCoinHit();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
				}
				SaveArray['Lid'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
				
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
				LidOpen = false;
				lid_open.alpha = 0;
				
				disc.alpha = 1;
				cross.alpha = 1;
				lid.alpha = 1;
				moon_mc.alpha = 1;
				cap.alpha = 1;
				arm_01_sprite.alpha = 1;
				arm_02_sprite.alpha = 1;
				arm_03_sprite.alpha = 1;
				arm_04_sprite.alpha = 1;
				arm_05_sprite.alpha = 1;
				arm_06_sprite.alpha = 1;
				
				this.removeChild(hit_coin);
				hit_face.graphics.clear();
				CreateFaceHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
				}
				SaveArray['Lid'] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);
				
				
			}
		}
		
		private function Solve():void{
			/*
			private var BallAttached:Boolean = false;
			private var BallAttached:Boolean = false;
			private var SunAttached:Boolean = false;
			*/
			if(BallAttached === true){
				if(MarsAttached === true){
					if(SunAttached === true){			
						trace("SOLVING");
						if(arm_01_sprite.rotation <= 0.17453292519947486 && arm_01_sprite.rotation >= -0.3665191429187673){
							trace("1 on Virgo")
							if(arm_02_sprite.rotation <= 1.117010721276371 && arm_02_sprite.rotation >= 0.7330382858376179){
								trace("2 on Scorpio")
								if(arm_03_sprite.rotation <= -0.8726646259971642 && arm_03_sprite.rotation >= -1.3264502315156905){
									trace("3 on Cancer")
									if(arm_04_sprite.rotation <= 2.199114857512854 && arm_04_sprite.rotation >= 1.7278759594743867){
										trace("4 on Capricon")
										if(arm_05_sprite.rotation <= -1.9547687622336503 && arm_05_sprite.rotation >= -2.478367537831944){
											trace("5 on Taurus")
											if(arm_06_sprite.rotation <=  -3.0368728984701345 || arm_06_sprite.rotation >= 2.740166925631102){
												trace("6 on Capricon")
												trace("SOLVED !!!!")
												Animating = true;
												Solved = true;
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
												trace("Solved");
												delayedcall = new DelayedCall(function():void{
													
													(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
													(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClockChime();
													LidHandler();
													Animating = false;
													
												},2);
												
												if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
													SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice;
												}
												
												SaveArray['Solved'] = 'Yes'; 
												(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDevice',SaveArray);	
												
												
												Starling.juggler.add(delayedcall);
												
											}
										}
									}
								}
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
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("triremeDevice_bg",true);
		//	this.assets.removeTexture("TriremeDevice_Sprite",true);
		//	this.assets.removeTextureAtlas("TriremeDevice_Sprite",true);
			this.assets.removeTexture("TriremeDevice_Moon_Sprite",true);
			this.assets.removeTextureAtlas("TriremeDevice_Moon_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("triremeDevice_01");
			(stage.getChildAt(0) as Object).falseAsset("triremeDevice_02");
			(stage.getChildAt(0) as Object).falseAsset("triremeDevice_03");
		//	(stage.getChildAt(0) as Object).falseAsset("triremeDevice_04");
		//	(stage.getChildAt(0) as Object).falseAsset("triremeDevice_05");
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