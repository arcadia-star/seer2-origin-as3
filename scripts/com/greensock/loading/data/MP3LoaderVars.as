package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   import flash.media.SoundLoaderContext;
   
   public class MP3LoaderVars
   {
      
      public static const version:Number = 1.2;
       
      
      protected var _vars:Object;
      
      public function MP3LoaderVars(param1:Object = null)
      {
         var _loc2_:String = null;
         super();
         _vars = {};
         if(param1 != null)
         {
            for(_loc2_ in param1)
            {
               _vars[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function onCancel(param1:Function) : MP3LoaderVars
      {
         return _set("onCancel",param1);
      }
      
      public function noCache(param1:Boolean) : MP3LoaderVars
      {
         return _set("noCache",param1);
      }
      
      public function autoPlay(param1:Boolean) : MP3LoaderVars
      {
         return _set("autoPlay",param1);
      }
      
      public function get vars() : Object
      {
         return _vars;
      }
      
      public function onOpen(param1:Function) : MP3LoaderVars
      {
         return _set("onOpen",param1);
      }
      
      public function onIOError(param1:Function) : MP3LoaderVars
      {
         return _set("onIOError",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : MP3LoaderVars
      {
         return _set("requireWithRoot",param1);
      }
      
      public function estimatedBytes(param1:uint) : MP3LoaderVars
      {
         return _set("estimatedBytes",param1);
      }
      
      public function name(param1:String) : MP3LoaderVars
      {
         return _set("name",param1);
      }
      
      public function alternateURL(param1:String) : MP3LoaderVars
      {
         return _set("alternateURL",param1);
      }
      
      public function volume(param1:Number) : MP3LoaderVars
      {
         return _set("volume",param1);
      }
      
      public function repeat(param1:int) : MP3LoaderVars
      {
         return _set("repeat",param1);
      }
      
      public function allowMalformedURL(param1:Boolean) : MP3LoaderVars
      {
         return _set("allowMalformedURL",param1);
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
      
      protected function _set(param1:String, param2:*) : MP3LoaderVars
      {
         if(param2 == null)
         {
            delete _vars[param1];
         }
         else
         {
            _vars[param1] = param2;
         }
         return this;
      }
      
      public function onFail(param1:Function) : MP3LoaderVars
      {
         return _set("onFail",param1);
      }
      
      public function onError(param1:Function) : MP3LoaderVars
      {
         return _set("onError",param1);
      }
      
      public function prop(param1:String, param2:*) : MP3LoaderVars
      {
         return _set(param1,param2);
      }
      
      public function onProgress(param1:Function) : MP3LoaderVars
      {
         return _set("onProgress",param1);
      }
      
      public function context(param1:SoundLoaderContext) : MP3LoaderVars
      {
         return _set("context",param1);
      }
      
      public function autoDispose(param1:Boolean) : MP3LoaderVars
      {
         return _set("autoDispose",param1);
      }
      
      public function onComplete(param1:Function) : MP3LoaderVars
      {
         return _set("onComplete",param1);
      }
      
      public function onHTTPStatus(param1:Function) : MP3LoaderVars
      {
         return _set("onHTTPStatus",param1);
      }
      
      public function initThreshold(param1:uint) : MP3LoaderVars
      {
         return _set("initThreshold",param1);
      }
   }
}
