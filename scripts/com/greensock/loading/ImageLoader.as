package com.greensock.loading
{
   import com.greensock.loading.core.DisplayObjectLoader;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ImageLoader extends DisplayObjectLoader
   {
      
      private static var _classActivated:Boolean = _activateClass("ImageLoader",ImageLoader,"jpg,jpeg,png,gif,bmp");
       
      
      public function ImageLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _type = "ImageLoader";
      }
      
      override protected function _initHandler(param1:Event) : void
      {
         _determineScriptAccess();
         if(!_scriptAccessDenied)
         {
            _content = Bitmap(_loader.content);
            _content.smoothing = Boolean(this.vars.smoothing != false);
         }
         else
         {
            _content = _loader;
         }
         super._initHandler(param1);
      }
   }
}
