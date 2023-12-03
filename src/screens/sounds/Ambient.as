package screens.sounds
{
	import flash.filesystem.File;
	import flash.media.Sound;
	
	import starling.utils.AssetManager;
	
	
	
	public class Ambient
	{
		public var assets:AssetManager;
		public var soundManager:SoundManager;
		
		public var MUS_Crickets_01:Sound
		public var MUS_Waves_01:Sound
		public var MUS_Waves_02:Sound
		public var MUS_Jungle_01:Sound
		public var MUS_BurningFireOne:Sound;
		public var MUS_BirdsOne:Sound;
		public var MUS_ShipGroansOne:Sound;
		public var MUS_CaveDrips:Sound;
		public var MUS_CaveDripsStream:Sound;
		public var MUS_ShipCreaks:Sound;
		public var MUS_Waterfall:Sound;
		public var MUS_TVStatic:Sound;
		public var MUS_WindOne:Sound;
		public var MUS_ElectricHum:Sound;
		public var MUS_Crows:Sound;
		public var MUS_Darkness:Sound;
		public var MUS_SpaceHum:Sound;
		public var MUS_SpaceHumPower:Sound;
		public var MUS_Sonar:Sound;
		
		public var globalVol:Number = 0.5;
		
		
		public var currentAmbient:String = null;
		
		public var pauseArr:Array = new Array();
		
		private var paused:Boolean = false;
		
		public function Ambient()
		{
			this.assets = new AssetManager();
			soundManager = new SoundManager();
			
		}
		public function Null_CurrentAmbient():void{
			currentAmbient = null;
		}
		//public var MUS_SpaceHum:Sound;
		//public var MUS_SpaceHumPower:Sound;
		
		//----------------------------------------------------------------		
		public function LoadSpaceHumPower(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SpaceHumPower")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/SpaceHumPower.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySpaceHumPower(p,r,t);
					}
				});
			}
		}
		private function ReadySpaceHumPower(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SpaceHumPower = assets.getSound("SpaceHumPower");
			soundManager.addSound("SpaceHumPower", MUS_SpaceHumPower);
			if(p === true){
				Play_SpaceHumPower(r,t);
			}
		}
		
		public function Play_SpaceHumPower(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "SpaceHumPower";
			soundManager.playMusic("SpaceHumPower",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SpaceHumPower",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		//MUS_Sonar
		//----------------------------------------------------------------		
		public function LoadSonar(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Sonar")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Sonar.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySonar(p,r,t);
					}
				});
			}
		}
		private function ReadySonar(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.Sonar();
			MUS_Sonar = assets.getSound("Sonar");
			soundManager.addSound("Sonar", MUS_Sonar);
			if(p === true){
				Play_Sonar(r,t);
			}
		}
		
		public function Play_Sonar(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Sonar";
			soundManager.playMusic("Sonar",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Sonar",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadSpaceHum(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SpaceHum")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/SpaceHum.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySpaceHum(p,r,t);
					}
				});
			}
		}
		private function ReadySpaceHum(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SpaceHum = assets.getSound("SpaceHum");
			soundManager.addSound("SpaceHum", MUS_SpaceHum);
			if(p === true){
				Play_SpaceHum(r,t);
			}
		}
		
		public function Play_SpaceHum(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "SpaceHum";
			soundManager.playMusic("SpaceHum",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SpaceHum",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadDarkness(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Darkness")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Darkness.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyDarkness(p,r,t);
					}
				});
			}
		}
		private function ReadyDarkness(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Darkness = assets.getSound("Darkness");
			soundManager.addSound("Darkness", MUS_Darkness);
			if(p === true){
				Play_Darkness(r,t);
			}
		}
		
		public function Play_Darkness(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Darkness";
			soundManager.playMusic("Darkness",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Darkness",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadCrows(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Crows")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Crows.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyCrows(p,r,t);
					}
				});
			}
		}
		private function ReadyCrows(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Crows = assets.getSound("Crows");
			soundManager.addSound("Crows", MUS_Crows);
			if(p === true){
				Play_Crows(r,t);
			}
		}
		
		public function Play_Crows(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Crows";
			soundManager.playMusic("Crows",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Crows",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadElectricHum(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("ElectricHum")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/ElectricHum.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyElectricHum(p,r,t);
					}
				});
			}
		}
		private function ReadyElectricHum(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_ElectricHum = assets.getSound("ElectricHum");
			soundManager.addSound("ElectricHum", MUS_ElectricHum);
			if(p === true){
				Play_ElectricHum(r,t);
			}
		}
		
		public function Play_ElectricHum(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "ElectricHum";
			soundManager.playMusic("ElectricHum",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("ElectricHum",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadTVStatic(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("TVStatic")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/TVStatic.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyTVStatic(p,r,t);
					}
				});
			}
		}
		private function ReadyTVStatic(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_TVStatic = assets.getSound("TVStatic");
			soundManager.addSound("TVStatic", MUS_TVStatic);
			if(p === true){
				Play_TVStatic(r,t);
			}
		}
		
		public function Play_TVStatic(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "TVStatic";
			soundManager.playMusic("TVStatic",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("TVStatic",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		//----------------------------------------------------------------		
		public function LoadWaterfall(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Waterfall")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Waterfall.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyWaterfall(p,r,t);
					}
				});
			}
		}
		private function ReadyWaterfall(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Waterfall = assets.getSound("Waterfall");
			soundManager.addSound("Waterfall", MUS_Waterfall);
			if(p === true){
				Play_Waterfall(r,t);
			}
		}
		
		public function Play_Waterfall(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Waterfall";
			soundManager.playMusic("Waterfall",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Waterfall",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		
		//----------------------------------------------------------------		
		public function LoadCaveDripsStream(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("CaveDripsStream")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/CaveDripsStream.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyCaveDripsStream(p,r,t);
					}
				});
			}
		}
		private function ReadyCaveDripsStream(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_CaveDripsStream = assets.getSound("CaveDripsStream");
			soundManager.addSound("CaveDripsStream", MUS_CaveDripsStream);
			if(p === true){
				Play_CaveDripsStream(r,t);
			}
		}
		
		public function Play_CaveDripsStream(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "CaveDripsStream";
			soundManager.playMusic("CaveDripsStream",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("CaveDripsStream",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadCaveDrips(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("CaveDrips")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/CaveDrips.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyCaveDrips(p,r,t);
					}
				});
			}
		}
		private function ReadyCaveDrips(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_CaveDrips = assets.getSound("CaveDrips");
			soundManager.addSound("CaveDrips", MUS_CaveDrips);
			if(p === true){
				Play_CaveDrips(r,t);
			}
		}
		
		public function Play_CaveDrips(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "CaveDrips";
			soundManager.playMusic("CaveDrips",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("CaveDrips",globalVol,t);
		}
		
		
		//----------------------------------------------------------------		
		
		
		//----------------------------------------------------------------		
		public function LoadShipGroansOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("ShipGroansOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/ShipGroansOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyShipGroansOne(p,r,t);
					}
				});
			}
		}
		private function ReadyShipGroansOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_ShipGroansOne = assets.getSound("ShipGroansOne");
			soundManager.addSound("ShipGroansOne", MUS_ShipGroansOne);
			if(p === true){
				Play_ShipGroansOne(r,t);
			}
		}
		
		public function Play_ShipGroansOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "ShipGroansOne";
			soundManager.playMusic("ShipGroansOne",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("ShipGroansOne",globalVol,t);
		}
		
		//MUS_ShipCreaks
		//----------------------------------------------------------------		
		public function LoadShipCreaks(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("ShipCreaks")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/ShipCreaks.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyShipCreaks(p,r,t);
					}
				});
			}
		}
		private function ReadyShipCreaks(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_ShipCreaks = assets.getSound("ShipCreaks");
			soundManager.addSound("ShipCreaks", MUS_ShipCreaks);
			if(p === true){
				Play_ShipCreaks(r,t);
			}
		}
		
		public function Play_ShipCreaks(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "ShipCreaks";
			soundManager.playMusic("ShipCreaks",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("ShipCreaks",globalVol,t);
		}
		
		//-----------------
		
		//----------------------------------------------------------------		
		public function LoadBirdsOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BirdsOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BirdsOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBirdsOne(p,r,t);
					}
				});
			}
		}
		private function ReadyBirdsOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BirdsOne = assets.getSound("BirdsOne");
			soundManager.addSound("BirdsOne", MUS_BirdsOne);
			if(p === true){
				Play_BirdsOne(r,t);
			}
		}
		
		public function Play_BirdsOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "BirdsOne";
			soundManager.playMusic("BirdsOne",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BirdsOne",globalVol,t);
		}
		
		//-----------------
		
		//MUS_WindOne
		//----------------------------------------------------------------		
		public function LoadWindOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("WindOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/WindOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyWindOne(p,r,t);
					}
				});
			}
		}
		private function ReadyWindOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_WindOne = assets.getSound("WindOne");
			soundManager.addSound("WindOne", MUS_WindOne);
			if(p === true){
				Play_WindOne(r,t);
			}
		}
		
		public function Play_WindOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "WindOne";
			soundManager.playMusic("WindOne",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("WindOne",globalVol,t);
		}
		
		//-----------------
		
		//----------------------------------------------------------------		
		public function LoadBurningFireOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BurningFireOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BurningFireOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBurningFireOne(p,r,t);
					}
				});
			}
		}
		private function ReadyBurningFireOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BurningFireOne = assets.getSound("BurningFireOne");
			soundManager.addSound("BurningFireOne", MUS_BurningFireOne);
			if(p === true){
				Play_BurningFireOne(r,t);
			}
		}
		
		public function Play_BurningFireOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "BurningFireOne";
			soundManager.playMusic("BurningFireOne",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BurningFireOne",globalVol,t);
		}
		
		//-----------------
		
		//----------------------------------------------------------------		
		public function LoadCrickets_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Crickets_01")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Crickets_01.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyCrickets_01(p,r,t);
					}
				});
			}
		}
		private function ReadyCrickets_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Crickets_01 = assets.getSound("Crickets_01");
			soundManager.addSound("Crickets_01", MUS_Crickets_01);
			if(p === true){
				Play_Crickets_01(r,t);
			}
		}
		
		public function Play_Crickets_01(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Crickets_01";
			soundManager.playMusic("Crickets_01",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Crickets_01",globalVol,t);
		}
		
		//-----------------
		//----------------------------------------------------------------		
		public function LoadWaves_02(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Waves_02")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Waves_02.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyWaves_02(p,r,t);
					}
				});
			}
		}
		private function ReadyWaves_02(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Waves_02 = assets.getSound("Waves_02");
			soundManager.addSound("Waves_02", MUS_Waves_02);
			if(p === true){
				Play_Waves_02(r,t);
			}
		}
		
		public function Play_Waves_02(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Waves_02";
			soundManager.playMusic("Waves_02",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Waves_02",globalVol,t);
		}
		
		//-----------------
		
		//----------------------------------------------------------------		
		public function LoadWaves_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Waves_01")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Waves_01.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyWaves_01(p,r,t);
					}
				});
			}
		}
		private function ReadyWaves_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Waves_01 = assets.getSound("Waves_01");
			soundManager.addSound("Waves_01", MUS_Waves_01);
			if(p === true){
				Play_Waves_01(r,t);
			}
		}
		
		public function Play_Waves_01(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Waves_01";
			soundManager.playMusic("Waves_01",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Waves_01",globalVol,t);
		}
		
		//-----------------
		
		//----------------------------------------------------------------		
		public function LoadJungle_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Jungle_01")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Jungle_01.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyJungle_01(p,r,t);
					}
				});
			}
		}
		private function ReadyJungle_01(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Jungle_01 = assets.getSound("Jungle_01");
			soundManager.addSound("Jungle_01", MUS_Jungle_01);
			if(p === true){
				Play_Jungle_01(r,t);
			}
		}
		
		public function Play_Jungle_01(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentAmbient = "Jungle_01";
			soundManager.playMusic("Jungle_01",0,repeatCount,0,0,Null_CurrentAmbient);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Jungle_01",globalVol,t);
		}
		
		//-----------------
		public function PauseAll():void{
			paused = true;

			if(MUS_Crickets_01 != null){
				
				pauseArr['Crickets_01'] =  soundManager.getPausePos("Crickets_01");
				soundManager.stopSound('Crickets_01');
			}
			if(MUS_Waves_01 != null){
				
				pauseArr['Waves_01'] =  soundManager.getPausePos("Waves_01");
				soundManager.stopSound('Waves_01');
			}
			if(MUS_Jungle_01 != null){
				
				pauseArr['Jungle_01'] =  soundManager.getPausePos("Jungle_01");
				soundManager.stopSound('Jungle_01');
			}
			
			if(MUS_BurningFireOne != null){
				
				pauseArr['BurningFireOne'] =  soundManager.getPausePos("BurningFireOne");
				soundManager.stopSound('BurningFireOne');
			}
			if(MUS_BirdsOne != null){
				
				pauseArr['BirdsOne'] =  soundManager.getPausePos("BirdsOne");
				soundManager.stopSound('BirdsOne');
			}
			if(MUS_ShipGroansOne != null){
				
				pauseArr['ShipGroansOne'] =  soundManager.getPausePos("ShipGroansOne");
				soundManager.stopSound('ShipGroansOne');
			}
			
			if(MUS_CaveDrips != null){
				
				pauseArr['CaveDrips'] =  soundManager.getPausePos("CaveDrips");
				soundManager.stopSound('CaveDrips');
			}
			if(MUS_CaveDripsStream != null){
				
				pauseArr['CaveDripsStream'] =  soundManager.getPausePos("CaveDripsStream");
				soundManager.stopSound('CaveDripsStream');
			}
			if(MUS_Waves_02 != null){
				
				pauseArr['Waves_02'] =  soundManager.getPausePos("Waves_02");
				soundManager.stopSound('Waves_02');
			}
			
			if(MUS_ShipCreaks != null){
				
				pauseArr['ShipCreaks'] =  soundManager.getPausePos("ShipCreaks");
				soundManager.stopSound('ShipCreaks');
			}
			if(MUS_Waterfall != null){
				
				pauseArr['Waterfall'] =  soundManager.getPausePos("Waterfall");
				soundManager.stopSound('Waterfall');
			}
			
			if(MUS_TVStatic != null){
				
				pauseArr['TVStatic'] =  soundManager.getPausePos("TVStatic");
				soundManager.stopSound('TVStatic');
			}
			
			if(MUS_ElectricHum != null){
				
				pauseArr['ElectricHum'] =  soundManager.getPausePos("ElectricHum");
				soundManager.stopSound('ElectricHum');
			}
			if(MUS_Crows != null){
				
				pauseArr['Crows'] =  soundManager.getPausePos("Crows");
				soundManager.stopSound('Crows');
			}
			if(MUS_WindOne != null){
				
				pauseArr['WindOne'] =  soundManager.getPausePos("WindOne");
				soundManager.stopSound('WindOne');
			}
			if(MUS_Darkness != null){
				
				pauseArr['Darkness'] =  soundManager.getPausePos("Darkness");
				soundManager.stopSound('Darkness');
			}
			if(MUS_SpaceHum != null){
				
				pauseArr['SpaceHum'] =  soundManager.getPausePos("SpaceHum");
				soundManager.stopSound('SpaceHum');
			}
			if(MUS_SpaceHumPower != null){
				
				pauseArr['SpaceHumPower'] =  soundManager.getPausePos("SpaceHumPower");
				soundManager.stopSound('SpaceHumPower');
			}
			if(MUS_Sonar != null){
				
				pauseArr['Sonar'] =  soundManager.getPausePos("Sonar");
				soundManager.stopSound('Sonar');
			}
			
			//public var MUS_SpaceHum:Sound;
			//public var MUS_SpaceHumPower:Sound;
			
		}
		public function resumeCurrentSong():void{
			paused = false;
			
			if(currentAmbient != null){
			//	var startPosAmb:Number = (pauseArr[currentAmbient]);
				
				soundManager.ResumeMusic(currentAmbient,globalVol,999,0,0,Null_CurrentAmbient);
				
			}
		}
		
	}
}