package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderCore;
   import com.greensock.loading.core.LoaderItem;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class LoaderMax extends LoaderCore
   {
      
      public static var defaultContext:LoaderContext;
      
      public static var contentDisplayClass:Class;
      
      public static var defaultEstimatedBytes:uint = 20000;
      
      public static const version:Number = 1.841;
      
      public static var defaultAuditSize:Boolean = true;
       
      
      protected var _loaders:Array;
      
      public var skipPaused:Boolean;
      
      public var maxConnections:uint;
      
      protected var _activeLoaders:Dictionary;
      
      public var skipFailed:Boolean;
      
      public function LoaderMax(param1:Object = null)
      {
         var _loc2_:int = 0;
         super(param1);
         _type = "LoaderMax";
         _loaders = [];
         _activeLoaders = new Dictionary();
         this.skipFailed = Boolean(this.vars.skipFailed != false);
         this.skipPaused = Boolean(this.vars.skipPaused != false);
         this.maxConnections = "maxConnections" in this.vars ? uint(this.vars.maxConnections) : 2;
         if(this.vars.loaders is Array)
         {
            _loc2_ = 0;
            while(_loc2_ < this.vars.loaders.length)
            {
               insert(this.vars.loaders[_loc2_],_loc2_);
               _loc2_++;
            }
         }
      }
      
      public static function getContent(param1:String) : *
      {
         return _globalRootLoader != null ? _globalRootLoader.getContent(param1) : null;
      }
      
      public static function getLoader(param1:String) : *
      {
         return _globalRootLoader != null ? _globalRootLoader.getLoader(param1) : null;
      }
      
      public static function parse(param1:*, param2:Object = null, param3:Object = null) : *
      {
         var _loc4_:LoaderMax = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(param1 is Array)
         {
            _loc4_ = new LoaderMax(param2);
            _loc5_ = int(param1.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_.append(LoaderMax.parse(param1[_loc6_],param3));
               _loc6_++;
            }
            return _loc4_;
         }
         if(param1 is String || param1 is URLRequest)
         {
            _loc7_ = String((_loc7_ = param1 is String ? param1 : URLRequest(param1).url).toLowerCase().split("?")[0]);
            if((_loc7_ = _loc7_.substr(_loc7_.lastIndexOf(".") + 1)) in _extensions)
            {
               return new _extensions[_loc7_](param1,param2);
            }
         }
         else if(param1 is LoaderCore)
         {
            return param1 as LoaderCore;
         }
         throw new Error("LoaderMax could not parse " + param1 + ". Don\'t forget to use LoaderMax.activate() to activate the necessary types of loaders.");
      }
      
      public static function registerFileType(param1:String, param2:Class) : void
      {
         _activateClass("",param2,param1);
      }
      
      public static function activate(param1:Array) : void
      {
      }
      
      public static function prioritize(param1:String, param2:Boolean = true) : LoaderCore
      {
         var _loc3_:LoaderCore = getLoader(param1);
         if(_loc3_ != null)
         {
            _loc3_.prioritize(param2);
         }
         return _loc3_;
      }
      
      override public function get content() : *
      {
         var _loc1_:Array = [];
         var _loc2_:int = int(_loaders.length);
         while(--_loc2_ > -1)
         {
            _loc1_[_loc2_] = LoaderCore(_loaders[_loc2_]).content;
         }
         return _loc1_;
      }
      
      public function getContent(param1:String) : *
      {
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null ? _loc2_.content : null;
      }
      
      public function remove(param1:LoaderCore) : void
      {
         _removeLoader(param1,true);
      }
      
      override protected function _load() : void
      {
         _loadNext(null);
      }
      
      protected function _cancelActiveLoaders() : void
      {
         var _loc2_:LoaderCore = null;
         var _loc1_:int = int(_loaders.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = _loaders[_loc1_];
            if(_loc2_.status == LoaderStatus.LOADING)
            {
               delete _activeLoaders[_loc2_];
               _removeLoaderListeners(_loc2_,false);
               _loc2_.cancel();
            }
         }
      }
      
      protected function _removeLoaderListeners(param1:LoaderCore, param2:Boolean) : void
      {
         var _loc3_:String = null;
         param1.removeEventListener(LoaderEvent.COMPLETE,_loadNext);
         param1.removeEventListener(LoaderEvent.CANCEL,_loadNext);
         if(param2)
         {
            param1.removeEventListener(LoaderEvent.PROGRESS,_progressHandler);
            param1.removeEventListener("prioritize",_prioritizeHandler);
            param1.removeEventListener("dispose",_disposeHandler);
            for(_loc3_ in _listenerTypes)
            {
               if(_loc3_ != "onProgress" && _loc3_ != "onInit")
               {
                  param1.removeEventListener(_listenerTypes[_loc3_],_passThroughEvent);
               }
            }
         }
      }
      
      protected function _disposeHandler(param1:Event) : void
      {
         _removeLoader(LoaderCore(param1.target),false);
      }
      
      public function getChildIndex(param1:LoaderCore) : uint
      {
         var _loc2_:int = int(_loaders.length);
         while(--_loc2_ > -1)
         {
            if(_loaders[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return 999999999;
      }
      
      public function prepend(param1:LoaderCore) : LoaderCore
      {
         return insert(param1,0);
      }
      
      public function getLoader(param1:String) : *
      {
         var _loc3_:LoaderCore = null;
         var _loc2_:int = int(_loaders.length);
         while(--_loc2_ > -1)
         {
            _loc3_ = _loaders[_loc2_];
            if(_loc3_.name == param1 || _loc3_ is LoaderItem && (_loc3_ as LoaderItem).url == param1)
            {
               return _loc3_;
            }
            if(_loc3_.hasOwnProperty("getLoader"))
            {
               _loc3_ = (_loc3_ as Object).getLoader(param1) as LoaderCore;
               if(_loc3_ != null)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function prependURLs(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:Array = getChildren(param2,true);
         var _loc4_:int = int(_loc3_.length);
         while(--_loc4_ > -1)
         {
            LoaderItem(_loc3_[_loc4_]).url = param1 + LoaderItem(_loc3_[_loc4_]).url;
         }
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(param2 == LoaderStatus.DISPOSED)
         {
            _status = LoaderStatus.DISPOSED;
            empty(true,Boolean(param1 == 3));
            if(this.vars.requireWithRoot is DisplayObject)
            {
               delete _rootLookup[this.vars.requireWithRoot];
            }
            _activeLoaders = null;
         }
         if(param1 <= 1)
         {
            _cancelActiveLoaders();
         }
         if(param1 == 1)
         {
            _loc4_ = int(_loaders.length);
            while(--_loc4_ > -1)
            {
               LoaderCore(_loaders[_loc4_]).unload();
            }
         }
         super._dump(param1,param2,param3);
         _cacheIsDirty = true;
      }
      
      public function empty(param1:Boolean = true, param2:Boolean = false) : void
      {
         var _loc3_:int = int(_loaders.length);
         while(--_loc3_ > -1)
         {
            if(param1)
            {
               LoaderCore(_loaders[_loc3_]).dispose(param2);
            }
            else if(param2)
            {
               LoaderCore(_loaders[_loc3_]).unload();
            }
            else
            {
               _removeLoader(_loaders[_loc3_],true);
            }
         }
      }
      
      protected function _removeLoader(param1:LoaderCore, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 && this != param1.rootLoader)
         {
            param1.rootLoader.append(param1);
         }
         _removeLoaderListeners(param1,true);
         _loaders.splice(getChildIndex(param1),1);
         if(param1 in _activeLoaders)
         {
            delete _activeLoaders[param1];
            param1.cancel();
            if(_status == LoaderStatus.LOADING)
            {
               _loadNext(null);
            }
         }
         _cacheIsDirty = true;
         _progressHandler(null);
      }
      
      public function get rawProgress() : Number
      {
         var _loc3_:int = 0;
         var _loc1_:Number = 0;
         var _loc2_:uint = 0;
         var _loc4_:int = int(_loaders.length);
         while(--_loc4_ > -1)
         {
            _loc3_ = LoaderCore(_loaders[_loc4_]).status;
            if(_loc3_ != LoaderStatus.DISPOSED && !(_loc3_ == LoaderStatus.PAUSED && this.skipPaused) && !(_loc3_ == LoaderStatus.FAILED && this.skipFailed))
            {
               _loc2_++;
               _loc1_ += _loaders[_loc4_] is LoaderMax ? LoaderMax(_loaders[_loc4_]).rawProgress : LoaderCore(_loaders[_loc4_]).progress;
            }
         }
         return _loc2_ == 0 ? 0 : _loc1_ / _loc2_;
      }
      
      protected function _loadNext(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:LoaderCore = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         if(param1 != null && _activeLoaders != null)
         {
            delete _activeLoaders[param1.target];
            _removeLoaderListeners(LoaderCore(param1.target),false);
         }
         if(_status == LoaderStatus.LOADING)
         {
            _loc2_ = "auditSize" in this.vars ? Boolean(this.vars.auditSize) : LoaderMax.defaultAuditSize;
            if(_loc2_ && !this.auditedSize)
            {
               _auditSize(null);
               return;
            }
            _loc4_ = _loaders.length;
            _loc5_ = 0;
            _calculateProgress();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc3_ = _loaders[_loc6_];
               if(!this.skipPaused && _loc3_.status == LoaderStatus.PAUSED)
               {
                  super._failHandler(new LoaderEvent(LoaderEvent.FAIL,this,"Did not complete LoaderMax because skipPaused was false and " + _loc3_.toString() + " was paused."),false);
                  return;
               }
               if(!this.skipFailed && _loc3_.status == LoaderStatus.FAILED)
               {
                  super._failHandler(new LoaderEvent(LoaderEvent.FAIL,this,"Did not complete LoaderMax because skipFailed was false and " + _loc3_.toString() + " failed."),false);
                  return;
               }
               if(_loc3_.status <= LoaderStatus.LOADING)
               {
                  _loc5_++;
                  if(!(_loc3_ in _activeLoaders))
                  {
                     _activeLoaders[_loc3_] = true;
                     _loc3_.addEventListener(LoaderEvent.COMPLETE,_loadNext,false,-100,true);
                     _loc3_.addEventListener(LoaderEvent.CANCEL,_loadNext,false,-100,true);
                     _loc3_.load(false);
                  }
                  if(_loc5_ == this.maxConnections)
                  {
                     break;
                  }
               }
               _loc6_++;
            }
            if(_loc5_ == 0 && _cachedBytesLoaded == _cachedBytesTotal)
            {
               _completeHandler(null);
            }
         }
      }
      
      public function append(param1:LoaderCore) : LoaderCore
      {
         return insert(param1,_loaders.length);
      }
      
      override protected function _progressHandler(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_dispatchChildProgress && param1 != null)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.CHILD_PROGRESS,param1.target));
         }
         if(_dispatchProgress && _status != LoaderStatus.DISPOSED)
         {
            _loc2_ = _cachedBytesLoaded;
            _loc3_ = _cachedBytesTotal;
            _calculateProgress();
            if(!(_loc2_ == 0 && _cachedBytesLoaded == 0))
            {
               if((_cachedBytesLoaded != _cachedBytesTotal || _status != LoaderStatus.LOADING) && (_loc2_ != _cachedBytesLoaded || _loc3_ != _cachedBytesTotal))
               {
                  dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
               }
            }
         }
         else
         {
            _cacheIsDirty = true;
         }
      }
      
      protected function _prioritizeHandler(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:LoaderCore = param1.target as LoaderCore;
         _loaders.splice(getChildIndex(_loc2_),1);
         _loaders.unshift(_loc2_);
         if(_status == LoaderStatus.LOADING && _loc2_.status <= LoaderStatus.LOADING && !(_loc2_ in _activeLoaders))
         {
            _cancelActiveLoaders();
            _loc3_ = this.maxConnections;
            this.maxConnections = 1;
            _loadNext(null);
            this.maxConnections = _loc3_;
         }
      }
      
      public function get numChildren() : uint
      {
         return _loaders.length;
      }
      
      public function replaceURLText(param1:String, param2:String, param3:Boolean = false) : void
      {
         var _loc5_:LoaderItem = null;
         var _loc4_:Array;
         var _loc6_:int = int((_loc4_ = getChildren(param3,true)).length);
         while(--_loc6_ > -1)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc5_.url = _loc5_.url.split(param1).join(param2);
            if("alternateURL" in _loc5_.vars)
            {
               _loc5_.vars.alternateURL = _loc5_.vars.alternateURL.split(param1).join(param2);
            }
         }
      }
      
      override public function get auditedSize() : Boolean
      {
         var _loc1_:int = this.skipPaused ? LoaderStatus.COMPLETED : LoaderStatus.PAUSED;
         var _loc2_:int = int(_loaders.length);
         while(--_loc2_ > -1)
         {
            if(!LoaderCore(_loaders[_loc2_]).auditedSize && LoaderCore(_loaders[_loc2_]).status <= _loc1_)
            {
               return false;
            }
         }
         return true;
      }
      
      override public function get status() : int
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(_status == LoaderStatus.COMPLETED)
         {
            _loc1_ = [0,0,0,0,0,0];
            _loc2_ = int(_loaders.length);
            while(--_loc2_ > -1)
            {
               ++_loc1_[LoaderCore(_loaders[_loc2_]).status];
            }
            if(!this.skipFailed && _loc1_[4] != 0 || !this.skipPaused && _loc1_[3] != 0)
            {
               _status = LoaderStatus.FAILED;
            }
            else if(_loc1_[0] + _loc1_[1] != 0)
            {
               _status = LoaderStatus.READY;
               _cacheIsDirty = true;
            }
         }
         return _status;
      }
      
      override protected function _calculateProgress() : void
      {
         var _loc2_:LoaderCore = null;
         var _loc3_:int = 0;
         _cachedBytesLoaded = 0;
         _cachedBytesTotal = 0;
         var _loc1_:int = int(_loaders.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = _loaders[_loc1_];
            _loc3_ = _loc2_.status;
            if(_loc3_ <= LoaderStatus.COMPLETED || !this.skipPaused && _loc3_ == LoaderStatus.PAUSED || !this.skipFailed && _loc3_ == LoaderStatus.FAILED)
            {
               _cachedBytesLoaded += _loc2_.bytesLoaded;
               _cachedBytesTotal += _loc2_.bytesTotal;
            }
         }
         _cacheIsDirty = false;
      }
      
      public function getChildren(param1:Boolean = false, param2:Boolean = false) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:int = int(_loaders.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(!param2 || !(_loaders[_loc5_] is LoaderMax))
            {
               _loc3_.push(_loaders[_loc5_]);
            }
            if(param1 && Boolean(_loaders[_loc5_].hasOwnProperty("getChildren")))
            {
               _loc3_ = _loc3_.concat(_loaders[_loc5_].getChildren(true,param2));
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function insert(param1:LoaderCore, param2:uint = 999999999) : LoaderCore
      {
         var _loc3_:String = null;
         if(param1 == null || param1 == this || _status == LoaderStatus.DISPOSED)
         {
            return null;
         }
         if(this != param1.rootLoader)
         {
            _removeLoader(param1,false);
         }
         if(param1.rootLoader == _globalRootLoader)
         {
            param1.rootLoader.remove(param1);
         }
         if(param2 > _loaders.length)
         {
            param2 = _loaders.length;
         }
         _loaders.splice(param2,0,param1);
         if(this != _globalRootLoader)
         {
            for(_loc3_ in _listenerTypes)
            {
               if(_loc3_ != "onProgress" && _loc3_ != "onInit")
               {
                  param1.addEventListener(_listenerTypes[_loc3_],_passThroughEvent,false,-100,true);
               }
            }
            param1.addEventListener(LoaderEvent.PROGRESS,_progressHandler,false,-100,true);
            param1.addEventListener("prioritize",_prioritizeHandler,false,-100,true);
         }
         param1.addEventListener("dispose",_disposeHandler,false,-100,true);
         _cacheIsDirty = true;
         if(_status != LoaderStatus.LOADING)
         {
            if(_status != LoaderStatus.PAUSED)
            {
               _status = LoaderStatus.READY;
            }
            else if(_prePauseStatus == LoaderStatus.COMPLETED)
            {
               _prePauseStatus = LoaderStatus.READY;
            }
         }
         return param1;
      }
      
      override public function auditSize() : void
      {
         if(!this.auditedSize)
         {
            _auditSize(null);
         }
      }
      
      protected function _auditSize(param1:Event = null) : void
      {
         var _loc4_:LoaderCore = null;
         var _loc5_:Boolean = false;
         if(param1 != null)
         {
            param1.target.removeEventListener("auditedSize",_auditSize);
            param1.target.removeEventListener(LoaderEvent.FAIL,_auditSize);
         }
         var _loc2_:uint = _loaders.length;
         var _loc3_:int = this.skipPaused ? LoaderStatus.COMPLETED : LoaderStatus.PAUSED;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            if(!(_loc4_ = _loaders[_loc6_]).auditedSize && _loc4_.status <= _loc3_)
            {
               if(!_loc5_)
               {
                  _loc4_.addEventListener("auditedSize",_auditSize,false,-100,true);
                  _loc4_.addEventListener(LoaderEvent.FAIL,_auditSize,false,-100,true);
               }
               _loc5_ = true;
               _loc4_.auditSize();
            }
            _loc6_++;
         }
         if(!_loc5_)
         {
            if(_status == LoaderStatus.LOADING)
            {
               _loadNext(null);
            }
            dispatchEvent(new Event("auditedSize"));
         }
      }
      
      public function getChildrenByStatus(param1:int, param2:Boolean = false) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array;
         var _loc5_:int = int((_loc4_ = getChildren(param2,false)).length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(LoaderCore(_loc4_[_loc6_]).status == param1)
            {
               _loc3_.push(_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         return _loc3_;
      }
   }
}
