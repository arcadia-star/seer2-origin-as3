package com.adobe.webapis
{
   import com.adobe.net.DynamicURLLoader;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   
   public class URLLoaderBase extends ServiceBase
   {
       
      
      public function URLLoaderBase()
      {
         super();
      }
      
      protected function getURLLoader() : DynamicURLLoader
      {
         var _loc1_:DynamicURLLoader = new DynamicURLLoader();
         _loc1_.addEventListener("progress",this.onProgress);
         _loc1_.addEventListener("ioError",this.onIOError);
         _loc1_.addEventListener("securityError",this.onSecurityError);
         return _loc1_;
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
