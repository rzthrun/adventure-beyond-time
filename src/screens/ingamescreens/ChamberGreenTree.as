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
	
	
	public class ChamberGreenTree extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var tree:Image;
		private var tube:Image;
		private var sprarks:Image;
		
		private var hit_tree:Shape;
		
		private var TreeTween:Tween;
		private var SparksTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var ItIsLit:Boolean = false;
		private var Solved:Boolean = false;
		private var goback:GoBackButton;
		private var Animating:Boolean = false;
		private var PlasmaAttached:Boolean = false;
		public var delayedCall:DelayedCall;
		public function ChamberGreenTree(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberGreenTree_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite.jpg'));
				game.TrackAssets('chamberGreenTree_01');
			}
			if(game.CheckAsset('chamberGreenTree_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite.xml'));
				game.TrackAssets('chamberGreenTree_02');
			}
			if(game.CheckAsset('chamberGreenTree_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite_02.atf'));
				game.TrackAssets('chamberGreenTree_03');
			}
			if(game.CheckAsset('chamberGreenTree_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite_02.xml'));
				game.TrackAssets('chamberGreenTree_04');
			}
			if(game.CheckAsset('chamberGreenTree_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite_03.png'));
				game.TrackAssets('chamberGreenTree_05');
			}
			if(game.CheckAsset('chamberGreenTree_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberGreenTree/ChamberGreenTree_Sprite_03.xml'));
				game.TrackAssets('chamberGreenTree_06');
			}
			//ChamberGreenTree_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberGreenTree","ChamberGreenTreeObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
		
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Green'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 0){
						ItIsLit = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						ItIsLit = true;			
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
							ItIsLit = true;
						}
					}
				}
			}
			if(ItIsLit === false){
				bg = new Image(this.assets.getTexture('chamberGreenTree_bg'));
				
			}else{
				bg = new Image(this.assets.getTexture('chamberGreenTree_bg_lit'));
			}
			
			
			
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			if(ItIsLit === false){
				tube = new Image(this.assets.getTexture('tube_white'));
				tree = new Image(this.assets.getTexture('blue_tree'));
			}else{
				tube = new Image(this.assets.getTexture('tube_green'));
				tree = new Image(this.assets.getTexture('blue_tree_lit'));
			}
			tube.smoothing = TextureSmoothing.NONE;
			tree.smoothing = TextureSmoothing.NONE;
			
			tube.touchable = false;
			tube.x = 328;
			tube.y = 222;
	
		
			tree.touchable = false;
			tree.x = 153;
			tree.y = 47;
	
			
			sprarks = new Image(this.assets.getTexture('sparks'));
			sprarks.touchable = false;
			sprarks.x = 77;
			sprarks.y = 225;
			
			
		//	SaveArray['Solved'] = "no";
		//	SaveArray['Plasma'] = "no";
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreenTree',SaveArray);
			
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree['Plasma'] == 'Attached'){
					tube.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree['Solved'] == 'Yes'){
						Solved = true;
						tree.alpha = 1;
						if(ItIsLit){
							sprarks.alpha = 1;
						}else{
							sprarks.alpha = 0;
						}
					}else{
						sprarks.alpha = 0;
						tree.alpha = 0;
						if(ItIsLit === true){
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree;
							}
							SaveArray['Solved'] = "Yes";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreenTree',SaveArray);
							delayedCall = new DelayedCall(FadeInSparks,2);
							Starling.juggler.add(delayedCall);	
						}else{
							sprarks.alpha = 0;
							tree.alpha = 0;
						}
					}
				}else{
					tree.alpha = 0;
					tube.alpha = 0;
					sprarks.alpha = 0;
				}
			}else{
				tube.alpha = 0;
				tree.alpha = 0;
				sprarks.alpha = 0;
			}
			
			
			
			this.addChildAt(tube,1);			
			this.addChildAt(tree,2);						
			this.addChildAt(sprarks,3);

			CreateHitTree();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
			

		}
		
		
		private function CreateHitTree():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(110,227);												
			hit_tree.graphics.lineTo(240,40);												
			hit_tree.graphics.lineTo(516,37);												
			hit_tree.graphics.lineTo(665,223);												
			hit_tree.graphics.lineTo(401,418);												

			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((ChamberGreen as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberGreenObj,true
							);
						}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							TreeHandler();
						}
					}
				}
			}
		}
		
		private function TreeHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Plasma)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				
				PlasmaAttached == true;
				Animating = true;
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Plasma,
						"item_Plasma"
					);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberGreenTree;
				}
				SaveArray['Plasma'] = "Attached";
				
				
				tube.alpha = 1;
				
				if(ItIsLit === true){
					
					SaveArray['Solved'] = "Yes";
					delayedCall = new DelayedCall(FadeInSparks,1.25);
					Starling.juggler.add(delayedCall);	
					
					
						
						(stage.getChildAt(0) as Object).MusicObj.LoadDeepSpace(true,1);

					
				}else{
					Animating = false;
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The strange metal creature seems interested in this stone, but it's not leaving the tube.");

				}
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberGreenTree',SaveArray);
			}else{
				trace("1");
				if(Solved === false){
					trace("2");
					if(PlasmaAttached === false){
						trace("3");
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A tree-like pattern is etched into the stone.");

					}else{
						trace("4");
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The strange metal creature seems interested in this stone, but it's not leaving the tube.");

					}
				}else{
					trace("5");
					if(ItIsLit === true){
						trace("6");
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tree glows an iridescent blue.");

					}else{
						trace("7");
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A blue outline remains on the surface.");

					}
				}
			}
			
		}
		
		private function FadeInTree():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
			
			TreeTween = new Tween(tree, 2.5, Transitions.LINEAR);
			TreeTween.fadeTo(1);
			TreeTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterBoil();
				ChangeRoom();
				TreeTween = null;
			}
			Starling.juggler.add(TreeTween);
		}
		
		private function FadeInSparks():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterBoil();
			SparksTween = new Tween(sprarks, 1.5, Transitions.LINEAR);
			SparksTween.fadeTo(1);
			SparksTween.onComplete = function():void{
				FadeInTree();
				SparksTween = null;
				delayedCall = null;
			}
			Starling.juggler.add(SparksTween);
		}
		
		private function ChangeRoom():void{
			delayedCall = new DelayedCall(function():void{
				
				FadeOut((ChamberGreen as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberGreenObj,true
				);
				
				Animating = false;
			},1.25);
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
			
			
		
			this.assets.removeTexture("ChamberGreenTree_Sprite",true);
			this.assets.removeTextureAtlas("ChamberGreenTree_Sprite",true);
			this.assets.removeTexture("ChamberGreenTree_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberGreenTree_Sprite_02",true);
			this.assets.removeTexture("ChamberGreenTree_Sprite_03",true);
			this.assets.removeTextureAtlas("ChamberGreenTree_Sprite_03",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_04");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_05");
			(stage.getChildAt(0) as Object).falseAsset("chamberGreenTree_06");
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