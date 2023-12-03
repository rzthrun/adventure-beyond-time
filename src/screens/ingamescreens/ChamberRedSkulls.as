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
	
	public class ChamberRedSkulls extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ItIsRed:Boolean = false;
		
		private var pos_01:Image;
		private var pos_02:Image;
		private var pos_03:Image;
		
		private var triangle:Image;
		private var slime:Image;
		
		private var TriangleTween:Tween;
		private var SlimeTween:Tween;
		
		private var hit_pos_01:Shape;
		private var hit_pos_02:Shape;
		private var hit_pos_03:Shape;
		private var hit_triangle:Shape;
		
		private var Pos1:String = null;
		private var Pos2:String = null;
		private var Pos3:String = null;
		
		private var Animating:Boolean = false;
		private var Solved:Boolean = false;
		private var Slimed:Boolean = false;
		
		public var delayedcall:DelayedCall;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function ChamberRedSkulls(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberRedSkulls_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedSkulls/ChamberRedSkulls_Sprite_01.jpg'));
				game.TrackAssets('chamberRedSkulls_01');
			}
			if(game.CheckAsset('chamberRedSkulls_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedSkulls/ChamberRedSkulls_Sprite_01.xml'));
				game.TrackAssets('chamberRedSkulls_02');
			}
			if(game.CheckAsset('chamberRedSkulls_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedSkulls/ChamberRedSkulls_Sprite_02.png'));
				game.TrackAssets('chamberRedSkulls_03');
			}
			if(game.CheckAsset('chamberRedSkulls_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberRedSkulls/ChamberRedSkulls_Sprite_02.xml'));
				game.TrackAssets('chamberRedSkulls_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberRedSkulls","ChamberRedSkullsObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
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
				bg = new Image(this.assets.getTexture('chamberRedSkulls_bg_lit'));
				triangle = new Image(this.assets.getTexture('triangle_red'));
				slime = new Image(this.assets.getTexture('slime_red'));
			}else{
				bg = new Image(this.assets.getTexture('chamberRedSkulls_bg'));
				triangle = new Image(this.assets.getTexture('triangle_white'));
				slime = new Image(this.assets.getTexture('slime_white'));
			}
			
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			//triangle_white
			
		//	triangle.smoothing = TextureSmoothing.NONE;
			triangle.touchable = false;
			triangle.x = 306;
			triangle.y = 190;
			
			//slime.smoothing = TextureSmoothing.NONE;
			slime.touchable = false;
			slime.x = 306;
			slime.y = 185;
			
			
			pos_01 = new Image(this.assets.getTexture('pos_01_alien_white'));
		//	pos_01.smoothing = TextureSmoothing.NONE;
			pos_01.touchable = false;
			pos_01.x = 124;
			pos_01.y = 293;
						
			pos_02 = new Image(this.assets.getTexture('pos_02_alien_white'));
		//	pos_02.smoothing = TextureSmoothing.NONE;
			pos_02.touchable = false;
			pos_02.x = 347;
			pos_02.y = 57;

			pos_03 = new Image(this.assets.getTexture('pos_03_alien_white'));
		//	pos_03.smoothing = TextureSmoothing.NONE;
			pos_03.touchable = false;
			pos_03.x = 465;
			pos_03.y = 295;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'empty'){
					pos_01.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'alien'){
					Pos1 = 'alien';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_alien_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_alien_white');
					}
					pos_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'human'){
					Pos1 = 'human';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_human_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_human_white');
					}
					pos_01.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos01'] == 'hominid'){
					Pos1 = 'hominid';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_human_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_human_white');
					}
					pos_01.alpha = 1;
				}else{
					pos_01.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'empty'){
					pos_02.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'alien'){
					Pos2 = 'alien';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_alien_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_alien_white');
					}
					pos_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'human'){
					Pos2 = 'human';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_human_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_human_white');
					}
					pos_02.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos02'] == 'hominid'){
					Pos2 = 'hominid';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_hominid_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_hominid_white');
					}
					pos_02.alpha = 1;
				}else{
					pos_02.alpha = 0;

				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'empty'){
					pos_03.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'alien'){
					Pos3 = 'alien';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_alien_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_alien_white');
					}
					pos_03.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'human'){
					Pos3 = 'human';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_human_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_human_white');
					}
					pos_03.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Pos03'] == 'hominid'){
					Pos3 = 'hominid';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_hominid_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_hominid_white');
					}
					pos_03.alpha = 1;
				}else{
					pos_03.alpha = 0;

				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Solved'] == 'Yes'){
					Solved = true;
					triangle.alpha = 1;
				}else{
					triangle.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Slimed'] == 'Yes'){
					Slimed = true;
					slime.alpha = 1;
				}else{
					slime.alpha = 0;
				}
				
			}else{
				pos_01.alpha = 0;
				pos_02.alpha = 0;				
				pos_03.alpha = 0;
				triangle.alpha = 0;
				slime.alpha = 0;
				
			}
			
			
		
			
		
			this.addChildAt(triangle,1);			
			this.addChildAt(slime,2);			
			this.addChildAt(pos_01,3);			
			this.addChildAt(pos_02,4);			
			this.addChildAt(pos_03,5);
			
			//FadeOutOcean(1);
			
			CreatePosHits();
			CreateTriangleHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
		//	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
		//				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hominid,
		//				'item_Hominid',
		//				'inven_hominid_sm'
		//			);
			
		}
		
		private function CreateTriangleHit():void{
			hit_triangle = new Shape();
			hit_triangle.touchable = false;
			hit_triangle.graphics.beginFill(0xff0000);
			
			hit_triangle.graphics.lineTo(282,298);
			hit_triangle.graphics.lineTo(326,200);
			hit_triangle.graphics.lineTo(424,197);
			hit_triangle.graphics.lineTo(483,284);
			hit_triangle.graphics.lineTo(438,341);
			hit_triangle.graphics.lineTo(313,343);
			
			hit_triangle.graphics.endFill(false);
			hit_triangle.alpha = 0.0;
			
			hit_triangle.graphics.precisionHitTest = true;	
			this.addChild(hit_triangle);
		}
		
		private function CreatePosHits():void{
			hit_pos_01 = new Shape();
			hit_pos_01.touchable = false;
			hit_pos_01.graphics.beginFill(0xff0000);
			
			hit_pos_01.graphics.lineTo(96,377);
			hit_pos_01.graphics.lineTo(216,248);
			hit_pos_01.graphics.lineTo(236,252);
			hit_pos_01.graphics.lineTo(318,365);
			hit_pos_01.graphics.lineTo(319,442);
			hit_pos_01.graphics.lineTo(183,471);
			
			hit_pos_01.graphics.endFill(false);
			hit_pos_01.alpha = 0.0;
			
			hit_pos_01.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_01);
			
			hit_pos_02 = new Shape();
			hit_pos_02.touchable = false;
			hit_pos_02.graphics.beginFill(0xff0000);
			
			hit_pos_02.graphics.lineTo(263,170);
			hit_pos_02.graphics.lineTo(356,0);
			hit_pos_02.graphics.lineTo(438,0);
			hit_pos_02.graphics.lineTo(523,140);
			hit_pos_02.graphics.lineTo(493,188);
			hit_pos_02.graphics.lineTo(300,200);

			hit_pos_02.graphics.endFill(false);
			hit_pos_02.alpha = 0.0;
			
			hit_pos_02.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_02);
			
			
			hit_pos_03 = new Shape();
			hit_pos_03.touchable = false;
			hit_pos_03.graphics.beginFill(0xff0000);
			
			hit_pos_03.graphics.lineTo(418,391);
			hit_pos_03.graphics.lineTo(531,230);
			hit_pos_03.graphics.lineTo(579,231);
			hit_pos_03.graphics.lineTo(678,384);
			hit_pos_03.graphics.lineTo(586,475);
			hit_pos_03.graphics.lineTo(447,469);

			hit_pos_03.graphics.endFill(false);
			hit_pos_03.alpha = 0.0;
			
			hit_pos_03.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_03);

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
							FadeOut((ChamberRed as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberRedObj,true
							);
						}else if(hit_pos_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Solved === false){
								Pos01Handler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I should leave the skull in place.");
							}
						}else if(hit_pos_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Solved === false){
								Pos02Handler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I should leave the skull where it is.");
							}
						}else if(hit_pos_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Solved === false){
								Pos03Handler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I should leave that where it is.");
							}
						}else if(hit_triangle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Solved === false){
								
							}else{
								if(Slimed === false){
									if(ItIsRed === true){
										SlimeFadeIn();
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Another triangle has appeared.");
									}
								}else{
									SlimePickerUpper();
								}
							}
						}
					}
				}
			}
		}
		
		private function SlimePickerUpper():void{
			trace("SLIME PIOCKER UPPER");
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls['Slime'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I have enough slime for today.");
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
							
						},1.5);
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Slime'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slime,
						'item_Slime',
						'inven_slime_sm'
					);	
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
						
					},1.5);
				}
				SaveArray['Slime'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Slime,
					'item_Slime',
					'inven_slime_sm'
				);	
			}
		}
		
		
		private function Pos03Handler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Alien)
			{
				
				if(Pos3 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos3 = 'alien';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_alien_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_alien_white');
					}
					pos_03.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos03'] = "alien";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Alien,
							"item_Alien"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Human)
			{
				
				if(Pos3 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos3 = 'human';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_human_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_human_white');
					}
					pos_03.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos03'] = "human";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Human,
							"item_Human"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Hominid)
			{
				
				if(Pos3 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos3 = 'hominid';
					if(ItIsRed === true){
						pos_03.texture = this.assets.getTexture('pos_03_hominid_red');
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_hominid_white');
					}
					pos_03.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos03'] = "hominid";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Hominid,
							"item_Hominid"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else{
				if(Pos3 == null){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A shallow ledge cuts into the wall.");
				}else{
					if(Pos3 == 'alien'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alien,
							'item_Alien',
							'inven_alien_sm'
						);
					}else if(Pos3 == 'human'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Human,
							'item_Human',
							'inven_human_sm'
						);
					}else if(Pos3 == 'hominid'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hominid,
							'item_Hominid',
							'inven_hominid_sm'
						);
					}
					pos_03.alpha = 0;
					Pos3 = null;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos03'] = "empty";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
				}
			}
		}
		
		private function Pos02Handler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Alien)
			{
				if(Pos2 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos2 = 'alien';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_alien_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_alien_white');
					}
					pos_02.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos02'] = "alien";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Alien,
							"item_Alien"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Human)
			{
				if(Pos2 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos2 = 'human';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_human_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_human_white');
					}
					pos_02.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos02'] = "human";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Human,
							"item_Human"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Hominid)
			{
				if(Pos2 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos2 = 'hominid';
					if(ItIsRed === true){
						pos_02.texture = this.assets.getTexture('pos_02_hominid_red');
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_hominid_white');
					}
					pos_02.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos02'] = "hominid";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Hominid,
							"item_Hominid"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else{
				if(Pos2 == null){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The alcove is in the shape of a triangle.");
				}else{
					if(Pos2 == 'alien'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alien,
							'item_Alien',
							'inven_alien_sm'
						);
					}else if(Pos2 == 'human'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Human,
							'item_Human',
							'inven_human_sm'
						);
					}else if(Pos2 == 'hominid'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hominid,
							'item_Hominid',
							'inven_hominid_sm'
						);
					}
					pos_02.alpha = 0;
					Pos2 = null;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos02'] = "empty";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
				}
			}
		}
		
		
		private function Pos01Handler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Alien)
			{
				if(Pos1 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos1 = 'alien';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_alien_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_alien_white');
					}
					pos_01.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos01'] = "alien";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Alien,
							"item_Alien"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Human)
			{
				if(Pos1 == null){
				//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos1 = 'human';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_human_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_human_white');
					}
					pos_01.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos01'] = "human";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Human,
							"item_Human"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Hominid)
			{
				if(Pos1 == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					Pos1 = 'hominid';
					if(ItIsRed === true){
						pos_01.texture = this.assets.getTexture('pos_01_hominid_red');
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_hominid_white');
					}
					pos_01.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos01'] = "hominid";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Hominid,
							"item_Hominid"
						);
					Solve();
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should pick up the skull that's already there before trying to put another in.");
				}
			}else{
				if(Pos1 == null){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's impossible to tell if the crevasses were made by intelligent beings or by nature.");
				}else{
					if(Pos1 == 'alien'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Alien,
							'item_Alien',
							'inven_alien_sm'
						);
					}else if(Pos1 == 'human'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Human,
							'item_Human',
							'inven_human_sm'
						);
					}else if(Pos1 == 'hominid'){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hominid,
							'item_Hominid',
							'inven_hominid_sm'
						);
					}
					pos_01.alpha = 0;
					Pos1 = null;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
					}
					SaveArray['Pos01'] = "empty";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
				}
			}
		}
		
		
		private function Solve():void{
			if(ItIsRed === true){
				if(Pos1 == 'alien'){
					if(Pos2 == 'human'){
						if(Pos3 == 'hominid'){
							Animating = true;
							Solved = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
							}
							SaveArray['Solved'] = "Yes";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
							
							delayedcall = new DelayedCall(function():void{
								Animating = false;
								TriangleFadeIn();
								//FadeOut(CliffCave,(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCaveObj,true)
							},1);
							Starling.juggler.add(delayedcall);
						}
					}
				}
			}
		}
		
		private function TriangleFadeIn():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TriangleTween = new Tween(triangle, 3, Transitions.LINEAR);
			TriangleTween.fadeTo(1);
			TriangleTween.onComplete = function():void{
				Animating = false;
			//	anima_laser.alpha = 0;
				TriangleTween = null;
			}
			Starling.juggler.add(TriangleTween);
		}
		
		private function SlimeFadeIn():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberRedSkulls;
			}
			SaveArray['Slimed'] = "Yes";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberRedSkulls',SaveArray);
			
			
			Slimed = true;
			Animating = true;
			SlimeTween = new Tween(slime, 3, Transitions.LINEAR);
			SlimeTween.fadeTo(1);
			SlimeTween.onComplete = function():void{
				Animating = false;
				//	anima_laser.alpha = 0;
				SlimeTween = null;
			}
			Starling.juggler.add(SlimeTween);
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
			
			
		
			this.assets.removeTexture("ChamberRedSkulls_Sprite_01",true);
			this.assets.removeTextureAtlas("ChamberRedSkulls_Sprite_01",true);
			this.assets.removeTexture("ChamberRedSkulls_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberRedSkulls_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberRedSkulls_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberRedSkulls_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberRedSkulls_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberRedSkulls_04");
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