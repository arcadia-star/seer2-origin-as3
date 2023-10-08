package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   
   public class RewardUnit extends BaseUnit
   {
       
      
      private var _params:int;
      
      private var _index:int;
      
      public function RewardUnit()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.type = FunctionalityType.REWARD;
      }
      
      override protected function addIcon() : void
      {
         _icon = UIManager.getSprite("UI_DialogReward");
         addChild(_icon);
      }
      
      override protected function onBtnClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._params = int(params.split(" ")[0]);
         this._index = int(params.split(" ")[1]);
         if(ActorManager.actorInfo.highestPetLevel >= this._params)
         {
            SwapManager.swapItem(this._index,1,null,function(param1:int):void
            {
               AlertManager.showAlert("你已经领取");
            });
         }
         else
         {
            AlertManager.showAlert("你还没有" + this._params + "级以上的精灵，请再接再厉哦");
         }
         DialogPanel.hide("");
      }
   }
}
