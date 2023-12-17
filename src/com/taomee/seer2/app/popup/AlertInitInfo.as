package com.taomee.seer2.app.popup
{
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.inventory.ItemGroup;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.team.data.TeamMainInfo;
   
   public dynamic class AlertInitInfo
   {
       
      
      public var message:String;
      
      public var closeHandler:Function;
      
      public var confirmHandler:Function;
      
      public var cancelHandler:Function;
      
      public var autoCloseDelayTime:uint;
      
      public var referenceId:uint;
      
      public var quantity:uint;
      
      public var teamInfo:TeamMainInfo;
      
      public var result:Boolean;
      
      public var doorType:uint = 0;
      
      public var doorRule:uint = 0;
      
      public var rewardId:uint = 0;
      
      public var rewardList:Vector.<ServerReward>;
      
      public var petInfo:PetInfo;
      
      public var equipId:uint = 0;
      
      public var category:String;
      
      public var group:ItemGroup;
      
      public var userId:uint;
      
      public var mode:uint;
      
      public function AlertInitInfo(param1:String, param2:Function = null, param3:Function = null, param4:Function = null, param5:uint = 0)
      {
         super();
         this.message = param1;
         this.closeHandler = param2;
         this.confirmHandler = param3;
         this.cancelHandler = param4;
         this.autoCloseDelayTime = param5;
      }
   }
}
