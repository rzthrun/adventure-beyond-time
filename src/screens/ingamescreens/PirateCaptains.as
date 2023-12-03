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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class PirateCaptains extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var couch_right_on:Image;
		private var couch_center_on:Image;
		private var couch_left_on:Image;
		
		private var couch_right_off:Image;
		private var couch_center_off:Image;
		private var couch_left_off:Image;
		
		private var couch_ry_up_left:Image;
		private var couch_ry_up_center:Image;
		private var couch_gb_up_right:Image;
		private var couch_gb_up_center:Image;
		
		private var couch_ry_down_left:Image;
		private var couch_ry_down_center:Image;
		private var couch_gb_down_right:Image;
		private var couch_gb_down_center:Image;
		
		private var couch_axe:Image;
		
		private var table_skull:Image;
		private var table_tools:Image;
		
		private var painting_left:Image;
		private var painting_right:Image;
		
		private var poker:Image;
		
		private var hit_couch:Shape;
		private var hit_table:Shape;
		private var hit_paintings:Shape;
		private var hit_poker:Shape;
		
		private var hit_greek:Shape;
		private var hit_egypt:Shape;
		private var hit_genish:Shape;
		private var hit_fudog:Shape
		private var hit_stool:Shape
		private var hit_fish:Shape
		private var hit_loot:Shape
		private var hit_chandillier:Shape
		private var hit_window:Shape
		private var hit_bust:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function PirateCaptains(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateCaptains_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptains/pirateCaptains_bg.jpg'));
				game.TrackAssets('pirateCaptains_01');
			}
			if(game.CheckAsset('pirateCaptains_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptains/PirateCaptains_Sprite.png'));
				game.TrackAssets('pirateCaptains_02');
			}
			if(game.CheckAsset('pirateCaptains_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptains/PirateCaptains_Sprite.xml'));
				game.TrackAssets('pirateCaptains_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("PirateCaptains","PirateCaptainsObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateCaptains_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			couch_right_on = new Image(this.assets.getTexture('couch_right_on'));
			//couch_right_on.smoothing = TextureSmoothing.NONE;
			couch_right_on.touchable = false;
			couch_right_on.x = 423;
			couch_right_on.y = 265;
			
			couch_center_on = new Image(this.assets.getTexture('couch_center_on'));
			//couch_center_on.smoothing = TextureSmoothing.NONE;
			couch_center_on.touchable = false;
			couch_center_on.x = 342;
			couch_center_on.y = 260;
			
			couch_left_on = new Image(this.assets.getTexture('couch_left_on'));
			//couch_left_on.smoothing = TextureSmoothing.NONE;
			couch_left_on.touchable = false;
			couch_left_on.x = 252;
			couch_left_on.y = 254;
			
			couch_gb_up_right = new Image(this.assets.getTexture('couch_gb_up_right'));
			//couch_gb_up_right.smoothing = TextureSmoothing.NONE;
			couch_gb_up_right.touchable = false;
			couch_gb_up_right.x = 441;
			couch_gb_up_right.y = 227;
			
			couch_gb_up_center = new Image(this.assets.getTexture('couch_gb_up_center'));
			//couch_gb_up_center.smoothing = TextureSmoothing.NONE;
			couch_gb_up_center.touchable = false;
			couch_gb_up_center.x = 376;
			couch_gb_up_center.y = 222;

			couch_ry_up_center = new Image(this.assets.getTexture('couch_ry_up_center'));
			//couch_ry_up_center.smoothing = TextureSmoothing.NONE;
			couch_ry_up_center.touchable = false;
			couch_ry_up_center.x = 332;
			couch_ry_up_center.y = 217;
			
			couch_ry_up_left = new Image(this.assets.getTexture('couch_ry_up_left'));
			//couch_ry_up_left.smoothing = TextureSmoothing.NONE;

			couch_ry_up_left.touchable = false;
			couch_ry_up_left.x = 254;
			couch_ry_up_left.y = 208;

			couch_ry_down_left = new Image(this.assets.getTexture('couch_ry_down_left'));
		//	couch_ry_down_left.smoothing = TextureSmoothing.NONE;

			couch_ry_down_left.touchable = false;
			couch_ry_down_left.x = 204;
			couch_ry_down_left.y = 232;
			
			couch_ry_down_center = new Image(this.assets.getTexture('couch_ry_down_center'));
			//couch_ry_down_center.smoothing = TextureSmoothing.NONE;

			couch_ry_down_center.touchable = false;
			couch_ry_down_center.x = 335;
			couch_ry_down_center.y = 238;

			couch_gb_down_center = new Image(this.assets.getTexture('couch_gb_down_center'));
			//couch_gb_down_center.smoothing = TextureSmoothing.NONE;

			couch_gb_down_center.touchable = false;
			couch_gb_down_center.x = 377;
			couch_gb_down_center.y = 242;
				
			couch_gb_down_right = new Image(this.assets.getTexture('couch_gb_down_right'));
			//couch_gb_down_right.smoothing = TextureSmoothing.NONE;

			couch_gb_down_right.touchable = false;
			couch_gb_down_right.x = 439;
			couch_gb_down_right.y = 248;

			couch_right_off = new Image(this.assets.getTexture('couch_right_off'));
		//	couch_right_off.smoothing = TextureSmoothing.NONE;

			couch_right_off.touchable = false;
			couch_right_off.x = 466;
			couch_right_off.y = 256;

			couch_center_off = new Image(this.assets.getTexture('couch_center_off'));
			//couch_center_off.smoothing = TextureSmoothing.NONE;

			couch_center_off.touchable = false;
			couch_center_off.x = 355;
			couch_center_off.y = 264;
		
			couch_left_off = new Image(this.assets.getTexture('couch_left_off'));
			//couch_left_off.smoothing = TextureSmoothing.NONE;

			couch_left_off.touchable = false;
			couch_left_off.x = 259;
			couch_left_off.y = 240;
			
			
			couch_axe = new Image(this.assets.getTexture('couch_axe'));
			//couch_axe.smoothing = TextureSmoothing.NONE;

			couch_axe.touchable = false;
			couch_axe.x = 324;
			couch_axe.y = 211;
			
			table_skull = new Image(this.assets.getTexture('table_skull'));
		//	table_skull.smoothing = TextureSmoothing.NONE;

			table_skull.touchable = false;
			table_skull.x = 109;
			table_skull.y = 201;
			
			table_tools = new Image(this.assets.getTexture('table_tools'));
		//	table_tools.smoothing = TextureSmoothing.NONE;

			table_tools.touchable = false;
			table_tools.x = 83;
			table_tools.y = 250;
			
			painting_left = new Image(this.assets.getTexture('painting_left'));
		//	painting_left.smoothing = TextureSmoothing.NONE;

			painting_left.touchable = false;
			painting_left.x = 529;
			painting_left.y = 235;
			
			painting_right = new Image(this.assets.getTexture('painting_right'));
		//	painting_right.smoothing = TextureSmoothing.NONE;

			painting_right.touchable = false;
			painting_right.x = 637;
			painting_right.y = 257;
			
			
			poker = new Image(this.assets.getTexture('poker'));
		//	poker.smoothing = TextureSmoothing.NONE;

			poker.touchable = false;
			poker.x = 385;
			poker.y = 382;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['PickAxe'] == 'PickedUp'){
					couch_axe.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['LeftOpen'] == 'Yes'){
						couch_left_on.alpha = 0;
						couch_left_off.alpha = 1;
						couch_ry_up_left.alpha = 0;
					}else{
						couch_left_on.alpha = 1;
						couch_left_off.alpha = 0;
						couch_ry_down_left.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['RightOpen'] == 'Yes'){
						couch_right_on.alpha = 0;
						couch_right_off.alpha = 1;
						couch_gb_up_right.alpha = 0;
					}else{
						couch_right_on.alpha = 1;
						couch_right_off.alpha = 0;
						couch_gb_down_right.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['CenterOpen'] == 'Yes'){
						couch_center_on.alpha = 0;
						couch_center_off.alpha = 1;
						couch_gb_up_center.alpha = 0;
						couch_ry_up_center.alpha = 0;
					}else{
						couch_center_on.alpha = 1;
						couch_center_off.alpha = 0;
						couch_gb_down_center.alpha = 0;
						couch_ry_down_center.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['RYisCenter'] == 'Yes'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['CenterOpen'] == 'Yes'){
							couch_ry_down_center.alpha = 1;
							couch_ry_up_center.alpha = 0;
							couch_ry_down_left.alpha = 0;
							couch_ry_up_left.alpha = 0;
						}else{
							couch_ry_down_center.alpha = 0;
							couch_ry_up_center.alpha = 1;
							couch_ry_down_left.alpha = 0;
							couch_ry_up_left.alpha = 0;
						}
					}else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['LeftOpen'] == 'Yes'){
							couch_ry_down_center.alpha = 0;
							couch_ry_up_center.alpha = 0;
							couch_ry_down_left.alpha = 1;
							couch_ry_up_left.alpha = 0;
						}else{
							couch_ry_down_center.alpha = 0;
							couch_ry_up_center.alpha = 0;
							couch_ry_down_left.alpha = 0;
							couch_ry_up_left.alpha = 1;
						}
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['GBisCenter'] == 'Yes'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['CenterOpen'] == 'Yes'){
							couch_gb_down_center.alpha = 1;
							couch_gb_up_center.alpha = 0;
							couch_gb_down_right.alpha = 0;
							couch_gb_up_right.alpha = 0;
						}else{
							couch_gb_down_center.alpha = 0;
							couch_gb_up_center.alpha = 1;
							couch_gb_down_right.alpha = 0;
							couch_gb_up_right.alpha = 0;
						}
					}else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsCouch['RightOpen'] == 'Yes'){
							couch_gb_down_center.alpha = 0;
							couch_gb_up_center.alpha = 0;
							couch_gb_down_right.alpha = 1;
							couch_gb_up_right.alpha = 0;
						}else{
							couch_gb_down_center.alpha = 0;
							couch_gb_up_center.alpha = 0;
							couch_gb_down_right.alpha = 0;
							couch_gb_up_right.alpha = 1;
						}
					}
					
					
				}else{
					couch_right_on.alpha = 1;
					couch_center_on.alpha = 1;
					couch_left_on.alpha = 1;
					couch_gb_up_right.alpha = 1;
					couch_gb_up_center.alpha = 0;
					couch_ry_up_center.alpha = 0;
					couch_ry_up_left.alpha = 1;
					couch_ry_down_left.alpha = 0;
					couch_ry_down_center.alpha = 0;
					couch_gb_down_center.alpha = 0;
					couch_gb_down_right.alpha = 0;
					couch_right_off.alpha = 0;
					couch_center_off.alpha = 0;
					couch_left_off.alpha = 0;
					couch_axe.alpha = 1;
				}
			}else{
				couch_right_on.alpha = 1;
				couch_center_on.alpha = 1;
				couch_left_on.alpha = 1;
				couch_gb_up_right.alpha = 1;
				couch_gb_up_center.alpha = 0;
				couch_ry_up_center.alpha = 0;
				couch_ry_up_left.alpha = 1;
				couch_ry_down_left.alpha = 0;
				couch_ry_down_center.alpha = 0;
				couch_gb_down_center.alpha = 0;
				couch_gb_down_right.alpha = 0;
				couch_right_off.alpha = 0;
				couch_center_off.alpha = 0;
				couch_left_off.alpha = 0;
				couch_axe.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['SculptTools'] == 'PickedUp'){
					table_tools.alpha = 0;
				}else{
					table_tools.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['Skull'] == 'PickedUp'){
					table_skull.alpha = 0;
				}else{
					table_skull.alpha = 1;
				}
				
				
				
			}else{
				table_skull.alpha = 1;
				table_tools.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['Left'] == 'Open'){
					painting_left.alpha = 1;
				}else{
					painting_left.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['Right'] == 'Open'){
					painting_right.alpha = 1;
				}else{
					painting_right.alpha = 0;
				}
			}else{
				painting_left.alpha = 0;
				painting_right.alpha = 0;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains['Poker'] == 'PickedUp'){
					poker.alpha = 0;
					
				}else{
					poker.alpha = 1;
					
				}
			}else{
				poker.alpha = 1;
				
			}
			
			this.addChildAt(couch_ry_down_left,1);			
			this.addChildAt(couch_ry_down_center,2);		
			this.addChildAt(couch_gb_down_center,3);			
			this.addChildAt(couch_gb_down_right,4);	
			this.addChildAt(couch_right_on,5);
			this.addChildAt(couch_center_on,6);			
			this.addChildAt(couch_left_on,7);			
			this.addChildAt(couch_gb_up_right,8);			
			this.addChildAt(couch_gb_up_center,9);			
			this.addChildAt(couch_ry_up_center,10);		
			this.addChildAt(couch_ry_up_left,11);					
			this.addChildAt(couch_right_off,12);			
			this.addChildAt(couch_center_off,13);			
			this.addChildAt(couch_left_off,14);
			
			this.addChildAt(couch_axe,14);
			
			this.addChildAt(table_skull,14);
			this.addChildAt(table_tools,15);
			
			this.addChildAt(painting_left,16);
			this.addChildAt(painting_right,17);
			
			this.addChildAt(poker,18);
			

			
			CreateFuDog();
			CreateLootHit();
			CreateGenishHit();
			CreateGreekHit();
			CreateStoolHit();
			CreateFishHit();
			CreateChandillierHit();
			CreateWindowHit();
			CreateEgyptHit();
			CreateBustHit();
			
			CreatePaintingsHit();
			CreatePokerHit();	
			CreateCouchHit();
			CreateTableHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("ShipCreaks",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waves_02';
			},0.5);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waves_02",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptains',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,1);
							
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptains',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,1);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}
			}
		
		}
		
		private function CreateFuDog():void{
			hit_fudog = new Shape();
			hit_fudog.touchable = false;
			hit_fudog.graphics.beginFill(0x00ff00);
			
			hit_fudog.graphics.lineTo(708,286);	
			hit_fudog.graphics.lineTo(729,277);	
			hit_fudog.graphics.lineTo(796,293);	
			hit_fudog.graphics.lineTo(795,403);	
			hit_fudog.graphics.lineTo(670,434);	
			
			
			hit_fudog.graphics.endFill(false);
			hit_fudog.alpha = 0.0;
			
			hit_fudog.graphics.precisionHitTest = true;	
			this.addChild(hit_fudog);
		}
		//hit_bust
		private function CreateBustHit():void{
			hit_bust = new Shape();
			hit_bust.touchable = false;
			hit_bust.graphics.beginFill(0x00ff00);
			
			hit_bust.graphics.lineTo(495,458);	
			hit_bust.graphics.lineTo(580,403);	
			hit_bust.graphics.lineTo(638,490);	
			hit_bust.graphics.lineTo(510,503);	

			hit_bust.graphics.endFill(false);
			hit_bust.alpha = 0.0;
			
			hit_bust.graphics.precisionHitTest = true;	
			this.addChild(hit_bust);
		}
		
		private function CreateLootHit():void{
			hit_loot = new Shape();
			hit_loot.touchable = false;
			hit_loot.graphics.beginFill(0x00ff00);
			
			hit_loot.graphics.lineTo(690,172);	
			hit_loot.graphics.lineTo(726,124);	
			hit_loot.graphics.lineTo(792,153);	
			hit_loot.graphics.lineTo(800,186);	
			hit_loot.graphics.lineTo(755,265);	
			hit_loot.graphics.lineTo(708,243);	
			
			hit_loot.graphics.endFill(false);
			hit_loot.alpha = 0.0;
			
			hit_loot.graphics.precisionHitTest = true;	
			this.addChild(hit_loot);
		}
		
		private function CreateEgyptHit():void{
			hit_egypt = new Shape();
			hit_egypt.touchable = false;
			hit_egypt.graphics.beginFill(0x00ff00);
			
			hit_egypt.graphics.lineTo(537,196);	
			hit_egypt.graphics.lineTo(583,106);	
			hit_egypt.graphics.lineTo(691,135);	
			hit_egypt.graphics.lineTo(710,245);	
			hit_egypt.graphics.lineTo(557,262);	
			
			hit_egypt.graphics.endFill(false);
			hit_egypt.alpha = 0.0;
			
			hit_egypt.graphics.precisionHitTest = true;	
			this.addChild(hit_egypt);
		}
		

		private function CreateWindowHit():void{
			hit_window = new Shape();
			hit_window.touchable = false;
			hit_window.graphics.beginFill(0x00ff00);
			
			hit_window.graphics.lineTo(183,63);	
			hit_window.graphics.lineTo(344,58);	
			hit_window.graphics.lineTo(536,101);	
			hit_window.graphics.lineTo(551,206);	
			hit_window.graphics.lineTo(227,174);	
			
			hit_window.graphics.endFill(false);
			hit_window.alpha = 0.0;
			
			hit_window.graphics.precisionHitTest = true;	
			this.addChild(hit_window);
		}
		
		private function CreateChandillierHit():void{
			hit_chandillier = new Shape();
			hit_chandillier.touchable = false;
			hit_chandillier.graphics.beginFill(0x00ff00);
			
			hit_chandillier.graphics.lineTo(326,30);	
			hit_chandillier.graphics.lineTo(381,0);	
			hit_chandillier.graphics.lineTo(501,0);	
			hit_chandillier.graphics.lineTo(513,44);	
			hit_chandillier.graphics.lineTo(472,115);	
			hit_chandillier.graphics.lineTo(364,117);	
			
			hit_chandillier.graphics.endFill(false);
			hit_chandillier.alpha = 0.0;
			
			hit_chandillier.graphics.precisionHitTest = true;	
			this.addChild(hit_chandillier);
		}
		
		private function CreateFishHit():void{
			hit_fish = new Shape();
			hit_fish.touchable = false;
			hit_fish.graphics.beginFill(0x00ff00);
			
			hit_fish.graphics.lineTo(216,348);	
			hit_fish.graphics.lineTo(251,250);	
			hit_fish.graphics.lineTo(296,247);	
			hit_fish.graphics.lineTo(284,352);	
			
			hit_fish.graphics.endFill(false);
			hit_fish.alpha = 0.0;
			
			hit_fish.graphics.precisionHitTest = true;	
			this.addChild(hit_fish);
		}
		
		private function CreateStoolHit():void{
			hit_stool = new Shape();
			hit_stool.touchable = false;
			hit_stool.graphics.beginFill(0x00ff00);
			
			hit_stool.graphics.lineTo(228,375);	
			hit_stool.graphics.lineTo(270,359);	
			hit_stool.graphics.lineTo(373,373);	
			hit_stool.graphics.lineTo(373,453);	
			hit_stool.graphics.lineTo(331,483);	
			hit_stool.graphics.lineTo(230,453);	
			
			hit_stool.graphics.endFill(false);
			hit_stool.alpha = 0.0;
			
			hit_stool.graphics.precisionHitTest = true;	
			this.addChild(hit_stool);
		}
		
		private function CreateGreekHit():void{
			hit_greek = new Shape();
			hit_greek.touchable = false;
			hit_greek.graphics.beginFill(0x00ff00);
			
			hit_greek.graphics.lineTo(67,76);	
			hit_greek.graphics.lineTo(180,48);	
			hit_greek.graphics.lineTo(223,70);	
			hit_greek.graphics.lineTo(263,168);	
			hit_greek.graphics.lineTo(230,216);	
			hit_greek.graphics.lineTo(70,107);	
			
			hit_greek.graphics.endFill(false);
			hit_greek.alpha = 0.0;
			
			hit_greek.graphics.precisionHitTest = true;	
			this.addChild(hit_greek);
		}
		
		private function CreateGenishHit():void{
			hit_genish = new Shape();
			hit_genish.touchable = false;
			hit_genish.graphics.beginFill(0x00ff00);
			
			hit_genish.graphics.lineTo(36,302);	
			hit_genish.graphics.lineTo(105,272);	
			hit_genish.graphics.lineTo(166,310);	
			hit_genish.graphics.lineTo(180,417);	
			hit_genish.graphics.lineTo(158,512);	
			hit_genish.graphics.lineTo(0,512);	
			
			
			hit_genish.graphics.endFill(false);
			hit_genish.alpha = 0.0;
			
			hit_genish.graphics.precisionHitTest = true;	
			this.addChild(hit_genish);
		}
		
		private function CreatePokerHit():void{
			hit_poker = new Shape();
			hit_poker.touchable = false;
			hit_poker.graphics.beginFill(0x00ff00);
			
			hit_poker.graphics.lineTo(382,439);	
			hit_poker.graphics.lineTo(526,370);	
			hit_poker.graphics.lineTo(551,378);	
			hit_poker.graphics.lineTo(551,402);	
			hit_poker.graphics.lineTo(407,481);	
		
			
			hit_poker.graphics.endFill(false);
			hit_poker.alpha = 0.0;
			
			hit_poker.graphics.precisionHitTest = true;	
			this.addChild(hit_poker);
		}
		
		private function CreatePaintingsHit():void{
			hit_paintings = new Shape();
			hit_paintings.touchable = false;
			hit_paintings.graphics.beginFill(0xff0000);
			
			hit_paintings.graphics.lineTo(573,229);	
			hit_paintings.graphics.lineTo(741,264);	
			hit_paintings.graphics.lineTo(708,287);	
			hit_paintings.graphics.lineTo(676,408);	
			hit_paintings.graphics.lineTo(631,407);	
			hit_paintings.graphics.lineTo(546,368);	

			hit_paintings.graphics.endFill(false);
			hit_paintings.alpha = 0.0;
			
			hit_paintings.graphics.precisionHitTest = true;	
			this.addChild(hit_paintings);
		}
		//hit_table
		
		private function CreateCouchHit():void{
			hit_couch = new Shape();
			hit_couch.touchable = false;
			hit_couch.graphics.beginFill(0xff0000);
			
			hit_couch.graphics.lineTo(243,199);	
			hit_couch.graphics.lineTo(295,157);	
			hit_couch.graphics.lineTo(385,159);	
			hit_couch.graphics.lineTo(492,176);	
			hit_couch.graphics.lineTo(535,202);	
			hit_couch.graphics.lineTo(555,241);	
			hit_couch.graphics.lineTo(535,332);	
			hit_couch.graphics.lineTo(292,320);	
			hit_couch.graphics.lineTo(302,245);	
			hit_couch.graphics.lineTo(255,247);	
			
			
			hit_couch.graphics.endFill(false);
			hit_couch.alpha = 0.0;
			
			hit_couch.graphics.precisionHitTest = true;	
			this.addChild(hit_couch);
		}
		//hit_table
		private function CreateTableHit():void{
			hit_table = new Shape();
			hit_table.touchable = false;
			hit_table.graphics.beginFill(0xff0000);
			
			hit_table.graphics.lineTo(0,90);	
			hit_table.graphics.lineTo(70,110);	
			hit_table.graphics.lineTo(115,156);	
			hit_table.graphics.lineTo(211,204);	
			hit_table.graphics.lineTo(248,248);	
			hit_table.graphics.lineTo(211,293);	
			hit_table.graphics.lineTo(111,272);	
			hit_table.graphics.lineTo(0,265);	

			hit_table.graphics.endFill(false);
			hit_table.alpha = 0.0;
			
			hit_table.graphics.precisionHitTest = true;	
			this.addChild(hit_table);
		}
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirateTopDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateTopDeckObj,false
						);
					}else if(hit_couch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((PirateCaptainsCouch as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsCouchObj,true
						);
					}else if(hit_table.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((PirateCaptainsTable as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsTableObj,true
						);
					}else if(hit_paintings.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((PirateCaptainsPainting as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsPaintingObj,true
						);
					}else if(hit_poker.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PokerHandler();
					
					}else if(hit_greek.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ancient Grecian statues of Poseidon and Apollo.");
					}else if(hit_egypt.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Two statues, one ancient Egyptian, the other European Renaissance");
					}else if(hit_genish.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ganesha, Hindu deity, remover of obstacles...");
					}else if(hit_fudog.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A foo dog... or 'komainu'.");
					}else if(hit_stool.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A short, overturned stool.");
					}else if(hit_fish.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A jade fish.");
					}else if(hit_loot.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A ceremonial mask and a lute.");
					}else if(hit_chandillier.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An ornate chandelier.");
					}else if(hit_window.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A layer of dust and grime covers the windows.");
					}else if(hit_bust.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The plaster bust of a man with a moustache.");
					}
					
					
					/*
					private var hit_greek:Shape;
					private var hit_egypt:Shape;
					private var hit_genish:Shape;
					private var hit_fudog:Shape
					private var hit_stool:Shape
					private var hit_fish:Shape
					private var hit_loot:Shape
					private var hit_chandillier:Shape
					private var hit_window:Shape
					*/
				}
			}
		}
		private function PokerHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains['Poker'] == 'PickedUp'){
					
				}else{
					poker.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains;
					}
					SaveArray["Poker"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptains',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Poker,
						'item_Poker',
						'inven_poker_sm'
					);
				}
			}else{
				poker.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptains;
				}
				SaveArray["Poker"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptains',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Poker,
					'item_Poker',
					'inven_poker_sm'
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
			
			
			this.assets.removeTexture("pirateCaptains_bg",true);
			this.assets.removeTexture("PirateCaptains_Sprite",true);
			this.assets.removeTextureAtlas("PirateCaptains_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptains_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptains_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptains_03");

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
