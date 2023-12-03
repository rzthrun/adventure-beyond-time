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
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	public class JunkPuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var dial:Image;
		private var dial_Tween:Tween;
		
		private var pos_00_color:Image;
		private var pos_01_color:Image;
		private var pos_02_color:Image;
		private var pos_03_color:Image;
		
		
		private var roater_sprite:Sprite;
		private var roater:Image;
		private var roater_right:Image;
		private var roater_top:Image;
		private var roater_left:Image;
		private var roater_bottom:Image;
		private var roater_center:Image;
		
		private var hit_roater:Shape;
		private var RoaterPos:String = '00';
		
		private var centerDisc:Image;
		
		private var coin_sprite:Sprite;
		private var coin_00:Image;
		private var coin_01:Image;
		private var coin_02:Image;
		private var coin_03:Image;
		private var Coin_Pos_00:String = 'empty';		
		private var Coin_Pos_01:String = 'empty';		
		private var Coin_Pos_02:String = 'empty';		
		private var Coin_Pos_03:String = 'empty';	
		private var Coin_Pos_Temp:String = 'empty';
		private var coin_00_tween:Tween;
		private var coin_01_tween:Tween;
		private var coin_02_tween:Tween;
		private var coin_03_tween:Tween;
		private var coin_Tween:Tween;
		private var CoinTracker:int = 0;
		
		
		private var hit_section_00:Shape;
		private var hit_section_01:Shape;
		private var hit_section_02:Shape;
		private var hit_section_03:Shape;
		
		private var hit_center:Shape;
		
		private var Animating:Boolean = false;
		private var Solved:Boolean = false;
		public var delayedcall:DelayedCall;
		
		private var MouseDownFlag:String = null;
		private var MouseUpFlag:String = null;
		private var ActiveColor:String = 'clear';
		
		private var Pos_00:String = 'clear';
		private var Pos_01:String = 'clear';
		private var Pos_02:String = 'clear';
		private var Pos_03:String = 'clear';
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		
		
		private var goback:GoBackButton;		
		
		public function JunkPuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('junkPuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkPuzzle/junkPuzzle_bg.jpg'));
				game.TrackAssets('junkPuzzle_01');
			}
			//JunkPuzzle_Sprite
			if(game.CheckAsset('junkPuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkPuzzle/JunkPuzzle_Sprite.atf'));
				game.TrackAssets('junkPuzzle_02');
			}
			if(game.CheckAsset('junkPuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkPuzzle/JunkPuzzle_Sprite.xml'));
				game.TrackAssets('junkPuzzle_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JunkPuzzle","JunkPuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
			}
			SaveArray['Coin_Pos_00'] = 'dragon';
			SaveArray['Coin_Pos_01'] = 'empty';
			SaveArray['Coin_Pos_02'] = 'tiger';
			SaveArray['Coin_Pos_03'] = 'phoenix';
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
			*/
			bg = new Image(this.assets.getTexture('junkPuzzle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			dial = new Image(this.assets.getTexture('dial'));
			dial.touchable = false;
			dial.pivotX = 255;
			dial.pivotY = 255;
			dial.x = 380;
			dial.y = 255;
			
			//FadeOutOcean(1);
			
			roater = new Image(this.assets.getTexture('roater'));
			roater.touchable = false;
			roater.x = 0;
			roater.y = 0;
			
			
			roater_center = new Image(this.assets.getTexture('roater_center_red'));
			roater_center.touchable = false;
			roater_center.x = 47;
			roater_center.y = 35;
			
			
			roater_right = new Image(this.assets.getTexture('roater_right_red'));
			roater_right.touchable = false;
			roater_right.x = 43;
			roater_right.y = 59;
			
			
			roater_top = new Image(this.assets.getTexture('roater_top_red'));
			roater_top.touchable = false;
			roater_top.x = 69;
			roater_top.y = 31;
			
			
			roater_left = new Image(this.assets.getTexture('roater_left_red'));
			roater_left.touchable = false;
			roater_left.x = 43;
			roater_left.y = 5;
		
			
			roater_bottom = new Image(this.assets.getTexture('roater_bottom_red'));
			roater_bottom.touchable = false;
			roater_bottom.x = 5;
			roater_bottom.y = 31;
			
			
			roater_sprite = new Sprite();
			roater_sprite.touchable = false;
			roater_sprite.pivotX = 59;
			roater_sprite.pivotY = 48;
			roater_sprite.x = 139;
			roater_sprite.y = 62;
			roater_sprite.rotation = deg2rad(180);
			
	
			
			pos_00_color = new Image(this.assets.getTexture('pos_00_red'));
			pos_00_color.touchable = false;
			pos_00_color.x = 437;
			pos_00_color.y = 173;
			
			
			pos_01_color = new Image(this.assets.getTexture('pos_01_red'));
			pos_01_color.touchable = false;
			pos_01_color.x = 298;
			pos_01_color.y = 311;
			
			
			pos_02_color = new Image(this.assets.getTexture('pos_02_red'));
			pos_02_color.touchable = false;
			pos_02_color.x = 159;
			pos_02_color.y = 172;
		
			
			pos_03_color = new Image(this.assets.getTexture('pos_03_red'));
			pos_03_color.touchable = false;
			pos_03_color.x = 299;
			pos_03_color.y = 34;
			
			
			
			centerDisc = new Image(this.assets.getTexture('center_clear'));
			centerDisc.touchable = false;
			centerDisc.pivotX = 59;
			centerDisc.pivotY = 59;
			centerDisc.x = 380;
			centerDisc.y = 254;
			
			
			coin_sprite = new Sprite();
			coin_sprite.touchable = false;
			coin_sprite.width = 408;
			coin_sprite.height = 408;
		//	coin_sprite.pivotX = 204;
		//	coin_sprite.pivotY = 204;
			coin_sprite.x = 380;
			coin_sprite.y = 255;
			
			
			coin_00  = new Image(this.assets.getTexture('dragon_clear'));
			coin_00.touchable = false;
			coin_00.pivotX = 64;
			coin_00.pivotY = 64;
			coin_00.x = 142;
			coin_00.y = 0;
			
			
			coin_01  = new Image(this.assets.getTexture('dragon_clear'));
			coin_01.touchable = false;
			coin_01.pivotX = 64;
			coin_01.pivotY = 64;
			coin_01.x = 0;
			coin_01.y = 142;
		
			
			coin_02  = new Image(this.assets.getTexture('dragon_clear'));
			coin_02.touchable = false;
			coin_02.pivotX = 64;
			coin_02.pivotY = 64;
			coin_02.x = -142;
			coin_02.y = 0;
			
			
			coin_03  = new Image(this.assets.getTexture('dragon_clear'));
			coin_03.touchable = false;
			coin_03.pivotX = 64;
			coin_03.pivotY = 64;
			coin_03.x = 0;
			coin_03.y = -142;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_00'] == 'clear'){
					pos_00_color.alpha = 0;
			//		roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_00'] == 'red'){
					Pos_00 = 'red';
					pos_00_color.texture = this.assets.getTexture('pos_00_red');
					pos_00_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_00'] == 'green'){
					Pos_00 = 'green';
					pos_00_color.texture = this.assets.getTexture('pos_00_green');
					pos_00_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_00'] == 'purple'){
					Pos_00 = 'purple';
					pos_00_color.texture = this.assets.getTexture('pos_00_purple');
					pos_00_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_00'] == 'white'){
					Pos_00 = 'white';
					pos_00_color.texture = this.assets.getTexture('pos_00_white');
					pos_00_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
				}else{
					pos_00_color.alpha = 0;		
	//				roater_left.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_01'] == 'clear'){
					trace('2');
					pos_01_color.alpha = 0;
		//			roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_01'] == 'red'){
					trace('3');
					Pos_01 = 'red';
					pos_01_color.texture = this.assets.getTexture('pos_01_red');
					pos_01_color.alpha = 1;
	//				roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_01'] == 'green'){
					trace('4');
					Pos_01 = 'green';
					pos_01_color.texture = this.assets.getTexture('pos_01_green');
					pos_01_color.alpha = 1;
//					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_01'] == 'purple'){
					trace('5');
					Pos_01 = 'purple';
					pos_01_color.texture = this.assets.getTexture('pos_01_purple');
					pos_01_color.alpha = 1;
//					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_01'] == 'white'){
					trace('6');
					Pos_01 = 'white';
					pos_01_color.texture = this.assets.getTexture('pos_01_white');
					pos_01_color.alpha = 1;
//					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
				}else{
					trace('1');
					pos_01_color.alpha = 0;		
//					roater_left.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == undefined){
					pos_02_color.alpha = 0;		
//					roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == 'clear'){
					pos_02_color.alpha = 0;
//					roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == 'red'){
					Pos_02 = 'red';
					pos_02_color.texture = this.assets.getTexture('pos_02_red');
					pos_02_color.alpha = 1;
//					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == 'green'){
					Pos_02 = 'green';
					pos_02_color.texture = this.assets.getTexture('pos_02_green');
					pos_02_color.alpha = 1;
	//				roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == 'purple'){
					Pos_02 = 'purple';
					pos_02_color.texture = this.assets.getTexture('pos_02_purple');
					pos_02_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_02'] == 'white'){
					Pos_02 = 'white';
					pos_02_color.texture = this.assets.getTexture('pos_02_white');
					pos_02_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == undefined){
					pos_03_color.alpha = 0;		
		//			roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == 'clear'){
					pos_03_color.alpha = 0;
		//			roater_left.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == 'red'){
					Pos_03 = 'red';
		//			pos_03_color.texture = this.assets.getTexture('pos_03_red');
					pos_03_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == 'green'){
					Pos_03 = 'green';
					pos_03_color.texture = this.assets.getTexture('pos_03_green');
					pos_03_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == 'purple'){
					Pos_03 = 'purple';
					pos_03_color.texture = this.assets.getTexture('pos_03_purple');
					pos_03_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Pos_03'] == 'white'){
					Pos_03 = 'white';
					pos_03_color.texture = this.assets.getTexture('pos_03_white');
					pos_03_color.alpha = 1;
		//			roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == undefined){
					centerDisc.texture = this.assets.getTexture('center_clear');
					roater_center.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == 'clear'){
					centerDisc.texture = this.assets.getTexture('center_clear');
					roater_center.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == 'red'){
					ActiveColor = 'red';
					centerDisc.texture = this.assets.getTexture('center_red');		
					roater_center.alpha = 1;
					roater_center.texture = this.assets.getTexture('roater_center_'+ActiveColor);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == 'green'){
					ActiveColor = 'green';
					centerDisc.texture = this.assets.getTexture('center_green');
					roater_center.alpha = 1;
					roater_center.texture = this.assets.getTexture('roater_center_'+ActiveColor);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == 'purple'){
					ActiveColor = 'purple';
					centerDisc.texture = this.assets.getTexture('center_purple');
					roater_center.alpha = 1;
					roater_center.texture = this.assets.getTexture('roater_center_'+ActiveColor);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['ActiveColor'] == 'white'){
					ActiveColor = 'white';
					centerDisc.texture = this.assets.getTexture('center_white');
					roater_center.alpha = 1;
					roater_center.texture = this.assets.getTexture('roater_center_'+ActiveColor);
				}
				////RoaterPos
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['RoaterPos'] == undefined){
					RoaterPos = '00';
					roater_sprite.rotation = deg2rad(180);
					
					if(Pos_00 == 'clear'){
						roater_bottom.alpha = 0;
					}else{
						roater_bottom.alpha = 1;
						roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_00);
					}
					
					if(Pos_01 == 'clear'){
						roater_left.alpha = 0;
					}else{
						roater_left.alpha = 1;
						roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
					}
					
					if(Pos_02 == 'clear'){
						roater_top.alpha = 0;
					}else{
						roater_top.alpha = 1;
						roater_top.texture = this.assets.getTexture('roater_top_'+Pos_02);
					}
					
					if(Pos_03 == 'clear'){
						roater_right.alpha = 0;
					}else{
						roater_right.alpha = 1;
						roater_right.texture = this.assets.getTexture('roater_right_'+Pos_03);
					}
					
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['RoaterPos'] == '00'){
					RoaterPos = '00';
					roater_sprite.rotation = deg2rad(180);
					
					if(Pos_00 == 'clear'){
						roater_bottom.alpha = 0;
					}else{
						roater_bottom.alpha = 1;
						roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_00);
					}
					
					if(Pos_01 == 'clear'){
						roater_left.alpha = 0;
					}else{
						roater_left.alpha = 1;
						roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
					}
					
					if(Pos_02 == 'clear'){
						roater_top.alpha = 0;
					}else{
						roater_top.alpha = 1;
						roater_top.texture = this.assets.getTexture('roater_top_'+Pos_02);
					}
					
					if(Pos_03 == 'clear'){
						roater_right.alpha = 0;
					}else{
						roater_right.alpha = 1;
						roater_right.texture = this.assets.getTexture('roater_right_'+Pos_03);
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['RoaterPos'] == '01'){
					RoaterPos = '01';
					roater_sprite.rotation = deg2rad(-90);

					if(Pos_00 == 'clear'){
						roater_right.alpha = 0;
					}else{
						roater_right.alpha = 2;
						roater_right.texture = this.assets.getTexture('roater_right_'+Pos_00);
					}
					
					if(Pos_01 == 'clear'){
						roater_bottom.alpha = 0;
					}else{
						roater_bottom.alpha = 1;
						roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_01);
					}
					
					if(Pos_02 == 'clear'){
						roater_left.alpha = 0;
					}else{
						roater_left.alpha = 1;
						roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
					}
					
					if(Pos_03 == 'clear'){
						roater_top.alpha = 0;
					}else{
						roater_top.alpha = 1;
						roater_top.texture = this.assets.getTexture('roater_top_'+Pos_03);
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['RoaterPos'] == '02'){
					RoaterPos = '02';
					roater_sprite.rotation = deg2rad(0);
					
					
					if(Pos_00 == 'clear'){
						roater_top.alpha = 0;
					}else{
						roater_top.alpha = 1;
						roater_top.texture = this.assets.getTexture('roater_top_'+Pos_00);
					}
					
					if(Pos_01 == 'clear'){
						roater_right.alpha = 0;
					}else{
						roater_right.alpha = 1;
						roater_right.texture = this.assets.getTexture('roater_right_'+Pos_01);
					}
					
					if(Pos_02 == 'clear'){
						roater_bottom.alpha = 0;
					}else{
						roater_bottom.alpha = 1;
						roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_02);
					}
		
					if(Pos_03 == 'clear'){
						roater_left.alpha = 0;
					}else{
						roater_left.alpha = 1;
						roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['RoaterPos'] == '03'){
					RoaterPos = '03';
					roater_sprite.rotation = deg2rad(90);

					if(Pos_00 == 'clear'){
						roater_left.alpha = 0;
					}else{
						roater_left.alpha = 1;
						roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
					}
					
					if(Pos_01 == 'clear'){
						roater_top.alpha = 0;
					}else{
						roater_top.alpha = 1;
						roater_top.texture = this.assets.getTexture('roater_top_'+Pos_01);
					}
					
					if(Pos_02 == 'clear'){
						roater_right.alpha = 0;
					}else{
						roater_right.alpha = 1;
						roater_right.texture = this.assets.getTexture('roater_right_'+Pos_02);
					}
					
					if(Pos_03 == 'clear'){
						roater_bottom.alpha = 0;
					}else{
						roater_bottom.alpha = 1;
						roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_03);
					}
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == undefined){
					trace("Coin_Pos_00");
					Coin_Pos_00 = 'empty';
					coin_00.alpha = 0;					
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == 'empty'){
					Coin_Pos_00 = 'empty';
					coin_00.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == 'tiger'){
					Coin_Pos_00 = 'tiger';
					coin_00.texture = this.assets.getTexture('tiger_clear');
					coin_00.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == 'dragon'){
					Coin_Pos_00 = 'dragon';
					coin_00.texture = this.assets.getTexture('dragon_clear');
					coin_00.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == 'phoenix'){
					Coin_Pos_00 = 'phoenix';
					coin_00.texture = this.assets.getTexture('phoenix_clear');
					coin_00.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] == 'turtle'){
					Coin_Pos_00 = 'turtle';
					coin_00.texture = this.assets.getTexture('turtle_clear');
					coin_00.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == undefined){
					Coin_Pos_01 = 'empty';
					coin_01.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == 'empty'){
					Coin_Pos_01 = 'empty';
					coin_01.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == 'tiger'){
					Coin_Pos_01 = 'tiger';
					coin_01.texture = this.assets.getTexture('tiger_clear');
					coin_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == 'dragon'){
					Coin_Pos_01 = 'dragon';
					coin_01.texture = this.assets.getTexture('dragon_clear');
					coin_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == 'phoenix'){
					Coin_Pos_01 = 'phoenix';
					coin_01.texture = this.assets.getTexture('phoenix_clear');
					coin_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] == 'turtle'){
					Coin_Pos_01 = 'turtle';
					coin_01.texture = this.assets.getTexture('turtle_clear');
					coin_01.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == undefined){
					Coin_Pos_02 = 'empty';
					coin_02.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == 'empty'){
					Coin_Pos_02 = 'empty';
					coin_02.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == 'tiger'){
					Coin_Pos_02 = 'tiger';
					coin_02.texture = this.assets.getTexture('tiger_clear');
					coin_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == 'dragon'){
					Coin_Pos_02 = 'dragon';
					coin_02.texture = this.assets.getTexture('dragon_clear');
					coin_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == 'phoenix'){
					Coin_Pos_02 = 'phoenix';
					coin_02.texture = this.assets.getTexture('phoenix_clear');
					coin_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] == 'turtle'){
					Coin_Pos_02 = 'turtle';
					coin_02.texture = this.assets.getTexture('turtle_clear');
					coin_02.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == undefined){
					Coin_Pos_03 = 'empty';
					coin_03.alpha = 0;
					trace("1 Coin_Pos_03 :"+Coin_Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == 'empty'){
					Coin_Pos_03 = 'empty';
					coin_03.alpha = 0;
					trace("2 Coin_Pos_03 :"+Coin_Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == 'tiger'){
					Coin_Pos_03 = 'tiger';
					coin_03.texture = this.assets.getTexture('tiger_clear');
					coin_03.alpha = 1;
					trace("3 Coin_Pos_03 :"+Coin_Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == 'dragon'){
					Coin_Pos_03 = 'dragon';
					coin_03.texture = this.assets.getTexture('dragon_clear');
					coin_03.alpha = 1;
					trace("4 Coin_Pos_03 :"+Coin_Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == 'phoenix'){
					Coin_Pos_03 = 'phoenix';
					coin_03.texture = this.assets.getTexture('phoenix_clear');
					coin_03.alpha = 1;
					trace("5 Coin_Pos_03 :"+Coin_Pos_03);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] == 'turtle'){
					Coin_Pos_03 = 'turtle';
					coin_03.texture = this.assets.getTexture('turtle_clear');
					coin_03.alpha = 1;
					trace("6 Coin_Pos_03 :"+Coin_Pos_03);
				}
				trace("Coin_Pos_00 :"+Coin_Pos_00);
				trace("Coin_Pos_01 :"+Coin_Pos_01);
				trace("Coin_Pos_02 :"+Coin_Pos_02);
				trace("Coin_Pos_03 :"+Coin_Pos_03);
				
				
					
			}else{
				pos_00_color.alpha = 0;
				pos_01_color.alpha = 0;
				pos_02_color.alpha = 0;
				pos_03_color.alpha = 0;
				
				coin_00.alpha = 0;
				coin_01.alpha = 0;
				coin_02.alpha = 0;
				coin_03.alpha = 0;
				
				roater_center.alpha = 0;
				roater_right.alpha = 0;
				roater_top.alpha = 0;
				roater_left.alpha = 0;
				roater_bottom.alpha = 0;	
			}
			
		
		
			
			dial.alpha = 1;
			roater.alpha = 1;
			roater_sprite.alpha = 1;
			
			centerDisc.alpha = 1;
			
			coin_sprite.alpha = 1;
			
			this.addChildAt(dial,1);	
				
				roater_sprite.addChildAt(roater,0);
				roater_sprite.addChildAt(roater_center,1);
				roater_sprite.addChildAt(roater_right,2);
				roater_sprite.addChildAt(roater_top,3);
				roater_sprite.addChildAt(roater_left,4);
				roater_sprite.addChildAt(roater_bottom,5);
				
			this.addChildAt(roater_sprite,2);		
			this.addChildAt(pos_00_color,3);
			this.addChildAt(pos_01_color,4);
			this.addChildAt(pos_02_color,5);
			this.addChildAt(pos_03_color,6);
			this.addChildAt(centerDisc,7);
			
			
				coin_sprite.addChildAt(coin_00,0);
				coin_sprite.addChildAt(coin_01,1);
				coin_sprite.addChildAt(coin_02,2);
				coin_sprite.addChildAt(coin_03,3);
			
			this.addChildAt(coin_sprite,8);
			
			CreateSectionHits();
			CreatRoaterHit();
			CreatCenterHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
		
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("ShipCreaks",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
		}
		
		private function CreatRoaterHit():void{
			hit_roater = new Shape();
			hit_roater.touchable = false;
			hit_roater.graphics.beginFill(0xff0000);
			
			hit_roater.graphics.lineTo(79,3);	
			hit_roater.graphics.lineTo(205,3);	
			hit_roater.graphics.lineTo(205,121);	
			hit_roater.graphics.lineTo(79,121);	

			hit_roater.graphics.endFill(false);
			
			hit_roater.alpha = 0.0;
			
			hit_roater.graphics.precisionHitTest = true;	
			this.addChild(hit_roater);
		}
		
		private function CreatCenterHit():void{
			hit_center = new Shape();
			hit_center.touchable = false;
			hit_center.graphics.beginFill(0xff0000);
			
			hit_center.graphics.lineTo(321,250);	
			hit_center.graphics.lineTo(335,211);	
			hit_center.graphics.lineTo(376,199);	
			hit_center.graphics.lineTo(415,217);	
			hit_center.graphics.lineTo(432,251);	
			hit_center.graphics.lineTo(415,289);	
			hit_center.graphics.lineTo(378,305);	
			hit_center.graphics.lineTo(343,291);	
			
			hit_center.graphics.endFill(false);
			
			hit_center.alpha = 0.0;
			
			hit_center.graphics.precisionHitTest = true;	
			this.addChild(hit_center);
		}
		
		
		private function CreateSectionHits():void{
			hit_section_00 = new Shape();

			hit_section_00.graphics.beginFill(0x00FF00);
			hit_section_00.graphics.lineTo(422,211);	
			hit_section_00.graphics.lineTo(513,122);	
			hit_section_00.graphics.lineTo(610,191);	
			hit_section_00.graphics.lineTo(630,256);	
			hit_section_00.graphics.lineTo(603,320);	
			hit_section_00.graphics.lineTo(507,384);	
			hit_section_00.graphics.lineTo(433,305);		
			hit_section_00.graphics.lineTo(440,251);	
			
			hit_section_00.graphics.endFill(false);
			hit_section_00.alpha = 0.0;
			hit_section_00.graphics.precisionHitTest = true;	
			this.addChild(hit_section_00);
			
			
			hit_section_01 = new Shape();
			
			hit_section_01.graphics.beginFill(0x0000FF);
			hit_section_01.graphics.lineTo(244,379);	
			hit_section_01.graphics.lineTo(336,293);	
			hit_section_01.graphics.lineTo(378,314);	
			hit_section_01.graphics.lineTo(421,296);	
			hit_section_01.graphics.lineTo(505,383);	
			hit_section_01.graphics.lineTo(438,475);	
			hit_section_01.graphics.lineTo(375,504);	
			hit_section_01.graphics.lineTo(311,472);	

			hit_section_01.graphics.endFill(false);
			hit_section_01.alpha = 0.0;
			hit_section_01.graphics.precisionHitTest = true;	
			this.addChild(hit_section_01);
			
			
			hit_section_02 = new Shape();
			
			hit_section_02.graphics.beginFill(0x00FF00);
			hit_section_02.graphics.lineTo(125,249);	
			hit_section_02.graphics.lineTo(151,183);	
			hit_section_02.graphics.lineTo(248,117);	
			hit_section_02.graphics.lineTo(336,211);	
			hit_section_02.graphics.lineTo(319,252);	
			hit_section_02.graphics.lineTo(335,289);	
			hit_section_02.graphics.lineTo(242,373);	
			hit_section_02.graphics.lineTo(168,328);	
		
			hit_section_02.graphics.endFill(false);
			hit_section_02.alpha = 0.0;
			hit_section_02.graphics.precisionHitTest = true;	
			this.addChild(hit_section_02);
			
			
			hit_section_03 = new Shape();
			
			hit_section_03.graphics.beginFill(0x0000FF);
			hit_section_03.graphics.lineTo(246,110);	
			hit_section_03.graphics.lineTo(302,36);	
			hit_section_03.graphics.lineTo(379,0);	
			hit_section_03.graphics.lineTo(463,44);	
			hit_section_03.graphics.lineTo(508,117);	
			hit_section_03.graphics.lineTo(412,212);	
			hit_section_03.graphics.lineTo(378,199);	
			hit_section_03.graphics.lineTo(340,211);	
	
			
			hit_section_03.graphics.endFill(false);
			hit_section_03.alpha = 0.0;
			hit_section_03.graphics.precisionHitTest = true;	
			this.addChild(hit_section_03);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.BEGAN) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
					
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JunkInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkInteriorObj,true
							);
						}else if(hit_section_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseDownFlag = '00';
						}else if(hit_section_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseDownFlag = '01';
						}else if(hit_section_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseDownFlag = '02';
						}else if(hit_section_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseDownFlag = '03';
						}
					}else if (touches[0].phase == TouchPhase.ENDED) {
						if(hit_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseDownFlag = null;
							CenterHandler();
						}else if(hit_roater.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
							MouseDownFlag = null;
							RoaterHandler();
						}else if(hit_section_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseUpFlag = '00';
							MouseUpHandler();
						}else if(hit_section_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseUpFlag = '01';
							MouseUpHandler();
						}else if(hit_section_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseUpFlag = '02';
							MouseUpHandler();
						}else if(hit_section_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouseUpFlag = '03';
							MouseUpHandler();
						}

					}
					
					
					
				}
			}
		}
		
		private function RoaterHandler():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsTwo();
			if(RoaterPos == '00'){
				RoaterPos = '03';
				roater_sprite.rotation = deg2rad(90);
				
				
				if(Pos_00 == 'clear'){
					roater_left.alpha = 0;
				}else{
					roater_left.alpha = 1;
					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_00);
				}
				
				if(Pos_01 == 'clear'){
					roater_top.alpha = 0;
				}else{
					roater_top.alpha = 1;
					roater_top.texture = this.assets.getTexture('roater_top_'+Pos_01);
				}
				
				if(Pos_02 == 'clear'){
					roater_right.alpha = 0;
				}else{
					roater_right.alpha = 1;
					roater_right.texture = this.assets.getTexture('roater_right_'+Pos_02);
				}
				
				if(Pos_03 == 'clear'){
					roater_bottom.alpha = 0;
				}else{
					roater_bottom.alpha = 1;
					roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_03);
				}
				
			}else if(RoaterPos == '01'){
				RoaterPos = '00';
				roater_sprite.rotation = deg2rad(180);
				
				if(Pos_00 == 'clear'){
					roater_bottom.alpha = 0;
				}else{
					roater_bottom.alpha = 1;
					roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_00);
				}
				
				if(Pos_01 == 'clear'){
					roater_left.alpha = 0;
				}else{
					roater_left.alpha = 1;
					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_01);
				}
				
				if(Pos_02 == 'clear'){
					roater_top.alpha = 0;
				}else{
					roater_top.alpha = 1;
					roater_top.texture = this.assets.getTexture('roater_top_'+Pos_02);
				}
				
				if(Pos_03 == 'clear'){
					roater_right.alpha = 0;
				}else{
					roater_right.alpha = 1;
					roater_right.texture = this.assets.getTexture('roater_right_'+Pos_03);
				}
				
				
				
			}else if(RoaterPos == '02'){
				RoaterPos = '01';
				roater_sprite.rotation = deg2rad(-90);
				
				
				if(Pos_00 == 'clear'){
					roater_right.alpha = 0;
				}else{
					roater_right.alpha = 2;
					roater_right.texture = this.assets.getTexture('roater_right_'+Pos_00);
				}
				
				if(Pos_01 == 'clear'){
					roater_bottom.alpha = 0;
				}else{
					roater_bottom.alpha = 1;
					roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_01);
				}
				
				if(Pos_02 == 'clear'){
					roater_left.alpha = 0;
				}else{
					roater_left.alpha = 1;
					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_02);
				}
				
				if(Pos_03 == 'clear'){
					roater_top.alpha = 0;
				}else{
					roater_top.alpha = 1;
					roater_top.texture = this.assets.getTexture('roater_top_'+Pos_03);
				}
				
				
			}else if(RoaterPos == '03'){
				RoaterPos = '02';
				roater_sprite.rotation = deg2rad(0);
				
				
				if(Pos_00 == 'clear'){
					roater_top.alpha = 0;
				}else{
					roater_top.alpha = 1;
					roater_top.texture = this.assets.getTexture('roater_top_'+Pos_00);
				}
				
				if(Pos_01 == 'clear'){
					roater_right.alpha = 0;
				}else{
					roater_right.alpha = 1;
					roater_right.texture = this.assets.getTexture('roater_right_'+Pos_01);
				}
				
				if(Pos_02 == 'clear'){
					roater_bottom.alpha = 0;
				}else{
					roater_bottom.alpha = 1;
					roater_bottom.texture = this.assets.getTexture('roater_bottom_'+Pos_02);
				}
				
				if(Pos_03 == 'clear'){
					roater_left.alpha = 0;
				}else{
					roater_left.alpha = 1;
					roater_left.texture = this.assets.getTexture('roater_left_'+Pos_03);
				}
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
			}
			SaveArray['RoaterPos'] = RoaterPos;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
			
			/*
			private var Pos_00:String = 'clear';
			private var Pos_01:String = 'clear';
			private var Pos_02:String = 'clear';
			private var Pos_03:String = 'clear';
			*/
			
		}
		
		private function CenterHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
			}
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmTwo();
			if(ActiveColor == 'clear'){
				ActiveColor = 'red';
				centerDisc.texture = this.assets.getTexture('center_red');
				roater_center.alpha = 1;
				roater_center.texture = this.assets.getTexture('roater_center_red');
				roater_bottom.texture = this.assets.getTexture('roater_bottom_red');
				roater_bottom.alpha = 1;
			}else if(ActiveColor == 'red'){
				ActiveColor = 'green';
				centerDisc.texture = this.assets.getTexture('center_green');
				roater_center.texture = this.assets.getTexture('roater_center_green');
				roater_bottom.texture = this.assets.getTexture('roater_bottom_green');
				roater_bottom.alpha = 1;
			}else if(ActiveColor == 'green'){
				ActiveColor = 'purple';
				centerDisc.texture = this.assets.getTexture('center_purple');
				roater_center.texture = this.assets.getTexture('roater_center_purple');
				roater_bottom.texture = this.assets.getTexture('roater_bottom_purple');
				roater_bottom.alpha = 1;
			}else if(ActiveColor == 'purple'){
				ActiveColor = 'white';
				centerDisc.texture = this.assets.getTexture('center_white');
				roater_center.texture = this.assets.getTexture('roater_center_white');
				
				roater_bottom.texture = this.assets.getTexture('roater_bottom_white');
				roater_bottom.alpha = 1;
				
			}else if(ActiveColor == 'white'){
				ActiveColor = 'clear';
				centerDisc.texture = this.assets.getTexture('center_clear');
				roater_center.alpha = 0;
				roater_center.texture = this.assets.getTexture('roater_center_red');
				roater_bottom.alpha = 0;
				roater_center.texture = this.assets.getTexture('roater_bottom_red');
			}
			
			if(ActiveColor == 'clear'){
				this[('Pos_'+RoaterPos+'')] = 'clear';
				this[('pos_'+RoaterPos+'_color')].alpha = 0;
				this[('pos_'+RoaterPos+'_color')].texture = this.assets.getTexture('pos_'+RoaterPos+'_red');
				
				SaveArray['Pos_'+RoaterPos] = 'clear';
			}else{
				this[('Pos_'+RoaterPos+'')] = ActiveColor;
				trace("this[('Pos_'+RoaterPos)]  :  "+this[('Pos_'+RoaterPos)]);
				this[('pos_'+RoaterPos+'_color')].alpha = 1;
				this[('pos_'+RoaterPos+'_color')].texture = this.assets.getTexture('pos_'+RoaterPos+'_'+ActiveColor);
				
				SaveArray['Pos_'+RoaterPos] = ActiveColor;
				
				Solve();
			}
			
			
			
			SaveArray['ActiveColor'] = ActiveColor;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
			
		}
		
		private function CheckCoin():void{
			var effCoinPos:int;
			trace("MouseUpFlag: "+MouseUpFlag);
			trace("CoinTracker: "+CoinTracker);
			trace("Coin_Pos_00: "+Coin_Pos_00);
			trace("Coin_Pos_01: "+Coin_Pos_01);
			trace("Coin_Pos_02: "+Coin_Pos_02);
			trace("Coin_Pos_03: "+Coin_Pos_03);
			
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CoinTiger)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				if(MouseUpFlag == '00'){
				
					if(Coin_Pos_00 == 'empty'){
						Coin_Pos_00 = 'tiger';
						this[('coin_0'+CoinTracker)].texture = this.assets.getTexture('tiger_clear')
						this[('coin_0'+CoinTracker)].alpha = 1;

						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTiger,
								"item_CoinTiger"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_00'] = 'tiger';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to take the disc out before putting another in the same spot.");
					}
				}else if(MouseUpFlag == '01'){
					
					effCoinPos = 1+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_01 == 'empty'){
						Coin_Pos_01 = 'tiger';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('tiger_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTiger,
								"item_CoinTiger"
							);
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_01'] = 'tiger';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should remove the disc before trying to put another in its place.");
					}
				}else if(MouseUpFlag == '02'){
					effCoinPos = 2+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_02 == 'empty'){
						Coin_Pos_02 = 'tiger';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('tiger_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTiger,
								"item_CoinTiger"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_02'] = 'tiger';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to remove one before putting another in the same place.");
					}
				}else if(MouseUpFlag == '03'){
					effCoinPos = 3+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_03 == 'empty'){
						Coin_Pos_03 = 'tiger';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('tiger_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTiger,
								"item_CoinTiger"
							);
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_03'] = 'tiger';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That space already has a disc in it.");
					}
				}
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CoinDragon)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				trace("CoinTracker: "+CoinTracker);
				if(MouseUpFlag == '00'){
					
					if(Coin_Pos_00 == 'empty'){
						Coin_Pos_00 = 'dragon';
						this[('coin_0'+CoinTracker)].texture = this.assets.getTexture('dragon_clear')
						this[('coin_0'+CoinTracker)].alpha = 1;
						
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinDragon,
								"item_CoinDragon"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_00'] = 'dragon';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						
					}
				}else if(MouseUpFlag == '01'){
					effCoinPos = 1+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_01 == 'empty'){
						Coin_Pos_01 = 'dragon';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('dragon_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinDragon,
								"item_CoinDragon"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_01'] = 'dragon';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That space already has a disc in it.");
					}
				}else if(MouseUpFlag == '02'){
					effCoinPos = 2+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_02 == 'empty'){
						Coin_Pos_02 = 'dragon';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('dragon_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinDragon,
								"item_CoinDragon"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_02'] = 'dragon';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should remove the disc before trying to put another in its place.");
					}
				}else if(MouseUpFlag == '03'){
					effCoinPos = 3+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_03 == 'empty'){
						Coin_Pos_03 = 'dragon';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('dragon_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinDragon,
								"item_CoinDragon"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_03'] = 'dragon';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't put two in the same spot.");
					}
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CoinPhoenix)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				trace("CoinTracker: "+CoinTracker);
				if(MouseUpFlag == '00'){
					
					if(Coin_Pos_00 == 'empty'){
						Coin_Pos_00 = 'phoenix';
						this[('coin_0'+CoinTracker)].texture = this.assets.getTexture('phoenix_clear')
						this[('coin_0'+CoinTracker)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinPhoenix,
								"item_CoinPhoenix"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_00'] = 'phoenix';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						
					}
				}else if(MouseUpFlag == '01'){
					effCoinPos = 1+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_01 == 'empty'){
						Coin_Pos_01 = 'phoenix';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('phoenix_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinPhoenix,
								"item_CoinPhoenix"
							);
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_01'] = 'phoenix';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That space already has a disc in it.");
					}
				}else if(MouseUpFlag == '02'){
					effCoinPos = 2+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_02 == 'empty'){
						Coin_Pos_02 = 'phoenix';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('phoenix_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinPhoenix,
								"item_CoinPhoenix"
							);
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_02'] = 'phoenix';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should remove the disc before trying to put another in its place.");
					}
				}else if(MouseUpFlag == '03'){
					effCoinPos = 3+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_03 == 'empty'){
						Coin_Pos_03 = 'phoenix';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('phoenix_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinPhoenix,
								"item_CoinPhoenix"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_03'] = 'phoenix';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't put two in the same spot.");
					}
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CoinTurtle)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				trace("CoinTracker: "+CoinTracker);
				if(MouseUpFlag == '00'){
					
					if(Coin_Pos_00 == 'empty'){
						Coin_Pos_00 = 'turtle';
						this[('coin_0'+CoinTracker)].texture = this.assets.getTexture('turtle_clear')
						this[('coin_0'+CoinTracker)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTurtle,
								"item_CoinTurtle"
							);
						Solve();
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_00'] = 'turtle';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else{
						
					}
				}else if(MouseUpFlag == '01'){
					effCoinPos = 1+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_01 == 'empty'){
						Coin_Pos_01 = 'turtle';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('turtle_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTurtle,
								"item_CoinTurtle"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_01'] = 'turtle';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That space already has a disc in it.");
					}
				}else if(MouseUpFlag == '02'){
					effCoinPos = 2+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_02 == 'empty'){
						Coin_Pos_02 = 'turtle';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('turtle_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTurtle,
								"item_CoinTurtle"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_02'] = 'turtle';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should remove the disc before trying to put another in its place.");
					}
				}else if(MouseUpFlag == '03'){
					effCoinPos = 3+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					
					if(Coin_Pos_03 == 'empty'){
						Coin_Pos_03 = 'turtle';
						this[('coin_0'+effCoinPos)].texture = this.assets.getTexture('turtle_clear')
						this[('coin_0'+effCoinPos)].alpha = 1;
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_CoinTurtle,
								"item_CoinTurtle"
							);
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_03'] = 'turtle';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't put two in the same spot.");
					}
				}
			}else{
				if(MouseUpFlag == '00'){
					this[('coin_0'+CoinTracker)].alpha = 0;
					if(Coin_Pos_00 == 'tiger'){
						
						Coin_Pos_00 = 'empty';
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
							'item_CoinTiger',
							'inven_coinTiger_sm'
						);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
						}
						SaveArray['Coin_Pos_00'] = 'empty';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
						
					}else if(Coin_Pos_00 == 'dragon'){
						Coin_Pos_00 = 'empty';
					
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
								'item_CoinDragon',
								'inven_coinDragon_sm'
							);
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_00'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);

					}else if(Coin_Pos_00 == 'phoenix'){
						Coin_Pos_00 = 'empty';
						
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
								'item_CoinPhoenix',
								'inven_coinPhoenix_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_00'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);	
							
					}else if(Coin_Pos_00 == 'turtle'){
						Coin_Pos_00 = 'empty';
						
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
								'item_CoinTurtle',
								'inven_coinTurtle_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_00'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}
				}else if(MouseUpFlag == '01'){
					effCoinPos = 1+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					this[('coin_0'+effCoinPos)].alpha = 0;
					
					if(Coin_Pos_01 == 'tiger'){
						Coin_Pos_01 = 'empty';	
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
								'item_CoinTiger',
								'inven_coinTiger_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_01'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
							
					}else if(Coin_Pos_01 == 'dragon'){
						Coin_Pos_01 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
								'item_CoinDragon',
								'inven_coinDragon_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_01'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
							
					}else if(Coin_Pos_01 == 'phoenix'){
						Coin_Pos_01 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
								'item_CoinPhoenix',
								'inven_coinPhoenix_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_01'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_01 == 'turtle'){
						Coin_Pos_01 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
								'item_CoinTurtle',
								'inven_coinTurtle_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_01'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}
				}else if(MouseUpFlag == '02'){
					effCoinPos = 2+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					this[('coin_0'+effCoinPos)].alpha = 0;
					if(Coin_Pos_02 == 'tiger'){
						Coin_Pos_02 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
								'item_CoinTiger',
								'inven_coinTiger_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_02'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_02 == 'dragon'){
						Coin_Pos_02 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
								'item_CoinDragon',
								'inven_coinDragon_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_02'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_02 == 'phoenix'){
						Coin_Pos_02 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
								'item_CoinPhoenix',
								'inven_coinPhoenix_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_02'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_02 == 'turtle'){
						Coin_Pos_02 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
								'item_CoinTurtle',
								'inven_coinTurtle_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_02'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}
				}else if(MouseUpFlag == '03'){
					effCoinPos = 3+CoinTracker;
					if(effCoinPos >= 4){
						effCoinPos = effCoinPos-4;
					}
					this[('coin_0'+effCoinPos)].alpha = 0;
					if(Coin_Pos_03 == 'tiger'){
						Coin_Pos_03 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
								'item_CoinTiger',
								'inven_coinTiger_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_03'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_03 == 'dragon'){
						Coin_Pos_03 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
								'item_CoinDragon',
								'inven_coinDragon_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_03'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_03 == 'phoenix'){
						Coin_Pos_03 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
								'item_CoinPhoenix',
								'inven_coinPhoenix_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_03'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}else if(Coin_Pos_03 == 'turtle'){
						Coin_Pos_03 = 'empty';
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
								(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
								'item_CoinTurtle',
								'inven_coinTurtle_sm'
							);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
							}
							SaveArray['Coin_Pos_03'] = 'empty';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
					}
				}
			}
			
			MouseDownFlag = null;
			MouseUpFlag = null;
		}
		
		private function MouseUpHandler():void{
			
			var rotationVal:int;
			var doAnimation:Boolean = true;
			
			if(MouseDownFlag == '00'){
				if(MouseUpFlag == '00'){
					CheckCoin();
					rotationVal = 0;
					doAnimation = false;
					CoinTracker = CoinTracker;
				}else if(MouseUpFlag == '01'){
					rotationVal = 90;
				//	CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '02'){
					rotationVal = 90;
				//	CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '03'){
					rotationVal = -90;
					
			//		CoinTracker = CoinTracker-1;
					
				}
			}else if(MouseDownFlag == '01'){
				if(MouseUpFlag == '00'){
					rotationVal = -90;
			//		CoinTracker = CoinTracker-1;
				}else if(MouseUpFlag == '01'){
					CheckCoin();
					rotationVal = 0;
					doAnimation = false;
			//		CoinTracker = CoinTracker;
				}else if(MouseUpFlag == '02'){
					rotationVal = 90;
			//		CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '03'){
					rotationVal = -90;
			//		CoinTracker = CoinTracker-1;
				}
			}else if(MouseDownFlag == '02'){
				if(MouseUpFlag == '00'){
					rotationVal = 90;
			//		CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '01'){
					rotationVal = -90;
			//		CoinTracker = CoinTracker-1;
				}else if(MouseUpFlag == '02'){
					CheckCoin();
					rotationVal = 0;
					doAnimation = false;
			//		CoinTracker = CoinTracker;
				}else if(MouseUpFlag == '03'){
					rotationVal = 90;
			//		CoinTracker = CoinTracker+1;
				}
			}else if(MouseDownFlag == '03'){
				if(MouseUpFlag == '00'){
					rotationVal = 90;
		//			CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '01'){
					rotationVal = 90;
		//			CoinTracker = CoinTracker+1;
				}else if(MouseUpFlag == '02'){
					rotationVal = -90;	
		//			CoinTracker = CoinTracker-1;
				}else if(MouseUpFlag == '03'){
					CheckCoin();
					rotationVal = 0;
					doAnimation = false;
		//			CoinTracker = CoinTracker;
				}
			}
			if(rotationVal == 90){
				CoinTracker = CoinTracker-1;
				Coin_Pos_Temp = Coin_Pos_03;
				Coin_Pos_03 = Coin_Pos_02;
				Coin_Pos_02 = Coin_Pos_01;
				Coin_Pos_01 = Coin_Pos_00;
				Coin_Pos_00 = Coin_Pos_Temp;
			}else if(rotationVal == -90){
				CoinTracker = CoinTracker+1;
				Coin_Pos_Temp = Coin_Pos_03;
				Coin_Pos_03 = Coin_Pos_00;
				Coin_Pos_00 = Coin_Pos_01;
				Coin_Pos_01 = Coin_Pos_02;
				Coin_Pos_02 = Coin_Pos_Temp;
			}else if(rotationVal == 0){
				CoinTracker = CoinTracker;
			}
			
			if(CoinTracker == -1){
				CoinTracker = 3;
			}else if(CoinTracker == 4){
				CoinTracker = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
			}
			SaveArray['Coin_Pos_00'] = Coin_Pos_00;
			SaveArray['Coin_Pos_01'] = Coin_Pos_01;
			SaveArray['Coin_Pos_02'] = Coin_Pos_02;
			SaveArray['Coin_Pos_03'] = Coin_Pos_03;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);
			
			if(doAnimation === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsOne();
				trace("ANIMATING");
				
				pos_00_color.alpha = 0;
				pos_01_color.alpha = 0;
				pos_02_color.alpha = 0;
				pos_03_color.alpha = 0;
				
				Animating = true;
				
				coin_Tween = new Tween(coin_sprite, 1.0, Transitions.EASE_IN_OUT);
				coin_Tween.animate("rotation", coin_sprite.rotation+deg2rad(rotationVal));
				coin_Tween.onComplete = function():void{
					coin_Tween = null;
				}
				coin_00_tween = new Tween(coin_00, 1.0, Transitions.EASE_IN_OUT);
				coin_00_tween.animate("rotation", coin_00.rotation+deg2rad(-rotationVal));
				coin_00_tween.onComplete = function():void{
					coin_00_tween = null;
				}
				coin_01_tween = new Tween(coin_01, 1.0, Transitions.EASE_IN_OUT);
				coin_01_tween.animate("rotation", coin_01.rotation+deg2rad(-rotationVal));
				coin_01_tween.onComplete = function():void{
					coin_01_tween = null;
				}
				coin_02_tween = new Tween(coin_02, 1.0, Transitions.EASE_IN_OUT);
				coin_02_tween.animate("rotation", coin_02.rotation+deg2rad(-rotationVal));
				coin_02_tween.onComplete = function():void{
					coin_02_tween = null;
				}
				coin_03_tween = new Tween(coin_03, 1.0, Transitions.EASE_IN_OUT);
				coin_03_tween.animate("rotation", coin_03.rotation+deg2rad(-rotationVal));
				coin_03_tween.onComplete = function():void{
					coin_03_tween = null;
				}				
				dial_Tween = new Tween(dial, 1.0, Transitions.EASE_IN_OUT);
				dial_Tween.animate("rotation", dial.rotation+deg2rad(rotationVal));
				dial_Tween.onComplete = function():void{
					(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("GearsOne");
					Animating = false;
					//Solve();
					rotationVal = 0;
					MouseDownFlag = null;
					MouseUpFlag = null
					dial_Tween = null;
					AnimationComplete();
				}
				Starling.juggler.add(coin_Tween);
				Starling.juggler.add(coin_00_tween);
				Starling.juggler.add(coin_01_tween);
				Starling.juggler.add(coin_02_tween);
				Starling.juggler.add(coin_03_tween);
				Starling.juggler.add(dial_Tween);
			}else{
				rotationVal = 0;
			//	MouseDownFlag = null;
			//	MouseUpFlag = null;
			}
			
		}
		
		private function AnimationComplete():void{
			if(Pos_00 == 'clear'){
				pos_00_color.alpha = 0;
			}else{
				pos_00_color.alpha = 1;
			}
			if(Pos_01 == 'clear'){
				pos_01_color.alpha = 0;
			}else{
				pos_01_color.alpha = 1;
			}
			if(Pos_02 == 'clear'){
				pos_02_color.alpha = 0;
			}else{
				pos_02_color.alpha = 1;
			}
			if(Pos_03 == 'clear'){
				pos_03_color.alpha = 0;
			}else{
				pos_03_color.alpha = 1;
			}
			
			Solve();
			
			
			
		}
		
		private function Solve():void{
			trace("Solving");
			if(Pos_00 == 'green'){
				trace('PASS 01');
				if(Pos_01 == 'purple'){
					trace('PASS 02');
					if(Pos_02 == 'white'){
						trace('PASS 03');
						if(Pos_03 == 'red'){
							trace('PASS 04');
							if(Coin_Pos_00 == 'dragon'){
								trace('PASS 05');
								if(Coin_Pos_01 == 'turtle'){
									trace('PASS 06');
									if(Coin_Pos_02 == 'tiger'){
										trace('PASS 07');
										if(Coin_Pos_03 == 'phoenix'){
											trace('PASS 08');
											trace("Solved");
											
											
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gong();
											Animating = true;
											Solved = true;
											//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
											
											if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
												SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle;
											}
											SaveArray['Solved'] = 'Yes'; 
											(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkPuzzle',SaveArray);	
											
											delayedcall = new DelayedCall(function():void{
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Unlock();
												Animating = false;
												FadeOut(JunkInterior,(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkInteriorObj,true)
												
											},3);
											
											
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
			
			
			this.assets.removeTexture("junkPuzzle_bg",true);
			this.assets.removeTexture("JunkPuzzle_Sprite",true);
			this.assets.removeTextureAtlas("JunkPuzzle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("junkPuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("junkPuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("junkPuzzle_03");
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
