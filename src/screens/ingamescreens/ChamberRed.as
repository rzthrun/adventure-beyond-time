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
	import starling.utils.AssetManager;
	
	
	
	public class ChamberRed extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var skulls_pos_01:Image;
		private var skulls_pos_02:Image;
		private var skulls_pos_03:Image;
		private var skulls_triangle:Image;
		private var skulls_slime:Image;
		
		private var hit_skulls:Shape;
		private var hit_triangle:Shape;
		
		private var hit_room:Shape;
		private var PhraseCounter:int = 0;
		
		private var ItIsRed:Boolean = false;
		
	
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function ChamberRed(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberRed_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRed/ChamberRed_Sprite_01.jpg'));
				game.TrackAssets('chamberRed_01');
			}
			if(game.CheckAsset('chamberRed_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRed/ChamberRed_Sprite_01.xml'));
				game.TrackAssets('chamberRed_02');
			}
			if(game.CheckAsset('chamberRed_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRed/ChamberRed_Sprite.png'));
				game.TrackAssets('chamberRed_03');
			}
			if(game.CheckAsset('chamberRed_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRed/ChamberRed_Sprite.xml'));
				game.TrackAssets('chamberRed_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberRed","ChamberRedObj");
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
				bg = new Image(this.assets.getTexture('chamberRed_bg_lit'));
				skulls_triangle = new Image(this.assets.getTexture('skulls_triangle_red'));
				skulls_slime = new Image(this.assets.getTexture('skulls_slime_red'));
			}else{
				bg = new Image(this.assets.getTexture('chamberRed_bg'));
				skulls_triangle = new Image(this.assets.getTexture('skulls_triangle_white'));
				skulls_slime = new Image(this.assets.getTexture('skulls_slime_white'));
			}
			
			
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			skulls_triangle.touchable = false;
			skulls_triangle.x = 496;
			skulls_triangle.y = 170;
			
			
			skulls_slime.touchable = false;
			skulls_slime.x = 483;
			skulls_slime.y = 170;
			
			skulls_pos_01 = new Image(this.assets.getTexture('skulls_pos_01_alien_white'));
			skulls_pos_01.touchable = false;
			skulls_pos_01.x = 421;
			skulls_pos_01.y = 217;
			
			skulls_pos_02 = new Image(this.assets.getTexture('skulls_pos_02_alien_white'));
			skulls_pos_02.touchable = false;
			skulls_pos_02.x = 522;
			skulls_pos_02.y = 103;
			
			
			skulls_pos_03 = new Image(this.assets.getTexture('skulls_pos_03_alien_white'));
			skulls_pos_03.touchable = false;
			skulls_pos_03.x = 586;
			skulls_pos_03.y = 223;
			
			/*
			private var skulls_pos_01:Image;
			private var skulls_pos_02:Image;
			private var skulls_pos_03:Image;
			*/
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'empty'){
					skulls_pos_01.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'alien'){
					if(ItIsRed === true){
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_alien_red');
					}else{
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_alien_white');
					}
					skulls_pos_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'human'){
					if(ItIsRed === true){
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_human_red');
					}else{
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_human_white');
					}
					skulls_pos_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'hominid'){
					if(ItIsRed === true){
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_hominid_red');
					}else{
						skulls_pos_01.texture = this.assets.getTexture('skulls_pos_01_hominid_white');
					}
					skulls_pos_01.alpha = 1;
				}else{
					skulls_pos_01.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'empty'){
					skulls_pos_02.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'alien'){
					if(ItIsRed === true){
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_alien_red');
					}else{
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_alien_white');
					}
					skulls_pos_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'human'){
					if(ItIsRed === true){
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_human_red');
					}else{
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_human_white');
					}
					skulls_pos_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'hominid'){
					if(ItIsRed === true){
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_hominid_red');
					}else{
						skulls_pos_02.texture = this.assets.getTexture('skulls_pos_02_hominid_white');
					}
					skulls_pos_02.alpha = 1;
				}else{
					skulls_pos_02.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'empty'){
					skulls_pos_03.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'alien'){
					if(ItIsRed === true){
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_alien_red');
					}else{
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_alien_white');
					}
					skulls_pos_03.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'human'){
					if(ItIsRed === true){
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_human_red');
					}else{
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_human_white');
					}
					skulls_pos_03.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'hominid'){
					if(ItIsRed === true){
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_hominid_red');
					}else{
						skulls_pos_03.texture = this.assets.getTexture('skulls_pos_03_hominid_white');
					}
					skulls_pos_03.alpha = 1;
				}else{
					skulls_pos_03.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Solved'] == 'Yes'){
					skulls_triangle.alpha = 1;
				}else{
					skulls_triangle.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Slimed'] == 'Yes'){
					skulls_slime.alpha = 1;
				}else{
					skulls_slime.alpha = 0;
				}
			}else{
				skulls_pos_01.alpha = 0;
				skulls_pos_02.alpha = 0;
				skulls_pos_03.alpha = 0;
				skulls_triangle.alpha = 0;
				skulls_slime.alpha = 0;
			}
			
			
			this.addChildAt(skulls_triangle,1);
			this.addChildAt(skulls_slime,2);
			this.addChildAt(skulls_pos_01,3);
			this.addChildAt(skulls_pos_02,4);
			this.addChildAt(skulls_pos_03,5);
			CreateHitRoom();
			CreateHitSkulls();
			CreateHitTriangle();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRed != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRed['FirstTime'] == 'Yes'){
					
				}else{
					if(ItIsRed === true){
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRed;
							SaveArray['FirstTime'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRed',SaveArray);
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadDeepSpace(true,1);
								
							},1.5);
						}
					}
				}
			}else{
				if(ItIsRed === true){
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRed',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							//	Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadDeepSpace(true,1);
							//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
						},1.5);
					}
				}
			}
			
			
		}
		
		
		private function CreateHitRoom():void{
			hit_room = new Shape();
			hit_room.touchable = false;
			hit_room.graphics.beginFill(0xff0000);
			
			hit_room.graphics.lineTo(0,180);
			hit_room.graphics.lineTo(120,0);
			hit_room.graphics.lineTo(626,0);
			hit_room.graphics.lineTo(800,149);
			hit_room.graphics.lineTo(800,376);
			hit_room.graphics.lineTo(330,408);
			hit_room.graphics.lineTo(0,350);
			
			
			hit_room.graphics.endFill(false);
			hit_room.alpha = 0.0;
			
			hit_room.graphics.precisionHitTest = true;	
			this.addChild(hit_room);
		}
		
		private function CreateHitTriangle():void{
			hit_triangle = new Shape();
			hit_triangle.touchable = false;
			hit_triangle.graphics.beginFill(0xff0000);
			
			hit_triangle.graphics.lineTo(55,287);
			hit_triangle.graphics.lineTo(130,120);
			hit_triangle.graphics.lineTo(208,129);
			hit_triangle.graphics.lineTo(261,268);
			hit_triangle.graphics.lineTo(227,320);
			hit_triangle.graphics.lineTo(84,344);
			
			hit_triangle.graphics.endFill(false);
			hit_triangle.alpha = 0.0;
			
			hit_triangle.graphics.precisionHitTest = true;	
			this.addChild(hit_triangle);
		}
		private function CreateHitSkulls():void{
			hit_skulls = new Shape();
			hit_skulls.touchable = false;
			hit_skulls.graphics.beginFill(0xff0000);
			
			hit_skulls.graphics.lineTo(363,246);
			hit_skulls.graphics.lineTo(462,76);
			hit_skulls.graphics.lineTo(644,65);
			hit_skulls.graphics.lineTo(716,302);
			hit_skulls.graphics.lineTo(606,337);
			hit_skulls.graphics.lineTo(396,334);
			
			hit_skulls.graphics.endFill(false);
			hit_skulls.alpha = 0.0;
			
			hit_skulls.graphics.precisionHitTest = true;	
			this.addChild(hit_skulls);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Chamber as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
						);
					}else if(hit_skulls.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((ChamberRedSkulls as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberRedSkullsObj,true
						);
					}else if(hit_triangle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((ChamberRedTriangle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberRedTriangleObj,true
						);
						
					}else if(hit_room.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){					
						
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shape of this roome makes my head spin.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The small chamber is glowing a blood red.");
							}
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("All types of geometric forms cover the walls.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can feel deep vibrations through my feet.");
							}
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							if(ItIsRed === false){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pyramids, spheres and all types of polyhedrons dance across the rock.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think these bizarre shapes are part of the mountain... always have been...");
							}
						}
						
					}
					
					/*
					
					private var hit_room:Shape;
					private var PhraseCounter:Shape;
					*/
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
			
			
			this.assets.removeTexture("ChamberRed_Sprite_01",true);
			this.assets.removeTexture("ChamberRed_Sprite",true);
			this.assets.removeTextureAtlas("ChamberRed_Sprite_01",true);
			this.assets.removeTextureAtlas("ChamberRed_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberRed_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberRed_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberRed_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberRed_04");
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