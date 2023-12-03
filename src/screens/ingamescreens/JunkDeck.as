
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
	
	
	public class JunkDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var hatch:Image;
		
		private var hit_hatch:Shape;
		private var hit_junkInterior:Shape;
		private var hit_junkUpperDeck:Shape;
		
		private var hit_cover:Shape;
		private var hit_floor:Shape;
		private var hit_railing:Shape;
		private var hit_stuff:Shape;
		private var hit_forest:Shape;
		
		private var hatch_open:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function JunkDeck(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('junkDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkDeck/junkDeck_bg.jpg'));
				game.TrackAssets('junkDeck_01');
			}
			if(game.CheckAsset('junkDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkDeck/junkDeck_spriteSheet.atf'));
				game.TrackAssets('junkDeck_02');
			}
			if(game.CheckAsset('junkDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkDeck/junkDeck_spriteSheet.xml'));
				game.TrackAssets('junkDeck_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JunkDeck","JunkDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			/*
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTurtle,
				'item_CoinTurtle',
				'inven_coinTurtle_sm'
			);
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
				'item_CoinDragon',
				'inven_coinDragon_sm'
			);
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
				'item_CoinTiger',
				'inven_coinTiger_sm'
			);
			*/
			
			bg = new Image(this.assets.getTexture('junkDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			hatch = new Image(this.assets.getTexture('hatch_open'));
			hatch.smoothing = TextureSmoothing.NONE;
			hatch.touchable = false;
			hatch.x = 126;
			hatch.y = 163;

						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck['Hatch'] == 'open'){
					
					hatch.alpha = 1;
					this.addChildAt(hatch,1);
					CreateHatchHit(true);
					hatch_open = true;
					CreateJunkInteriorHit();
					
				}else{
					hatch.alpha = 0;
					this.addChildAt(hatch,1);
					CreateHatchHit(false);
					hatch_open = false;
					
				}
				
			}else{
				
				hatch.alpha = 0;
				this.addChildAt(hatch,1);
				CreateHatchHit(false);
				hatch_open = false;
			}
			CreateForestHit();
			CreateStuffHit();
			CreateCoverHit();
			CreateFloorHit();
			CreateRailingHit();

			
			CreateJunkUpperDeckHit();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Jungle_01",0,0.5,'stop');
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("TVStatic",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'BirdsOne';
			},0.7);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkDeck',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,1);
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkDeck',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,1);
					},1.5);
				}
			}
		}
		
		
		private function CreateForestHit():void{
			hit_forest = new Shape();
			hit_forest.touchable = false
			hit_forest.graphics.beginFill(0x00FF00);
			
			hit_forest.graphics.lineTo(643,0);				
			hit_forest.graphics.lineTo(800,0);				
			hit_forest.graphics.lineTo(800,374);				
			hit_forest.graphics.lineTo(691,224);				
			hit_forest.graphics.lineTo(673,65);				
			
			hit_forest.graphics.endFill(false);
			hit_forest.alpha = 0.0;
			hit_forest.graphics.precisionHitTest = true;		
			this.addChild(hit_forest);
			
		}
		
		private function CreateStuffHit():void{
			hit_stuff = new Shape();
			hit_stuff.touchable = false
			hit_stuff.graphics.beginFill(0x00FF00);
			
			hit_stuff.graphics.lineTo(82,297);	
			hit_stuff.graphics.lineTo(286,221);	
			hit_stuff.graphics.lineTo(336,232);	
			hit_stuff.graphics.lineTo(325,297);	
			hit_stuff.graphics.lineTo(96,401);	
			
			hit_stuff.graphics.endFill(false);
			hit_stuff.alpha = 0.0;
			hit_stuff.graphics.precisionHitTest = true;		
			this.addChild(hit_stuff);
			
		}
		
		private function CreateRailingHit():void{
			hit_railing = new Shape();
			hit_railing.touchable = false
			hit_railing.graphics.beginFill(0x00FF00);
			
			hit_railing.graphics.lineTo(609,243);	
			hit_railing.graphics.lineTo(708,239);	
			hit_railing.graphics.lineTo(786,386);	
			hit_railing.graphics.lineTo(593,502);	
			hit_railing.graphics.lineTo(548,432);	
			
			
			hit_railing.graphics.endFill(false);
			hit_railing.alpha = 0.0;
			hit_railing.graphics.precisionHitTest = true;		
			this.addChild(hit_railing);
			
		}
		
		private function CreateFloorHit():void{
			hit_floor = new Shape();
			hit_floor.touchable = false;
			hit_floor.graphics.beginFill(0x00FF00);
			hit_floor.graphics.lineTo(98,376);	
			hit_floor.graphics.lineTo(319,281);	
			hit_floor.graphics.lineTo(601,301);	
			hit_floor.graphics.lineTo(535,506);	
			hit_floor.graphics.lineTo(255,505);	
			hit_floor.graphics.lineTo(98,416);	
			
			hit_floor.graphics.endFill(false);
			hit_floor.alpha = 0.0;
			hit_floor.graphics.precisionHitTest = true;		
			this.addChild(hit_floor);
			
		}

		
		private function CreateCoverHit():void{
			hit_cover = new Shape();
			hit_cover.touchable = false;
			hit_cover.graphics.beginFill(0x00FF00);
			hit_cover.graphics.lineTo(49,57);	
			hit_cover.graphics.lineTo(295,60);	
			hit_cover.graphics.lineTo(502,128);	
			hit_cover.graphics.lineTo(497,248);	
			hit_cover.graphics.lineTo(338,202);	
			hit_cover.graphics.lineTo(78,147);	
			
			hit_cover.graphics.endFill(false);
			hit_cover.alpha = 0.0;
			hit_cover.graphics.precisionHitTest = true;		
			this.addChild(hit_cover);
			
		}
		
		private function CreateHatchHit(open:Boolean = false):void{
			hit_hatch = new Shape();
			hit_hatch.touchable = false;
			this.addChild(hit_hatch);
			if(open === false){
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);
				hit_hatch.graphics.lineTo(192,386);				
				hit_hatch.graphics.lineTo(343,307);				
				hit_hatch.graphics.lineTo(487,319);				
				hit_hatch.graphics.lineTo(402,417);				

				hit_hatch.graphics.endFill(false);
				
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);		
				hit_hatch.graphics.lineTo(133,206);	
				hit_hatch.graphics.lineTo(303,172);	
				hit_hatch.graphics.lineTo(334,321);	
				hit_hatch.graphics.lineTo(187,396);	
				

				hit_hatch.graphics.endFill(false);
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;				
			}			
			
		}			
		//hit_junkUpperDeck
		
		private function CreateJunkUpperDeckHit():void{
			hit_junkUpperDeck = new Shape();
			hit_junkUpperDeck.touchable = false;
			hit_junkUpperDeck.graphics.beginFill(0x00FF00);
			hit_junkUpperDeck.graphics.lineTo(430,0);	
			hit_junkUpperDeck.graphics.lineTo(626,0);	
			hit_junkUpperDeck.graphics.lineTo(643,67);	
			hit_junkUpperDeck.graphics.lineTo(653,192);	
			hit_junkUpperDeck.graphics.lineTo(631,211);	
			hit_junkUpperDeck.graphics.lineTo(585,293);	
			hit_junkUpperDeck.graphics.lineTo(531,289);	
			hit_junkUpperDeck.graphics.lineTo(546,121);	
			hit_junkUpperDeck.graphics.lineTo(488,124);	
			hit_junkUpperDeck.graphics.lineTo(418,97);	
			hit_junkUpperDeck.graphics.lineTo(415,72);	
			
			hit_junkUpperDeck.graphics.endFill(false);
			hit_junkUpperDeck.alpha = 0.0;
			hit_junkUpperDeck.graphics.precisionHitTest = true;		
			this.addChild(hit_junkUpperDeck);
			
		}
		
		private function CreateJunkInteriorHit():void{
			hit_junkInterior = new Shape();
			
			hit_junkInterior.graphics.beginFill(0x00FF00);
			hit_junkInterior.graphics.lineTo(199,396);	
			hit_junkInterior.graphics.lineTo(339,323);	
			hit_junkInterior.graphics.lineTo(481,332);	
			hit_junkInterior.graphics.lineTo(395,424);	
			
			hit_junkInterior.graphics.endFill(false);
			hit_junkInterior.alpha = 0.0;
			hit_junkInterior.graphics.precisionHitTest = true;				
			this.addChild(hit_junkInterior);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
						);
						
						
				//	}else if(){
					}else if(hit_junkUpperDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
						FadeOut((JunkTopDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkTopDeckObj,true
						);
					}else if(hatch_open === true){
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchTouch();
						}else if(hit_junkInterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((JunkInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkInteriorObj,false
							);
							
						}else if(hit_cover.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The awning is made from bamboo... It looks ready to collapse.");						
						}else if(hit_stuff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Various items used for running the ship.");						
						}else if(hit_railing.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's gunwale and bollards.");						
						}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor has many scratches and small holes.");						
						}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((JungleJunk as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
							);
						}
					}else{
						if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HatchTouch();
						}else if(hit_cover.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The awning is made from bamboo... It looks ready to collapse.");						
						}else if(hit_stuff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Various items used for running the ship.");						
						}else if(hit_railing.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's gunwale and bollards.");						
						}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor has many scratches and small holes.");						
						}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((JungleJunk as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
							);
						}
					}
					
					/*
					
					private var hit_cover:Shape;
					private var hit_floor:Shape;
					private var hit_railing:Shape;
					private var hit_stuff:Shape;
					private var hit_forest:Shape;
					
					*/
		
				}
			}
		}
		private function HatchTouch():void{
			
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck['Hatch'] != 'open'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyOpen();
					SaveArray['Hatch'] = 'open';
					
					hatch.alpha = 1;
					hit_hatch.graphics.clear();
					CreateHatchHit(true);
					hatch_open = true;
					CreateJunkInteriorHit();
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyClose();
					SaveArray['Hatch'] = 'close';
					
					hatch.alpha = 0;
					hit_hatch.graphics.clear();
					hit_junkInterior.graphics.clear();
					CreateHatchHit(false);
					hatch_open = false;
					
				}
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyOpen();
				SaveArray['Hatch'] = 'open';
				
				hatch.alpha = 1;
				hit_hatch.graphics.clear();
				CreateHatchHit(true);
				hatch_open = true;
				CreateJunkInteriorHit();
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkDeck',SaveArray);	
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
			
			
			this.assets.removeTexture("junkDeck_spriteSheet",true);
			this.assets.removeTextureAtlas("junkDeck_spriteSheet",true);
			this.assets.removeTexture("junkDeck_bg",true);
			(stage.getChildAt(0) as Object).falseAsset("junkDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("junkDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("junkDeck_03");
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
import starling.utils.AssetManager;

