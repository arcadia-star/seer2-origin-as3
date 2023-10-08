package com.taomee.seer2.core.loader
{
   public class QueueInfo
   {
       
      
      public var timeCount:uint;
      
      public var priority:int = 2;
      
      public var url:String;
      
      public var type:String;
      
      public var title:String;
      
      public var data;
      
      public var openHandler:Function;
      
      public var completeHandler:Function;
      
      public var progressHandler:Function;
      
      public var errorHandler:Function;
      
      public function QueueInfo()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.data = null;
         this.openHandler = null;
         this.completeHandler = null;
         this.progressHandler = null;
         this.errorHandler = null;
      }
   }
}
