package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	
	public class SpaceShipPuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var puzzleSprite:Sprite;
		private var PuzzleSpriteTween:Tween;
		private var disc_00:Image;
		private var disc_01:Image;
		private var disc_02:Image;
		private var disc_03:Image;
		private var disc_04:Image;
		private var disc_05:Image;
		
		private var textdisc_00:Image;
		private var textdisc_01:Image;
		private var textdisc_02:Image;
		private var textdisc_03:Image;
		private var textdisc_04:Image;
		private var textdisc_05:Image;
		
		
		private var hit_00:Shape;
		private var hit_01:Shape;
		private var hit_02:Shape;
		private var hit_03:Shape;
		private var hit_04:Shape;
		private var hit_05:Shape;
		
		
		private var deepdisc_00:Image;
		private var deepdisc_01:Image;
		private var deepdisc_02:Image;
		
		private var pageOneSprite:Sprite;
		private var PageOneTween:Tween;
		private var pageOne_Corner:Image;
		private var pageOne_Main:Image;
		private var pageOne_Switch:Image;
		private var pageOne_detail_01:Image;
		private var pageOne_detail_02:Image;
		private var pageOne_detail_03:Image;
		private var pageOne_detail_04:Image;
		
		private var hit_pageOne_switch:Shape;
		
		private var pageTwoSprite:Sprite;
		private var PageTwoTween:Tween;
		private var pageTwo_Corner:Image;
		private var pageTwo_Main:Image;
		private var pageTwo_Switch:Image;
		private var pageTwo_detail_01:Image;
		private var pageTwo_detail_02:Image;
		private var pageTwo_detail_03:Image;
		private var pageTwo_detail_04:Image;
		
		private var pageTwoAClick:Boolean = false;
		private var pageTwoBClick:Boolean = false;
		private var pageTwoCClick:Boolean = false;
		
		private var hit_pageTwo_one:Shape;
		private var hit_pageTwo_two:Shape;
		private var hit_pageTwo_three:Shape;
		
		private var hit_oven:Shape;
		private var hit_ship:Shape;
		
		private var hit_ChangePage:Shape;
		
		private var HandFlag:String = null;
		private var Animating:Boolean = false;
		private var Solved:Boolean = false;
		private var delayedCall:DelayedCall;
		private var MousePrevAngle:Number;
		private var MouseCurrentAngle:Number;
		private var CurrentPage:String = 'One';
		
		private var Unlocked:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function SpaceShipPuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('spaceShipPuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipPuzzle/spaceShipPuzzle_bg.jpg'));
				game.TrackAssets('spaceShipPuzzle_01');
			}
			if(game.CheckAsset('spaceShipPuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipPuzzle/SpaceShipPuzzle_Sprite.png'));
				game.TrackAssets('spaceShipPuzzle_02');
			}
			if(game.CheckAsset('spaceShipPuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipPuzzle/SpaceShipPuzzle_Sprite.xml'));
				game.TrackAssets('spaceShipPuzzle_03');
			}
			if(game.CheckAsset('spaceShipPuzzle_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipPuzzle/SpaceShipPuzzle_Sprite_02.png'));
				game.TrackAssets('spaceShipPuzzle_04');
			}
			if(game.CheckAsset('spaceShipPuzzle_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipPuzzle/SpaceShipPuzzle_Sprite_02.xml'));
				game.TrackAssets('spaceShipPuzzle_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SpaceShipPuzzle","SpaceShipPuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		
		//	if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
		//		SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
		//	}
		//	SaveArray['Unlocked'] = 'no';
		
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
	
			
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
			
			bg = new Image(this.assets.getTexture('spaceShipPuzzle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			puzzleSprite = new Sprite();
			puzzleSprite.touchable = false;
			puzzleSprite.x = 0;
			puzzleSprite.y = 0;
			puzzleSprite.alpha = 1;
			
			
				
			
			
				disc_00 = new Image(this.assets.getTexture('00_dial'));
				disc_00.touchable = false;
				disc_00.pivotX = 145;
				disc_00.pivotY = 145;
				disc_00.x = 160;
				disc_00.y = 121;
		
				disc_01 = new Image(this.assets.getTexture('01_dial'));
				disc_01.touchable = false;
				disc_01.pivotX = 173;
				disc_01.pivotY = 173;
				disc_01.x = 384;
				disc_01.y = 160;
	
				disc_02 = new Image(this.assets.getTexture('02_dial'));
				disc_02.touchable = false;
				disc_02.pivotX = 124;
				disc_02.pivotY = 124;
				disc_02.x = 597;
				disc_02.y = 136;
	
				disc_03 = new Image(this.assets.getTexture('03_dial'));
				disc_03.touchable = false;
				disc_03.pivotX = 162.5;
				disc_03.pivotY = 162.5;
				disc_03.x = 158;
				disc_03.y = 346;
	
				disc_04 = new Image(this.assets.getTexture('04_dial'));
				disc_04.touchable = false;
				disc_04.pivotX = 145;
				disc_04.pivotY = 145;
				disc_04.x = 378;
				disc_04.y = 285;
	
				disc_05 = new Image(this.assets.getTexture('05_dial'));
				disc_05.touchable = false;
				disc_05.pivotX = 167.5;
				disc_05.pivotY = 167.5;
				disc_05.x = 598;
				disc_05.y = 364;
				
				textdisc_00 = new Image(this.assets.getTexture('00_tex'));
				textdisc_00.touchable = false;
				textdisc_00.pivotX = 102.5;
				textdisc_00.pivotY = 102.5;
				textdisc_00.x = 160;
				textdisc_00.y = 121;
				
				textdisc_01 = new Image(this.assets.getTexture('01_tex'));
				textdisc_01.touchable = false;
				textdisc_01.pivotX = 120;
				textdisc_01.pivotY = 120;
				textdisc_01.x = 384;
				textdisc_01.y = 160;
				
				textdisc_02 = new Image(this.assets.getTexture('02_tex'));
				textdisc_02.touchable = false;
				textdisc_02.pivotX = 98.5;
				textdisc_02.pivotY = 98.5;
				textdisc_02.x = 597;
				textdisc_02.y = 136;
				
				textdisc_03 = new Image(this.assets.getTexture('01_tex'));
				textdisc_03.touchable = false;
				textdisc_03.pivotX = 120;
				textdisc_03.pivotY = 120;
				textdisc_03.x = 158;
				textdisc_03.y = 346;
				
				textdisc_04 = new Image(this.assets.getTexture('04_tex'));
				textdisc_04.touchable = false;
				textdisc_04.pivotX = 105;
				textdisc_04.pivotY = 105;
				textdisc_04.x = 378;
				textdisc_04.y = 285;
				
				textdisc_05 = new Image(this.assets.getTexture('05_tex'));
				textdisc_05.touchable = false;
				textdisc_05.pivotX = 111;
				textdisc_05.pivotY = 111;
				textdisc_05.x = 598;
				textdisc_05.y = 364;
				
				deepdisc_00 = new Image(this.assets.getTexture('deep_00'));
				deepdisc_00.touchable = false;				
				deepdisc_00.width = deepdisc_00.width*2
				deepdisc_00.height = deepdisc_00.height*2;
				deepdisc_00.pivotX = 99;
				deepdisc_00.pivotY = 99;
				deepdisc_00.x = 205;
				deepdisc_00.y = 202;
				
				deepdisc_01 = new Image(this.assets.getTexture('deep_01'));
				deepdisc_01.touchable = false;				
				deepdisc_01.width = deepdisc_01.width*2
				deepdisc_01.height = deepdisc_01.height*2;
				deepdisc_01.pivotX = 110;
				deepdisc_01.pivotY = 110;
				deepdisc_01.x = 371;
				deepdisc_01.y = 282;
				
				deepdisc_02 = new Image(this.assets.getTexture('deep_02'));
				deepdisc_02.touchable = false;				
				deepdisc_02.width = deepdisc_02.width*2
				deepdisc_02.height = deepdisc_02.height*2;
				deepdisc_02.pivotX = 100;
				deepdisc_02.pivotY = 100;
				deepdisc_02.x = 555;
				deepdisc_02.y = 229;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Solved'] == 'Yes'){
						Solved = true;
						MakePageOne();
						MakePageTwo();
						CreatePageOneHits();
						CreatePageTwoHits();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['CurrentPage'] == 'One'){
							pageOneSprite.alpha = 1;
							pageTwoSprite.alpha = 0;
							AddPageOneListener();
							
						}else{
							CurrentPage = 'Two';
							pageOneSprite.alpha = 0;
							pageTwoSprite.alpha = 1;
							AddPageTwoListener();
							
						}
						this.addChildAt(pageOneSprite,1);
						this.addChildAt(pageTwoSprite,2);
					}else{	
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['00'] != undefined){
							disc_00.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['00'];
							disc_01.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['01'];
							disc_02.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['02'];
							disc_03.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['03'];
							disc_04.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['04'];
							disc_05.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['05'];
						
							AddPuzzleSprite();
						}else{
							disc_00.rotation = deg2rad(45);
							disc_01.rotation = deg2rad(90);
							disc_02.rotation = deg2rad(135);
							disc_03.rotation = deg2rad(180);
							disc_04.rotation = deg2rad(225);
							disc_05.rotation = deg2rad(270);
							
							AddPuzzleSprite();
						}
					}
				}else{
					disc_00.rotation = deg2rad(45);
					disc_01.rotation = deg2rad(90);
					disc_02.rotation = deg2rad(135);
					disc_03.rotation = deg2rad(180);
					disc_04.rotation = deg2rad(225);
					disc_05.rotation = deg2rad(270);
					
					AddPuzzleSprite();
				}
				
				
	

			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
					Starling.juggler.delayCall(function():void{
						
						(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,1);
					},0.5);
				}
			}
			
		//(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = null;
		}
		
		private function AddPuzzleSprite():void{
			
			disc_00.alpha = 0.7;
			disc_01.alpha = 0.7;
			disc_02.alpha = 0.7;
			disc_03.alpha = 0.7;
			disc_04.alpha = 0.7;
			disc_05.alpha = 0.7;
			
			puzzleSprite.addChildAt(deepdisc_00,0);
			puzzleSprite.addChildAt(deepdisc_01,1);
			puzzleSprite.addChildAt(deepdisc_02,2);
			
			puzzleSprite.addChildAt(textdisc_00,3);
			puzzleSprite.addChildAt(textdisc_01,4);
			puzzleSprite.addChildAt(textdisc_02,5);
			puzzleSprite.addChildAt(textdisc_03,6);
			puzzleSprite.addChildAt(textdisc_04,7);
			puzzleSprite.addChildAt(textdisc_05,8);
			
			puzzleSprite.addChildAt(disc_00,9);
			puzzleSprite.addChildAt(disc_02,10);
			puzzleSprite.addChildAt(disc_04,11);
			
			puzzleSprite.addChildAt(disc_03,12);
			puzzleSprite.addChildAt(disc_01,13);
			puzzleSprite.addChildAt(disc_05,14);
			
			
			this.addChildAt(puzzleSprite,1);
			
			CreateDiscHit();
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, RotateTexImages);
			
		}
		
		private function MakePageOne():void{
			
			
			
			pageOneSprite = new Sprite();
			pageOneSprite.touchable = false;
			pageOneSprite.x = 0;
			pageOneSprite.y = 0;
			pageOneSprite.alpha = 1;
			
			pageOne_Corner = new Image(this.assets.getTexture('info_01'));
			pageOne_Corner.touchable = false;				
			pageOne_Corner.x = 50;
			pageOne_Corner.y = 50;
			pageOne_Corner.alpha = 1;
			
			pageOne_Main = new Image(this.assets.getTexture('oven'));
			pageOne_Main.touchable = false;				
			
			pageOne_Main.x = 451;
			pageOne_Main.y = 62;
			pageOne_Main.alpha = 0.7;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					pageOne_Switch = new Image(this.assets.getTexture('switch_closed'));
				}else{
					pageOne_Switch = new Image(this.assets.getTexture('switch_open'));
				}
			}else{
				pageOne_Switch = new Image(this.assets.getTexture('switch_open'));
			}

			pageOne_Switch.touchable = false;				
			pageOne_Switch.x = 330;
			pageOne_Switch.y = 79;
			pageOne_Switch.width = pageOne_Switch.width;
			pageOne_Switch.height = pageOne_Switch.height;
			pageOne_Switch.alpha = 0.8;
		
			
			pageOne_detail_01 = new Image(this.assets.getTexture('yellow_Mark'));
			pageOne_detail_01.touchable = false;				
			pageOne_detail_01.pivotX = 48.5;
			pageOne_detail_01.pivotY = 48.5;
			pageOne_detail_01.x = 306;
			pageOne_detail_01.y = 315;
			pageOne_detail_01.alpha = 0.7;
			
			pageOne_detail_02 = new Image(this.assets.getTexture('white_highlight'));
			pageOne_detail_02.touchable = false;				
			pageOne_detail_02.height = -(pageOne_detail_02.height);
			pageOne_detail_02.x = 135;
			pageOne_detail_02.y = 450;
			pageOne_detail_02.alpha = 0.7;
			
			pageOne_detail_03 = new Image(this.assets.getTexture('white_highlight'));
			pageOne_detail_03.touchable = false;				
			
			pageOne_detail_03.x = 385;
			pageOne_detail_03.y = 33;
			pageOne_detail_03.alpha = 0.7;

			
		
			
			pageOneSprite.addChildAt(pageOne_Corner,0)
			pageOneSprite.addChildAt(pageOne_Main,1)
			pageOneSprite.addChildAt(pageOne_Switch,2)
			pageOneSprite.addChildAt(pageOne_detail_02,3)
			pageOneSprite.addChildAt(pageOne_detail_01,4)
			pageOneSprite.addChildAt(pageOne_detail_03,5)
				
			CreateChangePageHit();
	
		}
		
		private function MakePageTwo():void{
			
			
			
			pageTwoSprite = new Sprite();
			pageTwoSprite.touchable = false;
			pageTwoSprite.x = 0;
			pageTwoSprite.y = 0;
			pageTwoSprite.alpha = 1;
			
			pageTwo_Corner = new Image(this.assets.getTexture('info_02'));
			pageTwo_Corner.touchable = false;				
			pageTwo_Corner.x = 50;
			pageTwo_Corner.y = 50;
			pageTwo_Corner.alpha = 1;
			
			pageTwo_Main = new Image(this.assets.getTexture('ship'));
			pageTwo_Main.touchable = false;				
			
			pageTwo_Main.x = 160;
			pageTwo_Main.y = 75;
			pageTwo_Main.alpha = 0.7;

			pageTwo_detail_01 = new Image(this.assets.getTexture('red_Mark'));
			pageTwo_detail_01.touchable = false;				
			pageTwo_detail_01.pivotX = 48.5;
			pageTwo_detail_01.pivotY = 48.5;
			pageTwo_detail_01.x = 220;
			pageTwo_detail_01.y = 353;
			pageTwo_detail_01.alpha = 0.7;
			
			pageTwo_detail_02 = new Image(this.assets.getTexture('red_Mark'));
			pageTwo_detail_02.touchable = false;				
			pageTwo_detail_02.pivotX = 48.5;
			pageTwo_detail_02.pivotY = 48.5;
			pageTwo_detail_02.x = 380;
			pageTwo_detail_02.y = 226;
			pageTwo_detail_02.alpha = 0.7;
			
			pageTwo_detail_03 = new Image(this.assets.getTexture('red_Mark'));
			pageTwo_detail_03.touchable = false;				
			pageTwo_detail_03.pivotX = 48.5;
			pageTwo_detail_03.pivotY = 48.5;
			pageTwo_detail_03.x = 565;
			pageTwo_detail_03.y = 179;
			pageTwo_detail_03.alpha = 0.7;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['pageTwoA'] == 'yes'){
					pageTwoAClick = true;
					pageTwo_detail_01.texture = this.assets.getTexture('yellow_Mark');
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['pageTwoB'] == 'yes'){
					pageTwoBClick = true;
					pageTwo_detail_02.texture = this.assets.getTexture('yellow_Mark');
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['pageTwoC'] == 'yes'){
					pageTwoCClick = true;
					pageTwo_detail_03.texture = this.assets.getTexture('yellow_Mark');
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					Unlocked = true;
					
				}
			}else{
				
			}

			pageTwoSprite.addChildAt(pageTwo_Corner,0)
			pageTwoSprite.addChildAt(pageTwo_Main,1)
			pageTwoSprite.addChildAt(pageTwo_detail_03,2)
			pageTwoSprite.addChildAt(pageTwo_detail_02,2)
			pageTwoSprite.addChildAt(pageTwo_detail_01,3)

			

		}

		private function CreateChangePageHit():void{
			hit_ChangePage = new Shape();
			hit_ChangePage.touchable = false;
			hit_ChangePage.graphics.beginFill(0xff0000);
			
			hit_ChangePage.graphics.lineTo(58,62);	
			hit_ChangePage.graphics.lineTo(244,60);	
			hit_ChangePage.graphics.lineTo(241,262);	
			hit_ChangePage.graphics.lineTo(57,261);	
			
			hit_ChangePage.graphics.endFill(false);
			hit_ChangePage.alpha = 0.0;
			
			hit_ChangePage.graphics.precisionHitTest = true;	
			this.addChild(hit_ChangePage);
		}
		
		private function CreatePageTwoHits():void{
			//hit_pageTwo_one
			hit_pageTwo_one = new Shape();
			hit_pageTwo_one.touchable = false;
			hit_pageTwo_one.graphics.beginFill(0xff0000);
			
			hit_pageTwo_one.graphics.lineTo(158,293);	
			hit_pageTwo_one.graphics.lineTo(288,293);	
			hit_pageTwo_one.graphics.lineTo(288,414);	
			hit_pageTwo_one.graphics.lineTo(158,414);	
			
			hit_pageTwo_one.graphics.endFill(false);
			hit_pageTwo_one.alpha = 0.0;
			
			hit_pageTwo_one.graphics.precisionHitTest = true;	
			pageTwoSprite.addChild(hit_pageTwo_one);
			
			hit_pageTwo_two = new Shape();
			hit_pageTwo_two.touchable = false;
			hit_pageTwo_two.graphics.beginFill(0xff0000);
			
			hit_pageTwo_two.graphics.lineTo(323,168);	
			hit_pageTwo_two.graphics.lineTo(433,170);	
			hit_pageTwo_two.graphics.lineTo(431,283);	
			hit_pageTwo_two.graphics.lineTo(320,280);	
		
			hit_pageTwo_two.graphics.endFill(false);
			hit_pageTwo_two.alpha = 0.0;
			
			hit_pageTwo_two.graphics.precisionHitTest = true;	
			pageTwoSprite.addChild(hit_pageTwo_two);
			
			hit_pageTwo_three = new Shape();
			hit_pageTwo_three.touchable = false;
			hit_pageTwo_three.graphics.beginFill(0xff0000);
			
			hit_pageTwo_three.graphics.lineTo(502,114);	
			hit_pageTwo_three.graphics.lineTo(626,119);	
			hit_pageTwo_three.graphics.lineTo(620,238);	
			hit_pageTwo_three.graphics.lineTo(501,234);	
		
			hit_pageTwo_three.graphics.endFill(false);
			hit_pageTwo_three.alpha = 0.0;
			
			hit_pageTwo_three.graphics.precisionHitTest = true;	
			pageTwoSprite.addChild(hit_pageTwo_three);
			
			
			hit_ship = new Shape();
			hit_ship.touchable = false;
			hit_ship.graphics.beginFill(0xff0000);
			
			hit_ship.graphics.lineTo(192,275);	
			hit_ship.graphics.lineTo(529,92);	
			hit_ship.graphics.lineTo(624,397);	
			hit_ship.graphics.lineTo(253,435);	
			
			
			hit_ship.graphics.endFill(false);
			hit_ship.alpha = 0.0;
			
			hit_ship.graphics.precisionHitTest = true;	
			pageTwoSprite.addChild(hit_ship);
			
			
		}
		
		
		private function CreatePageOneHits():void{
			hit_pageOne_switch  = new Shape();
			hit_pageOne_switch.touchable = false;
			hit_pageOne_switch.graphics.beginFill(0xff0000);
			
			hit_pageOne_switch.graphics.lineTo(306,74);	
			hit_pageOne_switch.graphics.lineTo(435,82);	
			hit_pageOne_switch.graphics.lineTo(433,447);	
			hit_pageOne_switch.graphics.lineTo(302,441);	

			hit_pageOne_switch.graphics.endFill(false);
			hit_pageOne_switch.alpha = 0.0;
			
			hit_pageOne_switch.graphics.precisionHitTest = true;	
			pageOneSprite.addChild(hit_pageOne_switch);
			
			hit_oven  = new Shape();
			hit_oven.touchable = false;
			hit_oven.graphics.beginFill(0xff0000);
			
			hit_oven.graphics.lineTo(465,105);	
			hit_oven.graphics.lineTo(506,68);	
			hit_oven.graphics.lineTo(656,71);	
			hit_oven.graphics.lineTo(707,126);	
			hit_oven.graphics.lineTo(698,403);	
			hit_oven.graphics.lineTo(606,437);	
			hit_oven.graphics.lineTo(460,428);	
			
			hit_oven.graphics.endFill(false);
			hit_oven.alpha = 0.0;
			
			hit_oven.graphics.precisionHitTest = true;	
			pageOneSprite.addChild(hit_oven);
			
		
		}
		
		private function RotatePageOneImages(e:Event):void{
			deepdisc_00.rotation = deepdisc_00.rotation-deg2rad(0.5);
			deepdisc_01.rotation = deepdisc_01.rotation-deg2rad(0.5);
			deepdisc_02.rotation = deepdisc_02.rotation+deg2rad(0.5);
			pageOne_detail_01.rotation = pageOne_detail_01.rotation-deg2rad(3);
		}
		
		private function RotatePageTwoImages(e:Event):void{
			deepdisc_00.rotation = deepdisc_00.rotation-deg2rad(0.5);
			deepdisc_01.rotation = deepdisc_01.rotation-deg2rad(0.5);
			deepdisc_02.rotation = deepdisc_02.rotation+deg2rad(0.5);
			pageTwo_detail_01.rotation = pageTwo_detail_01.rotation-deg2rad(3);
			pageTwo_detail_02.rotation = pageTwo_detail_03.rotation-deg2rad(3);
			pageTwo_detail_03.rotation = pageTwo_detail_03.rotation-deg2rad(3);
		}
		
		
		private function RotateTexImages(e:Event):void{
			textdisc_00.rotation = textdisc_00.rotation+deg2rad(1.5);
			textdisc_01.rotation = textdisc_00.rotation-deg2rad(1.5);
			textdisc_02.rotation = textdisc_00.rotation+deg2rad(1.5);
			textdisc_03.rotation = textdisc_00.rotation-deg2rad(1.5);
			textdisc_04.rotation = textdisc_00.rotation-deg2rad(1.5);
			textdisc_05.rotation = textdisc_00.rotation+deg2rad(1.5);
			
			deepdisc_00.rotation = deepdisc_00.rotation-deg2rad(0.5);
			deepdisc_01.rotation = deepdisc_01.rotation-deg2rad(0.5);
			deepdisc_02.rotation = deepdisc_02.rotation+deg2rad(0.5);
		}
		
		private function CreateDiscHit():void{
			hit_00 = new Shape();
			hit_00.touchable = false;
			hit_00.graphics.beginFill(0xff0000);
			
			hit_00.graphics.lineTo(60,111);	
			hit_00.graphics.lineTo(91,44);	
			hit_00.graphics.lineTo(165,19);	
			hit_00.graphics.lineTo(232,53);	
			hit_00.graphics.lineTo(256,106);	
			hit_00.graphics.lineTo(222,190);	
			hit_00.graphics.lineTo(140,215);	
			hit_00.graphics.lineTo(72,165);	
			
			hit_00.graphics.endFill(false);
			hit_00.alpha = 0.0;
			
			hit_00.graphics.precisionHitTest = true;	
			this.addChild(hit_00);
			
			hit_01 = new Shape();
			hit_01.touchable = false;
			hit_01.graphics.beginFill(0xff0000);
			
			hit_01.graphics.lineTo(263,162);	
			hit_01.graphics.lineTo(301,70);	
			hit_01.graphics.lineTo(386,33);	
			hit_01.graphics.lineTo(476,75);	
			hit_01.graphics.lineTo(507,152);	
			hit_01.graphics.lineTo(481,233);	
			hit_01.graphics.lineTo(404,174);	
			hit_01.graphics.lineTo(355,172);	
			hit_01.graphics.lineTo(278,218);	
			
			hit_01.graphics.endFill(false);
			hit_01.alpha = 0.0;
			
			hit_01.graphics.precisionHitTest = true;	
			this.addChild(hit_01);
			
			hit_02 = new Shape();
			hit_02.touchable = false;
			hit_02.graphics.beginFill(0xff0000);
			
			hit_02.graphics.lineTo(508,151);	
			hit_02.graphics.lineTo(536,61);	
			hit_02.graphics.lineTo(598,39);	
			hit_02.graphics.lineTo(668,71);	
			hit_02.graphics.lineTo(692,203);	
			hit_02.graphics.lineTo(661,131);	
			hit_02.graphics.lineTo(593,222);	
			hit_02.graphics.lineTo(521,190);	
			
			hit_02.graphics.endFill(false);
			hit_02.alpha = 0.0;
			
			hit_02.graphics.precisionHitTest = true;	
			this.addChild(hit_02);
			
			hit_03 = new Shape();
			hit_03.touchable = false;
			hit_03.graphics.beginFill(0xff0000);
			
			hit_03.graphics.lineTo(31,342);	
			hit_03.graphics.lineTo(71,256);	
			hit_03.graphics.lineTo(157,220);	
			hit_03.graphics.lineTo(236,247);	
			hit_03.graphics.lineTo(278,352);	
			hit_03.graphics.lineTo(234,442);	
			hit_03.graphics.lineTo(234,442);	
			hit_03.graphics.lineTo(150,467);	
			hit_03.graphics.lineTo(70,399);	
			hit_03.graphics.lineTo(40,327);	
			
			
			hit_03.graphics.endFill(false);
			hit_03.alpha = 0.0;
			
			hit_03.graphics.precisionHitTest = true;	
			this.addChild(hit_03);
			
			hit_04 = new Shape();
			hit_04.touchable = false;
			hit_04.graphics.beginFill(0xff0000);
			
			hit_04.graphics.lineTo(278,296);	
			hit_04.graphics.lineTo(301,223);	
			hit_04.graphics.lineTo(384,190);	
			hit_04.graphics.lineTo(458,232);	
			hit_04.graphics.lineTo(475,300);	
			hit_04.graphics.lineTo(440,366);	
			hit_04.graphics.lineTo(380,388);	
			hit_04.graphics.lineTo(312,365);	
		
			hit_04.graphics.endFill(false);
			hit_04.alpha = 0.0;
			
			hit_04.graphics.precisionHitTest = true;	
			this.addChild(hit_04);
			
			
			hit_05 = new Shape();
			hit_05.touchable = false;
			hit_05.graphics.beginFill(0xff0000);
			
			hit_05.graphics.lineTo(475,369);	
			hit_05.graphics.lineTo(508,283);	
			hit_05.graphics.lineTo(596,245);	
			hit_05.graphics.lineTo(688,295);	
			hit_05.graphics.lineTo(712,368);	
			hit_05.graphics.lineTo(665,458);	
			hit_05.graphics.lineTo(592,485);	
			hit_05.graphics.lineTo(503,440);	

			
			hit_05.graphics.endFill(false);
			hit_05.alpha = 0.0;
			
			hit_05.graphics.precisionHitTest = true;	
			this.addChild(hit_05);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if(Solved === false){
						if (touches[0].phase == TouchPhase.BEGAN) {
							trace(touches[0].globalX+" ,"+touches[0].globalY);
						
							
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((SpaceShipConsole as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipConsoleObj,true
								);
							}else if(hit_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-121, touches[0].globalX-160))
										*180
									)/ Math.PI
								)+180;
								trace("00 READY");
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '00';
							}else if(hit_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-160, touches[0].globalX-384))
										*180
									)/ Math.PI
								)-180;
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '01';
							}
							else if(hit_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-136, touches[0].globalX-597))
										*180
									)/ Math.PI
								)-180;
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '02';
							}
							else if(hit_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-346, touches[0].globalX-158))
										*180
									)/ Math.PI
								)-180;
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '03';
							}
							else if(hit_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-285, touches[0].globalX-378))
										*180
									)/ Math.PI
								)-180;
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '04';
							}
							else if(hit_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-364, touches[0].globalX-598))
										*180
									)/ Math.PI
								)-180;
								trace("MousePrevAngle: "+MousePrevAngle);
								HandFlag = '05';
							}
	
						}else if (touches[0].phase == TouchPhase.MOVED) {
							if(HandFlag != null){
								DiscHandler();
							}
						}else if (touches[0].phase == TouchPhase.ENDED) {
							(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("CosmicWindUp");
							//WindUpPlaying = false;
							//DialActive = false;
							MousePrevAngle = 0;
							MouseCurrentAngle = 0;
						//	(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("WindUp");
							
							//if(Solved === false){
								HandFlag = null;
								
								Solve();
						//	}
							
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
							}
							SaveArray['00'] = disc_00.rotation;
							SaveArray['01'] = disc_01.rotation;
							SaveArray['02'] = disc_02.rotation;
							SaveArray['03'] = disc_03.rotation;
							SaveArray['04'] = disc_04.rotation;
							SaveArray['05'] = disc_05.rotation;
							
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
							
							trace(rad2deg(disc_00.rotation));
							trace(rad2deg(disc_01.rotation));
							trace(rad2deg(disc_02.rotation));
							trace(rad2deg(disc_03.rotation));
							trace(rad2deg(disc_04.rotation));
							trace(rad2deg(disc_05.rotation));
							
						}	
					}else if(Solved === true){
						if (touches[0].phase == TouchPhase.ENDED) {
							trace(touches[0].globalX+" ,"+touches[0].globalY);
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((SpaceShipConsole as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipConsoleObj,true
								);
							}else if(hit_ChangePage.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiTwo();
								if(CurrentPage == 'One'){
									CurrentPage = 'Two';
									
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
									}
									SaveArray['CurrentPage'] = 'Two';
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
									
									FadeOutPageOne();
								}else {
									CurrentPage = 'One';
									
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
									}
									SaveArray['CurrentPage'] = 'One';
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
									
									FadeOutPageTwo();
								}
							}else if(CurrentPage == 'Two'){
								if(hit_pageTwo_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									PageTwoClickHandler('A');
								}else if(hit_pageTwo_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									PageTwoClickHandler('B');
								}else if(hit_pageTwo_three.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									PageTwoClickHandler('C');
								}else if(hit_ship.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									if(Unlocked === false){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's an image of the spacecraft on the viewer.");				

									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This must be a diagnostic and maintenance screen.");
									}
								}

								
								/*
								private var hit_oven:Shape;
								private var hit_ship:Shape;
								*/
							}else if(CurrentPage == 'One'){
								if(hit_pageOne_switch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									if(Unlocked === false){
										PageOneClickHandler();
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Better to leave this switch alone now.");				
										
									}
								}else if(hit_oven.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									if(Unlocked === false){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That looks like the machine in the corner of the room.");				
										
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The screen must control the power flow to the other machine.");
									}
								}
							}
						
						}
					}
				}
			}
		}
		
		private function PageOneClickHandler():void{
			if(pageTwoAClick === true){
				if(pageTwoBClick === true){
					if(pageTwoCClick === true){
						Animating = true;
						Unlocked = true;
						pageOne_Switch.texture = this.assets.getTexture('switch_closed');
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
						}
						SaveArray['Unlocked'] = 'Yes';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicProcess();
						
						
						
						delayedCall = new DelayedCall(function():void{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
							FadeOut((SpaceShipInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipInteriorObj,true
							);
						}, 2);
						Starling.juggler.add(delayedCall);
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Seems that symbol throws an error when pressed.");

					}
				}else{
				//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Seems that symbol throws an error when pressed.");

				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Seems that symbol throws an error when pressed.");


			}

		}
		
		
		private function PageTwoClickHandler(ABC:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
			}
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
			if(ABC == 'A'){
				trace("BARK_01");
				if(pageTwoAClick === false){
					pageTwoAClick = true;
					pageTwo_detail_01.texture = this.assets.getTexture('yellow_Mark');
					SaveArray['pageTwoA'] = 'yes';
				}else{
					pageTwoAClick = false;
					pageTwo_detail_01.texture = this.assets.getTexture('red_Mark');
					SaveArray['pageTwoA'] = 'no';
				}
			}else if(ABC == 'B'){
				trace("BARK_02");
				if(pageTwoBClick === false){
					pageTwoBClick = true;
					pageTwo_detail_02.texture = this.assets.getTexture('yellow_Mark');
					SaveArray['pageTwoB'] = 'yes';
				}else{
					
					pageTwoBClick = false;
					pageTwo_detail_02.texture = this.assets.getTexture('red_Mark');
					SaveArray['pageTwoB'] = 'no';

				}
			}
			else if(ABC == 'C'){
				trace("BARK_03");
				if(pageTwoCClick === false){
					pageTwoCClick = true;
					pageTwo_detail_03.texture = this.assets.getTexture('yellow_Mark');
					SaveArray['pageTwoC'] = 'yes';
				}else{
					pageTwoCClick = false;
					pageTwo_detail_03.texture = this.assets.getTexture('red_Mark');
					SaveArray['pageTwoC'] = 'no';

				}
			}

			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
		}
		
		private function DiscHandler():void{
			//	if(WindUpPlaying === false){
			//		WindUpPlaying = true;
			//		(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
			//	}
			
			if(HandFlag == '00'){
			
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-121, touches[0].globalX-160))
						*180
					)/ Math.PI
				)+180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation-(deg2rad(1));	

					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation+(deg2rad(1));		
					
					
				}
			}
			
			if(HandFlag == '01'){
				
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-160, touches[0].globalX-384))
						*180
					)/ Math.PI
				)-180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation-(deg2rad(1));	
					disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation+(deg2rad(1));	
					disc_03.rotation = disc_03.rotation+(deg2rad(1));	
					disc_04.rotation = disc_04.rotation-(deg2rad(1));	
					disc_05.rotation = disc_05.rotation-(deg2rad(1));	
					
					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation+(deg2rad(1));	
					disc_01.rotation = disc_01.rotation+(deg2rad(1));	
					disc_02.rotation = disc_02.rotation-(deg2rad(1));	
					disc_03.rotation = disc_03.rotation-(deg2rad(1));	
					disc_04.rotation = disc_04.rotation+(deg2rad(1));	
					disc_05.rotation = disc_05.rotation+(deg2rad(1));			
					
					
				}
			}
			
			if(HandFlag == '02'){
				
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-136, touches[0].globalX-597))
						*180
					)/ Math.PI
				)-180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					disc_02.rotation = disc_02.rotation-(deg2rad(1));	
					
					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					disc_02.rotation = disc_02.rotation+(deg2rad(1));		
					
					
				}
			}
			
			if(HandFlag == '03'){
				
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-346, touches[0].globalX-158))
						*180
					)/ Math.PI
				)-180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation-(deg2rad(1));	
				//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation+(deg2rad(1));	
					disc_03.rotation = disc_03.rotation-(deg2rad(1));	
				//	disc_04.rotation = disc_04.rotation-(deg2rad(1));	
				//	disc_05.rotation = disc_05.rotation-(deg2rad(1));	
					
					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation+(deg2rad(1));	
					//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation-(deg2rad(1));	
					disc_03.rotation = disc_03.rotation+(deg2rad(1));	
					//	disc_04.rotation = disc_04.rotation-(deg2rad(1));	
					//	disc_05.rotation = disc_05.rotation-(deg2rad(1));	
					
					
					
				}
			}
			if(HandFlag == '04'){
				
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-285, touches[0].globalX-378))
						*180
					)/ Math.PI
				)-180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation+(deg2rad(1));	
				//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation+(deg2rad(1));	
					disc_03.rotation = disc_03.rotation+(deg2rad(1));	
					disc_04.rotation = disc_04.rotation-(deg2rad(1));	
					disc_05.rotation = disc_05.rotation+(deg2rad(1));	
					
					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					disc_00.rotation = disc_00.rotation-(deg2rad(1));	
					//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation-(deg2rad(1));	
					disc_03.rotation = disc_03.rotation-(deg2rad(1));	
					disc_04.rotation = disc_04.rotation+(deg2rad(1));	
					disc_05.rotation = disc_05.rotation-(deg2rad(1));		
					
					
				}
			}
			if(HandFlag == '05'){
				
				MouseCurrentAngle = (
					((Math.atan2(touches[0].globalY-364, touches[0].globalX-598))
						*180
					)/ Math.PI
				)-180;
				if(MousePrevAngle > MouseCurrentAngle){
					
					//disc_00.rotation = disc_00.rotation-(deg2rad(1));	
					//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation+(deg2rad(1));	
					//disc_03.rotation = disc_03.rotation+(deg2rad(1));	
					//	disc_04.rotation = disc_04.rotation-(deg2rad(1));	
					disc_05.rotation = disc_05.rotation-(deg2rad(1));	
					
					
					
				}else if(MousePrevAngle < MouseCurrentAngle){
					
					//disc_00.rotation = disc_00.rotation-(deg2rad(1));	
					//	disc_01.rotation = disc_01.rotation-(deg2rad(1));	
					disc_02.rotation = disc_02.rotation-(deg2rad(1));	
					//disc_03.rotation = disc_03.rotation+(deg2rad(1));	
					//	disc_04.rotation = disc_04.rotation-(deg2rad(1));	
						disc_05.rotation = disc_05.rotation+(deg2rad(1));	
						
					
					
				}
			}
			MousePrevAngle = MouseCurrentAngle;
			return;
			
			
		}
		//FIX THIS missing rad2deg
		private function Solve():void{
			if(rad2deg(disc_00.rotation) <= 8&& disc_00.rotation >= -6){
				if(rad2deg(disc_01.rotation) >= -1 && rad2deg(disc_01.rotation) <= 15){
					if(rad2deg(disc_02.rotation) >= -10 && rad2deg(disc_02.rotation) <= -2){
						if(rad2deg(disc_03.rotation) >= -5 && rad2deg(disc_03.rotation) <= 5){
							if(rad2deg(disc_04.rotation) <= 5 && rad2deg(disc_04.rotation) >= -10){
								if(rad2deg(disc_05.rotation) >= 2 && rad2deg(disc_05.rotation) <= 10){
									trace("Solved");
									
									trace("solved");
									Solved = true;
									Animating = true;
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicProcess();
																		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle;
									}
									SaveArray['Solved'] = 'Yes';
									SaveArray['CurrentPage'] = 'One';
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
									
									if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
										Starling.juggler.delayCall(function():void{
											(stage.getChildAt(0) as Object).MusicObj.LoadXFiles(true,1);
										},0.5);
									}
									
									delayedCall = new DelayedCall(function():void{
										RunSolve();
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicProcess();
										
									}, 1);
									Starling.juggler.add(delayedCall);
								}else{
									trace("FAILED ON 5");
								}
							}else{
								trace("FAILED ON 4");
							}
							
						}else{
							trace("FAILED ON 3");
						}
					}else{
						trace("FAILED ON 2");
					}
					
				}else{	
					trace("FAILED ON 1");
				}
			}else{
				trace("FAILED ON 0");
			}
		}
		
		private function RunSolve():void{
			this.removeEventListener(EnterFrameEvent.ENTER_FRAME, RotateTexImages);
			
			PuzzleSpriteTween = new Tween(puzzleSprite, 2, Transitions.LINEAR);
			PuzzleSpriteTween.fadeTo(0);
			PuzzleSpriteTween.onComplete = function():void{
				MakePageOne();
				MakePageTwo();
				
				pageOneSprite.alpha = 0;
				pageTwoSprite.alpha = 0;
				RemovePuzzle();
				
				FadeInPageOne();
				PuzzleSpriteTween = null;
			}
			Starling.juggler.add(PuzzleSpriteTween);
			
		}
		private function RemovePuzzle():void{
			this.removeChild(puzzleSprite);
			this.removeChild(hit_00);
			this.removeChild(hit_01);
			this.removeChild(hit_02);
			this.removeChild(hit_03);
			this.removeChild(hit_04);
			this.removeChild(hit_05);
			this.addChildAt(pageOneSprite,1);
			this.addChildAt(pageTwoSprite,2);
			CreatePageOneHits();
			CreateChangePageHit();
			CreatePageTwoHits();
			
		}
		private function FadeInPageOne():void{
			deepdisc_00.x = 586;
			deepdisc_00.y = 254;
			
			deepdisc_01.x = 369;
			deepdisc_01.y = 244;
			
			deepdisc_02.x = 202;
			deepdisc_02.y = 192;
	
			pageOneSprite.addChildAt(deepdisc_00,0)
			pageOneSprite.addChildAt(deepdisc_01,1)
			pageOneSprite.addChildAt(deepdisc_02,2)
			
			
			PageOneTween  = new Tween(pageOneSprite, 1, Transitions.LINEAR);
			PageOneTween.fadeTo(1);
			PageOneTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
				Animating = false;
				AddPageOneListener();
				PageOneTween = null;
				PageTwoTween = null;
			}
			Starling.juggler.add(PageOneTween);
		}
		
		private function FadeOutPageOne():void{
			Animating = true;
			this.removeEventListener(EnterFrameEvent.ENTER_FRAME, RotatePageOneImages);
			PageOneTween  = new Tween(pageOneSprite, 1, Transitions.LINEAR);
			PageOneTween.fadeTo(0);
			PageOneTween.onComplete = function():void{
				FadeInPageTwo();
				
				
			}
			Starling.juggler.add(PageOneTween);
		}
		private function AddPageOneListener():void{
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, RotatePageOneImages);
		}
		
		private function FadeInPageTwo():void{
			deepdisc_01.x = 586;
			deepdisc_01.y = 254;
			
			deepdisc_02.x = 369;
			deepdisc_02.y = 244;
			
			deepdisc_01.x = 202;
			deepdisc_01.y = 192;
			
			pageTwoSprite.addChildAt(deepdisc_00,0)
			pageTwoSprite.addChildAt(deepdisc_01,1)
			pageTwoSprite.addChildAt(deepdisc_02,2)
			
			trace("PAGE TWO FADE IN");
			PageTwoTween  = new Tween(pageTwoSprite, 1, Transitions.LINEAR);
			PageTwoTween.fadeTo(1);
			PageTwoTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
				trace("PAGE TWO FADE DONE");
				Animating = false;
				AddPageTwoListener();
				PageTwoTween = null;
				PageOneTween = null;
			}
			Starling.juggler.add(PageTwoTween);
		}
		
		private function AddPageTwoListener():void{
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, RotatePageTwoImages);
		}
		
		private function FadeOutPageTwo():void{
			Animating = true;
			this.removeEventListener(EnterFrameEvent.ENTER_FRAME, RotatePageTwoImages);
			PageTwoTween  = new Tween(pageTwoSprite, 1, Transitions.LINEAR);
			PageTwoTween.fadeTo(0);
			PageTwoTween.onComplete = function():void{
				FadeInPageOne();
				
			//	PageTwoTween = null;
			}
			Starling.juggler.add(PageTwoTween);
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
			
			
			this.assets.removeTexture("spaceShipPuzzle_bg",true);
			this.assets.removeTexture("SpaceShipPuzzle_Sprite",true);
			this.assets.removeTexture("SpaceShipPuzzle_Sprite_02",true);
			this.assets.removeTextureAtlas("SpaceShipPuzzle_Sprite",true);
			this.assets.removeTextureAtlas("SpaceShipPuzzle_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("spaceShipPuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipPuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipPuzzle_03");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipPuzzle_04");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipPuzzle_05");
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