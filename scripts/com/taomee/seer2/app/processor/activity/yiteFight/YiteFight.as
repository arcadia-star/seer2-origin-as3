package com.taomee.seer2.app.processor.activity.yiteFight
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   
   public class YiteFight
   {
       
      
      private var _map:MapModel;
      
      private var _npc:Mobile;
      
      public function YiteFight(param1:MapModel)
      {
         super();
         this._map = param1;
         this.setup();
      }
      
      private function setup() : void
      {
         this._npc = MobileManager.getMobile(430,MobileType.NPC);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onNpc);
      }
      
      private function onNpc(param1:DialogPanelEvent) : void
      {
         var url:String = null;
         var type:uint = 0;
         var dayStartType:uint = 0;
         var totalCount:uint = 0;
         var swapID:uint = 0;
         var str:String = null;
         var event:DialogPanelEvent = param1;
         if(event.content.params == "win10")
         {
            type = 413;
            totalCount = 10;
            swapID = 398;
            dayStartType = 416;
            str = "战胜";
         }
         if(event.content.params == "start10")
         {
            type = 414;
            totalCount = 10;
            swapID = 399;
            dayStartType = 417;
            str = "参加";
         }
         if(event.content.params == "win3")
         {
            type = 415;
            totalCount = 3;
            swapID = 400;
            dayStartType = 418;
            str = "连胜";
         }
         DayLimitManager.getDoCount(type,function(param1:uint):void
         {
            var count:uint = param1;
            if(type == 414)
            {
               DayLimitManager.getDoCount(413,function(param1:uint):void
               {
                  var acount:uint = param1;
                  if(count + acount >= totalCount)
                  {
                     DayLimitManager.getDoCount(dayStartType,function(param1:uint):void
                     {
                        if(param1 < 1)
                        {
                           SwapManager.swapItem(swapID);
                        }
                        else
                        {
                           AlertManager.showAlert("今天已经完成了这项任务");
                        }
                     });
                  }
                  else
                  {
                     AlertManager.showAlert("今天已经" + str + "了" + (count + acount) + "次，还剩" + (totalCount - (count + acount)) + "次");
                  }
               });
            }
            else if(count >= totalCount)
            {
               DayLimitManager.getDoCount(dayStartType,function(param1:uint):void
               {
                  if(param1 < 1)
                  {
                     SwapManager.swapItem(swapID);
                  }
                  else
                  {
                     AlertManager.showAlert("今天已经完成了这项任务");
                  }
               });
            }
            else
            {
               AlertManager.showAlert("今天已经" + str + "了" + count + "次，还剩" + (totalCount - count) + "次");
            }
         });
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onNpc);
         this._npc = null;
      }
   }
}
