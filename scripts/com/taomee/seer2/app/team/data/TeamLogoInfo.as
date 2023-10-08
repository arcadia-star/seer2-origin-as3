package com.taomee.seer2.app.team.data
{
   import flash.utils.IDataInput;
   
   public class TeamLogoInfo
   {
       
      
      public var id:uint;
      
      public var name:String;
      
      public var logoFront:uint;
      
      public var logoBack:uint;
      
      public var logoColor:uint;
      
      public function TeamLogoInfo(param1:IDataInput)
      {
         super();
         this.id = param1.readUnsignedInt();
         this.name = param1.readUTFBytes(25);
         this.logoFront = param1.readUnsignedInt();
         this.logoBack = param1.readUnsignedInt();
         this.logoColor = param1.readUnsignedInt();
      }
   }
}
