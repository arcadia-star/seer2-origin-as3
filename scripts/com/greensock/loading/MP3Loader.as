package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderItem;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   
   public class MP3Loader extends LoaderItem
   {
      
      private static var _shape:Shape = new Shape();
      
      public static const SOUND_PAUSE:String = "soundPause";
      
      public static const SOUND_COMPLETE:String = "soundComplete";
      
      public static const SOUND_PLAY:String = "soundPlay";
      
      private static var _classActivated:Boolean = _activateClass("MP3Loader",MP3Loader,"mp3");
      
      public static const PLAY_PROGRESS:String = "playProgress";
       
      
      protected var _dispatchPlayProgress:Boolean;
      
      public var channel:SoundChannel;
      
      protected var _position:Number;
      
      protected var _soundTransform:SoundTransform;
      
      protected var _initPhase:int;
      
      protected var _sound:Sound;
      
      protected var _soundPaused:Boolean;
      
      protected var _soundComplete:Boolean;
      
      protected var _context:SoundLoaderContext;
      
      protected var _duration:Number;
      
      public var initThreshold:uint;
      
      public function MP3Loader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _type = "MP3Loader";
         _position = 0;
         _duration = 0;
         _soundPaused = true;
         _soundTransform = new SoundTransform("volume" in this.vars ? Number(this.vars.volume) : 1);
         this.initThreshold = "initThreshold" in this.vars ? uint(this.vars.initThreshold) : 102400;
         _initSound();
      }
      
      public function playSound(param1:Event = null) : SoundChannel
      {
         this.soundPaused = false;
         return this.channel;
      }
      
      override protected function _load() : void
      {
         _context = this.vars.context is SoundLoaderContext ? this.vars.context : new SoundLoaderContext(3000);
         _prepRequest();
         _soundComplete = false;
         _initPhase = -1;
         _position = 0;
         _duration = 0;
         try
         {
            _sound.load(_request,_context);
            if(this.vars.autoPlay != false)
            {
               playSound();
            }
         }
         catch(error:Error)
         {
            _errorHandler(new LoaderEvent(LoaderEvent.ERROR,this,error.message));
         }
      }
      
      public function set soundPaused(param1:Boolean) : void
      {
         var _loc2_:Boolean = Boolean(param1 != _soundPaused);
         _soundPaused = param1;
         if(!_loc2_)
         {
            return;
         }
         if(_soundPaused)
         {
            if(this.channel != null)
            {
               _position = this.channel.position;
               this.channel.removeEventListener(Event.SOUND_COMPLETE,_soundCompleteHandler);
               _shape.removeEventListener(Event.ENTER_FRAME,_enterFrameHandler);
               this.channel.stop();
            }
         }
         else
         {
            this.channel = _sound.play(_position,this.vars.repeat == -1 ? 9999999 : uint(this.vars.repeat) + 1,_soundTransform);
            this.channel.addEventListener(Event.SOUND_COMPLETE,_soundCompleteHandler);
            _shape.addEventListener(Event.ENTER_FRAME,_enterFrameHandler,false,0,true);
         }
         dispatchEvent(new LoaderEvent(_soundPaused ? SOUND_PAUSE : SOUND_PLAY,this));
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == PLAY_PROGRESS)
         {
            _dispatchPlayProgress = true;
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function _id3Handler(param1:Event) : void
      {
         if(_sound.bytesLoaded > this.initThreshold)
         {
            _initPhase = 1;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         }
         else
         {
            _initPhase = 0;
         }
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         this.pauseSound();
         _initSound();
         _position = 0;
         _duration = 0;
         _soundComplete = false;
         super._dump(param1,param2);
         _content = _sound;
      }
      
      protected function _enterFrameHandler(param1:Event) : void
      {
         if(_dispatchPlayProgress)
         {
            dispatchEvent(new LoaderEvent(PLAY_PROGRESS,this));
         }
      }
      
      public function gotoSoundTime(param1:Number, param2:Boolean = false) : void
      {
         if(param1 > _duration)
         {
            param1 = _duration;
         }
         _position = param1 * 1000;
         _soundComplete = false;
         if(!_soundPaused || param2)
         {
            if(this.channel != null)
            {
               this.channel.removeEventListener(Event.SOUND_COMPLETE,_soundCompleteHandler);
               this.channel.stop();
            }
            this.channel = _sound.play(_position,this.vars.repeat == -1 ? 9999999 : uint(this.vars.repeat) + 1,_soundTransform);
            this.channel.addEventListener(Event.SOUND_COMPLETE,_soundCompleteHandler);
            if(_soundPaused)
            {
               _shape.addEventListener(Event.ENTER_FRAME,_enterFrameHandler,false,0,true);
               _soundPaused = false;
               dispatchEvent(new LoaderEvent(SOUND_PLAY,this));
            }
         }
      }
      
      public function set playProgress(param1:Number) : void
      {
         if(this.duration != 0)
         {
            gotoSoundTime(param1 * _duration,!_soundPaused);
         }
      }
      
      public function get duration() : Number
      {
         if(_sound.bytesLoaded < _sound.bytesTotal)
         {
            _duration = _sound.length / 1000 / (_sound.bytesLoaded / _sound.bytesTotal);
         }
         return _duration;
      }
      
      public function get soundPaused() : Boolean
      {
         return _soundPaused;
      }
      
      protected function _soundCompleteHandler(param1:Event) : void
      {
         _soundComplete = true;
         this.soundPaused = true;
         _position = _duration * 1000;
         _enterFrameHandler(null);
         dispatchEvent(new LoaderEvent(SOUND_COMPLETE,this));
      }
      
      public function get playProgress() : Number
      {
         return _soundComplete ? 1 : this.soundTime / this.duration;
      }
      
      override protected function _progressHandler(param1:Event) : void
      {
         if(_initPhase == 0 && _sound.bytesLoaded > this.initThreshold)
         {
            _initPhase = 1;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         }
         super._progressHandler(param1);
      }
      
      override protected function _completeHandler(param1:Event = null) : void
      {
         _duration = _sound.length / 1000;
         if(_initPhase != 1)
         {
            _initPhase = 1;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         }
         super._completeHandler(param1);
      }
      
      public function set volume(param1:Number) : void
      {
         _soundTransform.volume = param1;
         if(this.channel != null)
         {
            this.channel.soundTransform = _soundTransform;
         }
      }
      
      protected function _initSound() : void
      {
         if(_sound != null)
         {
            try
            {
               _sound.close();
            }
            catch(error:Error)
            {
            }
            _sound.removeEventListener(ProgressEvent.PROGRESS,_progressHandler);
            _sound.removeEventListener(Event.COMPLETE,_completeHandler);
            _sound.removeEventListener("ioError",_failHandler);
            _sound.removeEventListener(Event.ID3,_id3Handler);
         }
         _initPhase = -1;
         _sound = _content = new Sound();
         _sound.addEventListener(ProgressEvent.PROGRESS,_progressHandler,false,0,true);
         _sound.addEventListener(Event.COMPLETE,_completeHandler,false,0,true);
         _sound.addEventListener("ioError",_failHandler,false,0,true);
         _sound.addEventListener(Event.ID3,_id3Handler,false,0,true);
      }
      
      public function get volume() : Number
      {
         return _soundTransform.volume;
      }
      
      public function get soundTime() : Number
      {
         return !_soundPaused && this.channel != null ? this.channel.position / 1000 : _position / 1000;
      }
      
      public function pauseSound(param1:Event = null) : void
      {
         this.soundPaused = true;
      }
      
      public function set soundTime(param1:Number) : void
      {
         gotoSoundTime(param1,!_soundPaused);
      }
   }
}
