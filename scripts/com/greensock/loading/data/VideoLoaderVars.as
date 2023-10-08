package com.greensock.loading.data
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class VideoLoaderVars
   {
      
      public static const version:Number = 1.2;
       
      
      protected var _vars:Object;
      
      public function VideoLoaderVars(param1:Object = null)
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
      
      public function container(param1:DisplayObjectContainer) : VideoLoaderVars
      {
         return _set("container",param1);
      }
      
      public function autoPlay(param1:Boolean) : VideoLoaderVars
      {
         return _set("autoPlay",param1);
      }
      
      public function rotation(param1:Number) : VideoLoaderVars
      {
         return _set("rotation",param1);
      }
      
      public function onSecurityError(param1:Function) : VideoLoaderVars
      {
         return _set("onSecurityError",param1);
      }
      
      public function bufferMode(param1:Boolean) : VideoLoaderVars
      {
         return _set("bufferMode",param1);
      }
      
      public function scaleMode(param1:String) : VideoLoaderVars
      {
         return _set("scaleMode",param1);
      }
      
      public function estimatedBytes(param1:uint) : VideoLoaderVars
      {
         return _set("estimatedBytes",param1);
      }
      
      public function crop(param1:Boolean) : VideoLoaderVars
      {
         return _set("crop",param1);
      }
      
      public function name(param1:String) : VideoLoaderVars
      {
         return _set("name",param1);
      }
      
      public function blendMode(param1:String) : VideoLoaderVars
      {
         return _set("blendMode",param1);
      }
      
      public function alternateURL(param1:String) : VideoLoaderVars
      {
         return _set("alternateURL",param1);
      }
      
      public function bgAlpha(param1:Number) : VideoLoaderVars
      {
         return _set("bgAlpha",param1);
      }
      
      public function volume(param1:Number) : VideoLoaderVars
      {
         return _set("volume",param1);
      }
      
      public function repeat(param1:int) : VideoLoaderVars
      {
         return _set("repeat",param1);
      }
      
      public function allowMalformedURL(param1:Boolean) : VideoLoaderVars
      {
         return _set("allowMalformedURL",param1);
      }
      
      public function bgColor(param1:uint) : VideoLoaderVars
      {
         return _set("bgColor",param1);
      }
      
      protected function _set(param1:String, param2:*) : VideoLoaderVars
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
      
      public function onFail(param1:Function) : VideoLoaderVars
      {
         return _set("onFail",param1);
      }
      
      public function height(param1:Number) : VideoLoaderVars
      {
         return _set("height",param1);
      }
      
      public function onProgress(param1:Function) : VideoLoaderVars
      {
         return _set("onProgress",param1);
      }
      
      public function bufferTime(param1:Number) : VideoLoaderVars
      {
         return _set("bufferTime",param1);
      }
      
      public function centerRegistration(param1:Boolean) : VideoLoaderVars
      {
         return _set("centerRegistration",param1);
      }
      
      public function vAlign(param1:String) : VideoLoaderVars
      {
         return _set("vAlign",param1);
      }
      
      public function deblocking(param1:int) : VideoLoaderVars
      {
         return _set("deblocking",param1);
      }
      
      public function onComplete(param1:Function) : VideoLoaderVars
      {
         return _set("onComplete",param1);
      }
      
      public function onCancel(param1:Function) : VideoLoaderVars
      {
         return _set("onCancel",param1);
      }
      
      public function get vars() : Object
      {
         return _vars;
      }
      
      public function onHTTPStatus(param1:Function) : VideoLoaderVars
      {
         return _set("onHTTPStatus",param1);
      }
      
      public function noCache(param1:Boolean) : VideoLoaderVars
      {
         return _set("noCache",param1);
      }
      
      public function onIOError(param1:Function) : VideoLoaderVars
      {
         return _set("onIOError",param1);
      }
      
      public function width(param1:Number) : VideoLoaderVars
      {
         return _set("width",param1);
      }
      
      public function onOpen(param1:Function) : VideoLoaderVars
      {
         return _set("onOpen",param1);
      }
      
      public function requireWithRoot(param1:DisplayObject) : VideoLoaderVars
      {
         return _set("requireWithRoot",param1);
      }
      
      public function scaleX(param1:Number) : VideoLoaderVars
      {
         return _set("scaleX",param1);
      }
      
      public function scaleY(param1:Number) : VideoLoaderVars
      {
         return _set("scaleY",param1);
      }
      
      public function alpha(param1:Number) : VideoLoaderVars
      {
         return _set("alpha",param1);
      }
      
      public function get isGSVars() : Boolean
      {
         return true;
      }
      
      public function prop(param1:String, param2:*) : VideoLoaderVars
      {
         return _set(param1,param2);
      }
      
      public function onError(param1:Function) : VideoLoaderVars
      {
         return _set("onError",param1);
      }
      
      public function autoDispose(param1:Boolean) : VideoLoaderVars
      {
         return _set("autoDispose",param1);
      }
      
      public function visible(param1:Boolean) : VideoLoaderVars
      {
         return _set("visible",param1);
      }
      
      public function smoothing(param1:Boolean) : VideoLoaderVars
      {
         return _set("smoothing",param1);
      }
      
      public function checkPolicyFile(param1:Boolean) : VideoLoaderVars
      {
         return _set("checkPolicyFile",param1);
      }
      
      public function estimatedDuration(param1:Number) : VideoLoaderVars
      {
         return _set("estimatedDuration",param1);
      }
      
      public function x(param1:Number) : VideoLoaderVars
      {
         return _set("x",param1);
      }
      
      public function y(param1:Number) : VideoLoaderVars
      {
         return _set("y",param1);
      }
      
      public function hAlign(param1:String) : VideoLoaderVars
      {
         return _set("hAlign",param1);
      }
      
      public function autoAdjustBuffer(param1:Boolean) : VideoLoaderVars
      {
         return _set("autoAdjustBuffer",param1);
      }
   }
}
