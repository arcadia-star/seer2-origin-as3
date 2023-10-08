package com.greensock.loading
{
   import com.greensock.loading.core.LoaderItem;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   
   public class SelfLoader extends LoaderItem
   {
       
      
      protected var _loaderInfo:LoaderInfo;
      
      public function SelfLoader(param1:DisplayObject, param2:Object = null)
      {
         super(param1.loaderInfo.url,param2);
         _type = "SelfLoader";
         _loaderInfo = param1.loaderInfo;
         _loaderInfo.addEventListener(ProgressEvent.PROGRESS,_progressHandler,false,0,true);
         _loaderInfo.addEventListener(Event.COMPLETE,_completeHandler,false,0,true);
         _cachedBytesTotal = _loaderInfo.bytesTotal;
         _cachedBytesLoaded = _loaderInfo.bytesLoaded;
         _status = _cachedBytesLoaded == _cachedBytesTotal ? LoaderStatus.COMPLETED : LoaderStatus.LOADING;
         _auditedSize = true;
         _content = param1;
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(param1 >= 2)
         {
            _loaderInfo.removeEventListener(ProgressEvent.PROGRESS,_progressHandler);
            _loaderInfo.removeEventListener(Event.COMPLETE,_completeHandler);
         }
         super._dump(param1,param2,param3);
      }
   }
}
