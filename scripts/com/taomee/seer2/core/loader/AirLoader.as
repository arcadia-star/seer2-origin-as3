package com.taomee.seer2.core.loader
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class AirLoader extends EventDispatcher
   {
       
      
      private var _context:LoaderContext;
      
      private var _byteLoader:URLLoader;
      
      private var _loader:Loader;
      
      public function AirLoader()
      {
         super();
         this._byteLoader = new URLLoader();
         this._byteLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this._byteLoader.addEventListener(Event.OPEN,this.onOpen);
         this._byteLoader.addEventListener(Event.COMPLETE,this.onURLComplete);
         this._byteLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._byteLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._byteLoader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
      }
      
      public function dispose() : void
      {
         this._byteLoader.removeEventListener(Event.OPEN,this.onOpen);
         this._byteLoader.removeEventListener(Event.COMPLETE,this.onURLComplete);
         this._byteLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._byteLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._byteLoader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._context = null;
         this._byteLoader = null;
         this._loader = null;
      }
      
      public function get content() : DisplayObject
      {
         return this._loader.content;
      }
      
      public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         this._context = param2;
         this._byteLoader.load(param1);
      }
      
      public function close() : void
      {
         try
         {
            this._byteLoader.close();
            this._loader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function unload() : void
      {
         this._loader.unload();
      }
      
      public function unloadAndStop(param1:Boolean = true) : void
      {
         this._loader.unloadAndStop(param1);
      }
      
      private function onURLComplete(param1:Event) : void
      {
         if(this._context == null)
         {
            this._context = new LoaderContext();
         }
         if("allowCodeImport" in this._context)
         {
            this._context["allowCodeImport"] = true;
         }
         this._loader.loadBytes(ByteArray(this._byteLoader.data),this._context);
      }
      
      private function onComplete(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onOpen(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
