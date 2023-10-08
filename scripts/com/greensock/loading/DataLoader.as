package com.greensock.loading
{
   import com.greensock.loading.core.LoaderItem;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   
   public class DataLoader extends LoaderItem
   {
      
      private static var _classActivated:Boolean = _activateClass("DataLoader",DataLoader,"txt,js");
       
      
      protected var _loader:URLLoader;
      
      public function DataLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _type = "DataLoader";
         _loader = new URLLoader(null);
         if("format" in this.vars)
         {
            _loader.dataFormat = String(this.vars.format);
         }
         _loader.addEventListener(ProgressEvent.PROGRESS,_progressHandler,false,0,true);
         _loader.addEventListener(Event.COMPLETE,_receiveDataHandler,false,0,true);
         _loader.addEventListener("ioError",_failHandler,false,0,true);
         _loader.addEventListener("securityError",_failHandler,false,0,true);
         _loader.addEventListener("httpStatus",_httpStatusHandler,false,0,true);
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         var scrubLevel:int = param1;
         var newStatus:int = param2;
         var suppressEvents:Boolean = param3;
         if(_status == LoaderStatus.LOADING)
         {
            try
            {
               _loader.close();
            }
            catch(error:Error)
            {
            }
         }
         super._dump(scrubLevel,newStatus,suppressEvents);
      }
      
      override protected function _load() : void
      {
         _prepRequest();
         _loader.load(_request);
      }
      
      protected function _receiveDataHandler(param1:Event) : void
      {
         _content = _loader.data;
         super._completeHandler(param1);
      }
   }
}
