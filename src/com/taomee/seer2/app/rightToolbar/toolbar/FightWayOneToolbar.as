package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import flash.events.MouseEvent;
   
   public class FightWayOneToolbar extends RightToolbar
   {
       
      
      public function FightWayOneToolbar()
      {
         super();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(!NewPlayerGuideTimeManager.timeCheckNewGuide())
         {
            ActsHelperUtil.goHandle("SPTPanel");
         }
         else
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEW_PLAYER_FIGHT_OPEN,function(param1:ServerBuffer):void
            {
               var _loc2_:int = PetInfoManager.getAllPetBagPower();
               if(param1.readDataAtPostion(1))
               {
                  ActsHelperUtil.goHandle("SPTPanel");
               }
               else if(_loc2_ >= 2000)
               {
                  ActsHelperUtil.goHandle("SPTPanel");
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEW_PLAYER_FIGHT_OPEN,1,1);
               }
               else
               {
                  AlertManager.showAlert("当前战斗力不足，不可开启哦!");
               }
            });
         }
      }
   }
}
