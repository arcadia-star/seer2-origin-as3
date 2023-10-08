package com.greensock.loading.core
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.LoaderMax;
   import com.greensock.loading.LoaderStatus;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.LocalConnection;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class LoaderCore extends EventDispatcher
   {
      
      protected static var _types:Object = {};
      
      protected static var _listenerTypes:Object = {
         "onOpen":"open",
         "onInit":"init",
         "onComplete":"complete",
         "onProgress":"progress",
         "onCancel":"cancel",
         "onFail":"fail",
         "onError":"error",
         "onSecurityError":"securityError",
         "onHTTPStatus":"httpStatus",
         "onIOError":"ioError",
         "onScriptAccessDenied":"scriptAccessDenied",
         "onChildOpen":"childOpen",
         "onChildCancel":"childCancel",
         "onChildComplete":"childComplete",
         "onChildProgress":"childProgress",
         "onChildFail":"childFail",
         "onRawLoad":"rawLoad"
      };
      
      protected static var _isLocal:Boolean;
      
      protected static var _extensions:Object = {};
      
      protected static var _globalRootLoader:LoaderMax;
      
      public static const version:Number = 1.83;
      
      protected static var _rootLookup:Dictionary = new Dictionary(false);
      
      protected static var _loaderCount:uint = 0;
       
      
      protected var _prePauseStatus:int;
      
      public var name:String;
      
      protected var _dispatchChildProgress:Boolean;
      
      protected var _status:int;
      
      protected var _type:String;
      
      protected var _auditedSize:Boolean;
      
      protected var _dispatchProgress:Boolean;
      
      public var vars:Object;
      
      protected var _cachedBytesTotal:uint;
      
      protected var _time:uint;
      
      protected var _content;
      
      protected var _rootLoader:LoaderMax;
      
      protected var _cacheIsDirty:Boolean;
      
      protected var _cachedBytesLoaded:uint;
      
      public var autoDispose:Boolean;
      
      public function LoaderCore(param1:Object = null)
      {
         var _loc2_:String = null;
         super();
         this.vars = param1 != null ? param1 : {};
         if(this.vars.isGSVars)
         {
            this.vars = this.vars.vars;
         }
         this.name = this.vars.name != undefined && String(this.vars.name) != "" ? String(this.vars.name) : "loader" + _loaderCount++;
         _cachedBytesLoaded = 0;
         _cachedBytesTotal = uint(this.vars.estimatedBytes) != 0 ? uint(this.vars.estimatedBytes) : LoaderMax.defaultEstimatedBytes;
         this.autoDispose = Boolean(this.vars.autoDispose == true);
         _status = this.vars.paused == true ? LoaderStatus.PAUSED : LoaderStatus.READY;
         _auditedSize = Boolean(uint(this.vars.estimatedBytes) != 0 && this.vars.auditSize != true);
         if(_globalRootLoader == null)
         {
            if(this.vars.__isRoot == true)
            {
               return;
            }
            _globalRootLoader = new LoaderMax({
               "name":"root",
               "__isRoot":true
            });
            _isLocal = Boolean(Capabilities.playerType == "Desktop" || new LocalConnection().domain == "localhost");
         }
         _rootLoader = this.vars.requireWithRoot is DisplayObject ? _rootLookup[this.vars.requireWithRoot] : _globalRootLoader;
         if(_rootLoader == null)
         {
            _rootLookup[this.vars.requireWithRoot] = _rootLoader = new LoaderMax();
            _rootLoader.name = "subloaded_swf_" + (this.vars.requireWithRoot.loaderInfo != null ? this.vars.requireWithRoot.loaderInfo.url : String(_loaderCount));
            _rootLoader.skipFailed = false;
         }
         for(_loc2_ in _listenerTypes)
         {
            if(_loc2_ in this.vars && this.vars[_loc2_] is Function)
            {
               this.addEventListener(_listenerTypes[_loc2_],this.vars[_loc2_],false,0,true);
            }
         }
         _rootLoader.append(this);
      }
      
      protected static function _activateClass(param1:String, param2:Class, param3:String) : Boolean
      {
         if(param1 != "")
         {
            _types[param1.toLowerCase()] = param2;
         }
         var _loc4_:Array;
         var _loc5_:int = int((_loc4_ = param3.split(",")).length);
         while(--_loc5_ > -1)
         {
            _extensions[_loc4_[_loc5_]] = param2;
         }
         return true;
      }
      
      protected function _errorHandler(param1:Event) : void
      {
         var _loc2_:Object = param1.target;
         _loc2_ = param1 is LoaderEvent && this.hasOwnProperty("getChildren") ? param1.target : this;
         var _loc3_:String = String((param1 as Object).text);
         trace("----\nLoading error on " + this.toString() + ": " + _loc3_ + "\n----");
         if(param1.type != LoaderEvent.ERROR && param1.type != LoaderEvent.FAIL && this.hasEventListener(param1.type))
         {
            dispatchEvent(new LoaderEvent(param1.type,_loc2_,_loc3_));
         }
         if(this.hasEventListener(LoaderEvent.ERROR))
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.ERROR,_loc2_,this.toString() + " > " + _loc3_));
         }
      }
      
      protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         var _loc3_:Object = null;
         _dump(0,LoaderStatus.FAILED);
         if(param2)
         {
            _errorHandler(param1);
         }
         else
         {
            _loc3_ = param1.target;
         }
         dispatchEvent(new LoaderEvent(LoaderEvent.FAIL,param1 is LoaderEvent && this.hasOwnProperty("getChildren") ? param1.target : this,this.toString() + " > " + (param1 as Object).text));
      }
      
      protected function _completeHandler(param1:Event = null) : void
      {
         _cachedBytesLoaded = _cachedBytesTotal;
         if(_status != LoaderStatus.COMPLETED)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
            _status = LoaderStatus.COMPLETED;
            _time = getTimer() - _time;
         }
         dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE,this));
         if(this.autoDispose)
         {
            dispose();
         }
      }
      
      public function get rootLoader() : LoaderMax
      {
         return _rootLoader;
      }
      
      protected function _progressHandler(param1:Event) : void
      {
         if(param1 is ProgressEvent)
         {
            _cachedBytesLoaded = (param1 as ProgressEvent).bytesLoaded;
            _cachedBytesTotal = (param1 as ProgressEvent).bytesTotal;
            if(!_auditedSize)
            {
               _auditedSize = true;
               dispatchEvent(new Event("auditedSize"));
            }
         }
         if(_dispatchProgress && _status == LoaderStatus.LOADING && _cachedBytesLoaded != _cachedBytesTotal)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
      }
      
      public function dispose(param1:Boolean = false) : void
      {
         _dump(param1 ? 3 : 2,LoaderStatus.DISPOSED);
      }
      
      public function get bytesTotal() : uint
      {
         if(_cacheIsDirty)
         {
            _calculateProgress();
         }
         return _cachedBytesTotal;
      }
      
      public function resume() : void
      {
         this.paused = false;
         load(false);
      }
      
      public function get paused() : Boolean
      {
         return Boolean(_status == LoaderStatus.PAUSED);
      }
      
      protected function _calculateProgress() : void
      {
      }
      
      public function get progress() : Number
      {
         return this.bytesTotal != 0 ? _cachedBytesLoaded / _cachedBytesTotal : (_status == LoaderStatus.COMPLETED ? 1 : 0);
      }
      
      public function prioritize(param1:Boolean = true) : void
      {
         dispatchEvent(new Event("prioritize"));
         if(param1 && _status != LoaderStatus.COMPLETED && _status != LoaderStatus.LOADING)
         {
            load(false);
         }
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == LoaderEvent.PROGRESS)
         {
            _dispatchProgress = true;
         }
         else if(param1 == LoaderEvent.CHILD_PROGRESS && this is LoaderMax)
         {
            _dispatchChildProgress = true;
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get bytesLoaded() : uint
      {
         if(_cacheIsDirty)
         {
            _calculateProgress();
         }
         return _cachedBytesLoaded;
      }
      
      protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         var _loc5_:String = null;
         _content = null;
         var _loc4_:Boolean = Boolean(_status == LoaderStatus.LOADING);
         if(_status == LoaderStatus.PAUSED && param2 != LoaderStatus.PAUSED && param2 != LoaderStatus.FAILED)
         {
            _prePauseStatus = param2;
         }
         else if(_status != LoaderStatus.DISPOSED)
         {
            _status = param2;
         }
         if(_loc4_)
         {
            _time = getTimer() - _time;
         }
         if(_dispatchProgress && !param3 && _status < LoaderStatus.FAILED)
         {
            if(this is LoaderMax)
            {
               _calculateProgress();
            }
            else
            {
               _cachedBytesLoaded = 0;
            }
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
         if(!param3)
         {
            if(_loc4_)
            {
               dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL,this));
            }
            if(param1 != 2)
            {
               dispatchEvent(new LoaderEvent(LoaderEvent.UNLOAD,this));
            }
         }
         if(param2 == LoaderStatus.DISPOSED)
         {
            if(!param3)
            {
               dispatchEvent(new Event("dispose"));
            }
            for(_loc5_ in _listenerTypes)
            {
               if(_loc5_ in this.vars && this.vars[_loc5_] is Function)
               {
                  this.removeEventListener(_listenerTypes[_loc5_],this.vars[_loc5_]);
               }
            }
         }
      }
      
      protected function _load() : void
      {
      }
      
      public function get loadTime() : Number
      {
         if(_status == LoaderStatus.READY)
         {
            return 0;
         }
         if(_status == LoaderStatus.LOADING)
         {
            return (getTimer() - _time) / 1000;
         }
         return _time / 1000;
      }
      
      public function get auditedSize() : Boolean
      {
         return _auditedSize;
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(param1 && _status != LoaderStatus.PAUSED)
         {
            _prePauseStatus = _status;
            if(_status == LoaderStatus.LOADING)
            {
               _dump(0,LoaderStatus.PAUSED);
            }
            _status = LoaderStatus.PAUSED;
         }
         else if(!param1 && _status == LoaderStatus.PAUSED)
         {
            if(_prePauseStatus == LoaderStatus.LOADING)
            {
               load(false);
            }
            else
            {
               _status = _prePauseStatus || LoaderStatus.READY;
            }
         }
      }
      
      protected function _passThroughEvent(param1:Event) : void
      {
         var _loc2_:String = param1.type;
         var _loc3_:Object = this;
         if(this.hasOwnProperty("getChildren"))
         {
            if(param1 is LoaderEvent)
            {
               _loc3_ = param1.target;
            }
            if(_loc2_ == "complete")
            {
               _loc2_ = "childComplete";
            }
            else if(_loc2_ == "open")
            {
               _loc2_ = "childOpen";
            }
            else if(_loc2_ == "cancel")
            {
               _loc2_ = "childCancel";
            }
            else if(_loc2_ == "fail")
            {
               _loc2_ = "childFail";
            }
         }
         if(this.hasEventListener(_loc2_))
         {
            dispatchEvent(new LoaderEvent(_loc2_,_loc3_,param1.hasOwnProperty("text") ? String((param1 as Object).text) : ""));
         }
      }
      
      public function load(param1:Boolean = false) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(this.status == LoaderStatus.PAUSED)
         {
            _status = _prePauseStatus <= LoaderStatus.LOADING ? LoaderStatus.READY : _prePauseStatus;
            if(_status == LoaderStatus.READY && this is LoaderMax)
            {
               _loc2_ -= _time;
            }
         }
         if(param1 || _status == LoaderStatus.FAILED)
         {
            _dump(1,LoaderStatus.READY);
         }
         if(_status == LoaderStatus.READY)
         {
            _status = LoaderStatus.LOADING;
            _time = _loc2_;
            _load();
            if(this.progress < 1)
            {
               dispatchEvent(new LoaderEvent(LoaderEvent.OPEN,this));
            }
         }
         else if(_status == LoaderStatus.COMPLETED)
         {
            _completeHandler(null);
         }
      }
      
      override public function toString() : String
      {
         return _type + " \'" + this.name + "\'" + (this is LoaderItem ? " (" + (this as LoaderItem).url + ")" : "");
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function pause() : void
      {
         this.paused = true;
      }
      
      public function get content() : *
      {
         return _content;
      }
      
      public function cancel() : void
      {
         if(_status == LoaderStatus.LOADING)
         {
            _dump(0,LoaderStatus.READY);
         }
      }
      
      public function auditSize() : void
      {
      }
      
      public function unload() : void
      {
         _dump(1,LoaderStatus.READY);
      }
   }
}
