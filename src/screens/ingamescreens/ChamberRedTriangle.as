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
	
	
	public class ChamberRedTriangle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ItIsRed:Boolean = false;
		
		private var hit_triangle:Shape;
		
		private var hit_room:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function ChamberRedTriangle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberRedTriangle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedTriangle/ChamberRedTriangle_Sprite.jpg'));
				game.TrackAssets('chamberRedTriangle_01');
			}
			if(game.CheckAsset('chamberRedTriangle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedTriangle/ChamberRedTriangle_Sprite.xml'));
				game.TrackAssets('chamberRedTriangle_02');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberRedTriangle","ChamberRedTriangleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Red'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						ItIsRed = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						ItIsRed = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						ItIsRed = true;
					}else{
						
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
							ItIsRed = true;
						}
					}
					
				}else{
					
				}
			}else{
				
			}
			
			if(ItIsRed === true){
				bg = new Image(this.assets.getTexture('chamberRedTriangle_bg_lit'));
			}else{
				bg = new Image(this.assets.getTexture('chamberRedTriangle_bg'));
			}
			
			bg.touchable = true;
			this.addChildAt(bg,0);
			CreateHitRoom();
			CreateHitTriangle();
			
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			if(ItIsRed === true){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedTriangle != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedTriangle['SeenIt'] == 'Yes'){
						
					}else{
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedTriangle;
						SaveArray['SeenIt'] = 'Yes';					
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedTriangle',SaveArray);				
					}				
				}else{
					SaveArray['SeenIt'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedTriangle',SaveArray);
				}
			}
			
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
		}
		
		//hit_triangle
		private function CreateHitRoom():void{
			hit_room = new Shape();
			hit_room.touchable = false;
			hit_room.graphics.beginFill(0xff0000);
			
			hit_room.graphics.lineTo(5,220);
			hit_room.graphics.lineTo(143,3);
			hit_room.graphics.lineTo(545,11);
			hit_room.graphics.lineTo(761,344);
			hit_room.graphics.lineTo(593,503);
			hit_room.graphics.lineTo(96,504);
			
			hit_room.graphics.endFill(false);
			hit_room.alpha = 0.0;
			
			hit_room.graphics.precisionHitTest = true;	
			this.addChild(hit_room);
		}
		
		
		private function CreateHitTriangle():void{
			hit_triangle = new Shape();
			hit_triangle.touchable = false;
			hit_triangle.graphics.beginFill(0xff0000);
			
			hit_triangle.graphics.lineTo(156,404);
			hit_triangle.graphics.lineTo(354,33);
			hit_triangle.graphics.lineTo(419,28);
			hit_triangle.graphics.lineTo(613,355);
			hit_triangle.graphics.lineTo(575,437);
			hit_triangle.graphics.lineTo(218,477);
	
			hit_triangle.graphics.endFill(false);
			hit_triangle.alpha = 0.0;
			
			hit_triangle.graphics.precisionHitTest = true;	
			this.addChild(hit_triangle);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((ChamberRed as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberRedObj,true
						);
						
					}else if(hit_triangle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						if(ItIsRed === false){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A single triangle juts prominently out from the wall.");
							}else if(PhraseCounter == 1){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This triangle is relatively free of the fractal growth forms.");
							}
						}else{
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Solved'] == 'Yes'){
									if(PhraseCounter == 0){
										PhraseCounter = 1;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These circles must represent the brain sizes of the three skulls.");
									}else if(PhraseCounter == 1){
										PhraseCounter = 0;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What common trait could link the three skulls to each other?");
									}
								}else{
									if(PhraseCounter == 0){
										PhraseCounter = 1;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Three circles of different sizes have appeared on the triangle.");
									}else if(PhraseCounter == 1){
										PhraseCounter = 0;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Each circle is perfectly round.");
									}
								}
							}else{
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Three circles of different sizes have appeared on the triangle.");
								}else if(PhraseCounter == 1){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Each circle is perfectly round.");
								}
							}
							
						}
					}else if(hit_room.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						if(ItIsRed === false){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Cubes form pyramids, spheres collide... but none touch the triangle.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The red light glistens off the shapes.");
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
			
			
			this.assets.removeTexture("ChamberRedTriangle_Sprite",true);		
			this.assets.removeTextureAtlas("ChamberRedTriangle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberRedTriangle_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberRedTriangle_02");
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