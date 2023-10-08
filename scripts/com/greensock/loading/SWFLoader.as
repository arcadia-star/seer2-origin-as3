package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.DisplayObjectLoader;
   import com.greensock.loading.core.LoaderCore;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.media.SoundTransform;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class SWFLoader extends DisplayObjectLoader
   {
      
      private static var _classActivated:Boolean = _activateClass("SWFLoader",SWFLoader,"swf");
       
      
      protected var _queue:com.greensock.loading.LoaderMax;
      
      protected var _loaderFailed:Boolean;
      
      protected var _rslAddedCount:uint;
      
      protected var _loadOnExitStealth:Boolean;
      
      protected var _hasRSL:Boolean;
      
      protected var _loaderCompleted:Boolean;
      
      public function SWFLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _preferEstimatedBytesInAudit = true;
         _type = "SWFLoader";
      }
      
      override public function set url(param1:String) : void
      {
         if(_url != param1)
         {
            if(_status == LoaderStatus.LOADING && !_initted && !_loaderFailed)
            {
               _loadOnExitStealth = true;
            }
            super.url = param1;
         }
      }
      
      override protected function _determineScriptAccess() : void
      {
         var mc:DisplayObject = null;
         try
         {
            mc = _loader.content;
         }
         catch(error:Error)
         {
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,error.message));
            return;
         }
         if(_loader.content is AVM1Movie)
         {
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,"AVM1Movie denies script access"));
         }
      }
      
      override protected function _load() : void
      {
         if(_stealthMode)
         {
            _stealthMode = _loadOnExitStealth;
         }
         else if(!_initted)
         {
            _loader.visible = false;
            _sprite.addChild(_loader);
            super._load();
         }
         else if(_queue != null)
         {
            _changeQueueListeners(true);
            _queue.load(false);
         }
      }
      
      public function getClass(param1:String) : Class
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(_content == null || _scriptAccessDenied)
         {
            return null;
         }
         if(_content.loaderInfo.applicationDomain.hasDefinition(param1))
         {
            return _content.loaderInfo.applicationDomain.getDefinition(param1);
         }
         if(_queue != null)
         {
            _loc3_ = _queue.getChildren(true,true);
            _loc4_ = int(_loc3_.length);
            while(--_loc4_ > -1)
            {
               if(_loc3_[_loc4_] is SWFLoader)
               {
                  _loc2_ = (_loc3_[_loc4_] as SWFLoader).getClass(param1);
                  if(_loc2_ != null)
                  {
                     return _loc2_ as Class;
                  }
               }
            }
         }
         return null;
      }
      
      public function getContent(param1:String) : *
      {
         if(param1 == this.name || param1 == _url)
         {
            return this.content;
         }
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null ? _loc2_.content : null;
      }
      
      override protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         if((param1.type == "ioError" || param1.type == "securityError") && param1.target == _loader.contentLoaderInfo)
         {
            _loaderFailed = true;
            if(_loadOnExitStealth)
            {
               _dump(1,_status,true);
               _load();
               return;
            }
         }
         if(param1.target == _queue)
         {
            _status = LoaderStatus.FAILED;
            _time = getTimer() - _time;
            dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL,this));
            dispatchEvent(new LoaderEvent(LoaderEvent.FAIL,this,this.toString() + " > " + (param1 as Object).text));
            return;
         }
         super._failHandler(param1,param2);
      }
      
      override protected function _refreshLoader(param1:Boolean = true) : void
      {
         super._refreshLoader(param1);
         _loaderCompleted = false;
      }
      
      public function getLoader(param1:String) : *
      {
         return _queue != null ? _queue.getLoader(param1) : null;
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         var content:* = undefined;
         var scrubLevel:int = param1;
         var newStatus:int = param2;
         var suppressEvents:Boolean = param3;
         _loaderCompleted = false;
         if(_status == LoaderStatus.LOADING && !_initted && !_loaderFailed)
         {
            _stealthMode = true;
            super._dump(scrubLevel,newStatus,suppressEvents);
            return;
         }
         if(_initted && !_scriptAccessDenied && scrubLevel != 2)
         {
            _stopMovieClips(_loader.content);
            if(_loader.content in _rootLookup)
            {
               _queue = LoaderMax(_rootLookup[_loader.content]);
               _changeQueueListeners(false);
               if(scrubLevel == 0)
               {
                  _queue.cancel();
               }
               else
               {
                  delete _rootLookup[_loader.content];
                  _queue.dispose(Boolean(scrubLevel != 2));
               }
            }
         }
         if(_stealthMode)
         {
            try
            {
               _loader.close();
            }
            catch(error:Error)
            {
            }
         }
         _loadOnExitStealth = false;
         _stealthMode = _hasRSL = _loaderFailed = false;
         _cacheIsDirty = true;
         if(scrubLevel >= 1)
         {
            _queue = null;
            _initted = false;
            super._dump(scrubLevel,newStatus,suppressEvents);
         }
         else
         {
            content = _content;
            super._dump(scrubLevel,newStatus,suppressEvents);
            _content = content;
         }
      }
      
      protected function _stopMovieClips(param1:DisplayObject) : void
      {
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.stop();
         var _loc3_:int = _loc2_.numChildren;
         while(--_loc3_ > -1)
         {
            _stopMovieClips(_loc2_.getChildAt(_loc3_));
         }
      }
      
      protected function _checkRequiredLoaders() : void
      {
         if(_queue == null && this.vars.integrateProgress != false && !_scriptAccessDenied && _content != null)
         {
            _queue = _rootLookup[_content];
            if(_queue != null)
            {
               _changeQueueListeners(true);
               _queue.load(false);
               _cacheIsDirty = true;
            }
         }
      }
      
      override protected function _completeHandler(param1:Event = null) : void
      {
         var _loc2_:SoundTransform = null;
         _loaderCompleted = true;
         _checkRequiredLoaders();
         _calculateProgress();
         if(this.progress == 1)
         {
            if(!_scriptAccessDenied && this.vars.autoPlay == false && _content is MovieClip)
            {
               _loc2_ = _content.soundTransform;
               _loc2_.volume = 1;
               _content.soundTransform = _loc2_;
            }
            _changeQueueListeners(false);
            super._determineScriptAccess();
            super._completeHandler(param1);
         }
      }
      
      protected function _changeQueueListeners(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(_queue != null)
         {
            if(param1 && this.vars.integrateProgress != false)
            {
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     _queue.addEventListener(_listenerTypes[_loc2_],_passThroughEvent,false,-100,true);
                  }
               }
               _queue.addEventListener(LoaderEvent.COMPLETE,_completeHandler,false,-100,true);
               _queue.addEventListener(LoaderEvent.PROGRESS,_progressHandler,false,-100,true);
               _queue.addEventListener(LoaderEvent.FAIL,_failHandler,false,-100,true);
            }
            else
            {
               _queue.removeEventListener(LoaderEvent.COMPLETE,_completeHandler);
               _queue.removeEventListener(LoaderEvent.PROGRESS,_progressHandler);
               _queue.removeEventListener(LoaderEvent.FAIL,_failHandler);
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     _queue.removeEventListener(_listenerTypes[_loc2_],_passThroughEvent);
                  }
               }
            }
         }
      }
      
      override protected function _initHandler(param1:Event) : void
      {
         var awaitingLoad:Boolean = false;
         var tempContent:DisplayObject = null;
         var className:String = null;
         var rslPreloader:Object = null;
         var event:Event = param1;
         if(_stealthMode)
         {
            _initted = true;
            awaitingLoad = _loadOnExitStealth;
            _dump(_status == LoaderStatus.DISPOSED ? 3 : 1,_status,true);
            if(awaitingLoad)
            {
               _load();
            }
            return;
         }
         _hasRSL = false;
         try
         {
            tempContent = _loader.content;
            className = getQualifiedClassName(tempContent);
            if(className.substr(-13) == "__Preloader__")
            {
               rslPreloader = tempContent["__rslPreloader"];
               if(rslPreloader != null)
               {
                  className = getQualifiedClassName(rslPreloader);
                  if(className == "fl.rsl::RSLPreloader")
                  {
                     _hasRSL = true;
                     _rslAddedCount = 0;
                     tempContent.addEventListener(Event.ADDED,_rslAddedHandler);
                  }
               }
            }
         }
         catch(error:Error)
         {
         }
         if(!_hasRSL)
         {
            _init();
         }
      }
      
      protected function _rslAddedHandler(param1:Event) : void
      {
         if(param1.target is DisplayObject && param1.currentTarget is DisplayObjectContainer && param1.target.parent == param1.currentTarget)
         {
            ++_rslAddedCount;
         }
         if(_rslAddedCount > 1)
         {
            param1.currentTarget.removeEventListener(Event.ADDED,_rslAddedHandler);
            if(_status == LoaderStatus.LOADING)
            {
               _content = param1.target;
               _init();
               _calculateProgress();
               dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
               _completeHandler(null);
            }
         }
      }
      
      override protected function _passThroughEvent(param1:Event) : void
      {
         if(param1.target != _queue)
         {
            super._passThroughEvent(param1);
         }
      }
      
      override protected function _progressHandler(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_status == LoaderStatus.LOADING)
         {
            if(_queue == null && _initted)
            {
               _checkRequiredLoaders();
            }
            if(_dispatchProgress)
            {
               _loc2_ = _cachedBytesLoaded;
               _loc3_ = _cachedBytesTotal;
               _calculateProgress();
               if(_cachedBytesLoaded != _cachedBytesTotal && (_loc2_ != _cachedBytesLoaded || _loc3_ != _cachedBytesTotal))
               {
                  dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
               }
            }
            else
            {
               _cacheIsDirty = true;
            }
         }
      }
      
      protected function _init() : void
      {
         var _loc1_:SoundTransform = null;
         _determineScriptAccess();
         if(!_scriptAccessDenied)
         {
            if(!_hasRSL)
            {
               _content = _loader.content;
            }
            if(_content != null)
            {
               if(this.vars.autoPlay == false && _content is MovieClip)
               {
                  _loc1_ = _content.soundTransform;
                  _loc1_.volume = 0;
                  _content.soundTransform = _loc1_;
                  _content.stop();
               }
               _checkRequiredLoaders();
            }
            if(_loader.parent == _sprite)
            {
               if(_sprite.stage != null && this.vars.suppressInitReparentEvents == true)
               {
                  _sprite.addEventListener(Event.ADDED_TO_STAGE,_captureFirstEvent,true,1000,true);
                  _loader.addEventListener(Event.REMOVED_FROM_STAGE,_captureFirstEvent,true,1000,true);
               }
               _sprite.removeChild(_loader);
            }
         }
         else
         {
            _content = _loader;
            _loader.visible = true;
         }
         super._initHandler(null);
      }
      
      protected function _captureFirstEvent(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         param1.currentTarget.removeEventListener(param1.type,_captureFirstEvent);
      }
      
      override protected function _calculateProgress() : void
      {
         _cachedBytesLoaded = _stealthMode ? 0 : _loader.contentLoaderInfo.bytesLoaded;
         if(_loader.contentLoaderInfo.bytesTotal != 0)
         {
            _cachedBytesTotal = _loader.contentLoaderInfo.bytesTotal;
         }
         if(_cachedBytesTotal < _cachedBytesLoaded || _loaderCompleted)
         {
            _cachedBytesTotal = _cachedBytesLoaded;
         }
         if(this.vars.integrateProgress != false)
         {
            if(_queue != null && (uint(this.vars.estimatedBytes) < _cachedBytesLoaded || _queue.auditedSize))
            {
               if(_queue.status <= LoaderStatus.COMPLETED)
               {
                  _cachedBytesLoaded += _queue.bytesLoaded;
                  _cachedBytesTotal += _queue.bytesTotal;
               }
            }
            else if(uint(this.vars.estimatedBytes) > _cachedBytesLoaded && (!_initted || _queue != null && _queue.status <= LoaderStatus.COMPLETED && !_queue.auditedSize))
            {
               _cachedBytesTotal = uint(this.vars.estimatedBytes);
            }
         }
         if(_hasRSL && _content == null || !_initted && _cachedBytesLoaded == _cachedBytesTotal)
         {
            _cachedBytesLoaded = int(_cachedBytesLoaded * 0.99);
         }
         _cacheIsDirty = false;
      }
      
      public function getChildren(param1:Boolean = false, param2:Boolean = false) : Array
      {
         return _queue != null ? _queue.getChildren(param1,param2) : [];
      }
      
      public function getSWFChild(param1:String) : DisplayObject
      {
         return !_scriptAccessDenied && _content is DisplayObjectContainer ? DisplayObjectContainer(_content).getChildByName(param1) : null;
      }
   }
}
