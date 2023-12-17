package com.taomee.seer2.app.config.info
{
   public class CopyItemInfo
   {
       
      
      public var parentId:int;
      
      public var mapId:int;
      
      public var mode:int;
      
      public var isOpen:int;
      
      public var hLinkId:int;
      
      public var vLinkId:int;
      
      public var tipOpen:String;
      
      public var tipClose:String;
      
      public var isComplete:int;
      
      public var animationStr:String;
      
      public var passMiId:uint;
      
      public var miFull:String = "";
      
      public function CopyItemInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String, param7:String, param8:String, param9:uint, param10:String)
      {
         super();
         this.mapId = param1;
         this.mode = param2;
         this.isOpen = param3;
         this.hLinkId = param4;
         this.vLinkId = param5;
         this.tipOpen = param6;
         this.tipClose = param7;
         this.animationStr = param8;
         this.passMiId = param9;
         this.miFull = param10;
      }
   }
}
