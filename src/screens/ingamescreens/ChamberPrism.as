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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class ChamberPrism extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var mirror:Image;
		
		
		private var crystal_red:Image;
		private var crystal_green:Image;
		private var crystal_blue:Image;
		
		
		private var crystal_one:Image;
		private var crystal_two:Image;
		private var crystal_three:Image;
		private var crystal_four:Image;
		private var crystal_five:Image;
	
		private var beam_01p01:Image;
		private var beam_01p02:Image;
		private var beam_02p01:Image;
		private var beam_02p02:Image;
		private var beam_02p03:Image;
		private var beam_03p01:Image;
		private var beam_03p02:Image;
		private var beam_03p03:Image;
		private var beam_04p01:Image;
		private var beam_04p02:Image;
		private var beam_05p01:Image;
		private var beam_05p02:Image;
		private var beam_06p01:Image;
		private var beam_06p02:Image;
		
		private var beamSprite:Sprite;
		
		private var hit_mirror:Shape;
		private var hit_d_01:Shape;
		private var hit_d_02:Shape;
		private var hit_d_03:Shape;
		private var hit_d_04:Shape;

		private var hit_red:Shape;
		private var hit_green:Shape;
		private var hit_blue:Shape;
		private var hit_white:Shape;
		
		private var Animating:Boolean = false;
		private var MirrorAttached:Boolean = false;
		private var RedAttached:Boolean = false;
		private var GreenAttached:Boolean = false;
		private var BlueAttached:Boolean = false;
		private var WhiteAttached:Boolean = false;
		public var delayedCall:DelayedCall;
		private var EndBeamTween:Tween;
		
		private var MirrorPos:int = 1;
		private var MirrorDir:Boolean = false
		// False is toward Left, True is toward Right, change on 0 and 4
		
		private var soundBool:Boolean = false;
			
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		
		private var goback:GoBackButton;
		public function ChamberPrism(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberPrism_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberPrism/chamberPrism_bg.jpg'));
				game.TrackAssets('chamberPrism_01');
			}
			if(game.CheckAsset('chamberPrism_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberPrism/ChamberPrism_Sprite_01.atf'));
				game.TrackAssets('chamberPrism_02');
			}
			if(game.CheckAsset('chamberPrism_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberPrism/ChamberPrism_Sprite_01.xml'));
				game.TrackAssets('chamberPrism_03');
			}
			if(game.CheckAsset('chamberPrism_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberPrism/ChamberPrism_Sprite_02.png'));
				game.TrackAssets('chamberPrism_04');
			}
			if(game.CheckAsset('chamberPrism_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberPrism/ChamberPrism_Sprite_02.xml'));
				game.TrackAssets('chamberPrism_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberPrism","ChamberPrismObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
	//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
	//			SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
	//		}
	//		SaveArray['White'] = "No";
	//		(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
			
	//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
	//			SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
	//		}
	//		SaveArray['Solved'] = 'no';
			
	//		(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
			
			
			bg = new Image(this.assets.getTexture('chamberPrism_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			mirror = new Image(this.assets.getTexture('mirror_pos_01'));
			mirror.smoothing = TextureSmoothing.NONE;
			mirror.touchable = false;
			mirror.x = 165;
			mirror.y = 6;
					
			crystal_red = new Image(this.assets.getTexture('red_off'));
			crystal_red.smoothing = TextureSmoothing.NONE;
			crystal_red.touchable = false;
			crystal_red.x = 411;
			crystal_red.y = 217;
			//crystal_blue.smoothing = TextureSmoothing.NONE;
			crystal_blue = new Image(this.assets.getTexture('blue_off'));
			crystal_blue.smoothing = TextureSmoothing.NONE;

			crystal_blue.touchable = false;
			crystal_blue.smoothing = TextureSmoothing.NONE;
			crystal_blue.x = 480;
			crystal_blue.y = 51;

			crystal_green = new Image(this.assets.getTexture('green_off'));
			crystal_green.smoothing = TextureSmoothing.NONE;
			crystal_green.touchable = false;
			crystal_green.x = 140;
			crystal_green.y = 208;
		
			crystal_one = new Image(this.assets.getTexture('d_01_on'));
			crystal_one.smoothing = TextureSmoothing.NONE;
			crystal_one.touchable = false;
			crystal_one.x = 82;
			crystal_one.y = 82;
			
			crystal_two = new Image(this.assets.getTexture('d_02_on'));
			crystal_two.smoothing = TextureSmoothing.NONE;
			crystal_two.touchable = false;
			crystal_two.x = 282;
			crystal_two.y = 296;
			
			crystal_three = new Image(this.assets.getTexture('d_03_on'));
			crystal_three.smoothing = TextureSmoothing.NONE;
			crystal_three.touchable = false;
			crystal_three.x = 572;
			crystal_three.y = 140;
			
			crystal_four = new Image(this.assets.getTexture('d_04_on'));
			crystal_four.smoothing = TextureSmoothing.NONE;
			crystal_four.touchable = false;
			crystal_four.x = 387;
			crystal_four.y = 18;
			
			crystal_five = new Image(this.assets.getTexture('d_05_off'));
			crystal_five.smoothing = TextureSmoothing.NONE;
			crystal_five.touchable = false;
			crystal_five.x = 320;
			crystal_five.y = 121;
			
			MakeBeamSprite();
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Red'] == 'Attached'){
					RedAttached = true;
					crystal_red.alpha = 1;
				}else{
					crystal_red.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Green'] == 'Attached'){
					GreenAttached = true;
					crystal_green.alpha = 1;
				}else{
					crystal_green.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Blue'] == 'Attached'){
					BlueAttached = true;
					crystal_blue.alpha = 1;
				}else{
					crystal_blue.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Mirror'] == 'Attached'){
					MirrorAttached = true;
					mirror.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorDir'] != undefined){
						MirrorDir = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorDir'];
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
						WhiteAttached = true;
						crystal_five.alpha = 1;
						
					}else{
						crystal_five.alpha = 0;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 0){

						MirrorPos = 0;
						crystal_one.alpha = 1;
						crystal_two.alpha = 0;
						crystal_three.alpha = 0;
						crystal_four.alpha = 0;
				//		crystal_five.alpha = 0;
						beam_01p01.alpha = 1;	
						if(GreenAttached === true){
							beam_01p02.alpha = 0;	
							crystal_green.texture = this.assets.getTexture('green_on');
						}else{
							beam_01p02.alpha = 1;
						}
					
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;						
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						MirrorPos = 1;
						
						crystal_one.alpha = 0;
						crystal_two.alpha = 1;
						crystal_three.alpha = 0;
						crystal_four.alpha = 0;
				//		crystal_five.alpha = 0;
						
						beam_02p01.alpha = 1;	
						if(GreenAttached === true){
							beam_02p02.alpha = 0;	
							crystal_green.texture = this.assets.getTexture('green_on');
						}else{
							beam_02p02.alpha = 1;
						}
						if(RedAttached === true){
							beam_02p03.alpha = 0;	
							crystal_red.texture = this.assets.getTexture('red_on');
						}else{
							crystal_three.alpha = 1;
							beam_02p03.alpha = 1;
						}
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;						
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						MirrorPos = 2;
						beam_05p01.alpha = 1;	
						crystal_one.alpha = 0;
						crystal_two.alpha = 0;
						crystal_three.alpha = 0;
						crystal_four.alpha = 0;
				//		crystal_five.alpha = 0;
						if(RedAttached === true){
							beam_05p02.alpha = 0;	
							crystal_red.texture = this.assets.getTexture('red_on');
						}else{
							beam_05p02.alpha = 1;	
						}
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;						
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						MirrorPos = 3;
						beam_03p01.alpha = 1;	
						crystal_one.alpha = 0;
						crystal_two.alpha = 0;
						crystal_three.alpha = 1;
						crystal_four.alpha = 0;
				//		crystal_five.alpha = 0;
						if(RedAttached === true){
							beam_03p02.alpha = 0;	
							crystal_red.texture = this.assets.getTexture('red_on');
						}else{
							crystal_two.alpha = 1;
							beam_03p02.alpha = 1;	
						}
						if(BlueAttached === true){							
							beam_03p03.alpha = 0;	
							crystal_blue.texture = this.assets.getTexture('blue_on');
						}else{
							
							beam_03p03.alpha = 1;	
						}
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
						
						
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 4){
						MirrorPos = 4;
						beam_04p01.alpha = 1;	
						crystal_one.alpha = 0;
						crystal_two.alpha = 0;
						crystal_three.alpha = 0;
						crystal_four.alpha = 1;
					//	crystal_five.alpha = 0;
						if(BlueAttached === true){							
							beam_04p02.alpha = 0;	
							crystal_blue.texture = this.assets.getTexture('blue_on');
						}else{
							
							beam_04p02.alpha = 1;
						}
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;						
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
					}
					
				}else{
					mirror.alpha = 0;
					crystal_one.alpha = 0;
					crystal_two.alpha = 0;
					crystal_three.alpha = 0;
					crystal_four.alpha = 0;
					crystal_five.alpha = 0;
					
					beam_01p01.alpha = 0;
					beam_01p02.alpha = 0;
					beam_02p01.alpha = 0;
					beam_02p02.alpha = 0;
					beam_02p03.alpha = 0;
					beam_03p01.alpha = 0;
					beam_03p02.alpha = 0;
					beam_03p03.alpha = 0;						
					beam_04p01.alpha = 0;						
					beam_04p02.alpha = 0;						
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
				}
			}else{
				mirror.alpha = 0;
				crystal_red.alpha = 0;
				crystal_blue.alpha = 0;
				crystal_green.alpha = 0;
				
				crystal_one.alpha = 0;
				crystal_two.alpha = 0;
				crystal_three.alpha = 0;
				crystal_four.alpha = 0;
				crystal_five.alpha = 0;
				
				beam_01p01.alpha = 0;
				beam_01p02.alpha = 0;
				beam_02p01.alpha = 0;
				beam_02p02.alpha = 0;
				beam_02p03.alpha = 0;
				beam_03p01.alpha = 0;
				beam_03p02.alpha = 0;
				beam_03p03.alpha = 0;						
				beam_04p01.alpha = 0;						
				beam_04p02.alpha = 0;						
				beam_05p01.alpha = 0;
				beam_05p02.alpha = 0;
			}
			
			
			
			
			this.addChildAt(mirror,1);
			
			this.addChildAt(crystal_one,2);
			this.addChildAt(crystal_two,3);
			this.addChildAt(crystal_three,4);
			this.addChildAt(crystal_four,5);
			this.addChildAt(crystal_five,6);
			
			this.addChildAt(crystal_red,7);
			this.addChildAt(crystal_blue,8);
			this.addChildAt(crystal_green,9);
			
			
	//		MirrorAttached = true;
		//	RedAttached = true
		//	GreenAttached = true
		//	BlueAttached = true;

			
			CreateDiamondHits();
			CreateHitMirror();
			
			
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
		//	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
	//			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Mirror,
	//			'item_Mirror',
	//			'inven_mirror_sm'
	//		);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
		}
		
		private function MakeBeamSprite():void{
			beamSprite = new Sprite();
			beamSprite.touchable = false;
			beamSprite.x = 0;
			beamSprite.y = 0;
			beamSprite.alpha = 1;
			
			beam_01p01 = new Image(this.assets.getTexture('beam_01_p01'));
			beam_01p01.touchable = false;
			beam_01p01.x = 105;
			beam_01p01.y = 32;
					
			beam_01p02 = new Image(this.assets.getTexture('beam_01_p02'));
			beam_01p02.touchable = false;
			beam_01p02.x = 142;
			beam_01p02.y = 206;
			
			beam_02p01 = new Image(this.assets.getTexture('beam_02_p01'));
			beam_02p01.touchable = false;
			beam_02p01.x = 174;
			beam_02p01.y = 35;
			
			beam_02p02 = new Image(this.assets.getTexture('beam_02_p02'));
			beam_02p02.touchable = false;
			beam_02p02.x = 0;
			beam_02p02.y = 90;

			beam_02p03 = new Image(this.assets.getTexture('beam_02_p03'));
			beam_02p03.touchable = false;
			beam_02p03.x = 448;
			beam_02p03.y = 191;
			
			beam_03p01 = new Image(this.assets.getTexture('beam_03_p01'));
			beam_03p01.touchable = false;
			beam_03p01.x = 247;
			beam_03p01.y = 53;
			
			beam_03p02 = new Image(this.assets.getTexture('beam_03_p02'));
			beam_03p02.touchable = false;
			beam_03p02.x = 329;
			beam_03p02.y = 226;

			beam_03p03 = new Image(this.assets.getTexture('beam_03_p03'));
			beam_03p03.touchable = false;
			beam_03p03.x = 494;
			beam_03p03.y = 0;
					
			beam_04p01 = new Image(this.assets.getTexture('beam_04_p01'));
			beam_04p01.touchable = false;
			beam_04p01.x = 235;
			beam_04p01.y = 28;		
			
			beam_04p02 = new Image(this.assets.getTexture('beam_04_p02'));
			beam_04p02.touchable = false;
			beam_04p02.x = 529;
			beam_04p02.y = 57;
			
			beam_05p01  = new Image(this.assets.getTexture('beam_05_p01'));
			beam_05p01.touchable = false;
			beam_05p01.x = 223;
			beam_05p01.y = 38;
			
			beam_05p02  = new Image(this.assets.getTexture('beam_05_p02'));
			beam_05p02.touchable = false;
			beam_05p02.x = 451;
			beam_05p02.y = 223;
			
			beam_06p01  = new Image(this.assets.getTexture('beam_06_p01'));
			beam_06p01.touchable = false;
			beam_06p01.x = 88;
			beam_06p01.y = 9;
			
			beam_06p02  = new Image(this.assets.getTexture('beam_06_p02'));
			beam_06p02.touchable = false;
			beam_06p02.x = 242;
			beam_06p02.y = 0;
			
			beam_01p01.alpha = 0;
			beam_01p02.alpha = 0;
			beam_02p01.alpha = 0;
			beam_02p02.alpha = 0;
			beam_02p03.alpha = 0;
			beam_03p01.alpha = 0;
			beam_03p02.alpha = 0;
			beam_03p03.alpha = 0;
			beam_04p01.alpha = 0;
			beam_04p02.alpha = 0;
			beam_05p01.alpha = 0;
			beam_05p02.alpha = 0;
			beam_06p01.alpha = 0;
			beam_06p02.alpha = 0;
			
			beamSprite.addChildAt(beam_01p01,0);
			beamSprite.addChildAt(beam_01p02,1);
			beamSprite.addChildAt(beam_02p01,2);
			beamSprite.addChildAt(beam_02p02,3);
			beamSprite.addChildAt(beam_02p03,4);
			beamSprite.addChildAt(beam_03p01,5);
			beamSprite.addChildAt(beam_03p02,6);
			beamSprite.addChildAt(beam_03p03,7);
			beamSprite.addChildAt(beam_04p01,8);
			beamSprite.addChildAt(beam_04p02,9);
			beamSprite.addChildAt(beam_05p01,10);
			beamSprite.addChildAt(beam_05p02,11);
			beamSprite.addChildAt(beam_06p01,12);
			beamSprite.addChildAt(beam_06p02,13);
			
			this.addChild(beamSprite);
			/*
			private var beam_01p01:Image;
			private var beam_01p02:Image;
			private var beam_02p01:Image;
			private var beam_02p02:Image;
			private var beam_02p03:Image;
			private var beam_03p01:Image;
			private var beam_03p02:Image;
			private var beam_03p03:Image;
			private var beam_04p01:Image;
			private var beam_04p02:Image;
			private var beam_05p01:Image;
			private var beam_05p02:Image;
			private var beam_06p01:Image;
			private var beam_06p02:Image;
			
			private var beamSprite:Sprite;
			*/
			
			
		}
		
		private function CreateHitMirror():void{
			hit_mirror = new Shape();
			hit_mirror.touchable = false;
			hit_mirror.graphics.beginFill(0xff0000);
			
			hit_mirror.graphics.lineTo(157,0);
			hit_mirror.graphics.lineTo(351,0);	
			hit_mirror.graphics.lineTo(370,112);
			hit_mirror.graphics.lineTo(227,161);
			hit_mirror.graphics.lineTo(200,152);
			hit_mirror.graphics.lineTo(157,20);												
																							
			
			hit_mirror.graphics.endFill(false);
			hit_mirror.alpha = 0.0;
			
			hit_mirror.graphics.precisionHitTest = true;	
			this.addChild(hit_mirror);
		}
		
		private function CreateDiamondHits():void{
			
			hit_red = new Shape();
			hit_red.touchable = false;
			hit_red.graphics.beginFill(0xff0000);
			
			hit_red.graphics.lineTo(423,279);												
			hit_red.graphics.lineTo(482,264);												
			hit_red.graphics.lineTo(560,306);												
			hit_red.graphics.lineTo(517,387);												
			hit_red.graphics.lineTo(422,360);												
			
			hit_red.graphics.endFill(false);
			hit_red.alpha = 0.0;
			
			hit_red.graphics.precisionHitTest = true;	
			this.addChild(hit_red);
			
			
			hit_green = new Shape();
			hit_green.touchable = false;
			hit_green.graphics.beginFill(0xff0000);
			
			hit_green.graphics.lineTo(167,296);																					
			hit_green.graphics.lineTo(256,267);																					
			hit_green.graphics.lineTo(270,325);																					
			hit_green.graphics.lineTo(240,371);																					
			hit_green.graphics.lineTo(178,352);																					
			
			hit_green.graphics.endFill(false);
			hit_green.alpha = 0.0;
			
			hit_green.graphics.precisionHitTest = true;	
			this.addChild(hit_green);
			
			
			hit_blue = new Shape();
			hit_blue.touchable = false;
			hit_blue.graphics.beginFill(0xff0000);
			
			hit_blue.graphics.lineTo(501,114);																					
			hit_blue.graphics.lineTo(580,101);																					
			hit_blue.graphics.lineTo(598,148);																					
			hit_blue.graphics.lineTo(568,161);																					
			hit_blue.graphics.lineTo(563,181);																					
			hit_blue.graphics.lineTo(501,156);																					
		
			hit_blue.graphics.endFill(false);
			hit_blue.alpha = 0.0;
			
			hit_blue.graphics.precisionHitTest = true;	
			this.addChild(hit_blue);
			
			hit_white = new Shape();
			hit_white.touchable = false;
			hit_white.graphics.beginFill(0xff0000);
			
			hit_white.graphics.lineTo(310,213);																					
			hit_white.graphics.lineTo(379,181);																					
			hit_white.graphics.lineTo(435,218);																					
			hit_white.graphics.lineTo(394,283);																					
			hit_white.graphics.lineTo(320,266);																					
		
			hit_white.graphics.endFill(false);
			hit_white.alpha = 0.0;
			
			hit_white.graphics.precisionHitTest = true;	
			this.addChild(hit_white);
			
			
			hit_d_01 = new Shape();
			hit_d_01.touchable = false;
			hit_d_01.graphics.beginFill(0xff0000);
			
			hit_d_01.graphics.lineTo(50,111);																					
			hit_d_01.graphics.lineTo(135,67);																					
			hit_d_01.graphics.lineTo(170,106);																					
			hit_d_01.graphics.lineTo(223,197);																					
			hit_d_01.graphics.lineTo(135,232);																					
			hit_d_01.graphics.lineTo(72,142);																					

			hit_d_01.graphics.endFill(false);
			hit_d_01.alpha = 0.0;
			
			hit_d_01.graphics.precisionHitTest = true;	
			this.addChild(hit_d_01);
			
			hit_d_02 = new Shape();
			hit_d_02.touchable = false;
			hit_d_02.graphics.beginFill(0xff0000);
			
			hit_d_02.graphics.lineTo(276,318);																					
			hit_d_02.graphics.lineTo(341,291);																					
			hit_d_02.graphics.lineTo(388,337);																					
			hit_d_02.graphics.lineTo(405,394);																					
			hit_d_02.graphics.lineTo(375,453);																					
			hit_d_02.graphics.lineTo(309,440);																					
			hit_d_02.graphics.lineTo(275,379);																																		
			
			hit_d_02.graphics.endFill(false);
			hit_d_02.alpha = 0.0;
			
			hit_d_02.graphics.precisionHitTest = true;	
			this.addChild(hit_d_02);
			
			hit_d_03 = new Shape();
			hit_d_03.touchable = false;
			hit_d_03.graphics.beginFill(0xff0000);
			
			hit_d_03.graphics.lineTo(566,232);																					
			hit_d_03.graphics.lineTo(576,158);																					
			hit_d_03.graphics.lineTo(630,135);																					
			hit_d_03.graphics.lineTo(675,165);																					
			hit_d_03.graphics.lineTo(647,301);																					
			hit_d_03.graphics.lineTo(578,283);																					

			hit_d_03.graphics.endFill(false);
			hit_d_03.alpha = 0.0;
			
			hit_d_03.graphics.precisionHitTest = true;	
			this.addChild(hit_d_03);
			
			hit_d_04 = new Shape();
			hit_d_04.touchable = false;
			hit_d_04.graphics.beginFill(0xff0000);
			
			hit_d_04.graphics.lineTo(382,26);																					
			hit_d_04.graphics.lineTo(436,11);																					
			hit_d_04.graphics.lineTo(468,40);																					
			hit_d_04.graphics.lineTo(478,127);																					
			hit_d_04.graphics.lineTo(445,151);																					
			hit_d_04.graphics.lineTo(385,134);																					

			hit_d_04.graphics.endFill(false);
			hit_d_04.alpha = 0.0;
			
			hit_d_04.graphics.precisionHitTest = true;	
			this.addChild(hit_d_04);
			
			/*
			private var hit_d_01:Shape;
			private var hit_d_02:Shape;
			private var hit_d_03:Shape;
			private var hit_d_04:Shape;
			*/
		
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((Chamber as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
							);
						}
						else if(hit_mirror.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							trace("Mirror hit");
							if(MirrorAttached === false){
								MirrorAttacher();
							}else{
								MirrorHandler();
							}
						}else if(hit_red.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							RedHandler();
						}else if(hit_green.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							GreenHandler();
						}else if(hit_blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							BlueHandler();
						}else if(hit_white.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							WhiteHandler();
						}else if(hit_d_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
								soundBool = false;
							}
						}else if(hit_d_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
								soundBool = false;
							}
						}else if(hit_d_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
								soundBool = false;
							}
						}else if(hit_d_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
								soundBool = false;
							}
						}
						
						/*
						
						*/
					}
				}
			}
		}
		
		private function WhiteHandler():void{
			//item_CrystalRed
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalWhite)
			{
				WhiteAttached = true;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				
				if(MirrorPos == 2){
					crystal_green.texture = this.assets.getTexture('green_on');
					crystal_red.texture = this.assets.getTexture('red_on');
					crystal_blue.texture = this.assets.getTexture('blue_on');
					crystal_five.texture = this.assets.getTexture('d_05_on');
					crystal_one.alpha = 1;
					crystal_two.alpha = 1;
					crystal_three.alpha = 1;
					crystal_four.alpha = 1;
					crystal_five.alpha = 1;
					
					beam_01p01.alpha = 0;
					beam_01p02.alpha = 0;	
					beam_02p01.alpha = 0;
					beam_02p02.alpha = 0;				
					beam_02p02.alpha = 0;
					beam_02p03.alpha = 0;
					beam_03p01.alpha = 0;
					beam_03p02.alpha = 0;
					beam_03p03.alpha = 0;
					beam_04p01.alpha = 0;
					beam_04p02.alpha = 0;
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
					beam_06p01.alpha = 1;
					beam_06p02.alpha = 0;
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					
					Solve();
				}else{
					crystal_five.alpha = 1;
				}				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
				}
				SaveArray['White'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_CrystalWhite,
						"item_CrystalWhite"
					);
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Marble)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some force is pushing the petrified wood piece away.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalRed)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The red crystal can't fit there.")
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalBlue)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The blue crystal won't go in the hole.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalGreen)
			{	
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The green crystal doesn't fit that hole.");
			}else{
				if(WhiteAttached === true){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
						soundBool = false;
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks as though there is room for another crystal.");
				}
				
			}
			
			
		}
		
		
		private function BlueHandler():void{
			//item_CrystalRed
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalBlue)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				BlueAttached = true;
				
				
				if(MirrorPos == 3){
					if(soundBool === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = true;
					}else{
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = false;
					}
					beam_03p03.alpha = 0;
					crystal_green.texture = this.assets.getTexture('blue_on');
				}else if(MirrorPos == 4){
					if(soundBool === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = true;
					}else{
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = false;
					}
					beam_04p02.alpha = 0;
					crystal_red.texture = this.assets.getTexture('blue_on');
				}else{
					
				}
				crystal_blue.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
				}
				SaveArray['Blue'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_CrystalBlue,
						"item_CrystalBlue"
					);
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Marble)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pedestal repels the petrified block.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalRed)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The red crystal doesn't fit in that hole.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalGreen)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The green crystal doesn't match there.");
					
			}else{
				if(BlueAttached === true){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
						soundBool = false;
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stone surrounding the hole is warm.");
				}
				
			}
			
			
		}
		
		
		private function GreenHandler():void{
			//item_CrystalRed
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalGreen)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				GreenAttached = true;
				
				
				if(MirrorPos == 1){
					if(soundBool === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = true;
					}else{
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = false;
					}
					beam_02p02.alpha = 0;
					crystal_green.texture = this.assets.getTexture('green_on');
				}else if(MirrorPos == 2){
					if(soundBool === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = true;
					}else{
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						soundBool = false;
					}
					beam_01p02.alpha = 0;
					crystal_red.texture = this.assets.getTexture('red_on');
				}else{
					
				}
				crystal_green.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
				}
				SaveArray['Green'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_CrystalGreen,
						"item_CrystalGreen"
					);
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Marble)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The piece of petrified wood won't go in.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalRed)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The red crystal won't fit in...");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalBlue)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The blue crystal won't go in the hole.");
					
			}else{
				if(GreenAttached === true){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
						soundBool = false;
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole extends deep down into the stone pedestal.");
				}
				
			}
			
			
		}
		
		
		private function MirrorAttacher():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Mirror)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				MirrorAttached = true;
				mirror.alpha = 1;
				beam_05p01.alpha = 1;
				if(RedAttached === true){	
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					crystal_red.texture = this.assets.getTexture('red_on');
					beam_05p02.alpha = 0;
				}else{	
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					beam_05p02.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
				}
				SaveArray['Mirror'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Mirror,
						"item_Mirror"
					);
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A beam of light is shining down here.");
			}
		}
		
		private function RedHandler():void{
			//item_CrystalRed
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CrystalRed)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
				RedAttached = true;
				
				
				if(MirrorPos == 1){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					beam_02p03.alpha = 0;
					crystal_red.texture = this.assets.getTexture('red_on');
				}else if(MirrorPos == 2){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					beam_05p02.alpha = 0;
					crystal_red.texture = this.assets.getTexture('red_on');
				}else{
					
				}
				crystal_red.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
				}
				SaveArray['Red'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_CrystalRed,
						"item_CrystalRed"
					);
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Marble)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wooden stone refuses to enter the hole....");
				
			}else{
				if(RedAttached === true){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPingTwo();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalPing();
						soundBool = false;
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hole is a near perfect pentagon.");
				}
				
			}
				
			
		}
		
		private function MirrorHandler():void{
			trace("Mirror Handler");		

		
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
			if(MirrorPos == 0){
				MirrorDir = true;
				MirrorPos = 1;

				mirror.texture = this.assets.getTexture('mirror_pos_01');
				crystal_green.texture = this.assets.getTexture('green_on');
				crystal_red.texture = this.assets.getTexture('red_on');
				
				crystal_one.alpha = 0;
				crystal_two.alpha = 1;
				crystal_three.alpha = 0;
				crystal_four.alpha = 0;
			//	crystal_five.alpha = 0;
				
				beam_01p01.alpha = 0;
				beam_01p02.alpha = 0;	
				beam_02p01.alpha = 1;
				if(GreenAttached === true){	
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					beam_02p02.alpha = 0;
				}else{	
					beam_02p02.alpha = 1;
				}
				if(RedAttached === true){
					if(GreenAttached === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
					}
					beam_02p03.alpha = 0;
				}else{
					beam_02p03.alpha = 1;
				}
				beam_03p01.alpha = 0;
				beam_03p02.alpha = 0;
				beam_03p03.alpha = 0;
				beam_04p01.alpha = 0;
				beam_04p02.alpha = 0;
				beam_05p01.alpha = 0;
				beam_05p02.alpha = 0;
				
				
			}else if(MirrorPos == 1){
				if(MirrorDir === true){
					MirrorPos = 2;

					mirror.texture = this.assets.getTexture('mirror_pos_02');					
					crystal_green.texture = this.assets.getTexture('green_off');
					crystal_red.texture = this.assets.getTexture('red_on');
					crystal_five.texture = this.assets.getTexture('d_05_on');
					if(WhiteAttached === true){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						
						crystal_one.alpha = 1;
						crystal_two.alpha = 1;
						crystal_three.alpha = 1;
						crystal_four.alpha = 1;
						crystal_five.alpha = 1;
						
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;	
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
						beam_06p01.alpha = 1;
						
						Solve();
						
					}else{
						crystal_one.alpha = 0;
						crystal_two.alpha = 0;
						crystal_three.alpha = 0;
						crystal_four.alpha = 0;
				//		crystal_five.alpha = 0;
						
						
						beam_01p01.alpha = 0;						
						beam_01p02.alpha = 0;		
						beam_01p02.alpha = 0;					
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						
						beam_05p01.alpha = 1;
						if(RedAttached === true){	
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
								soundBool = false;
							}
							beam_05p02.alpha = 0;
						}else{	
							beam_05p02.alpha = 1;
						}
					}
				
					
				}else{
					MirrorPos = 0;
					
					mirror.texture = this.assets.getTexture('mirror_pos_00');
					crystal_green.texture = this.assets.getTexture('green_on');
					crystal_red.texture = this.assets.getTexture('red_off');
					crystal_five.texture = this.assets.getTexture('d_05_off');
					
					crystal_one.alpha = 1;
					crystal_two.alpha = 0;
					crystal_three.alpha = 0;
					crystal_four.alpha = 0;
				//	crystal_five.alpha = 0;
					
					beam_01p01.alpha = 1;
					if(GreenAttached === true){	
						beam_01p02.alpha = 0;		
					}else{	
						beam_01p02.alpha = 1;	
					}
					beam_02p01.alpha = 0;
					beam_02p02.alpha = 0;
					beam_02p03.alpha = 0;
					beam_03p01.alpha = 0;
					beam_03p02.alpha = 0;
					beam_03p03.alpha = 0;
					beam_04p01.alpha = 0;
					beam_04p02.alpha = 0;
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
				}
			}else if(MirrorPos == 2){
				if(MirrorDir === true){
					MirrorPos = 3;
					mirror.texture = this.assets.getTexture('mirror_pos_03');
					crystal_blue.texture = this.assets.getTexture('blue_on');
					crystal_red.texture = this.assets.getTexture('red_on');
					crystal_five.texture = this.assets.getTexture('d_05_off');
					crystal_one.alpha = 0;
					crystal_two.alpha = 0;
					crystal_three.alpha = 1;
					crystal_four.alpha = 0;
			//		crystal_five.alpha = 0;
					
					beam_01p01.alpha = 0;
					beam_01p02.alpha = 0;	
					beam_02p01.alpha = 0;
					beam_02p02.alpha = 0;
					beam_02p03.alpha = 0;
					beam_03p01.alpha = 1;
					
					if(RedAttached === true){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						beam_03p02.alpha = 0;
					}else{
						beam_03p02.alpha = 1;
					}
					if(BlueAttached === true){
						if(RedAttached === false){
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
								soundBool = false;
							}
						}
						beam_03p03.alpha = 0;
					}else{
						beam_03p03.alpha = 1;
					}
					
					beam_04p01.alpha = 0;
					beam_04p02.alpha = 0;
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
					
					
				}else{
					MirrorPos = 1;
					mirror.texture = this.assets.getTexture('mirror_pos_01');
					crystal_green.texture = this.assets.getTexture('green_on');
					crystal_red.texture = this.assets.getTexture('red_on');
					crystal_five.texture = this.assets.getTexture('d_05_off');
					crystal_one.alpha = 0;
					crystal_two.alpha = 1;
					crystal_three.alpha = 0;
					crystal_four.alpha = 0;
				//	crystal_five.alpha = 0;
					
					beam_01p01.alpha = 0;
					beam_01p02.alpha = 0;	
					beam_02p01.alpha = 1;
					if(GreenAttached === true){	
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						beam_02p02.alpha = 0;
					}else{	
						beam_02p02.alpha = 1;
					}
					if(RedAttached === true){
						beam_02p03.alpha = 0;
						if(GreenAttached === false){	
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
								soundBool = false;
							}
						}
					}else{
						beam_02p03.alpha = 1;
					}
					beam_03p01.alpha = 0;
					beam_03p02.alpha = 0;
					beam_03p03.alpha = 0;
					beam_04p01.alpha = 0;
					beam_04p02.alpha = 0;
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
					
				}
			}else if(MirrorPos == 3){
				if(MirrorDir === true){
					MirrorPos = 4;
					mirror.texture = this.assets.getTexture('mirror_pos_04');
					crystal_blue.texture = this.assets.getTexture('blue_on');
					crystal_red.texture = this.assets.getTexture('red_off');
					crystal_five.texture = this.assets.getTexture('d_05_off');
					crystal_one.alpha = 0;
					crystal_two.alpha = 0;
					crystal_three.alpha = 0;
					crystal_four.alpha = 1;
				//	crystal_five.alpha = 0;
					
					beam_01p01.alpha = 0;
					beam_01p02.alpha = 0;		
					beam_02p01.alpha = 0;
					beam_02p02.alpha = 0;
					beam_02p03.alpha = 0;
					beam_03p01.alpha = 0;
					beam_03p02.alpha = 0;
					beam_03p03.alpha = 0;
					beam_04p01.alpha = 1;
					if(BlueAttached === true){	
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						beam_04p02.alpha = 0;
					}else{	
						beam_04p02.alpha = 1;
					}
					
					beam_05p01.alpha = 0;
					beam_05p02.alpha = 0;
					
					
				}else{
					MirrorPos = 2;
					mirror.texture = this.assets.getTexture('mirror_pos_02');
					
					crystal_blue.texture = this.assets.getTexture('blue_off');
					crystal_red.texture = this.assets.getTexture('red_on');
					crystal_five.texture = this.assets.getTexture('d_05_on');
					
					if(WhiteAttached === true){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
						
						crystal_one.alpha = 1;
						crystal_two.alpha = 1;
						crystal_three.alpha = 1;
						crystal_four.alpha = 1;
						crystal_five.alpha = 1;
						
						beam_01p01.alpha = 0;
						beam_01p02.alpha = 0;	
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						beam_05p01.alpha = 0;
						beam_05p02.alpha = 0;
						beam_06p01.alpha = 1;
						
						Solve();
						
					}else{
						crystal_one.alpha = 0;
						crystal_two.alpha = 0;
						crystal_three.alpha = 0;
						crystal_four.alpha = 0;
					//	crystal_five.alpha = 0;
						
						beam_01p01.alpha = 0;						
						beam_01p02.alpha = 0;		
						beam_01p02.alpha = 0;					
						beam_02p01.alpha = 0;
						beam_02p02.alpha = 0;
						beam_02p03.alpha = 0;
						beam_03p01.alpha = 0;
						beam_03p02.alpha = 0;
						beam_03p03.alpha = 0;
						beam_04p01.alpha = 0;
						beam_04p02.alpha = 0;
						
						beam_05p01.alpha = 1;
						if(RedAttached === true){	
							if(soundBool === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
								soundBool = true;
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
								soundBool = false;
							}
							beam_05p02.alpha = 0;
						}else{	
							beam_05p02.alpha = 1;
						}
					}
					
				}	
			}else if(MirrorPos == 4){
				
				crystal_one.alpha = 0;
				crystal_two.alpha = 0;
				crystal_three.alpha = 1;
				crystal_four.alpha = 0;
			//	crystal_five.alpha = 0;
				
				MirrorDir = false;
				MirrorPos = 3;
				mirror.texture = this.assets.getTexture('mirror_pos_03');
				crystal_blue.texture = this.assets.getTexture('blue_on');
				crystal_red.texture = this.assets.getTexture('red_on');
				crystal_five.texture = this.assets.getTexture('d_05_off');
				
				beam_01p01.alpha = 0;
				beam_01p02.alpha = 0;	
				beam_02p01.alpha = 0;
				beam_02p02.alpha = 0;
				beam_02p03.alpha = 0;
				beam_03p01.alpha = 1;
				
				if(RedAttached === true){
					if(soundBool === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
						soundBool = true;
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
						soundBool = false;
					}
					beam_03p02.alpha = 0;
				}else{
					beam_03p02.alpha = 1;
				}
				if(BlueAttached === true){
					if(RedAttached === false){
						if(soundBool === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWave();
							soundBool = true;
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CrystalWaveTwo();
							soundBool = false;
						}
					}
					beam_03p03.alpha = 0;
				}else{
					beam_03p03.alpha = 1;
				}
				
				beam_04p01.alpha = 0;
				beam_04p02.alpha = 0;
				beam_05p01.alpha = 0;
				beam_05p02.alpha = 0;
				
			}
			
			trace("MirrorPos: "+MirrorPos);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
			}
			SaveArray['MirrorPos'] = MirrorPos;
			SaveArray['MirrorDir'] = MirrorDir;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
		}
		
		
		private function Solve():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
			

			Animating = true;
			trace("SOLVING!!!!");
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism;
			}
			SaveArray['Solved'] = 'Yes';
		
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberPrism',SaveArray);
			
			delayedCall = new DelayedCall(FadeEndBeam,1);
			Starling.juggler.add(delayedCall);
		}
		
		private function FadeEndBeam():void{
			(stage.getChildAt(0) as Object).MusicObj.LoadLightBeam(true,0);
			EndBeamTween = new Tween(beam_06p02, 3, Transitions.EASE_IN_OUT_BOUNCE);
			EndBeamTween.fadeTo(1);
			EndBeamTween.onComplete = function():void{
				ChangeRoom();	
			}
			Starling.juggler.add(EndBeamTween);
		}
		
		private function ChangeRoom():void{
			EndBeamTween = null;
			
			delayedCall = new DelayedCall(function():void{
				
				FadeOut(Chamber,(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true);
				Animating = false;
			},1);
			Starling.juggler.add(delayedCall);
			
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
			
			
			this.assets.removeTexture("chamberPrism_bg",true);
			this.assets.removeTexture("ChamberPrism_Sprite_01",true);
			this.assets.removeTextureAtlas("ChamberPrism_Sprite_01",true);
			this.assets.removeTexture("ChamberPrism_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberPrism_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberPrism_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberPrism_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberPrism_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberPrism_04");
			(stage.getChildAt(0) as Object).falseAsset("chamberPrism_05");
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