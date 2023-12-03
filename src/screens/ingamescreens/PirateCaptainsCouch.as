package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	
	public class PirateCaptainsCouch extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var left_on:Image;
		private var left_off:Image;
		private var center_on:Image;
		private var center_off:Image;
		private var right_on:Image;
		private var right_off:Image;
		
		private var cushion_ry_right_up:Image;
		private var cushion_ry_right_down:Image;
		private var cushion_ry_center_up:Image;
		private var cushion_ry_center_down:Image;
		
		private var cushion_gb_left_up:Image;
		private var cushion_gb_left_down:Image;
		private var cushion_gb_center_up:Image;
		private var cushion_gb_center_down:Image;
		
		private var pickAxe:Image;
		
		private var coin:Image;
		
		private var hit_pickAxe:Shape;
		
		private var hit_coin:Shape;
		
		private var hit_left:Shape;
		private var hit_center:Shape;
		private var hit_right:Shape;
		
		private var hit_cushion_right:Shape;
		private var hit_cushion_ry_center:Shape;
		private var hit_cushion_gb_center:Shape;
		private var hit_cushion_left:Shape;
		
		private var hit_back:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var LeftOpen:Boolean = false;
		private var CenterOpen:Boolean = false;
		private var RightOpen:Boolean = false;
		private var RYisCenter:Boolean = false;
		private var GBisCenter:Boolean = false;
		private var AxePickedUp:Boolean = false;
		private var CoinPickedUp:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function PirateCaptainsCouch(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateCaptainsCouch_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsCouch/pirateCaptainsCouch_bg.jpg'));
				game.TrackAssets('pirateCaptainsCouch_01');
			}
			if(game.CheckAsset('pirateCaptainsCouch_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsCouch/PirateCaptainsCouch_Sprite.png'));
				game.TrackAssets('pirateCaptainsCouch_02');
			}
			if(game.CheckAsset('pirateCaptainsCouch_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsCouch/PirateCaptainsCouch_Sprite.xml'));
				game.TrackAssets('pirateCaptainsCouch_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("PirateCaptainsCouch","PirateCaptainsCouchObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			
			bg = new Image(this.assets.getTexture('pirateCaptainsCouch_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			coin = new Image(this.assets.getTexture('coin'));
		//	coin.smoothing = TextureSmoothing.NONE;

			coin.touchable = false;
			coin.x = 608;
			coin.y = 234;
			
			right_on = new Image(this.assets.getTexture('right_on'));
		//	right_on.smoothing = TextureSmoothing.NONE;

			right_on.touchable = false;
			right_on.x = 512;
			right_on.y = 225;
			
			
			
			center_on = new Image(this.assets.getTexture('center_on'));
		//	center_on.smoothing = TextureSmoothing.NONE;

			center_on.touchable = false;
			center_on.x = 305;
			center_on.y = 245;
		
			left_on = new Image(this.assets.getTexture('left_on'));
	//		left_on.smoothing = TextureSmoothing.NONE;

			left_on.touchable = false;
			left_on.x = 40;
			left_on.y = 276;
			
					
			right_off = new Image(this.assets.getTexture('right_off'));
		//	right_off.smoothing = TextureSmoothing.NONE;

			right_off.touchable = false;
			right_off.x = 667;
			right_off.y = 293;

			center_off = new Image(this.assets.getTexture('center_off'));
//			center_off.smoothing = TextureSmoothing.NONE;

			center_off.touchable = false;
			center_off.x = 360;
			center_off.y = 349;
		
			
			left_off = new Image(this.assets.getTexture('left_off'));
	//		left_off.smoothing = TextureSmoothing.NONE;

			left_off.touchable = false;
			left_off.x = 34;
			left_off.y = 398;
	
			cushion_gb_left_down = new Image(this.assets.getTexture('cushion_gb_left_down'));
	//		cushion_gb_left_down.smoothing = TextureSmoothing.NONE;

			cushion_gb_left_down.touchable = false;
			cushion_gb_left_down.x = 540;
			cushion_gb_left_down.y = 170;
			
				
			cushion_gb_center_down = new Image(this.assets.getTexture('cushion_gb_center_down'));
		//	cushion_gb_center_down.smoothing = TextureSmoothing.NONE;

			cushion_gb_center_down.touchable = false;
			cushion_gb_center_down.x = 391;
			cushion_gb_center_down.y = 192;

			
			cushion_ry_right_down = new Image(this.assets.getTexture('cushion_ry_right_down'));
		//	cushion_ry_right_down.smoothing = TextureSmoothing.NONE;

			cushion_ry_right_down.touchable = false;
			cushion_ry_right_down.x = 23;
			cushion_ry_right_down.y = 222;
						
			
			cushion_ry_center_down = new Image(this.assets.getTexture('cushion_ry_center_down'));
	//		cushion_ry_center_down.smoothing = TextureSmoothing.NONE;

			cushion_ry_center_down.touchable = false;
			cushion_ry_center_down.x = 303;
			cushion_ry_center_down.y = 206;
			
			
			cushion_gb_left_up = new Image(this.assets.getTexture('cushion_gb_left_up'));
		//	cushion_gb_left_up.smoothing = TextureSmoothing.NONE;

			cushion_gb_left_up.touchable = false;
			cushion_gb_left_up.x = 546;
			cushion_gb_left_up.y = 123;

			
			cushion_gb_center_up = new Image(this.assets.getTexture('cushion_gb_center_up'));
		//	cushion_gb_center_up.smoothing = TextureSmoothing.NONE;

			cushion_gb_center_up.touchable = false;
			cushion_gb_center_up.x = 388;
			cushion_gb_center_up.y = 146;

			
			cushion_ry_right_up = new Image(this.assets.getTexture('cushion_ry_right_up'));
		//	cushion_ry_right_up.smoothing = TextureSmoothing.NONE;

			cushion_ry_right_up.touchable = false;
			cushion_ry_right_up.x = 17;
			cushion_ry_right_up.y = 173;
			
			
			cushion_ry_center_up = new Image(this.assets.getTexture('cushion_ry_center_up'));
	//		cushion_ry_center_up.smoothing = TextureSmoothing.NONE;

			cushion_ry_center_up.touchable = false;
			cushion_ry_center_up.x = 279.5;
			cushion_ry_center_up.y = 161;

			
			pickAxe = new Image(this.assets.getTexture('pickaxe'));
	//		pickAxe.smoothing = TextureSmoothing.NONE;

			pickAxe.touchable = false;
			pickAxe.x = 261;
			pickAxe.y = 122;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['PickAxe'] == 'PickedUp'){
					pickAxe.alpha = 0;
					AxePickedUp = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['LeftOpen'] == 'Yes'){
						LeftOpen = true;
						left_on.alpha = 0;
						left_off.alpha = 1;
						cushion_ry_right_up.alpha = 0;
					}else{
						left_on.alpha = 1;
						left_off.alpha = 0;
						cushion_ry_right_down.alpha = 0;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['RightOpen'] == 'Yes'){
						RightOpen = true;
						right_on.alpha = 0;
						right_off.alpha = 1;
						cushion_gb_left_up.alpha = 0;
					}else{
						right_on.alpha = 1;
						right_off.alpha = 0;
						cushion_gb_left_down.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['CenterOpen'] == 'Yes'){
						CenterOpen = true;
						center_on.alpha = 0;
						center_off.alpha = 1;
						cushion_gb_center_up.alpha = 0;
						cushion_ry_center_up.alpha = 0;
					}else{
						center_on.alpha = 1;
						center_off.alpha = 0;
						cushion_gb_center_down.alpha = 0;
						cushion_ry_center_down.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['RYisCenter'] == 'Yes'){
						RYisCenter = true;
						if(CenterOpen === true){
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 0;
							cushion_ry_center_down.alpha = 1;
							cushion_ry_center_up.alpha = 0;
						}else{
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 0;
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 1;
						}
					}else{
						RYisCenter = false;
						if(LeftOpen === true){
							cushion_ry_right_down.alpha = 1;
							cushion_ry_right_up.alpha = 0;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_center_down.alpha = 0;
						}else{
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 1;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_center_down.alpha = 0;
						}
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['GBisCenter'] == 'Yes'){
						GBisCenter = true;
						if(CenterOpen === true){
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 0;
							cushion_gb_center_down.alpha = 1;
							cushion_gb_center_up.alpha = 0;
						}else{
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 0;
							cushion_gb_center_down.alpha = 0;
							cushion_gb_center_up.alpha = 1;
							
						}
					}else{
						GBisCenter = false;
						if(RightOpen === true){
							cushion_gb_left_down.alpha = 1;
							cushion_gb_left_up.alpha = 0;
							cushion_gb_center_up.alpha = 0;
							cushion_gb_center_down.alpha = 0;
						}else{
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 1;
							cushion_gb_center_up.alpha = 0;
							cushion_gb_center_down.alpha = 0;
						}
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['Coin'] == 'PickedUp'){
						CoinPickedUp = true;
						coin.alpha = 0;
					}else{
						if(RightOpen === true){
							if(GBisCenter === true){
								coin.alpha = 1;
							}else{
								coin.alpha = 0;
							}
						}else{
							coin.alpha = 0;
						}
					}
					
				}else{
					pickAxe.alpha = 1
					coin.alpha = 0;
					right_on.alpha = 1;
					center_on.alpha = 1;
					left_on.alpha = 1;
					right_off.alpha = 0;
					center_off.alpha = 0;
					left_off.alpha = 0;
					cushion_gb_left_down.alpha = 0;
					cushion_gb_center_down.alpha = 0;
					cushion_ry_right_down.alpha = 0;
					cushion_ry_center_down.alpha = 0;
					cushion_gb_left_up.alpha = 1;
					cushion_gb_center_up.alpha = 0;
					cushion_ry_right_up.alpha = 1;
					cushion_ry_center_up.alpha = 0;
				}
			}else{
				coin.alpha = 0;
				right_on.alpha = 1;
				center_on.alpha = 1;
				left_on.alpha = 1;
				right_off.alpha = 0;
				center_off.alpha = 0;
				left_off.alpha = 0;
				cushion_gb_left_down.alpha = 0;
				cushion_gb_center_down.alpha = 0;
				cushion_ry_right_down.alpha = 0;
				cushion_ry_center_down.alpha = 0;
				cushion_gb_left_up.alpha = 1;
				cushion_gb_center_up.alpha = 0;
				cushion_ry_right_up.alpha = 1;
				cushion_ry_center_up.alpha = 0;
				pickAxe.alpha = 1;
			}
			
			
			
			
			
			
			this.addChildAt(coin,1);
			this.addChildAt(right_off,2);	
			this.addChildAt(left_off,3);
			this.addChildAt(right_on,4);
			this.addChildAt(cushion_gb_center_down,5);	
			this.addChildAt(cushion_ry_center_down,6);	
			
			this.addChildAt(center_off,7);
				
			
			this.addChildAt(center_on,8);	
			this.addChildAt(left_on,9);
				
									
								
			this.addChildAt(cushion_gb_left_down,10);					
	//		this.addChildAt(cushion_gb_center_down,11);						
			this.addChildAt(cushion_ry_right_down,11);					
	//		this.addChildAt(cushion_ry_center_down,13);	
			this.addChildAt(cushion_gb_left_up,12);					
			this.addChildAt(cushion_gb_center_up,13);
			
			this.addChildAt(cushion_ry_right_up,14);								
			this.addChildAt(cushion_ry_center_up,15);						
			this.addChildAt(pickAxe,16);
			
			
			CreateBackHit();
			CreateLeftHit(LeftOpen);
			CreateCenterHit(CenterOpen);
			CreateRightHit(RightOpen);
			
			
			
			CreateCushionGBCenterHit();
			CreateCushionRYCenterHit();
			CreateCushionRightHit();
			CreateCushionLeftHit();
			CreateCoinHit();
			CreatePickAxeHit();

			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		//hit_back
		private function CreateBackHit():void{
			hit_back = new Shape();
			hit_back.touchable = false;
			hit_back.graphics.beginFill(0x0000ff);
			
			hit_back.graphics.lineTo(25,94);			
			hit_back.graphics.lineTo(89,45);			
			hit_back.graphics.lineTo(637,16);			
			hit_back.graphics.lineTo(649,118);			
			hit_back.graphics.lineTo(32,208);			
			
			hit_back.graphics.endFill(false);
			hit_back.alpha = 0.0;
			
			hit_back.graphics.precisionHitTest = true;	
			this.addChild(hit_back);
		}
		
		private function CreateCoinHit():void{
			hit_coin = new Shape();
			hit_coin.touchable = false;
			hit_coin.graphics.beginFill(0x0000ff);
			
			hit_coin.graphics.lineTo(590,250);	
			hit_coin.graphics.lineTo(600,218);	
			hit_coin.graphics.lineTo(653,213);	
			hit_coin.graphics.lineTo(673,251);	
			hit_coin.graphics.lineTo(672,289);	
			hit_coin.graphics.lineTo(629,297);	

			
			hit_coin.graphics.endFill(false);
			hit_coin.alpha = 0.0;
			
			hit_coin.graphics.precisionHitTest = true;	
			this.addChild(hit_coin);
		}
		
		private function CreatePickAxeHit():void{
			hit_pickAxe = new Shape();
			hit_pickAxe.touchable = false;
			hit_pickAxe.graphics.beginFill(0x0000ff);
			
			hit_pickAxe.graphics.lineTo(238,325);	
			hit_pickAxe.graphics.lineTo(430,189);	
			hit_pickAxe.graphics.lineTo(456,104);	
			hit_pickAxe.graphics.lineTo(554,176);	
			hit_pickAxe.graphics.lineTo(581,293);	
			hit_pickAxe.graphics.lineTo(273,380);	

			
			hit_pickAxe.graphics.endFill(false);
			hit_pickAxe.alpha = 0.0;
			
			hit_pickAxe.graphics.precisionHitTest = true;	
			this.addChild(hit_pickAxe);
		}
	

		private function CreateCushionLeftHit():void{
			hit_cushion_left = new Shape();
			hit_cushion_left.touchable = false;
			hit_cushion_left.graphics.beginFill(0x0000ff);
			
			hit_cushion_left.graphics.lineTo(7,253);	
			hit_cushion_left.graphics.lineTo(81,188);	
			hit_cushion_left.graphics.lineTo(205,167);	
			hit_cushion_left.graphics.lineTo(269,301);	
			hit_cushion_left.graphics.lineTo(268,336);	
			hit_cushion_left.graphics.lineTo(198,396);	
			hit_cushion_left.graphics.lineTo(141,398);	
			hit_cushion_left.graphics.lineTo(83,432);	
			hit_cushion_left.graphics.lineTo(25,346);	
			
			hit_cushion_left.graphics.endFill(false);
			hit_cushion_left.alpha = 0.0;
			
			hit_cushion_left.graphics.precisionHitTest = true;	
			this.addChild(hit_cushion_left);
		}

		private function CreateCushionRightHit():void{
			hit_cushion_right = new Shape();
			hit_cushion_right.touchable = false;
			hit_cushion_right.graphics.beginFill(0x0000ff);
			
			hit_cushion_right.graphics.lineTo(571,129);	
			hit_cushion_right.graphics.lineTo(635,115);	
			hit_cushion_right.graphics.lineTo(753,131);	
			hit_cushion_right.graphics.lineTo(771,158);	
			hit_cushion_right.graphics.lineTo(743,296);	
			hit_cushion_right.graphics.lineTo(666,315);	
			hit_cushion_right.graphics.lineTo(524,276);	
	
			hit_cushion_right.graphics.endFill(false);
			hit_cushion_right.alpha = 0.0;
			
			hit_cushion_right.graphics.precisionHitTest = true;	
			this.addChild(hit_cushion_right);
		}
		
		
		private function CreateCushionRYCenterHit():void{
			hit_cushion_ry_center = new Shape();
			hit_cushion_ry_center.touchable = false;
			hit_cushion_ry_center.graphics.beginFill(0x0000ff);
			
			hit_cushion_ry_center.graphics.lineTo(270,278);	
			hit_cushion_ry_center.graphics.lineTo(291,154);	
			hit_cushion_ry_center.graphics.lineTo(428,167);	
			hit_cushion_ry_center.graphics.lineTo(472,186);	
			hit_cushion_ry_center.graphics.lineTo(500,320);	
			hit_cushion_ry_center.graphics.lineTo(493,367);	
			hit_cushion_ry_center.graphics.lineTo(465,373);	
			hit_cushion_ry_center.graphics.lineTo(333,369);	
		
			
			hit_cushion_ry_center.graphics.endFill(false);
			hit_cushion_ry_center.alpha = 0.0;
			
			hit_cushion_ry_center.graphics.precisionHitTest = true;	
			this.addChild(hit_cushion_ry_center);
		}
		
		private function CreateCushionGBCenterHit():void{
			hit_cushion_gb_center = new Shape();
			hit_cushion_gb_center.touchable = false;
			hit_cushion_gb_center.graphics.beginFill(0x0000ff);
			
			hit_cushion_gb_center.graphics.lineTo(390,172);	
			hit_cushion_gb_center.graphics.lineTo(514,139);	
			hit_cushion_gb_center.graphics.lineTo(576,193);	
			hit_cushion_gb_center.graphics.lineTo(588,320);	
			hit_cushion_gb_center.graphics.lineTo(564,350);	
			hit_cushion_gb_center.graphics.lineTo(517,362);	
			hit_cushion_gb_center.graphics.lineTo(425,346);	
			hit_cushion_gb_center.graphics.lineTo(391,318);	
			
			hit_cushion_gb_center.graphics.endFill(false);
			hit_cushion_gb_center.alpha = 0.0;
			
			hit_cushion_gb_center.graphics.precisionHitTest = true;	
			this.addChild(hit_cushion_gb_center);
		}

		private function CreateLeftHit(open:Boolean = false):void{
			hit_left = new Shape();
			
			if(open === false){
				
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);
				
				
				hit_left.graphics.lineTo(37,512);	
				hit_left.graphics.lineTo(61,344);	
				hit_left.graphics.lineTo(104,299);	
				hit_left.graphics.lineTo(301,268);	
				hit_left.graphics.lineTo(363,444);	
				hit_left.graphics.lineTo(366,497);	
				hit_left.graphics.lineTo(327,512);	

				hit_left.graphics.endFill(false);
				
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;	
			}else{
				
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);
	
				hit_left.graphics.lineTo(89,512);
				hit_left.graphics.lineTo(91,437);
				hit_left.graphics.lineTo(141,407);
				hit_left.graphics.lineTo(314,394);
				hit_left.graphics.lineTo(347,436);
				hit_left.graphics.lineTo(344,512);
				
				hit_left.graphics.endFill(false);
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;				
			}
			hit_left.touchable = false;
			this.addChild(hit_left);
			
		}	
		
		
		private function CreateCenterHit(open:Boolean = false):void{
			hit_center = new Shape();
			
			if(open === false){
				
				hit_center.x = 0;
				hit_center.y = 0;
				hit_center.graphics.beginFill(0x00FF00);
								
				hit_center.graphics.lineTo(303,267);	
				hit_center.graphics.lineTo(498,235);	
				hit_center.graphics.lineTo(638,382);	
				hit_center.graphics.lineTo(640,410);	
				hit_center.graphics.lineTo(589,448);	
				hit_center.graphics.lineTo(367,499);	
				hit_center.graphics.lineTo(365,442);	

				hit_center.graphics.endFill(false);
				
				hit_center.alpha = 0.0;
				
				hit_center.graphics.precisionHitTest = true;	
			}else{
				
				hit_center.x = 0;
				hit_center.y = 0;
				hit_center.graphics.beginFill(0x00FF00);		
				hit_center.graphics.lineTo(353,456);
				hit_center.graphics.lineTo(356,403);
				hit_center.graphics.lineTo(628,346);
				hit_center.graphics.lineTo(653,408);
				hit_center.graphics.lineTo(593,506);
				hit_center.graphics.lineTo(373,507);
				
				hit_center.graphics.endFill(false);
				hit_center.alpha = 0.0;
				
				hit_center.graphics.precisionHitTest = true;				
			}
			hit_center.touchable = false;
			this.addChild(hit_center);
			
		}	
		
		private function CreateRightHit(open:Boolean = false):void{
			hit_right = new Shape();
			
			if(open === false){
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000ff);
				
				hit_right.graphics.lineTo(498,232);	
				hit_right.graphics.lineTo(610,210);	
				hit_right.graphics.lineTo(708,220);	
				hit_right.graphics.lineTo(796,273);	
				hit_right.graphics.lineTo(797,380);	
				hit_right.graphics.lineTo(641,409);	
				hit_right.graphics.lineTo(638,377);	
			
				hit_right.graphics.endFill(false);
				
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;	
			}else{
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000FF);		
				
				hit_right.graphics.lineTo(663,357);	
				hit_right.graphics.lineTo(748,303);	
				hit_right.graphics.lineTo(800,284);	
				hit_right.graphics.lineTo(800,410);	
				hit_right.graphics.lineTo(670,408);	
				
				hit_right.graphics.endFill(false);
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;				
			}
			hit_right.touchable = false;
			this.addChild(hit_right);
			
		}	
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((PirateCaptains as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsObj,true
						);
					}
					else if(AxePickedUp === true){
						if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CouchHandler('LEFT');
						}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){

							CouchHandler('RIGHT');
							
						}else if(hit_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CouchHandler('CENTER');
						}else if(hit_cushion_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CushionHandler('LEFT');
						}else if(hit_cushion_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(RightOpen === true){
								if(GBisCenter === true){
									if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										CoinHandler();
									}else{
										CushionHandler('RIGHT');
									}
								}else{
									CushionHandler('RIGHT');
								}
							}else{
								CushionHandler('RIGHT');
							}
							
						}else if(hit_cushion_ry_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(RYisCenter === true){
								CushionHandler('CENTERRY');
							}else if(hit_cushion_gb_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								CushionHandler('CENTERGB');
							}
						}else if(hit_cushion_gb_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CushionHandler('CENTERGB');
						}else if(hit_back.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The couch has a floral upholstery and is badly stained.");	
							
						}
				//		if(RightOpen === true){
				//			if(GBisCenter === true){
				//				if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				//					CoinHandler();
				//				}
				//			}
				//		}
					}else{
						if(hit_pickAxe.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							AxeHandler();
						}else if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before trying to move the cushions.");				
						}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before trying to move the cushions.");				
						}else if(hit_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before trying to move the cushions.");				
						}else if(hit_cushion_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before moving the pillows.");				
						}else if(hit_cushion_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before moving the pillows.");	
						}else if(hit_cushion_ry_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before moving the pillows.");	
						}else if(hit_cushion_gb_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the pickaxe before moving the pillows.");	

						}else if(hit_back.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The couch has a floral upholstery and is badly stained.");	

						}
						
					}
				}
			}
		}
		
		
		private function AxeHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['PickAxe'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					pickAxe.alpha = 0;
					AxePickedUp = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
					}
					SaveArray["PickAxe"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PickAxe,
						'item_PickAxe',
						'inven_pickAxe_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
				pickAxe.alpha = 0;
				AxePickedUp = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
				}
				SaveArray["PickAxe"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PickAxe,
					'item_PickAxe',
					'inven_pickAxe_sm'
				);
			}
		}
		
		private function CoinHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['Coin'] == 'PickedUp'){
					
				}else{
					coin.alpha = 0;
					CoinPickedUp = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
					}
					SaveArray["Coin"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AncientCoinTwo,
						'item_AncientCoinTwo',
						'inven_ancientCoinTwo_sm'
					);
				}
			}else{
				coin.alpha = 0;
				CoinPickedUp = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
				}
				SaveArray["Coin"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AncientCoinTwo,
					'item_AncientCoinTwo',
					'inven_ancientCoinTwo_sm'
				);
			}
		}
		
		private function CushionHandler(StrikePOS:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
			}
			
			
			if(StrikePOS == 'LEFT'){
				if(RYisCenter === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					RYisCenter = true;
					SaveArray['RYisCenter'] = 'Yes';
					if(CenterOpen === false){
						cushion_ry_center_down.alpha = 0;
						cushion_ry_center_up.alpha = 1;
						cushion_ry_right_down.alpha = 0;
						cushion_ry_right_up.alpha = 0;
					}else{
						cushion_ry_center_down.alpha = 1;
						cushion_ry_center_up.alpha = 0;
						cushion_ry_right_down.alpha = 0;
						cushion_ry_right_up.alpha = 0;
					}
				}
			}else if(StrikePOS == 'RIGHT'){
				if(GBisCenter === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					GBisCenter = true;
					SaveArray['GBisCenter'] = 'Yes';
					if(CenterOpen === false){
						cushion_gb_center_down.alpha = 0;
						cushion_gb_center_up.alpha = 1;
						cushion_gb_left_down.alpha = 0;
						cushion_gb_left_up.alpha = 0;
		
					}else{
						cushion_gb_center_down.alpha = 1;
						cushion_gb_center_up.alpha = 0;
						cushion_gb_left_down.alpha = 0;
						cushion_gb_left_up.alpha = 0;
					}
					
					if(CoinPickedUp === false){
						coin.alpha = 1;
					}else{
						coin.alpha = 0;
					}
				}
			}else if(StrikePOS == 'CENTERRY'){
				if(RYisCenter === true){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					RYisCenter = false;
					SaveArray['RYisCenter'] = 'No';
					if(LeftOpen === false){
						cushion_ry_center_down.alpha = 0;
						cushion_ry_center_up.alpha = 0;
						cushion_ry_right_down.alpha = 0;
						cushion_ry_right_up.alpha = 1;
					}else{
						cushion_ry_center_down.alpha = 0;
						cushion_ry_center_up.alpha = 0;
						cushion_ry_right_down.alpha = 1;
						cushion_ry_right_up.alpha = 0;
						
					}
				}
			}else if(StrikePOS == 'CENTERGB'){
				if(GBisCenter === true){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					GBisCenter = false;
					SaveArray['GBisCenter'] = 'No';
					if(RightOpen === false){
						cushion_gb_center_down.alpha = 0;
						cushion_gb_center_up.alpha = 0;
						cushion_gb_left_down.alpha = 0;
						cushion_gb_left_up.alpha = 1;
					}else{
						cushion_gb_center_down.alpha = 0;
						cushion_gb_center_up.alpha = 0;
						cushion_gb_left_down.alpha = 1;
						cushion_gb_left_up.alpha = 0;
						
						coin.alpha = 0;
					}
				}
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
		}
		
		private function CouchHandler(StrikePOS:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch;
			}
			
			if(StrikePOS == 'LEFT'){
				if(LeftOpen === false){
					
					if(RYisCenter === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						RYisCenter = true;
						SaveArray['RYisCenter'] = 'Yes';
						if(CenterOpen === false){
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 1;
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 0;
						}else{
							cushion_ry_center_down.alpha = 1;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 0;
						}
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['LeftOpen'] = 'Yes';
						LeftOpen = true;
						left_on.alpha = 0;
						left_off.alpha = 1;
						hit_left.graphics.clear();
						CreateLeftHit(true);
					}
				}else{
					if(RYisCenter === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to move the pillows first.");				
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['LeftOpen'] = 'No';
						LeftOpen = false;
						left_on.alpha = 1;
						left_off.alpha = 0;
						hit_left.graphics.clear();
						CreateLeftHit(false);
					}
				}
			}else if(StrikePOS == 'RIGHT'){
				if(RightOpen === false){
					
					if(GBisCenter === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						GBisCenter = true;
						SaveArray['GBisCenter'] = 'Yes';
						if(CenterOpen === false){
							cushion_gb_center_down.alpha = 0;
							cushion_gb_center_up.alpha = 1;
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 0;
						
						}else{
							cushion_gb_center_down.alpha = 1;
							cushion_gb_center_up.alpha = 0;
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 0;
						}
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['RightOpen'] = 'Yes';
						RightOpen = true;
						right_on.alpha = 0;
						right_off.alpha = 1;
						
						if(CoinPickedUp === false){
							coin.alpha = 1;
						}else{
							coin.alpha = 0;
						}
						
						hit_right.graphics.clear();
						CreateRightHit(true);
						
						
						
					}
				}else{
					if(GBisCenter === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to move the pillows first.");				
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['RightOpen'] = 'No';
						RightOpen = false;
						coin.alpha = 0;
						right_on.alpha = 1;
						right_off.alpha = 0;
						hit_right.graphics.clear();
						CreateRightHit(false);
					}
				}
			}else if(StrikePOS == 'CENTER'){
				if(CenterOpen === false){
					if(RYisCenter === false && GBisCenter === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['CenterOpen'] = 'Yes';
						CenterOpen = true;
						center_on.alpha = 0;
						center_off.alpha = 1;
						hit_center.graphics.clear();
						CreateCenterHit(true);
					}else if(RYisCenter === true && GBisCenter === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						RYisCenter = false;
						SaveArray['RYisCenter'] = 'No';
						if(LeftOpen === false){
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 1;
						}else{
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_right_down.alpha = 1;
							cushion_ry_right_up.alpha = 0;
						}
					}else if(RYisCenter === false && GBisCenter === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						GBisCenter = false;
						SaveArray['GBisCenter'] = 'No';
						if(RightOpen === false){
							cushion_gb_center_down.alpha = 0;
							cushion_gb_center_up.alpha = 0;
							cushion_gb_left_down.alpha = 0;
							cushion_gb_left_up.alpha = 1;
						}else{
							cushion_gb_center_down.alpha = 0;
							cushion_gb_center_up.alpha = 0;
							cushion_gb_left_down.alpha = 1;
							cushion_gb_left_up.alpha = 0;
							
							
							coin.alpha = 0;
							
						}
					}else if(RYisCenter === true && GBisCenter === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						RYisCenter = false;
						SaveArray['RYisCenter'] = 'No';
						if(LeftOpen === false){
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_right_down.alpha = 0;
							cushion_ry_right_up.alpha = 1;
						}else{
							cushion_ry_center_down.alpha = 0;
							cushion_ry_center_up.alpha = 0;
							cushion_ry_right_down.alpha = 1;
							cushion_ry_right_up.alpha = 0;
						}
					}
					
					
				}else{
					if(GBisCenter === true || RYisCenter === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I need to move the pillows first.");				
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
						SaveArray['CenterOpen'] = 'No';
						CenterOpen = false;
						center_on.alpha = 1;
						center_off.alpha = 0;
						hit_center.graphics.clear();
						CreateCenterHit(false);
					}
				}
			}
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsCouch',SaveArray);
		}
		/*
		cushion_ry_right_down.alpha = 0;
		cushion_ry_center_down.alpha = 0;
		*/
		
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
			
			
			this.assets.removeTexture("pirateCaptainsCouch_bg",true);
			this.assets.removeTexture("PirateCaptainsCouch_Sprite",true);
			this.assets.removeTextureAtlas("PirateCaptainsCouch_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsCouch_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsCouch_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsCouch_03");
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