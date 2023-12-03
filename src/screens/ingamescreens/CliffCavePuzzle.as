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

	public class CliffCavePuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var seal:Image;
		
		private var disc_01:Image;
		private var disc_02:Image;
		private var disc_03:Image;
		private var disc_04:Image;
		
		private var cover:Image;
		
		private var hit_center:Shape;
		
		private var hit_disc_01_right:Shape;
		private var hit_disc_01_left:Shape;
		private var hit_disc_02_right:Shape;
		private var hit_disc_02_left:Shape;	
		private var hit_disc_03_right:Shape;
		private var hit_disc_03_left:Shape;
		private var hit_disc_04_right:Shape;
		private var hit_disc_04_left:Shape;
		
		private var disc_01_Tween:Tween;
		private var disc_02_Tween:Tween;
		private var disc_03_Tween:Tween;
		private var disc_04_Tween:Tween;
		
		private var disc_01_pos:int = 0;
		private var disc_02_pos:int = 0;
		private var disc_03_pos:int = 0;
		private var disc_04_pos:int = 0;		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		private var Disc_01_Animating:Boolean = false;
		private var Disc_02_Animating:Boolean = false;
		private var Disc_03_Animating:Boolean = false;
		private var Disc_04_Animating:Boolean = false;
		private var SealAttached:Boolean = false;
		private var Solved:Boolean = false;
		
		public var delayedcall:DelayedCall;
		
		private var goback:GoBackButton;
		
		public function CliffCavePuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cliffCavePuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCavePuzzle/cliffCavePuzzle_bg.jpg'));
				game.TrackAssets('cliffCavePuzzle_01');
			}
			if(game.CheckAsset('cliffCavePuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCavePuzzle/CliffCavePuzzle_Sprite.png'));
				game.TrackAssets('cliffCavePuzzle_02');
			}
			if(game.CheckAsset('cliffCavePuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCavePuzzle/CliffCavePuzzle_Sprite.xml'));
				game.TrackAssets('cliffCavePuzzle_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CliffCavePuzzle","CliffCavePuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cliffCavePuzzle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			seal = new Image(this.assets.getTexture('seal'));
			seal.touchable = false;
			seal.x = 334;
			seal.y = 372;
		
			
			disc_01 = new Image(this.assets.getTexture('disc_01'));
			disc_01.touchable = false;
		//	disc_01.pivotX = 427;
		//	disc_01.pivotY = 427;
			disc_01.pivotX = 432.5;
			disc_01.pivotY = 432.5;
			disc_01.x = 403;
			disc_01.y = 433;
		
			
			disc_02 = new Image(this.assets.getTexture('disc_02'));
			disc_02.touchable = false;
			disc_02.pivotX = 331;
			disc_02.pivotY = 331;
			disc_02.x = 403;
			disc_02.y = 433;
		
			
			disc_03 = new Image(this.assets.getTexture('disc_03'));
			disc_03.touchable = false;
			disc_03.pivotX = 232;
			disc_03.pivotY = 232;
			disc_03.x = 403;
			disc_03.y = 435;
		
			
			disc_04 = new Image(this.assets.getTexture('disc_04'));
			disc_04.touchable = false;
			disc_04.pivotX = 141;
			disc_04.pivotY = 141;
			disc_04.x = 403;
			disc_04.y = 438;
		
			
			cover = new Image(this.assets.getTexture('cover'));
			cover.touchable = false;
			cover.x = 0;
			cover.y = 0;
			//cover.y = 333;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_04'] == 'pos_is_0'){
					disc_04.rotation = 0;
					disc_04_pos = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_04'] == 'pos_is_1'){
					disc_04.rotation = deg2rad(72);
					disc_04_pos = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_04'] == 'pos_is_2'){
					disc_04.rotation = deg2rad(144);
					disc_04_pos = 2;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_04'] == 'pos_is_3'){
					disc_04.rotation = deg2rad(216);
					disc_04_pos = 3;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_04'] == 'pos_is_4'){
					disc_04.rotation = deg2rad(288);
					disc_04_pos = 4;
				}else{
					disc_04.rotation = 0;
					disc_04_pos = 0;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_03'] == 'pos_is_0'){
					disc_03.rotation = 0;
					disc_03_pos = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_03'] == 'pos_is_1'){
					disc_03.rotation = deg2rad(72);
					disc_03_pos = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_03'] == 'pos_is_2'){
					disc_03.rotation = deg2rad(144);
					disc_03_pos = 2;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_03'] == 'pos_is_3'){
					disc_03.rotation = deg2rad(216);
					disc_03_pos = 3;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_03'] == 'pos_is_4'){
					disc_03.rotation = deg2rad(288);
					disc_03_pos = 4;
				}else{
					disc_03.rotation = 0;
					disc_03_pos = 0;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_02'] == 'pos_is_0'){
					disc_02.rotation = 0;
					disc_02_pos = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_02'] == 'pos_is_1'){
					disc_02.rotation = deg2rad(72);
					disc_02_pos = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_02'] == 'pos_is_2'){
					disc_02.rotation = deg2rad(144);
					disc_02_pos = 2;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_02'] == 'pos_is_3'){
					disc_02.rotation = deg2rad(216);
					disc_02_pos = 3;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_02'] == 'pos_is_4'){
					disc_02.rotation = deg2rad(288);
					disc_02_pos = 4;
				}else{
					disc_02.rotation = 0;
					disc_02_pos = 0;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_01'] == 'pos_is_0'){
					disc_01.rotation = 0;
					disc_01_pos = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_01'] == 'pos_is_1'){
					disc_01.rotation = deg2rad(72);
					disc_01_pos = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_01'] == 'pos_is_2'){
					disc_01.rotation = deg2rad(144);
					disc_01_pos = 2;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_01'] == 'pos_is_3'){
					disc_01.rotation = deg2rad(216);
					disc_01_pos = 3;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['disc_01'] == 'pos_is_4'){
					disc_01.rotation = deg2rad(288);
					disc_01_pos = 4;
				}else{
					disc_01.rotation = 0;
					disc_01_pos = 0;
				}
		
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['Seal'] == 'Attached'){
					seal.alpha = 1;
					SealAttached = true;
				}else{
					seal.alpha = 0;
				}
				
				
			}else{
				seal.alpha = 0;
			}
			
			
			
			
			
			cover.alpha = 1;
			disc_01.alpha = 1;
			disc_02.alpha = 1;
			disc_03.alpha = 1;
			disc_04.alpha = 1;

			this.addChildAt(seal,1);	
			this.addChildAt(disc_01,2);
			this.addChildAt(disc_02,3);
			this.addChildAt(disc_03,4);
			this.addChildAt(disc_04,5);
			this.addChildAt(cover,6);
			//FadeOutOcean(1);
			CreateHitCenter();
			CreateDiscHits();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waterfall",((stage.getChildAt(0) as Object).MusicObj.globalVol/2),1.0);
			},0.7);

		}
		
		private function CreateHitCenter():void{
			hit_center = new Shape();
			hit_center.touchable = false;
			hit_center.graphics.beginFill(0xff0000);
			
			hit_center.graphics.lineTo(322,430);	
			hit_center.graphics.lineTo(348,385);	
			hit_center.graphics.lineTo(398,362);	
			hit_center.graphics.lineTo(441,376);	
			hit_center.graphics.lineTo(471,423);	
			hit_center.graphics.lineTo(472,456);	
			hit_center.graphics.lineTo(448,497);	
			hit_center.graphics.lineTo(405,508);	
			hit_center.graphics.lineTo(353,497);	
			hit_center.graphics.lineTo(326,455);	

			hit_center.graphics.endFill(false);
			hit_center.alpha = 0.0;
			
			hit_center.graphics.precisionHitTest = true;	
			this.addChild(hit_center);
		}
		
		
		
		private function CreateDiscHits():void{
			hit_disc_01_left = new Shape();
			hit_disc_01_left.touchable = false;
			hit_disc_01_left.graphics.beginFill(0x00ff00);
			
			hit_disc_01_left.graphics.lineTo(0,252);	
			hit_disc_01_left.graphics.lineTo(70,128);	
			hit_disc_01_left.graphics.lineTo(167,50);	
			hit_disc_01_left.graphics.lineTo(295,0);	
			hit_disc_01_left.graphics.lineTo(400,0);	
			hit_disc_01_left.graphics.lineTo(400,94);	
			hit_disc_01_left.graphics.lineTo(282,117);	
			hit_disc_01_left.graphics.lineTo(183,174);	
			hit_disc_01_left.graphics.lineTo(108,260);	
			hit_disc_01_left.graphics.lineTo(68,348);	
			hit_disc_01_left.graphics.lineTo(0,328);	

			hit_disc_01_left.graphics.endFill(false);
			hit_disc_01_left.alpha = 0.0;
			hit_disc_01_left.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_01_left);
			
			
			hit_disc_01_right = new Shape();
			hit_disc_01_right.touchable = false;
			hit_disc_01_right.graphics.beginFill(0x00ff00);
			
			hit_disc_01_right.graphics.lineTo(400,0);	
			hit_disc_01_right.graphics.lineTo(499,0);	
			hit_disc_01_right.graphics.lineTo(620,44);	
			hit_disc_01_right.graphics.lineTo(726,128);	
			hit_disc_01_right.graphics.lineTo(800,228);	
			hit_disc_01_right.graphics.lineTo(800,325);	
			hit_disc_01_right.graphics.lineTo(733,346);	
			hit_disc_01_right.graphics.lineTo(660,210);	
			hit_disc_01_right.graphics.lineTo(521,115);	
			hit_disc_01_right.graphics.lineTo(400,94);	

			hit_disc_01_right.graphics.endFill(false);
			hit_disc_01_right.alpha = 0.0;
			hit_disc_01_right.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_01_right);
			
			
			hit_disc_02_left = new Shape();
			hit_disc_02_left.touchable = false;
			hit_disc_02_left.graphics.beginFill(0x00ff00);
			
			hit_disc_02_left.graphics.lineTo(71,346);	
			hit_disc_02_left.graphics.lineTo(110,258);	
			hit_disc_02_left.graphics.lineTo(184,175);	
			hit_disc_02_left.graphics.lineTo(285,117);	
			hit_disc_02_left.graphics.lineTo(400,95);	
			hit_disc_02_left.graphics.lineTo(400,194);	
			hit_disc_02_left.graphics.lineTo(299,216);	
			hit_disc_02_left.graphics.lineTo(299,216);	
			hit_disc_02_left.graphics.lineTo(221,272);	
			hit_disc_02_left.graphics.lineTo(174,348);	
			hit_disc_02_left.graphics.lineTo(166,377);	

			
			hit_disc_02_left.graphics.endFill(false);
			hit_disc_02_left.alpha = 0.0;
			hit_disc_02_left.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_02_left);
			
			
			hit_disc_02_right = new Shape();
			hit_disc_02_right.touchable = false;
			hit_disc_02_right.graphics.beginFill(0x00ff00);
			
			hit_disc_02_right.graphics.lineTo(400,95);	
			hit_disc_02_right.graphics.lineTo(518,116);	
			hit_disc_02_right.graphics.lineTo(653,208);	
			hit_disc_02_right.graphics.lineTo(730,348);	
			hit_disc_02_right.graphics.lineTo(633,375);	
			hit_disc_02_right.graphics.lineTo(599,293);	
			hit_disc_02_right.graphics.lineTo(521,225);	
			hit_disc_02_right.graphics.lineTo(430,196);	
			hit_disc_02_right.graphics.lineTo(400,194);	

			hit_disc_02_right.graphics.endFill(false);
			hit_disc_02_right.alpha = 0.0;
			hit_disc_02_right.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_02_right);
			
			
			hit_disc_03_left = new Shape();
			hit_disc_03_left.touchable = false;
			hit_disc_03_left.graphics.beginFill(0x00ff00);
			
			hit_disc_03_left.graphics.lineTo(170,375);	
			hit_disc_03_left.graphics.lineTo(179,346);	
			hit_disc_03_left.graphics.lineTo(226,270);	
			hit_disc_03_left.graphics.lineTo(300,216);	
			hit_disc_03_left.graphics.lineTo(400,195);	
			hit_disc_03_left.graphics.lineTo(400,285);	
			hit_disc_03_left.graphics.lineTo(338,296);	
			hit_disc_03_left.graphics.lineTo(283,337);	
			hit_disc_03_left.graphics.lineTo(251,398);	
			
			hit_disc_03_left.graphics.endFill(false);
			
			hit_disc_03_left.alpha = 0.0;
			hit_disc_03_left.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_03_left);
			
			
			hit_disc_03_right = new Shape();
			hit_disc_03_right.touchable = false;
			hit_disc_03_right.graphics.beginFill(0x00ff00);
			
			hit_disc_03_right.graphics.lineTo(400,193);	
			hit_disc_03_right.graphics.lineTo(430,196);	
			hit_disc_03_right.graphics.lineTo(518,225);	
			hit_disc_03_right.graphics.lineTo(595,291);	
			hit_disc_03_right.graphics.lineTo(626,371);	
			hit_disc_03_right.graphics.lineTo(546,395);	
			hit_disc_03_right.graphics.lineTo(516,340);	
			hit_disc_03_right.graphics.lineTo(467,300);	
			hit_disc_03_right.graphics.lineTo(400,284);	

			
			hit_disc_03_right.graphics.endFill(false);
			hit_disc_03_right.alpha = 0.0;
			hit_disc_03_right.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_03_right);
			
			
			hit_disc_04_left = new Shape();
			hit_disc_04_left.touchable = false;
			hit_disc_04_left.graphics.beginFill(0x00ff00);
			
			hit_disc_04_left.graphics.lineTo(253,394);	
			hit_disc_04_left.graphics.lineTo(285,334);	
			hit_disc_04_left.graphics.lineTo(337,298);	
			hit_disc_04_left.graphics.lineTo(400,285);	
			hit_disc_04_left.graphics.lineTo(400,359);	
			hit_disc_04_left.graphics.lineTo(348,384);	
			hit_disc_04_left.graphics.lineTo(326,421);	

			hit_disc_04_left.graphics.endFill(false);
			
			hit_disc_04_left.alpha = 0.0;
			hit_disc_04_left.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_04_left);
			
			
			hit_disc_04_right = new Shape();
			hit_disc_04_right.touchable = false;
			hit_disc_04_right.graphics.beginFill(0x00ff00);
			
			hit_disc_04_right.graphics.lineTo(400,283);	
			hit_disc_04_right.graphics.lineTo(464,300);	
			hit_disc_04_right.graphics.lineTo(513,341);	
			hit_disc_04_right.graphics.lineTo(542,400);	
			hit_disc_04_right.graphics.lineTo(474,420);	
			hit_disc_04_right.graphics.lineTo(445,373);	
			hit_disc_04_right.graphics.lineTo(400,359);	
			
			hit_disc_04_right.graphics.endFill(false);
			hit_disc_04_right.alpha = 0.0;
			hit_disc_04_right.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_04_right);
			
			
		}

		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							if(Disc_01_Animating === false){
								if(Disc_02_Animating === false){
									if(Disc_03_Animating === false){
										if(Disc_04_Animating === false){	
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
											FadeOut((CliffCave as Class), 
												(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true
											);
										}
									}
								}	
							}
						}else if(hit_center.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CenterHandler();
						}else if(hit_disc_01_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_01_Animating === false){
								Disc_01_Handler(true);
							}
						}else if(hit_disc_01_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_01_Animating === false){
								Disc_01_Handler(false);
							}
						}else if(hit_disc_02_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_02_Animating === false){
								Disc_02_Handler(true);
							}
						}else if(hit_disc_02_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_02_Animating === false){
								Disc_02_Handler(false);
							}
						}else if(hit_disc_03_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_03_Animating === false){
								Disc_03_Handler(true);
							}
						}else if(hit_disc_03_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_03_Animating === false){
								Disc_03_Handler(false);
							}
						}else if(hit_disc_04_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_04_Animating === false){
								Disc_04_Handler(true);
							}
						}else if(hit_disc_04_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Disc_04_Animating === false){
								Disc_04_Handler(false);
							}
						}
					}
				}
			}
		}
		private function CenterHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle["Seal"] == "Attached"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The design on the cylinder matches the designs of the spinning discs.");
				}else{
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Seal)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
						seal.alpha = 1;
						SealAttached = true;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
						}
						SaveArray['Seal'] = 'Attached';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
						
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Seal,
								"item_Seal"
							);
						
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a cylindrical hole in the seal.");
					}
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Seal)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
					seal.alpha = 1;
					SealAttached = true;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
					}
					SaveArray['Seal'] = 'Attached';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Seal,
							"item_Seal"
						);
					
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a cylindrical alcove in the seal.");
				}
			}
		
		}
		
		
		private function Disc_04_Handler(LeftRight:Boolean):void{
			/*
			Left = true  /  Right = false
			*/
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
			if(LeftRight === true){
				
				Disc_04_Animating = true;
				
				if(disc_04_pos == 0){
					disc_04_pos = 4;
				}else{
					disc_04_pos = disc_04_pos-1;
				}
				
				
				disc_04_Tween = new Tween(disc_04, 1, Transitions.EASE_IN_OUT);
				disc_04_Tween.animate("rotation", disc_04.rotation+deg2rad(-72));
				disc_04_Tween.onComplete = function():void{
					Disc_04_Animating = false;
					Solve();
					disc_04_Tween = null;
				}
				Starling.juggler.add(disc_04_Tween);
			}else{
				
				if(disc_04_pos == 4){
					disc_04_pos = 0;
				}else{
					disc_04_pos = disc_04_pos+1;
				}
				
				Disc_04_Animating = true;
				disc_04_Tween = new Tween(disc_04, 1, Transitions.EASE_IN_OUT);
				disc_04_Tween.animate("rotation", disc_04.rotation+deg2rad(72));
				disc_04_Tween.onComplete = function():void{
					Disc_04_Animating = false;
					Solve();
					disc_04_Tween = null;
				}
				Starling.juggler.add(disc_04_Tween);
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
			}
			SaveArray['disc_04'] = 'pos_is_'+disc_04_pos;
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
			
			trace("Disc_04_pos: "+disc_04_pos);
			
		}
		
		
		private function Disc_03_Handler(LeftRight:Boolean):void{
			/*
			Left = true  /  Right = false
			*/
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
			if(LeftRight === true){
				
				Disc_03_Animating = true;
				
				if(disc_03_pos == 0){
					disc_03_pos = 4;
				}else{
					disc_03_pos = disc_03_pos-1;
				}

				disc_03_Tween = new Tween(disc_03, 1.33, Transitions.EASE_IN_OUT);
				disc_03_Tween.animate("rotation", disc_03.rotation+deg2rad(-72));
				disc_03_Tween.onComplete = function():void{
					Disc_03_Animating = false;
					Solve();
					disc_03_Tween = null;
				}
				Starling.juggler.add(disc_03_Tween);
			}else{
			//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
				Disc_03_Animating = true;
				
				if(disc_03_pos == 4){
					disc_03_pos = 0;
				}else{
					disc_03_pos = disc_03_pos+1;
				}
				
				disc_03_Tween = new Tween(disc_03, 1.33, Transitions.EASE_IN_OUT);
				disc_03_Tween.animate("rotation", disc_03.rotation+deg2rad(72));
				disc_03_Tween.onComplete = function():void{
					Disc_03_Animating = false;
					Solve();
					disc_03_Tween = null;
				}
				Starling.juggler.add(disc_03_Tween);
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
			}
			SaveArray['disc_03'] = 'pos_is_'+disc_03_pos;
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
			
			trace("Disc_03_pos: "+disc_03_pos);
		}
		
		
		private function Disc_02_Handler(LeftRight:Boolean):void{
			/*
			Left = true  /  Right = false
			*/
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
			if(LeftRight === true){
				
				Disc_02_Animating = true;
				
				if(disc_02_pos == 0){
					disc_02_pos = 4;
				}else{
					disc_02_pos = disc_02_pos-1;
				}
				
				disc_02_Tween = new Tween(disc_02, 1.66, Transitions.EASE_IN_OUT);
				disc_02_Tween.animate("rotation", disc_02.rotation+deg2rad(-72));
				disc_02_Tween.onComplete = function():void{
					Disc_02_Animating = false;
					Solve();
					disc_02_Tween = null;
				}
				Starling.juggler.add(disc_02_Tween);
			}else{
				
				Disc_02_Animating = true;
				
				if(disc_02_pos == 4){
					disc_02_pos = 0;
				}else{
					disc_02_pos = disc_02_pos+1;
				}
	
				disc_02_Tween = new Tween(disc_02, 1.66, Transitions.EASE_IN_OUT);
				disc_02_Tween.animate("rotation", disc_02.rotation+deg2rad(72));
				disc_02_Tween.onComplete = function():void{
					Disc_02_Animating = false;
					Solve();
					disc_02_Tween = null;
				}
				Starling.juggler.add(disc_02_Tween);
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
			}
			SaveArray['disc_02'] = 'pos_is_'+disc_02_pos;
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
			
			trace("Disc_02_pos: "+disc_02_pos);
			
		}
		
		
		private function Disc_01_Handler(LeftRight:Boolean):void{
			/*
			Left = true  /  Right = false
			*/
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
			if(LeftRight === true){
			
				Disc_01_Animating = true;
				
				if(disc_01_pos == 0){
					disc_01_pos = 4;
				}else{
					disc_01_pos = disc_01_pos-1;
				}
				
				disc_01_Tween = new Tween(disc_01, 2.0, Transitions.EASE_IN_OUT);
				disc_01_Tween.animate("rotation", disc_01.rotation+deg2rad(-72));
				disc_01_Tween.onComplete = function():void{
					Disc_01_Animating = false;
					Solve();
					disc_01_Tween = null;
				}
				Starling.juggler.add(disc_01_Tween);
			}else{
			
				Disc_01_Animating = true;
				
				if(disc_01_pos == 4){
					disc_01_pos = 0;
				}else{
					disc_01_pos = disc_01_pos+1;
				}
				
				disc_01_Tween = new Tween(disc_01, 2.0, Transitions.EASE_IN_OUT);
				disc_01_Tween.animate("rotation", disc_01.rotation+deg2rad(72));
				disc_01_Tween.onComplete = function():void{
					Disc_01_Animating = false;
					Solve();
					disc_01_Tween = null;
				}
				Starling.juggler.add(disc_01_Tween);
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
			}
			SaveArray['disc_01'] = 'pos_is_'+disc_01_pos;
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);
			
			trace("Disc_01_pos: "+disc_01_pos);
			
			
		}
		
		
		private function Solve():void{
			if(SealAttached === true){
				if(Solved === false){
					if(disc_01_pos == 2){
						if(disc_02_pos == 4){
							if(disc_03_pos == 3){
								if(disc_04_pos == 1){
									Solved = true;
									trace("SOLVED");
									Animating = true;
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
									trace("Solved");
									delayedcall = new DelayedCall(function():void{
										Animating = false;
										FadeOut(CliffCave,(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true)
									},2);
									
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle;
									}
									SaveArray['Solved'] = 'Yes'; 
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);	
									
									
									Starling.juggler.add(delayedcall);
									
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
			
			
			this.assets.removeTexture("cliffCavePuzzle_bg",true);
			this.assets.removeTexture("CliffCavePuzzle_Sprite",true);
			this.assets.removeTextureAtlas("CliffCavePuzzle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cliffCavePuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("cliffCavePuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("cliffCavePuzzle_03");
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