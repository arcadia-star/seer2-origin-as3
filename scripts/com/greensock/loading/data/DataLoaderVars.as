package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   
   public class DataLoaderVars
   {
      
      public static const version:Number = 1.2;
       
      
      protected var _vars:Object;
      
      public function DataLoaderVars(param1:Object = null)
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
      
      public function onHTTPStatus(param1:Function) : DataLoaderVars
      {
         return _set("onHTTPStatus",param1);
      }
      
      public function onOpen(param1:Function) : DataLoaderVars
      {
         return _set("onOpen",param1);
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
      
      protected function _set(param1:String, param2:*) : DataLoaderVars
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
      
      public function allowMalformedURL(param1:Boolean) : DataLoaderVars
      {
         return _set("allowMalformedURL",param1);
      }
      
      public function noCache(param1:Boolean) : DataLoaderVars
      {
         return _set("noCache",param1);
      }
      
      public function onError(param1:Function) : DataLoaderVars
      {
         return _set("onError",param1);
      }
      
      public function prop(param1:String, param2:*) : DataLoaderVars
      {
         return _set(param1,param2);
      }
      
      public function onProgress(param1:Function) : DataLoaderVars
      {
         return _set("onProgress",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : DataLoaderVars
      {
         return _set("requireWithRoot",param1);
      }
      
      public function get vars() : Object
      {
         return _vars;
      }
      
      public function estimatedBytes(param1:uint) : DataLoaderVars
      {
         return _set("estimatedBytes",param1);
      }
      
      public function autoDispose(param1:Boolean) : DataLoaderVars
      {
         return _set("autoDispose",param1);
      }
      
      public function name(param1:String) : DataLoaderVars
      {
         return _set("name",param1);
      }
      
      public function alternateURL(param1:String) : DataLoaderVars
      {
         return _set("alternateURL",param1);
      }
      
      public function format(param1:String) : DataLoaderVars
      {
         return _set("format",param1);
      }
      
      public function onComplete(param1:Function) : DataLoaderVars
      {
         return _set("onComplete",param1);
      }
      
      public function onCancel(param1:Function) : DataLoaderVars
      {
         return _set("onCancel",param1);
      }
      
      public function onIOError(param1:Function) : DataLoaderVars
      {
         return _set("onIOError",param1);
      }
      
      public function onFail(param1:Function) : DataLoaderVars
      {
         return _set("onFail",param1);
      }
   }
}
