package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.npc.NpcEvent;
   import com.taomee.seer2.app.npc.NpcManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.geom.Point;
   
   public class MapProcessor_1600 extends MapProcessor
   {
       
      
      public function MapProcessor_1600(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.getReplay);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDiaLogShow);
         NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE,this.onArrive);
      }
      
      override public function init() : void
      {
         var _loc2_:int = 0;
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_547);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.getReplay);
         NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE,this.onArrive);
         var _loc1_:Vector.<Mobile> = MobileManager.getMobileVec(MobileType.NPC);
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(_loc1_[_loc2_])
               {
                  (_loc1_[_loc2_] as Mobile).buttonMode = false;
               }
               _loc2_++;
            }
         }
      }
      
      private function onArrive(param1:NpcEvent) : void
      {
         if(param1.npcDefinition.id == 337)
         {
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE,this.onArrive);
            SeatTipsManager.removeSeat(new Point(440,345),1600);
         }
      }
      
      protected function getReplay(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(DialogPanelEventData(event.content).params == "WithPetRide")
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.PET_RIDE_GUIDE,function(param1:ServerBuffer):void
            {
               var buffer:ServerBuffer = param1;
               var mark:int = buffer.readDataAtPostion(1);
               if(mark == 0)
               {
                  NpcDialog.show(337,"天龙骑士-唐",[[0,"想加入赛尔骑士团？！那么至少你要拥有一只驯化过的坐骑精灵！"]],["使用引导","获得骑乘晶片","只是逛逛而已"],[function():void
                  {
                     NpcDialog.show(337,"天龙骑士-唐",[[0,"你已经有一个免费的骑乘晶片了，看看怎么用吧，要睁大眼睛认真看哦！"]],["开始吧"],[function():void
                     {
                        ModuleManager.addEventListener("PetRideGuidePanel",ModuleEvent.DISPOSE,onGuidePanelDispose);
                        ModuleManager.toggleModule(URLUtil.getAppModule("PetRideGuidePanel"));
                        ServerBufferManager.updateServerBuffer(ServerBufferType.PET_RIDE_GUIDE,1,1);
                     }]);
                  },function():void
                  {
                     SwapManager.swapItem(2228);
                     ModuleManager.toggleModule(URLUtil.getAppModule("PetRideShopPanel"));
                  },null]);
               }
               else
               {
                  NpcDialog.show(337,"天龙骑士-唐",[[0,"想加入赛尔骑士团？！那么至少你要拥有一只驯化过的坐骑精灵！"]],["获得骑乘晶片","如何使用坐骑","只是逛逛而已"],[function():void
                  {
                     SwapManager.swapItem(2228);
                     ModuleManager.toggleModule(URLUtil.getAppModule("PetRideShopPanel"));
                  },function():void
                  {
                     ModuleManager.toggleModule(URLUtil.getAppModule("PetRideAdsPanel"));
                  },null]);
               }
            });
         }
      }
      
      protected function onDiaLogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:CustomUnit = null;
         if(param1.content == 337)
         {
            _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"天龙冲锋号！骑宠大赛","天龙冲锋号！骑宠大赛");
            DialogPanel.functionalityBox.addUnit(_loc2_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         }
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var str:String;
         var event:DialogPanelEvent = param1;
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         str = DialogPanelEventData(event.content).params;
         if(str == "天龙冲锋号！骑宠大赛")
         {
            NpcDialog.show(337,"天龙骑士",[[0,"加入骑宠大赛，拿上冲锋号，一决高下！"]],["参加骑宠大赛","走过路过~擦身而过"],[function():void
            {
               var _loc1_:* = new Date(TimeManager.getPrecisionServerTime() * 1000);
               var _loc2_:* = new Date(2013,8,29,6);
               if(_loc1_ < _loc2_)
               {
                  NpcDialog.show(337,"天龙骑士",[[0,"活动在9月29号才开启哦!"]],["好的"]);
               }
               else
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("TianlongMainPanel"));
               }
            }]);
         }
      }
      
      private function onGuidePanelDispose(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("PetRideGuidePanel",ModuleEvent.DISPOSE,this.onGuidePanelDispose);
         ModuleManager.toggleModule(URLUtil.getAppModule("PetRideShopPanel"));
      }
   }
}
