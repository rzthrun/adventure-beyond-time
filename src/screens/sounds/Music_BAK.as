package screens.sounds
{
	import flash.filesystem.File;
	import flash.media.Sound;
	
	import starling.utils.AssetManager;

	public class Music
	{
		public var assets:AssetManager;
		public var soundManager:SoundManager;
		public var MUS_MainTheme:Sound;
		public var MUS_KidsBells:Sound;
		public var MUS_MainThemeReduced:Sound;
		
	//	public var channel:SoundChannel;
	//	public var volumeAdjust:SoundTransform = new SoundTransform();
		
		public var globalVol:Number = 0.5;
		
		public var currentSong:String = null;
		
		public var pauseArr:Array = new Array();
		
		public function Music()
		{
			this.assets = new AssetManager();
			soundManager = new SoundManager();
		}
		
		
		
		public function LoadMainThemeReduced(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("MainThemeReduced")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Main_Theme_Reduced_One_v001a002.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyMainThemeReduced(p,r,t);
					}
				});
			}
		}
		private function ReadyMainThemeReduced(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_MainThemeReduced = assets.getSound("Main_Theme_Reduced_One_v001a002");
			soundManager.addSound("MainThemeReduced", MUS_MainThemeReduced);
			if(p === true){
				Play_MainThemeReduced(r);
			}
		}
		
		public function Play_MainThemeReduced(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "MainThemeReduced";
			soundManager.playSound("MainThemeReduced",0,repeatCount);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("MainThemeReduced",globalVol,t);
		}
		
		
		
	
		
		
		
		
//---------------------------------------------------------------		
		
		public function LoadMainTheme():void{
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Main_Theme_2013_08_18_003.mp3'));			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
				//	soundManager = new SoundManager();
//					soundManager = SoundManager.getInstance();
					ReadyMainTheme();
				}
			});
		}
		private function ReadyMainTheme():void{
			
			MUS_MainTheme = assets.getSound("Main_Theme_2013_08_18_003");
			soundManager.addSound("MainTheme", MUS_MainTheme);
		}
		
		public function Play_MainTheme(repeatCount:Number = 0):void{
			currentSong = "MainTheme";
			soundManager.playSound("MainTheme",globalVol,repeatCount);
		}
		
		
		
//---------------------------------------------------------------		
		
		public function LoadKidsBells(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("KidsBells")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/KidsBells_v001a001.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyKidsBells(p,r);
					}
				});
			}
		}
		private function ReadyKidsBells(p:Boolean = false,r:Number = 0,t:Number = 0):void{
		//	soundManager = SoundManager.getInstance();
			MUS_KidsBells = assets.getSound("KidsBells_v001a001");
			soundManager.addSound("KidsBells", MUS_KidsBells);
			if(p === true){
				Play_KidsBells(r);
			}
		}
		
		public function Play_KidsBells(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "KidsBells";
			soundManager.playSound("KidsBells",0,repeatCount);
			//soundManager.setVolume("KidsBells", 0);
			soundManager.tweenVolume("KidsBells",globalVol,t);
		}
//------------------------------------------------------------------		
		public function PauseAll():void{
			if(MUS_MainTheme != null){
				pauseArr['MainTheme'] = soundManager.getPausePos("MainTheme");
				soundManager.stopSound('MainTheme');
			}
			if(MUS_KidsBells  != null){
				pauseArr['KidsBells'] =  soundManager.getPausePos("KidsBells");
				soundManager.stopSound('KidsBells');
			}
			if(MUS_MainThemeReduced != null){
				
				pauseArr['MainThemeReduced'] =  soundManager.getPausePos("MainThemeReduced");
				soundManager.stopSound('MainThemeReduced');
			}
			
		
			
		}
		public function resumeCurrentSong():void{
			trace("currentSong "+currentSong);
			trace("pauseArr[currentSong] "+pauseArr[currentSong]);
			trace("pauseArr[currentSong]/1000 "+(pauseArr[currentSong]/1000));
			if(currentSong != null){
				var startPos:Number = (pauseArr[currentSong]);
				soundManager.ResumeSound(currentSong,globalVol,0,0,startPos);
			}
		}
		
		
		
	}
}