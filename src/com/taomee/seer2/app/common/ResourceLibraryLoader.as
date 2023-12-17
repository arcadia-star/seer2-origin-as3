package com.taomee.seer2.app.common
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import flash.events.EventDispatcher;
   
   public class ResourceLibraryLoader extends EventDispatcher
   {
       
      
      private var _resUrl:String;
      
      private var _resLib:ResourceLibrary;
      
      private var _callBack:Function;
      
      public function ResourceLibraryLoader(param1:String)
      {
         super();
         this._resUrl = param1;
      }
      
      public function getLib(param1:Function) : void
      {
         this._callBack = param1;
         if(this._resLib == null)
         {
            QueueLoader.load(this._resUrl,LoadType.DOMAIN,this.onLoadComplete);
         }
         else
         {
            this.handlerCallBack();
         }
      }
      
      public function cancel(param1:Boolean = false) : void
      {
         this._callBack = null;
         if(param1)
         {
            QueueLoader.cancel(this._resUrl,this.onLoadComplete);
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this._resLib = new ResourceLibrary(param1.content);
         this.handlerCallBack();
      }
      
      private function handlerCallBack() : void
      {
         if(this._callBack != null)
         {
            this._callBack(this._resLib);
            this._callBack = null;
         }
      }
      
      public function dispose() : void
      {
         QueueLoader.cancel(this._resUrl,this.onLoadComplete);
         this._callBack = null;
         if(this._resLib)
         {
            this._resLib.dispose();
         }
      }
   }
}
