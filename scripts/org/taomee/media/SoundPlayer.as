package org.taomee.media
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class SoundPlayer extends EventDispatcher
   {
       
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _autoStart:Boolean;
      
      private var _cyc:Boolean;
      
      private var _position:Number = 0;
      
      private var _soundState:int;
      
      private var _url:String = "";
      
      private var _volume:Number = 1;
      
      public function SoundPlayer(param1:String = "", param2:Boolean = false, param3:Boolean = false)
      {
         this._soundState = SoundPlayerState.NOTLOADED;
         super();
         this.load(param1,param2,param3);
      }
      
      public function get leftPeak() : Number
      {
         if(this._soundChannel)
         {
            return this._soundChannel.leftPeak;
         }
         return NaN;
      }
      
      public function get rightPeak() : Number
      {
         if(this._soundChannel)
         {
            return this._soundChannel.rightPeak;
         }
         return NaN;
      }
      
      public function get position() : Number
      {
         if(this._soundChannel)
         {
            return this._soundChannel.position;
         }
         return NaN;
      }
      
      public function set position(param1:Number) : void
      {
         var _loc2_:* = this._soundState == SoundPlayerState.PLAYING;
         this.pause();
         this._position = param1;
         if(_loc2_)
         {
            this.play();
         }
      }
      
      public function get duration() : Number
      {
         return this._sound.length;
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         var _loc2_:SoundTransform = null;
         this._volume = param1;
         if(this._soundChannel)
         {
            _loc2_ = this._soundChannel.soundTransform;
            _loc2_.volume = param1;
            this._soundChannel.soundTransform = _loc2_;
         }
      }
      
      public function set autoStart(param1:Boolean) : void
      {
         this._autoStart = param1;
      }
      
      public function get autoStart() : Boolean
      {
         return this._autoStart;
      }
      
      public function set cyc(param1:Boolean) : void
      {
         this._cyc = param1;
      }
      
      public function get cyc() : Boolean
      {
         return this._cyc;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get state() : int
      {
         return this._soundState;
      }
      
      public function load(param1:String, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         if(this._url == param1)
         {
            this.play();
            return;
         }
         this._url = param1;
         this._sound = new Sound();
         this._sound.addEventListener(Event.OPEN,this.onLoadOpen);
         this._sound.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
         this._sound.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
         this._sound.load(new URLRequest(param1));
         this._autoStart = param2;
         this._cyc = param3;
      }
      
      public function play() : void
      {
         if(this._url == "")
         {
            return;
         }
         if(this._soundState == SoundPlayerState.NOTLOADED)
         {
            return;
         }
         if(this._soundState == SoundPlayerState.PLAYING)
         {
            return;
         }
         this.clearSoundChannel();
         this._soundChannel = this._sound.play(this._position);
         this.volume = this._volume;
         if(this._soundChannel)
         {
            this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            this._soundState = SoundPlayerState.PLAYING;
         }
      }
      
      public function pause() : void
      {
         if(this._soundState == SoundPlayerState.NOTLOADED)
         {
            return;
         }
         if(this._soundChannel == null)
         {
            this._soundState = SoundPlayerState.PAUSED;
            return;
         }
         if(this._soundState == SoundPlayerState.PAUSED)
         {
            return;
         }
         this._position = this._soundChannel.position;
         this.clearSoundChannel();
         this._soundState = SoundPlayerState.PAUSED;
      }
      
      public function stop() : void
      {
         this.removeEvent();
         if(this._soundState == SoundPlayerState.NOTLOADED)
         {
            return;
         }
         if(this._soundChannel == null)
         {
            this._soundState = SoundPlayerState.STOPPED;
            return;
         }
         this._position = 0;
         this.clearSoundChannel();
         this._soundState = SoundPlayerState.STOPPED;
      }
      
      public function destroy() : void
      {
         this.stop();
         this._sound = null;
         this._soundChannel = null;
      }
      
      private function clearSoundChannel() : void
      {
         if(this._soundChannel)
         {
            this._soundChannel.stop();
            this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
            this._soundChannel = null;
         }
      }
      
      private function onLoadOpen(param1:Event) : void
      {
         this._sound.removeEventListener(Event.OPEN,this.onLoadOpen);
         this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
         dispatchEvent(param1);
         if(this._autoStart)
         {
            if(this._soundState == SoundPlayerState.PAUSED)
            {
               return;
            }
            this._soundState = SoundPlayerState.LOADED;
            this._position = 0;
            this.play();
         }
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
         this._sound.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         dispatchEvent(param1);
      }
      
      private function onSoundComplete(param1:Event) : void
      {
         this.stop();
         dispatchEvent(param1);
         if(this._cyc)
         {
            this.play();
         }
      }
      
      private function onIoError(param1:IOErrorEvent) : void
      {
         this.removeEvent();
         trace("SoundPlayer:IoError",this._url);
         this._soundState = SoundPlayerState.NOTLOADED;
      }
      
      private function removeEvent() : void
      {
         if(this._sound)
         {
            this._sound.removeEventListener(Event.OPEN,this.onLoadOpen);
            this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
            this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
            this._sound.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         }
      }
   }
}
