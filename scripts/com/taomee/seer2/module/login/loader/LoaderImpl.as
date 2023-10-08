package com.taomee.seer2.module.login.loader
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LoaderImpl extends EventDispatcher
   {
       
      
      private const TIME_OUT:int = 50000;
      
      private var _loader:Loader;
      
      private var _loader2:Loader;
      
      private var _timeId:int;
      
      private var _url:String;
      
      public function LoaderImpl()
      {
         super();
      }
      
      public function load(param1:String) : void
      {
         this.close();
         this._url = param1;
         this._timeId = setTimeout(this.onTimeOut,this.TIME_OUT);
         this.getLoader().load(new URLRequest(param1));
      }
      
      private function onTimeOut() : void
      {
         clearTimeout(this._timeId);
         dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
      }
      
      private function getLoader() : Loader
      {
         if(!this._loader)
         {
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.OPEN,this.onOpen);
            this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBytesComplete);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         return this._loader;
      }
      
      private function onOpen(param1:Event) : void
      {
         clearTimeout(this._timeId);
         dispatchEvent(param1);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onBytesComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this._loader2 = new Loader();
         this._loader2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader2.loadBytes(_loc2_.bytes);
      }
      
      private function onComplete(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function onError(param1:ErrorEvent) : void
      {
         clearTimeout(this._timeId);
         dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
      }
      
      public function get domain() : ApplicationDomain
      {
         if(this._loader2)
         {
            return this._loader2.contentLoaderInfo.applicationDomain;
         }
         return null;
      }
      
      public function get content() : DisplayObject
      {
         if(this._loader2)
         {
            return this._loader2.contentLoaderInfo.content;
         }
         return null;
      }
      
      public function close() : void
      {
         if(this._loader)
         {
            try
            {
               this._loader.close();
               this._loader.unload();
            }
            catch(e:Error)
            {
            }
         }
         if(this._loader2)
         {
            try
            {
               this._loader2.close();
               this._loader2.unload();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function dispose() : void
      {
         this.close();
         if(this._loader)
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.onOpen);
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBytesComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         if(this._loader2)
         {
            this._loader2.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
         }
      }
   }
}
