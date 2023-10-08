package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.system.LoaderContext;
   
   public class ImageLoaderVars
   {
      
      public static const version:Number = 1.2;
       
      
      protected var _vars:Object;
      
      public function ImageLoaderVars(param1:Object = null)
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
      
      public function onCancel(param1:Function) : ImageLoaderVars
      {
         return _set("onCancel",param1);
      }
      
      public function noCache(param1:Boolean) : ImageLoaderVars
      {
         return _set("noCache",param1);
      }
      
      public function onIOError(param1:Function) : ImageLoaderVars
      {
         return _set("onIOError",param1);
      }
      
      public function width(param1:Number) : ImageLoaderVars
      {
         return _set("width",param1);
      }
      
      public function container(param1:DisplayObjectContainer) : ImageLoaderVars
      {
         return _set("container",param1);
      }
      
      public function onOpen(param1:Function) : ImageLoaderVars
      {
         return _set("onOpen",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : ImageLoaderVars
      {
         return _set("requireWithRoot",param1);
      }
      
      public function scaleX(param1:Number) : ImageLoaderVars
      {
         return _set("scaleX",param1);
      }
      
      public function estimatedBytes(param1:uint) : ImageLoaderVars
      {
         return _set("estimatedBytes",param1);
      }
      
      public function crop(param1:Boolean) : ImageLoaderVars
      {
         return _set("crop",param1);
      }
      
      public function y(param1:Number) : ImageLoaderVars
      {
         return _set("y",param1);
      }
      
      public function name(param1:String) : ImageLoaderVars
      {
         return _set("name",param1);
      }
      
      public function blendMode(param1:String) : ImageLoaderVars
      {
         return _set("blendMode",param1);
      }
      
      public function alternateURL(param1:String) : ImageLoaderVars
      {
         return _set("alternateURL",param1);
      }
      
      public function onSecurityError(param1:Function) : ImageLoaderVars
      {
         return _set("onSecurityError",param1);
      }
      
      public function bgAlpha(param1:Number) : ImageLoaderVars
      {
         return _set("bgAlpha",param1);
      }
      
      public function scaleMode(param1:String) : ImageLoaderVars
      {
         return _set("scaleMode",param1);
      }
      
      public function allowMalformedURL(param1:Boolean) : ImageLoaderVars
      {
         return _set("allowMalformedURL",param1);
      }
      
      public function bgColor(param1:uint) : ImageLoaderVars
      {
         return _set("bgColor",param1);
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
      
      protected function _set(param1:String, param2:*) : ImageLoaderVars
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
      
      public function onFail(param1:Function) : ImageLoaderVars
      {
         return _set("onFail",param1);
      }
      
      public function alpha(param1:Number) : ImageLoaderVars
      {
         return _set("alpha",param1);
      }
      
      public function height(param1:Number) : ImageLoaderVars
      {
         return _set("height",param1);
      }
      
      public function onError(param1:Function) : ImageLoaderVars
      {
         return _set("onError",param1);
      }
      
      public function prop(param1:String, param2:*) : ImageLoaderVars
      {
         return _set(param1,param2);
      }
      
      public function onProgress(param1:Function) : ImageLoaderVars
      {
         return _set("onProgress",param1);
      }
      
      public function centerRegistration(param1:Boolean) : ImageLoaderVars
      {
         return _set("centerRegistration",param1);
      }
      
      public function context(param1:LoaderContext) : ImageLoaderVars
      {
         return _set("context",param1);
      }
      
      public function autoDispose(param1:Boolean) : ImageLoaderVars
      {
         return _set("autoDispose",param1);
      }
      
      public function scaleY(param1:Number) : ImageLoaderVars
      {
         return _set("scaleY",param1);
      }
      
      public function visible(param1:Boolean) : ImageLoaderVars
      {
         return _set("visible",param1);
      }
      
      public function smoothing(param1:Boolean) : ImageLoaderVars
      {
         return _set("smoothing",param1);
      }
      
      public function vAlign(param1:String) : ImageLoaderVars
      {
         return _set("vAlign",param1);
      }
      
      public function onComplete(param1:Function) : ImageLoaderVars
      {
         return _set("onComplete",param1);
      }
      
      public function onHTTPStatus(param1:Function) : ImageLoaderVars
      {
         return _set("onHTTPStatus",param1);
      }
      
      public function get vars() : Object
      {
         return _vars;
      }
      
      public function hAlign(param1:String) : ImageLoaderVars
      {
         return _set("hAlign",param1);
      }
      
      public function rotation(param1:Number) : ImageLoaderVars
      {
         return _set("rotation",param1);
      }
      
      public function x(param1:Number) : ImageLoaderVars
      {
         return _set("x",param1);
      }
   }
}
