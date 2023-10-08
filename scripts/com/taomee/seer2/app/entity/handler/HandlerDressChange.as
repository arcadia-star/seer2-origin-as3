package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.morphSystem.MorphUpdate;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.swap.SwapManager;
   import flash.utils.IDataInput;
   
   public class HandlerDressChange extends HandlerEntityClick
   {
       
      
      private var _rewardId:int;
      
      public function HandlerDressChange()
      {
         super();
      }
      
      override public function initData(param1:XML) : void
      {
         this._rewardId = int(param1);
      }
      
      override protected function action() : void
      {
         InteractiveRewardManager.requestReward(this._rewardId,function(param1:Parser_1060):void
         {
            param1.showResult();
         });
         SwapManager.swapItem(669,1,function(param1:IDataInput):void
         {
            MorphUpdate.updateMorph();
         });
      }
   }
}
