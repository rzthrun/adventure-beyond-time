package screens.sounds
{
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class VolSlider extends Sprite
	{
		public var bg:Image;
		public var slider:Image;
		public var sliderHolder:Sprite;
		public var hit_slider:Shape;
		private var assets:AssetManager;
		
		private var Lable:Image;
		
		private var hit_Slider:Shape;
		
		private var _identity:String = ""
		
		public function VolSlider(textureRef:AssetManager,identity:String)
		{
			super();
			_identity = identity;
			assets = textureRef;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			bg = new Image(assets.getTexture("VolBG"));
			this.addChild(bg);
			
			sliderHolder = new Sprite();
			sliderHolder.x = 14+(412/2);
			sliderHolder.y = 16;
			this.addChild(sliderHolder);
			
			slider = new Image(assets.getTexture("VolButton"));
			slider.x = 27;
		//	slider.y = 36;
			slider.y = 28;
			slider.pivotX = 24.5;
			//slider.pivotY = 36.5;
			slider.pivotY = 25.5;
			this.sliderHolder.addChild(slider);
			CreateHitSlider();
			
			if(_identity == 'Music'){
				if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol != undefined){
					trace(((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol));
					sliderHolder.x = ((((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol)*4)*100)+13;
					trace("sliderHolder.x: "+sliderHolder.x);
				//	(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol);
				}
				Lable = new Image(assets.getTexture("MusicVol"));
				Lable.y = 20;
				Lable.x = -285;
				this.addChild(Lable);
				
			}
			if(_identity == 'SoundFX'){
				if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol != undefined){
					trace(((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol));
					sliderHolder.x = ((((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.SoundFXVol)*4)*100)+13;
					trace("sliderHolder.x: "+sliderHolder.x);
					//	(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol);
				}
				Lable = new Image(assets.getTexture("SoundFXVol"));
				Lable.y = 20;
				Lable.x = -270;
				this.addChild(Lable);
			}
			if(_identity == 'Ambient'){
				if((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol != undefined){
					trace(((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol));
					sliderHolder.x = ((((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.AmbientVol)*4)*100)+13;
					trace("sliderHolder.x: "+sliderHolder.x);
					//	(stage.getChildAt(0) as Object).MusicObj.soundManager.setGlobalVolume((stage.getChildAt(0) as Object).SavedGame.SavedSoundObj.data.MusicVol);
				}
				Lable = new Image(	assets.getTexture("AmbientVol"));
				Lable.y = 0;
				Lable.x = -300;
				this.addChild(Lable);
			}
			
			
		}
		
		private function CreateHitSlider():void{
			hit_slider = new Shape();
			this.sliderHolder.addChild(hit_slider);
			hit_slider.graphics.beginFill(0x00FF00);
			hit_slider.graphics.lineTo(-20,-15);	
			hit_slider.graphics.lineTo(70,-15);	
			hit_slider.graphics.lineTo(70,75);	
			hit_slider.graphics.lineTo(-20,75);	
			
			hit_slider.touchable = false;
			hit_slider.graphics.endFill(false);
			hit_slider.alpha = 0.0;
			hit_slider.graphics.precisionHitTest = true;	
		}
		
		
	}
}