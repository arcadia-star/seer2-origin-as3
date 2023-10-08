package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderCore;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import flash.utils.getTimer;
   
   public class XMLLoader extends DataLoader
   {
      
      protected static var _varTypes:Object = {
         "skipFailed":true,
         "skipPaused":true,
         "paused":false,
         "load":false,
         "noCache":false,
         "maxConnections":2,
         "autoPlay":false,
         "autoDispose":false,
         "smoothing":false,
         "estimatedBytes":1,
         "x":1,
         "y":1,
         "width":1,
         "height":1,
         "scaleX":1,
         "scaleY":1,
         "rotation":1,
         "alpha":1,
         "visible":true,
         "bgColor":0,
         "bgAlpha":0,
         "deblocking":1,
         "repeat":1,
         "checkPolicyFile":false,
         "centerRegistration":false,
         "bufferTime":5,
         "volume":1,
         "bufferMode":false,
         "estimatedDuration":200,
         "crop":false,
         "autoAdjustBuffer":true,
         "suppressInitReparentEvents":true
      };
      
      private static var _classActivated:Boolean = _activateClass("XMLLoader",XMLLoader,"xml,php,jsp,asp,cfm,cfml,aspx");
      
      public static var RAW_LOAD:String = "rawLoad";
       
      
      protected var _initted:Boolean;
      
      protected var _parsed:com.greensock.loading.LoaderMax;
      
      protected var _loadingQueue:com.greensock.loading.LoaderMax;
      
      public function XMLLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _preferEstimatedBytesInAudit = true;
         _type = "XMLLoader";
         _loader.dataFormat = "text";
      }
      
      public static function parseLoaders(param1:XML, param2:com.greensock.loading.LoaderMax, param3:com.greensock.loading.LoaderMax = null) : void
      {
         var _loc4_:XML = null;
         var _loc6_:com.greensock.loading.LoaderMax = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Class = null;
         var _loc10_:LoaderCore = null;
         var _loc5_:String;
         if((_loc5_ = String(param1.name()).toLowerCase()) == "loadermax")
         {
            _loc6_ = param2.append(new com.greensock.loading.LoaderMax(_parseVars(param1))) as com.greensock.loading.LoaderMax;
            if(param3 != null && Boolean(_loc6_.vars.load))
            {
               param3.append(_loc6_);
            }
            for each(_loc4_ in param1.children())
            {
               parseLoaders(_loc4_,_loc6_,param3);
            }
            if("replaceURLText" in _loc6_.vars)
            {
               _loc7_ = _loc6_.vars.replaceURLText.split(",");
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc6_.replaceURLText(_loc7_[_loc8_],_loc7_[_loc8_ + 1],false);
                  _loc8_ += 2;
               }
            }
            if("prependURLs" in _loc6_.vars)
            {
               _loc6_.prependURLs(_loc6_.vars.prependURLs,false);
            }
         }
         else
         {
            if(_loc5_ in _types)
            {
               _loc9_ = _types[_loc5_];
               _loc10_ = param2.append(new _loc9_(param1.@url,_parseVars(param1)));
               if(param3 != null && Boolean(_loc10_.vars.load))
               {
                  param3.append(_loc10_);
               }
            }
            for each(_loc4_ in param1.children())
            {
               parseLoaders(_loc4_,param2,param3);
            }
         }
      }
      
      protected static function _parseVars(param1:XML) : Object
      {
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:ApplicationDomain = null;
         var _loc8_:XML = null;
         var _loc2_:Object = {"rawXML":param1};
         var _loc7_:XMLList = param1.attributes();
         for each(_loc8_ in _loc7_)
         {
            _loc3_ = String(_loc8_.name());
            _loc5_ = _loc8_.toString();
            if(_loc3_ != "url")
            {
               if(_loc3_ == "context")
               {
                  _loc2_.context = new LoaderContext(true,_loc5_ == "own" ? ApplicationDomain.currentDomain : (_loc5_ == "separate" ? new ApplicationDomain() : new ApplicationDomain(ApplicationDomain.currentDomain)),!_isLocal ? SecurityDomain.currentDomain : null);
               }
               else if((_loc4_ = typeof _varTypes[_loc3_]) == "boolean")
               {
                  _loc2_[_loc3_] = Boolean(_loc5_ == "true" || _loc5_ == "1");
               }
               else if(_loc4_ == "number")
               {
                  _loc2_[_loc3_] = Number(_loc5_);
               }
               else
               {
                  _loc2_[_loc3_] = _loc5_;
               }
            }
         }
         return _loc2_;
      }
      
      public function getContent(param1:String) : *
      {
         if(param1 == this.name || param1 == _url)
         {
            return _content;
         }
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null ? _loc2_.content : null;
      }
      
      override protected function _load() : void
      {
         if(!_initted)
         {
            _prepRequest();
            _loader.load(_request);
         }
         else if(_loadingQueue != null)
         {
            _changeQueueListeners(true);
            _loadingQueue.load(false);
         }
      }
      
      override public function get progress() : Number
      {
         return this.bytesTotal != 0 ? _cachedBytesLoaded / _cachedBytesTotal : (_status == LoaderStatus.COMPLETED || _initted ? 1 : 0);
      }
      
      public function getLoader(param1:String) : *
      {
         return _parsed != null ? _parsed.getLoader(param1) : null;
      }
      
      override protected function _passThroughEvent(param1:Event) : void
      {
         if(param1.target != _loadingQueue)
         {
            super._passThroughEvent(param1);
         }
      }
      
      override protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         if(param1.target == _loadingQueue)
         {
            _status = LoaderStatus.FAILED;
            _time = getTimer() - _time;
            dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL,this));
            dispatchEvent(new LoaderEvent(LoaderEvent.FAIL,this,this.toString() + " > " + (param1 as Object).text));
         }
         else
         {
            super._failHandler(param1,param2);
         }
      }
      
      override protected function _completeHandler(param1:Event = null) : void
      {
         _calculateProgress();
         if(this.progress == 1)
         {
            _changeQueueListeners(false);
            super._completeHandler(param1);
         }
      }
      
      public function getChildren(param1:Boolean = false, param2:Boolean = false) : Array
      {
         return _parsed != null ? _parsed.getChildren(param1,param2) : [];
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(_loadingQueue != null)
         {
            _changeQueueListeners(false);
            if(param1 == 0)
            {
               _loadingQueue.cancel();
            }
            else
            {
               _loadingQueue.dispose(Boolean(param1 == 3));
               _loadingQueue = null;
            }
         }
         if(param1 >= 1)
         {
            if(_parsed != null)
            {
               _parsed.dispose(Boolean(param1 == 3));
               _parsed = null;
            }
            _initted = false;
         }
         _cacheIsDirty = true;
         var _loc4_:* = _content;
         super._dump(param1,param2,param3);
         if(param1 == 0)
         {
            _content = _loc4_;
         }
      }
      
      override protected function _calculateProgress() : void
      {
         _cachedBytesLoaded = _loader.bytesLoaded;
         if(_loader.bytesTotal != 0)
         {
            _cachedBytesTotal = _loader.bytesTotal;
         }
         if(_cachedBytesTotal < _cachedBytesLoaded || _initted)
         {
            _cachedBytesTotal = _cachedBytesLoaded;
         }
         var _loc1_:uint = uint(this.vars.estimatedBytes);
         if(this.vars.integrateProgress != false)
         {
            if(_loadingQueue != null && (uint(this.vars.estimatedBytes) < _cachedBytesLoaded || _loadingQueue.auditedSize))
            {
               if(_loadingQueue.status <= LoaderStatus.COMPLETED)
               {
                  _cachedBytesLoaded += _loadingQueue.bytesLoaded;
                  _cachedBytesTotal += _loadingQueue.bytesTotal;
               }
            }
            else if(uint(this.vars.estimatedBytes) > _cachedBytesLoaded && (!_initted || _loadingQueue != null && _loadingQueue.status <= LoaderStatus.COMPLETED && !_loadingQueue.auditedSize))
            {
               _cachedBytesTotal = uint(this.vars.estimatedBytes);
            }
         }
         if(!_initted && _cachedBytesLoaded == _cachedBytesTotal)
         {
            _cachedBytesLoaded = int(_cachedBytesLoaded * 0.99);
         }
         _cacheIsDirty = false;
      }
      
      override protected function _receiveDataHandler(param1:Event) : void
      {
         var loaders:Array = null;
         var i:int = 0;
         var event:Event = param1;
         try
         {
            _content = new XML(_loader.data);
         }
         catch(error:Error)
         {
            _content = _loader.data;
            _failHandler(new LoaderEvent(LoaderEvent.ERROR,this,error.message));
            return;
         }
         dispatchEvent(new LoaderEvent(RAW_LOAD,this,"",_content));
         _initted = true;
         _loadingQueue = new com.greensock.loading.LoaderMax({"name":this.name + "_Queue"});
         _parsed = new com.greensock.loading.LoaderMax({
            "name":this.name + "_ParsedLoaders",
            "paused":true
         });
         parseLoaders(_content as XML,_parsed,_loadingQueue);
         if(_parsed.numChildren == 0)
         {
            _parsed.dispose(false);
            _parsed = null;
         }
         else if("recursivePrependURLs" in this.vars)
         {
            _parsed.prependURLs(this.vars.recursivePrependURLs,true);
            loaders = _parsed.getChildren(true,true);
            i = int(loaders.length);
            while(--i > -1)
            {
               if(loaders[i] is XMLLoader)
               {
                  loaders[i].vars.recursivePrependURLs = this.vars.recursivePrependURLs;
               }
            }
         }
         else if("prependURLs" in this.vars)
         {
            _parsed.prependURLs(this.vars.prependURLs,true);
         }
         if(_loadingQueue.getChildren(true,true).length == 0)
         {
            _loadingQueue.empty(false);
            _loadingQueue.dispose(false);
            _loadingQueue = null;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",_content));
         }
         else
         {
            _cacheIsDirty = true;
            _changeQueueListeners(true);
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",_content));
            _loadingQueue.load(false);
         }
         if(_loadingQueue == null || this.vars.integrateProgress == false)
         {
            _completeHandler(event);
         }
      }
      
      protected function _changeQueueListeners(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(_loadingQueue != null)
         {
            if(param1 && this.vars.integrateProgress != false)
            {
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     _loadingQueue.addEventListener(_listenerTypes[_loc2_],_passThroughEvent,false,-100,true);
                  }
               }
               _loadingQueue.addEventListener(LoaderEvent.COMPLETE,_completeHandler,false,-100,true);
               _loadingQueue.addEventListener(LoaderEvent.PROGRESS,_progressHandler,false,-100,true);
               _loadingQueue.addEventListener(LoaderEvent.FAIL,_failHandler,false,-100,true);
            }
            else
            {
               _loadingQueue.removeEventListener(LoaderEvent.COMPLETE,_completeHandler);
               _loadingQueue.removeEventListener(LoaderEvent.PROGRESS,_progressHandler);
               _loadingQueue.removeEventListener(LoaderEvent.FAIL,_failHandler);
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     _loadingQueue.removeEventListener(_listenerTypes[_loc2_],_passThroughEvent);
                  }
               }
            }
         }
      }
      
      override protected function _progressHandler(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
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
}
