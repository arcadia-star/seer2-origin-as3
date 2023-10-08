package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   
   public class LoaderMaxVars
   {
      
      public static const version:Number = 1.1;
       
      
      protected var _vars:Object;
      
      public function LoaderMaxVars(param1:Object = null)
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
      
      public function loaders(param1:Array) : LoaderMaxVars
      {
         return _set("loaders",param1);
      }
      
      public function onIOError(param1:Function) : LoaderMaxVars
      {
         return _set("onIOError",param1);
      }
      
      public function get vars() : Object
      {
         return _vars;
      }
      
      public function onCancel(param1:Function) : LoaderMaxVars
      {
         return _set("onCancel",param1);
      }
      
      public function onOpen(param1:Function) : LoaderMaxVars
      {
         return _set("onOpen",param1);
      }
      
      public function onChildProgress(param1:Function) : LoaderMaxVars
      {
         return _set("onChildProgress",param1);
      }
      
      public function skipPaused(param1:Boolean) : LoaderMaxVars
      {
         return _set("skipPaused",param1);
      }
      
      public function onScriptAccessDenied(param1:Function) : LoaderMaxVars
      {
         return _set("onScriptAccessDenied",param1);
      }
      
      public function maxConnections(param1:uint) : LoaderMaxVars
      {
         return _set("maxConnections",param1);
      }
      
      public function name(param1:String) : LoaderMaxVars
      {
         return _set("name",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : LoaderMaxVars
      {
         return _set("requireWithRoot",param1);
      }
      
      public function onChildComplete(param1:Function) : LoaderMaxVars
      {
         return _set("onChildComplete",param1);
      }
      
      public function onChildCancel(param1:Function) : LoaderMaxVars
      {
         return _set("onChildCancel",param1);
      }
      
      public function skipFailed(param1:Boolean) : LoaderMaxVars
      {
         return _set("skipFailed",param1);
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
      
      protected function _set(param1:String, param2:*) : LoaderMaxVars
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
      
      public function onFail(param1:Function) : LoaderMaxVars
      {
         return _set("onFail",param1);
      }
      
      public function onChildOpen(param1:Function) : LoaderMaxVars
      {
         return _set("onChildOpen",param1);
      }
      
      public function onError(param1:Function) : LoaderMaxVars
      {
         return _set("onError",param1);
      }
      
      public function prop(param1:String, param2:*) : LoaderMaxVars
      {
         return _set(param1,param2);
      }
      
      public function onProgress(param1:Function) : LoaderMaxVars
      {
         return _set("onProgress",param1);
      }
      
      public function autoDispose(param1:Boolean) : LoaderMaxVars
      {
         return _set("autoDispose",param1);
      }
      
      public function onComplete(param1:Function) : LoaderMaxVars
      {
         return _set("onComplete",param1);
      }
      
      public function onHTTPStatus(param1:Function) : LoaderMaxVars
      {
         return _set("onHTTPStatus",param1);
      }
      
      public function onChildFail(param1:Function) : LoaderMaxVars
      {
         return _set("onChildFail",param1);
      }
      
      public function auditSize(param1:Boolean) : LoaderMaxVars
      {
         return _set("auditSize",param1);
      }
   }
}
