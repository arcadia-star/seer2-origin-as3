package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderItem;
   import com.greensock.loading.display.ContentDisplay;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundTransform;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class VideoLoader extends LoaderItem
   {
      
      public static const VIDEO_CUE_POINT:String = "videoCuePoint";
      
      public static const PLAY_PROGRESS:String = "playProgress";
      
      public static const VIDEO_BUFFER_FULL:String = "videoBufferFull";
      
      public static const VIDEO_BUFFER_EMPTY:String = "videoBufferEmpty";
      
      public static const VIDEO_PLAY:String = "videoPlay";
      
      public static const VIDEO_PAUSE:String = "videoPause";
      
      public static const VIDEO_COMPLETE:String = "videoComplete";
      
      private static var _classActivated:Boolean = _activateClass("VideoLoader",VideoLoader,"flv,f4v,mp4,mov");
       
      
      protected var _video:Video;
      
      protected var _bufferFull:Boolean;
      
      protected var _sound:SoundTransform;
      
      protected var _bufferMode:Boolean;
      
      protected var _pausePending:Boolean;
      
      protected var _renderedOnce:Boolean;
      
      protected var _volume:Number;
      
      protected var _initted:Boolean;
      
      protected var _timer:Timer;
      
      protected var _videoPaused:Boolean;
      
      public var metaData:Object;
      
      protected var _nc:NetConnection;
      
      protected var _videoComplete:Boolean;
      
      protected var _forceTime:Number;
      
      protected var _ns:NetStream;
      
      protected var _sprite:Sprite;
      
      protected var _firstCuePoint:CuePoint;
      
      protected var _duration:Number;
      
      protected var _repeatCount:uint;
      
      protected var _dispatchPlayProgress:Boolean;
      
      public var autoAdjustBuffer:Boolean;
      
      protected var _prevTime:Number;
      
      public function VideoLoader(param1:*, param2:Object = null)
      {
         _timer = new Timer(50,0);
         super(param1,param2);
         _type = "VideoLoader";
         _nc = new NetConnection();
         _nc.connect(null);
         _nc.addEventListener("asyncError",_failHandler,false,0,true);
         _nc.addEventListener("securityError",_failHandler,false,0,true);
         _video = new Video(int(this.vars.width) || 320,int(this.vars.height) || 240);
         _video.smoothing = Boolean(this.vars.smoothing != false);
         _video.deblocking = uint(this.vars.deblocking);
         _refreshNetStream();
         _duration = isNaN(this.vars.estimatedDuration) ? 200 : Number(this.vars.estimatedDuration);
         _bufferMode = _preferEstimatedBytesInAudit = Boolean(this.vars.bufferMode == true);
         _videoPaused = _pausePending = Boolean(this.vars.autoPlay == false);
         this.autoAdjustBuffer = this.vars.autoAdjustBuffer != false;
         this.volume = "volume" in this.vars ? Number(this.vars.volume) : 1;
         if(LoaderMax.contentDisplayClass is Class)
         {
            _sprite = new LoaderMax.contentDisplayClass(this);
            if(!_sprite.hasOwnProperty("rawContent"))
            {
               throw new Error("LoaderMax.contentDisplayClass must be set to a class with a \'rawContent\' property, like com.greensock.loading.display.ContentDisplay");
            }
         }
         else
         {
            _sprite = new ContentDisplay(this);
         }
         Object(_sprite).rawContent = null;
      }
      
      public function getCuePointTime(param1:String) : Number
      {
         var _loc3_:int = 0;
         if(this.metaData != null && this.metaData.cuePoints is Array)
         {
            _loc3_ = int(this.metaData.cuePoints.length);
            while(--_loc3_ > -1)
            {
               if(param1 == this.metaData.cuePoints[_loc3_].name)
               {
                  return Number(this.metaData.cuePoints[_loc3_].time);
               }
            }
         }
         var _loc2_:CuePoint = _firstCuePoint;
         while(_loc2_)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_.time;
            }
            _loc2_ = _loc2_.next;
         }
         return NaN;
      }
      
      public function get playProgress() : Number
      {
         return _videoComplete ? 1 : this.videoTime / _duration;
      }
      
      public function removeASCuePoint(param1:*) : Object
      {
         var _loc2_:CuePoint = _firstCuePoint;
         while(_loc2_)
         {
            if(_loc2_ == param1 || _loc2_.time == param1 || _loc2_.name == param1)
            {
               if(_loc2_.next)
               {
                  _loc2_.next.prev = _loc2_.prev;
               }
               if(_loc2_.prev)
               {
                  _loc2_.prev.next = _loc2_.next;
               }
               else if(_loc2_ == _firstCuePoint)
               {
                  _firstCuePoint = _loc2_.next;
               }
               _loc2_.next = _loc2_.prev = null;
               _loc2_.gc = true;
               return _loc2_;
            }
            _loc2_ = _loc2_.next;
         }
         return null;
      }
      
      protected function _setForceTime(param1:Number) : void
      {
         if(!(_forceTime || _forceTime == 0))
         {
            _waitForRender();
         }
         _forceTime = param1;
      }
      
      public function set bufferMode(param1:Boolean) : void
      {
         _bufferMode = param1;
         _preferEstimatedBytesInAudit = _bufferMode;
         _calculateProgress();
         if(_cachedBytesLoaded < _cachedBytesTotal && _status == LoaderStatus.COMPLETED)
         {
            _status = LoaderStatus.LOADING;
            _sprite.addEventListener(Event.ENTER_FRAME,_loadingProgressCheck);
         }
      }
      
      public function get videoPaused() : Boolean
      {
         return _videoPaused;
      }
      
      public function get bufferMode() : Boolean
      {
         return _bufferMode;
      }
      
      public function setContentDisplay(param1:Sprite) : void
      {
         _sprite = param1;
      }
      
      protected function _onBufferFull() : void
      {
         if(!_renderedOnce && !_timer.running)
         {
            _waitForRender();
            return;
         }
         if(_pausePending)
         {
            if(!_initted && getTimer() - _time < 10000)
            {
               _video.attachNetStream(null);
               return;
            }
            if(_renderedOnce)
            {
               _applyPendingPause();
            }
         }
         if(!_bufferFull)
         {
            _bufferFull = true;
            dispatchEvent(new LoaderEvent(VIDEO_BUFFER_FULL,this));
         }
      }
      
      override public function get content() : *
      {
         return _sprite;
      }
      
      public function set videoPaused(param1:Boolean) : void
      {
         var _loc2_:Boolean = Boolean(param1 != _videoPaused);
         _videoPaused = param1;
         if(_videoPaused)
         {
            if(!_renderedOnce)
            {
               _setForceTime(0);
               _pausePending = true;
               _sound.volume = 0;
               _ns.soundTransform = _sound;
            }
            else
            {
               _pausePending = false;
               this.volume = _volume;
               _ns.pause();
            }
            if(_loc2_)
            {
               _sprite.removeEventListener(Event.ENTER_FRAME,_playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PAUSE,this));
            }
         }
         else
         {
            if(_pausePending || !_bufferFull)
            {
               if(_initted && _renderedOnce)
               {
                  _ns.seek(this.videoTime);
                  _bufferFull = false;
               }
               _video.attachNetStream(_ns);
               _pausePending = false;
            }
            this.volume = _volume;
            _ns.resume();
            if(_loc2_)
            {
               _sprite.addEventListener(Event.ENTER_FRAME,_playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PLAY,this));
            }
         }
      }
      
      public function gotoVideoCuePoint(param1:String, param2:Boolean = false, param3:Boolean = true) : Number
      {
         return gotoVideoTime(getCuePointTime(param1),param2,param3);
      }
      
      public function set playProgress(param1:Number) : void
      {
         if(_duration != 0)
         {
            gotoVideoTime(param1 * _duration,!_videoPaused,true);
         }
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      protected function _forceInit() : void
      {
         if(_ns.bufferTime >= _duration)
         {
            _ns.bufferTime = uint(_duration - 1);
         }
         _initted = true;
         if(!_bufferFull && _ns.bufferLength >= _ns.bufferTime)
         {
            _onBufferFull();
         }
         (_sprite as Object).rawContent = _video;
         if(!_bufferFull && _pausePending && _renderedOnce)
         {
            _video.attachNetStream(null);
         }
      }
      
      public function pauseVideo(param1:Event = null) : void
      {
         this.videoPaused = true;
      }
      
      public function playVideo(param1:Event = null) : void
      {
         this.videoPaused = false;
      }
      
      public function get bufferProgress() : Number
      {
         if(uint(_ns.bytesTotal) < 5)
         {
            return 0;
         }
         return _ns.bufferLength > _ns.bufferTime ? 1 : _ns.bufferLength / _ns.bufferTime;
      }
      
      public function get rawContent() : Video
      {
         return _video;
      }
      
      override protected function _calculateProgress() : void
      {
         _cachedBytesLoaded = _ns.bytesLoaded;
         if(_cachedBytesLoaded > 1)
         {
            if(_bufferMode)
            {
               _cachedBytesTotal = _ns.bytesTotal * (_ns.bufferTime / _duration);
               if(_ns.bufferLength > 0)
               {
                  _cachedBytesLoaded = _ns.bufferLength / _ns.bufferTime * _cachedBytesTotal;
               }
            }
            else
            {
               _cachedBytesTotal = _ns.bytesTotal;
            }
            if(_cachedBytesTotal <= _cachedBytesLoaded)
            {
               _cachedBytesTotal = this.metaData != null && _renderedOnce && _initted || getTimer() - _time >= 10000 ? _cachedBytesLoaded : uint(int(1.01 * _cachedBytesLoaded) + 1);
            }
            if(!_auditedSize)
            {
               _auditedSize = true;
               dispatchEvent(new Event("auditedSize"));
            }
         }
         _cacheIsDirty = false;
      }
      
      public function set volume(param1:Number) : void
      {
         _sound.volume = _volume = param1;
         _ns.soundTransform = _sound;
      }
      
      protected function _metaDataHandler(param1:Object) : void
      {
         if(this.metaData == null || this.metaData.cuePoints == null)
         {
            this.metaData = param1;
         }
         _duration = param1.duration;
         if("width" in param1)
         {
            _video.width = Number(param1.width);
            _video.height = Number(param1.height);
         }
         _forceInit();
         dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",param1));
      }
      
      protected function _applyPendingPause() : void
      {
         _pausePending = false;
         this.volume = _volume;
         _ns.seek(_forceTime || 0);
         _video.attachNetStream(_ns);
         _ns.pause();
      }
      
      protected function _refreshNetStream() : void
      {
         if(_ns != null)
         {
            _ns.pause();
            try
            {
               _ns.close();
            }
            catch(error:Error)
            {
            }
            _sprite.removeEventListener(Event.ENTER_FRAME,_playProgressHandler);
            _ns.client = {};
            _ns.removeEventListener(NetStatusEvent.NET_STATUS,_statusHandler);
            _ns.removeEventListener("ioError",_failHandler);
            _ns.removeEventListener("asyncError",_failHandler);
            _ns.removeEventListener(Event.RENDER,_renderHandler);
         }
         _prevTime = 0;
         _ns = this.vars.netStream is NetStream ? this.vars.netStream : new NetStream(_nc);
         _ns.checkPolicyFile = Boolean(this.vars.checkPolicyFile == true);
         _ns.client = {
            "onMetaData":_metaDataHandler,
            "onCuePoint":_cuePointHandler
         };
         _ns.addEventListener(NetStatusEvent.NET_STATUS,_statusHandler,false,0,true);
         _ns.addEventListener("ioError",_failHandler,false,0,true);
         _ns.addEventListener("asyncError",_failHandler,false,0,true);
         _timer.addEventListener(TimerEvent.TIMER,_renderHandler,false,0,true);
         _ns.bufferTime = isNaN(this.vars.bufferTime) ? 5 : Number(this.vars.bufferTime);
         _video.attachNetStream(_ns);
         _sound = _ns.soundTransform;
      }
      
      override protected function _load() : void
      {
         _prepRequest();
         _repeatCount = 0;
         _prevTime = 0;
         _bufferFull = false;
         _renderedOnce = false;
         this.metaData = null;
         _pausePending = _videoPaused;
         if(_videoPaused)
         {
            _setForceTime(0);
            _sound.volume = 0;
            _ns.soundTransform = _sound;
         }
         else
         {
            this.volume = _volume;
         }
         _sprite.addEventListener(Event.ENTER_FRAME,_loadingProgressCheck);
         _waitForRender();
         _videoComplete = _initted = false;
         _ns.play(_request.url);
      }
      
      public function gotoVideoTime(param1:Number, param2:Boolean = false, param3:Boolean = true) : Number
      {
         if(isNaN(param1))
         {
            return NaN;
         }
         if(param1 > _duration)
         {
            param1 = _duration;
         }
         var _loc4_:* = param1 != this.videoTime;
         if(_initted && _renderedOnce && _loc4_)
         {
            _ns.seek(param1);
            _bufferFull = false;
         }
         _videoComplete = false;
         _setForceTime(param1);
         if(_loc4_)
         {
            if(!param3)
            {
               _playProgressHandler(null);
            }
            else
            {
               _prevTime = param1;
            }
         }
         if(param2)
         {
            playVideo();
         }
         if(_loc4_ && param3 && _dispatchPlayProgress)
         {
            dispatchEvent(new LoaderEvent(PLAY_PROGRESS,this));
         }
         return param1;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == PLAY_PROGRESS)
         {
            _dispatchPlayProgress = true;
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function addASCuePoint(param1:Number, param2:String = "", param3:Object = null) : Object
      {
         var _loc4_:CuePoint;
         if((_loc4_ = _firstCuePoint) != null && _loc4_.time > param1)
         {
            _loc4_ = null;
         }
         else
         {
            while(_loc4_ && _loc4_.time <= param1 && _loc4_.next && _loc4_.next.time <= param1)
            {
               _loc4_ = _loc4_.next;
            }
         }
         var _loc5_:CuePoint = new CuePoint(param1,param2,param3,_loc4_);
         if(_loc4_ == null)
         {
            if(_firstCuePoint != null)
            {
               _firstCuePoint.prev = _loc5_;
               _loc5_.next = _firstCuePoint;
            }
            _firstCuePoint = _loc5_;
         }
         return _loc5_;
      }
      
      protected function _playProgressHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:CuePoint = null;
         var _loc4_:CuePoint = null;
         if(!_bufferFull && _ns.bufferLength >= _ns.bufferTime)
         {
            _onBufferFull();
         }
         if(Boolean(_firstCuePoint) || _dispatchPlayProgress)
         {
            _loc2_ = _prevTime;
            _prevTime = this.videoTime;
            _loc4_ = _firstCuePoint;
            while(_loc4_)
            {
               _loc3_ = _loc4_.next;
               if(_loc4_.time > _loc2_ && _loc4_.time <= _prevTime && !_loc4_.gc)
               {
                  dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT,this,"",_loc4_));
               }
               _loc4_ = _loc3_;
            }
            if(_dispatchPlayProgress && _loc2_ != _prevTime)
            {
               dispatchEvent(new LoaderEvent(PLAY_PROGRESS,this));
            }
         }
      }
      
      protected function _waitForRender() : void
      {
         _ns.addEventListener(Event.RENDER,_renderHandler,false,0,true);
         _timer.reset();
         _timer.start();
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         _sprite.removeEventListener(Event.ENTER_FRAME,_loadingProgressCheck);
         _ns.removeEventListener(Event.RENDER,_renderHandler);
         _timer.removeEventListener(TimerEvent.TIMER,_renderHandler);
         _forceTime = NaN;
         _prevTime = 0;
         _initted = false;
         _renderedOnce = false;
         this.metaData = null;
         if(param1 != 2)
         {
            _refreshNetStream();
            (_sprite as Object).rawContent = null;
            if(_video.parent != null)
            {
               _video.parent.removeChild(_video);
            }
         }
         if(param1 >= 2)
         {
            if(param1 == 3)
            {
               _video.attachNetStream(null);
               (_sprite as Object).dispose(false,false);
            }
            _nc.removeEventListener("asyncError",_failHandler);
            _nc.removeEventListener("securityError",_failHandler);
            _ns.removeEventListener(NetStatusEvent.NET_STATUS,_statusHandler);
            _ns.removeEventListener("ioError",_failHandler);
            _ns.removeEventListener("asyncError",_failHandler);
            _firstCuePoint = null;
            (_sprite as Object).gcProtect = param1 == 3 ? null : _ns;
            _ns.client = {};
            _video = null;
            _ns = null;
            _nc = null;
            _sound = null;
            (_sprite as Object).loader = null;
            _sprite = null;
         }
         super._dump(param1,param2,param3);
      }
      
      protected function _cuePointHandler(param1:Object) : void
      {
         if(!_videoPaused)
         {
            dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT,this,"",param1));
         }
      }
      
      protected function _loadingProgressCheck(param1:Event) : void
      {
         var _loc2_:uint = _cachedBytesLoaded;
         var _loc3_:uint = _cachedBytesTotal;
         if(!_bufferFull && _ns.bufferLength >= _ns.bufferTime)
         {
            _onBufferFull();
         }
         _calculateProgress();
         if(_cachedBytesLoaded == _cachedBytesTotal)
         {
            _sprite.removeEventListener(Event.ENTER_FRAME,_loadingProgressCheck);
            if(!_bufferFull)
            {
               _onBufferFull();
            }
            if(!_initted)
            {
               _forceInit();
               _errorHandler(new LoaderEvent(LoaderEvent.ERROR,this,"No metaData was received."));
            }
            _completeHandler(param1);
         }
         else if(_dispatchProgress && _cachedBytesLoaded / _cachedBytesTotal != _loc2_ / _loc3_)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
      }
      
      public function set videoTime(param1:Number) : void
      {
         gotoVideoTime(param1,!_videoPaused,true);
      }
      
      override protected function _auditStreamHandler(param1:Event) : void
      {
         if(param1 is ProgressEvent && _bufferMode)
         {
            (param1 as ProgressEvent).bytesTotal *= _ns.bufferTime / _duration;
         }
         super._auditStreamHandler(param1);
      }
      
      public function get videoTime() : Number
      {
         if(_videoComplete)
         {
            return _duration;
         }
         if(Boolean(_forceTime) || _forceTime == 0)
         {
            return _forceTime;
         }
         if(_ns.time > _duration)
         {
            return _duration * 0.995;
         }
         return _ns.time;
      }
      
      protected function _renderHandler(param1:Event) : void
      {
         _renderedOnce = true;
         if(!_videoPaused || _initted)
         {
            _forceTime = NaN;
            _timer.stop();
            _ns.removeEventListener(Event.RENDER,_renderHandler);
         }
         if(_pausePending)
         {
            if(_bufferFull)
            {
               _applyPendingPause();
            }
            else
            {
               _sprite.addEventListener(Event.ENTER_FRAME,_detachNS,false,100,true);
            }
         }
      }
      
      private function _detachNS(param1:Event) : void
      {
         _sprite.removeEventListener(Event.ENTER_FRAME,_detachNS);
         if(!_bufferFull && _pausePending)
         {
            _video.attachNetStream(null);
         }
      }
      
      protected function _statusHandler(param1:NetStatusEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:String = String(param1.info.code);
         if(_loc2_ == "NetStream.Play.Start")
         {
            if(!_pausePending)
            {
               _sprite.addEventListener(Event.ENTER_FRAME,_playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PLAY,this));
            }
         }
         dispatchEvent(new LoaderEvent(NetStatusEvent.NET_STATUS,this,_loc2_,param1.info));
         if(_loc2_ == "NetStream.Play.Stop")
         {
            _bufferFull = false;
            if(_videoPaused)
            {
               return;
            }
            if(this.vars.repeat == -1 || uint(this.vars.repeat) > _repeatCount)
            {
               ++_repeatCount;
               dispatchEvent(new LoaderEvent(VIDEO_COMPLETE,this));
               gotoVideoTime(0,true,true);
            }
            else
            {
               _videoComplete = true;
               this.videoPaused = true;
               _playProgressHandler(null);
               dispatchEvent(new LoaderEvent(VIDEO_COMPLETE,this));
            }
         }
         else if(_loc2_ == "NetStream.Buffer.Full")
         {
            _onBufferFull();
         }
         else if(_loc2_ == "NetStream.Buffer.Empty")
         {
            _bufferFull = false;
            _loc3_ = this.duration - this.videoTime;
            _loc4_ = 1 / this.progress * this.loadTime;
            if(this.autoAdjustBuffer && _loc4_ > _loc3_)
            {
               _ns.bufferTime = _loc3_ * (1 - _loc3_ / _loc4_) * 0.9;
            }
            dispatchEvent(new LoaderEvent(VIDEO_BUFFER_EMPTY,this));
         }
         else if(_loc2_ == "NetStream.Play.StreamNotFound" || _loc2_ == "NetConnection.Connect.Failed" || _loc2_ == "NetStream.Play.Failed" || _loc2_ == "NetStream.Play.FileStructureInvalid" || _loc2_ == "The MP4 doesn\'t contain any supported tracks")
         {
            _failHandler(new LoaderEvent(LoaderEvent.ERROR,this,_loc2_));
         }
      }
      
      public function get netStream() : NetStream
      {
         return _ns;
      }
   }
}

class CuePoint
{
    
   
   public var time:Number;
   
   public var parameters:Object;
   
   public var name:String;
   
   public var next:CuePoint;
   
   public var prev:CuePoint;
   
   public var gc:Boolean;
   
   public function CuePoint(param1:Number, param2:String, param3:Object, param4:CuePoint)
   {
      super();
      this.time = param1;
      this.name = param2;
      this.parameters = param3;
      if(param4)
      {
         this.prev = param4;
         if(param4.next)
         {
            param4.next.prev = this;
            this.next = param4.next;
         }
         param4.next = this;
      }
   }
}
