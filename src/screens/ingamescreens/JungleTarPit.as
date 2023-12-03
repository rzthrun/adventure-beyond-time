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
	import starling.utils.AssetManager;
	
	public class JungleTarPit extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var ribbon:Image;
		private var stick:Image;
		private var plank_front:Image;
		private var plank_back:Image;
		
		private var hit_Jungle:Shape;
		private var hit_Pit:Shape;
		private var hit_Ribbon:Shape;
		private var hit_Wall:Shape;
		private var hit_WallOne:Shape;
		private var hit_WallTwo:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var goback:GoBackButton;		
		
		public function JungleTarPit(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('JungleTarPit_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPit/jungleTarPit_bg.jpg'));
				game.TrackAssets('JungleTarPit_01');
			}
			if(game.CheckAsset('JungleTarPit_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPit/JungleTarPit_Sprite.png'));
				game.TrackAssets('JungleTarPit_02');
			}
			if(game.CheckAsset('JungleTarPit_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPit/JungleTarPit_Sprite.xml'));
				game.TrackAssets('JungleTarPit_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleTarPit","JungleTarPitObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleTarPit_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			ribbon = new Image(this.assets.getTexture('ribbon'));
			ribbon.touchable = false;
			ribbon.x = 86;
			ribbon.y = 49;
					
			stick = new Image(this.assets.getTexture('pit_stick'));
			stick.touchable = false;
			stick.x = 318;
			stick.y = 280;
			
			plank_front = new Image(this.assets.getTexture('pit_plank_front'));
			plank_front.touchable = false;
			plank_front.x = 236;
			plank_front.y = 299;
			
			plank_back = new Image(this.assets.getTexture('pit_plank_back'));
			plank_back.touchable = false;
			plank_back.x = 392;
			plank_back.y = 247;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPit['Ribbon'] == 'PickedUp'){
					ribbon.alpha = 0;
				}else{
					ribbon.alpha = 1;
				}
			}else{
				ribbon.alpha = 1;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
					stick.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
						plank_front.alpha = 1;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankFar'] == 'Attached'){
							plank_back.alpha = 1;
						}else{
							
							plank_back.alpha = 0;
						}
					}else{
						plank_front.alpha = 0;
						plank_back.alpha = 0;
					}
				}else{
					stick.alpha = 1;
					plank_front.alpha = 0;
					plank_back.alpha = 0;
				}
			}else{
				stick.alpha = 1;
				plank_front.alpha = 0;
				plank_back.alpha = 0;
			}
			
		
			
			this.addChildAt(ribbon,1);
			this.addChildAt(stick,2);
			this.addChildAt(plank_front,3);
			this.addChildAt(plank_back,4);
			
			//FadeOutOcean(1);
			CreateHitJungle();
			CreateHitPit();
			CreateHitRibbon();
			CreateHitWall();
			CreateWallOneHit();
			CreateWallTwoHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
		}
		
		private function CreateWallOneHit():void{
			hit_WallOne = new Shape();
			hit_WallOne.touchable = false;
			hit_WallOne.graphics.beginFill(0xff0000);
			
			hit_WallOne.graphics.lineTo(180,118);	
			hit_WallOne.graphics.lineTo(233,96);	
			hit_WallOne.graphics.lineTo(250,46);	
			hit_WallOne.graphics.lineTo(294,68);	
			hit_WallOne.graphics.lineTo(325,216);	
			hit_WallOne.graphics.lineTo(246,215);	
			hit_WallOne.graphics.lineTo(195,229);	
			
			
			
			hit_WallOne.graphics.endFill(false);
			hit_WallOne.alpha = 0.0;
			
			hit_WallOne.graphics.precisionHitTest = true;	
			this.addChild(hit_WallOne);
		}
		private function CreateWallTwoHit():void{
			hit_WallTwo = new Shape();
			hit_WallTwo.touchable = false;
			hit_WallTwo.graphics.beginFill(0xff0000);
			
			hit_WallTwo.graphics.lineTo(500,58);	
			hit_WallTwo.graphics.lineTo(600,16);	
			hit_WallTwo.graphics.lineTo(591,186);	
			hit_WallTwo.graphics.lineTo(577,261);	
			hit_WallTwo.graphics.lineTo(510,238);	
			
			
			hit_WallTwo.graphics.endFill(false);
			hit_WallTwo.alpha = 0.0;
			
			hit_WallTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_WallTwo);
		}
		
		private function CreateHitJungle():void{
			hit_Jungle = new Shape();
			hit_Jungle.touchable = false;
			hit_Jungle.graphics.beginFill(0xff0000);
			
			hit_Jungle.graphics.lineTo(261,0);	
			hit_Jungle.graphics.lineTo(531,0);	
			hit_Jungle.graphics.lineTo(530,42);	
			hit_Jungle.graphics.lineTo(493,53);	
			hit_Jungle.graphics.lineTo(499,186);	
			hit_Jungle.graphics.lineTo(461,215);	
			hit_Jungle.graphics.lineTo(455,233);	
			//hit_Jungle.graphics.lineTo(387,215);	
			hit_Jungle.graphics.lineTo(388,229);	
			hit_Jungle.graphics.lineTo(355,150);	
			hit_Jungle.graphics.lineTo(321,143);	
			hit_Jungle.graphics.lineTo(298,55);	
			hit_Jungle.graphics.lineTo(265,51);	
			hit_Jungle.graphics.endFill(false);
			hit_Jungle.alpha = 0.0;
			
			hit_Jungle.graphics.precisionHitTest = true;	
			this.addChild(hit_Jungle);
		}
		
		private function CreateHitPit():void{
			hit_Pit = new Shape();
			hit_Pit.touchable = false;
			hit_Pit.graphics.beginFill(0xff0000);
			
			hit_Pit.graphics.lineTo(143,268);	
			hit_Pit.graphics.lineTo(246,226);	
			hit_Pit.graphics.lineTo(321,229);	
			hit_Pit.graphics.lineTo(450,240);	
			hit_Pit.graphics.lineTo(527,258);	
			hit_Pit.graphics.lineTo(588,368);	
			hit_Pit.graphics.lineTo(593,402);	
			hit_Pit.graphics.lineTo(535,428);	
			hit_Pit.graphics.lineTo(279,413);	
			hit_Pit.graphics.lineTo(189,400);	
			hit_Pit.graphics.lineTo(163,355);	
			hit_Pit.graphics.lineTo(141,325);	

			hit_Pit.graphics.endFill(false);
			hit_Pit.alpha = 0.0;
			
			hit_Pit.graphics.precisionHitTest = true;	
			this.addChild(hit_Pit);
		}
		
		private function CreateHitRibbon():void{
			hit_Ribbon = new Shape();
			hit_Ribbon.touchable = false;
			hit_Ribbon.graphics.beginFill(0xff0000);
			
			hit_Ribbon.graphics.lineTo(99,42);	
			hit_Ribbon.graphics.lineTo(136,48);	
			hit_Ribbon.graphics.lineTo(136,130);	
			hit_Ribbon.graphics.lineTo(173,226);	
			hit_Ribbon.graphics.lineTo(135,239);	
			hit_Ribbon.graphics.lineTo(90,197);	
			hit_Ribbon.graphics.lineTo(76,144);	
			
			hit_Ribbon.graphics.endFill(false);
			hit_Ribbon.alpha = 0.0;
			
			hit_Ribbon.graphics.precisionHitTest = true;	
			this.addChild(hit_Ribbon);
		}
		
		private function CreateHitWall():void{
			hit_Wall = new Shape();
			hit_Wall.touchable = false;
			hit_Wall.graphics.beginFill(0xff0000);
			
			hit_Wall.graphics.lineTo(600,185);	
			hit_Wall.graphics.lineTo(615,96);	
			hit_Wall.graphics.lineTo(681,90);	
			hit_Wall.graphics.lineTo(761,129);	
			hit_Wall.graphics.lineTo(749,294);	
			hit_Wall.graphics.lineTo(655,324);	
			hit_Wall.graphics.lineTo(605,286);	

			hit_Wall.graphics.endFill(false);
			hit_Wall.alpha = 0.0;
			
			hit_Wall.graphics.precisionHitTest = true;	
			this.addChild(hit_Wall);
		}
		//hit_Wall
		//hit_Pit
		//hit_Ribbon
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleEdge as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
						);
					}else if(hit_Jungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						JungleHandler();
					}else if(hit_Pit.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleTarPitPit as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitPitObj,true
						);
					}else if(hit_Wall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleTarPitWall as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitWallObj,true
						);
					}else if(hit_Ribbon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RibbonHandler();
					}else if(hit_WallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wall of the pit is slick with tar and decaying leaves.");
					}else if(hit_WallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pit wall is steep and slippery.");
					}
				}
			}
		}
		
		private function JungleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankFar'] == 'Attached'){
					FadeOut((Jungle as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleObj,true
					);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't reach the other side.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't reach the other side.");
			}
		}
		
		private function RibbonHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPit['Ribbon'] == 'PickedUp'){
					
				}else{
					ribbon.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPit;
					SaveArray['Ribbon'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPit',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ribbon,
						'item_Ribbon',
						'inven_ribbon_sm'
					);
				}
			}else{
				ribbon.alpha = 0;
				SaveArray['Ribbon'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPit',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ribbon,
					'item_Ribbon',
					'inven_ribbon_sm'
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
			
			
			this.assets.removeTexture("jungleTarPit_bg",true);
			this.assets.removeTexture("JungleTarPit_Sprite",true);
			this.assets.removeTextureAtlas("JungleTarPit_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("JungleTarPit_01");
			(stage.getChildAt(0) as Object).falseAsset("JungleTarPit_02");
			(stage.getChildAt(0) as Object).falseAsset("JungleTarPit_03");
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