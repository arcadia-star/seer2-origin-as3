package com.taomee.seer2.app.processor.activity.christmas
{
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.inventory.events.InventoryEvent;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class ChristmasOneProcess
   {
       
      
      private var _map:MapModel;
      
      private var _christmas:MovieClip;
      
      private var _christmasMessage:MovieClip;
      
      private var _tip:SimpleButton;
      
      public function ChristmasOneProcess()
      {
         super();
      }
      
      public function startProcess(param1:MapModel) : void
      {
         this._map = param1;
         this.startTip();
      }
      
      private function onInitCount(param1:MessageEvent) : void
      {
         var event:MessageEvent = param1;
         var parser:Parser_1065 = new Parser_1065(event.message.getRawDataCopy());
         if(parser.id == 283)
         {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onInitCount);
            if(parser.count == 0 && QuestManager.isFreshQuestComplete())
            {
               InteractiveRewardManager.requestReward(54,function(param1:Parser_1060):void
               {
                  playAnimation();
               });
            }
         }
      }
      
      private function playAnimation() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("9/1"));
         MovieClipUtil.playFullScreen(_loc1_,null,false);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         Connection.send(CommandSet.ACTIVE_COUNT_1142,1,202004);
      }
      
      private function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         AlertManager.showAlert("获取信息失败");
      }
      
      private function onGetPanel(param1:MessageEvent) : void
      {
         var parser:Parser_1142;
         var count:uint;
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         parser = new Parser_1142(event.message.getRawData());
         count = parser.infoVec[0];
         if(count == 0)
         {
            ItemManager.requestItemList(function():void
            {
               if(ItemManager.getItemQuantityByReferenceId(400220) >= 1 || ItemManager.getItemQuantityByReferenceId(400221) >= 1 || ItemManager.getItemQuantityByReferenceId(400222) >= 1)
               {
                  ModuleManager.showModule(URLUtil.getAppModule("ChristmasPanel1"),"正在打开圣诞面板...");
               }
               else
               {
                  AlertManager.showAlert("没有圣诞小道具可不能许愿哦！快去获得更多的吧!");
               }
            });
         }
         else if(count == 1)
         {
            ModuleManager.showModule(URLUtil.getAppModule("ChristmasPanel2"),"正在打开圣诞面板...");
         }
      }
      
      private function onMessage(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("ChristmasMessagePanel"),"正在打开圣诞面板...");
      }
      
      private function startTip() : void
      {
         this._tip = this._map.content["tip"];
         this._tip.addEventListener(MouseEvent.CLICK,this.onMessage);
         ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY,this.onItemAdded);
         ItemManager.requestItemList(function():void
         {
            TooltipManager.addMultipleTip(_tip,"飞天破袜子" + ItemManager.getItemQuantityByReferenceId(400220) + "个\n" + "飞天小姜饼" + ItemManager.getItemQuantityByReferenceId(400221) + "个\n" + "飞天棒棒糖" + ItemManager.getItemQuantityByReferenceId(400222) + "个");
         });
      }
      
      private function onItemAdded(param1:InventoryEvent) : void
      {
         var event:InventoryEvent = param1;
         TooltipManager.remove(this._tip);
         ItemManager.requestItemList(function():void
         {
            TooltipManager.addMultipleTip(_tip,"飞天破袜子" + ItemManager.getItemQuantityByReferenceId(400220) + "个\n" + "飞天小姜饼" + ItemManager.getItemQuantityByReferenceId(400221) + "个\n" + "飞天棒棒糖" + ItemManager.getItemQuantityByReferenceId(400222) + "个");
         });
      }
      
      public function dispose() : void
      {
         if(this._tip)
         {
            TooltipManager.remove(this._tip);
         }
         this._tip = null;
         if(this._christmasMessage)
         {
            this._christmasMessage.removeEventListener(MouseEvent.CLICK,this.onMessage);
         }
         ItemManager.removeEventListener(InventoryEvent.UPDATE_QUANTITY,this.onItemAdded);
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onInitCount);
         this._christmas = null;
         this._christmasMessage = null;
      }
   }
}
