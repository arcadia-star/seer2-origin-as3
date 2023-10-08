package com.greensock.loading.core
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.LoaderMax;
   import com.greensock.loading.LoaderStatus;
   import com.greensock.loading.display.ContentDisplay;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.LocalConnection;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   
   public class DisplayObjectLoader extends LoaderItem
   {
      
      protected static var _gcDispatcher:Sprite;
      
      protected static var _gcCycles:uint = 0;
       
      
      protected var _initted:Boolean;
      
      protected var _stealthMode:Boolean;
      
      protected var _sprite:Sprite;
      
      protected var _context:LoaderContext;
      
      protected var _loader:Loader;
      
      public function DisplayObjectLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _refreshLoader(false);
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
      }
      
      protected static function _forceGCHandler(param1:Event) : void
      {
         var event:Event = param1;
         if(_gcCycles == 0)
         {
            _gcDispatcher.removeEventListener(Event.ENTER_FRAME,_forceGCHandler);
            _gcDispatcher = null;
         }
         else
         {
            --_gcCycles;
         }
         try
         {
            new LocalConnection().connect("FORCE_GC");
            new LocalConnection().connect("FORCE_GC");
         }
         catch(error:Error)
         {
         }
      }
      
      public static function forceGC(param1:uint = 1) : void
      {
         if(_gcCycles < param1)
         {
            _gcCycles = param1;
            if(_gcDispatcher == null)
            {
               _gcDispatcher = new Sprite();
               _gcDispatcher.addEventListener(Event.ENTER_FRAME,_forceGCHandler,false,0,true);
            }
         }
      }
      
      protected function _securityErrorHandler(param1:ErrorEvent) : void
      {
         if(_context != null && _context.checkPolicyFile && !(this.vars.context is LoaderContext))
         {
            _context = new LoaderContext(false);
            _scriptAccessDenied = true;
            dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,param1.text));
            _errorHandler(param1);
            _load();
         }
         else
         {
            _failHandler(param1);
         }
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(!_stealthMode)
         {
            _refreshLoader(Boolean(param1 != 2));
         }
         if(param1 == 1)
         {
            (_sprite as Object).rawContent = null;
         }
         else if(param1 == 2)
         {
            (_sprite as Object).loader = null;
         }
         else if(param1 == 3)
         {
            (_sprite as Object).dispose(false,false);
         }
         super._dump(param1,param2,param3);
      }
      
      protected function _determineScriptAccess() : void
      {
         if(!_scriptAccessDenied)
         {
            if(!_loader.contentLoaderInfo.childAllowsParent)
            {
               _scriptAccessDenied = true;
               dispatchEvent(new LoaderEvent(LoaderEvent.SCRIPT_ACCESS_DENIED,this,"Error #2123: Security sandbox violation: " + this + ". No policy files granted access."));
            }
         }
      }
      
      override protected function _load() : void
      {
         _prepRequest();
         if(this.vars.context is LoaderContext)
         {
            _context = this.vars.context;
         }
         else if(_context == null)
         {
            if(LoaderMax.defaultContext != null)
            {
               _context = LoaderMax.defaultContext;
               if(_isLocal)
               {
                  _context.securityDomain = null;
               }
            }
            else if(!_isLocal)
            {
               _context = new LoaderContext(true,new ApplicationDomain(ApplicationDomain.currentDomain),SecurityDomain.currentDomain);
            }
         }
         if(Capabilities.playerType != "Desktop")
         {
            Security.allowDomain(_url);
         }
         _loader.load(_request,_context);
      }
      
      public function get rawContent() : *
      {
         return _content;
      }
      
      protected function _refreshLoader(param1:Boolean = true) : void
      {
         var unloadContent:Boolean = param1;
         if(_loader != null)
         {
            if(_status == LoaderStatus.LOADING)
            {
               try
               {
                  _loader.close();
               }
               catch(error:Error)
               {
               }
            }
            _loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_progressHandler);
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,_completeHandler);
            _loader.contentLoaderInfo.removeEventListener("ioError",_failHandler);
            _loader.contentLoaderInfo.removeEventListener("securityError",_securityErrorHandler);
            _loader.contentLoaderInfo.removeEventListener("httpStatus",_httpStatusHandler);
            _loader.contentLoaderInfo.removeEventListener(Event.INIT,_initHandler);
            if(unloadContent)
            {
               try
               {
                  if(_loader.parent == null && _sprite != null)
                  {
                     _sprite.addChild(_loader);
                  }
                  if(_loader.hasOwnProperty("unloadAndStop"))
                  {
                     (_loader as Object).unloadAndStop();
                  }
                  else
                  {
                     _loader.unload();
                  }
               }
               catch(error:Error)
               {
               }
               if(_loader.parent)
               {
                  _loader.parent.removeChild(_loader);
               }
            }
            forceGC(this.hasOwnProperty("getClass") ? 3 : 1);
         }
         _initted = false;
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_progressHandler,false,0,true);
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,_completeHandler,false,0,true);
         _loader.contentLoaderInfo.addEventListener("ioError",_failHandler,false,0,true);
         _loader.contentLoaderInfo.addEventListener("securityError",_securityErrorHandler,false,0,true);
         _loader.contentLoaderInfo.addEventListener("httpStatus",_httpStatusHandler,false,0,true);
         _loader.contentLoaderInfo.addEventListener(Event.INIT,_initHandler,false,0,true);
      }
      
      override public function get content() : *
      {
         return _sprite;
      }
      
      public function setContentDisplay(param1:Sprite) : void
      {
         _sprite = param1;
      }
      
      protected function _initHandler(param1:Event) : void
      {
         if(!_initted)
         {
            _initted = true;
            if(_content == null)
            {
               _content = _scriptAccessDenied ? _loader : _loader.content;
            }
            (_sprite as Object).rawContent = _content as DisplayObject;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this));
         }
      }
   }
}
