package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class MiKaLaoDongJieAct
   {
      
      private static var _instance:MiKaLaoDongJieAct;
       
      
      private const GET_STATE:uint = 1169;
      
      private const SWAP_FEED:uint = 2864;
      
      private const SWAP_GAD:uint = 2866;
      
      private const SWAP_FIGHT:uint = 2867;
      
      private const FIGHT_ID:uint = 1021;
      
      private const ITEM_ID:uint = 209000;
      
      private var hasGet:Boolean;
      
      private var itemNum:uint;
      
      public function MiKaLaoDongJieAct()
      {
         super();
      }
      
      public static function getInstance() : MiKaLaoDongJieAct
      {
         if(!_instance)
         {
            _instance = new MiKaLaoDongJieAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DayLimitManager.getDoCount(this.GET_STATE,this.getDayData);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDiaLogShow);
      }
      
      private function getDayData(param1:uint) : void
      {
         this.hasGet = Boolean(param1);
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getItem);
         ItemManager.requestSpecialItemList();
      }
      
      private function getItem(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getItem);
         this.itemNum = ItemManager.getItemQuantityByReferenceId(this.ITEM_ID);
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDiaLogShow);
      }
      
      protected function onDiaLogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:CustomUnit = null;
         if(param1.content == 1)
         {
            _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"(活动)劳动节米咔","showMiKaDia");
            DialogPanel.functionalityBox.addUnit(_loc2_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         }
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var _loc2_:String = DialogPanelEventData(param1.content).params;
         if(_loc2_ == "showMiKaDia")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
            ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_211,this.onBuffer);
         }
      }
      
      private function onBuffer(param1:ServerBuffer) : void
      {
         if(!param1.readDataAtPostion(12))
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_211,12,1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("MiKaLaoDongJieFull"),this.showDia);
         }
         else
         {
            this.showDia();
         }
      }
      
      private function showDia() : void
      {
         NpcDialog.show(1,"辛迪",[[0,"你想抓住劳动节特别米咔吗？来试试吧！"]],["领取辛勤种子","兑换劳动米咔纹章","抓住劳动米咔！","离开"],[this.getSeed,this.swapGad,this.fightMika]);
      }
      
      private function getSeed() : void
      {
         if(this.hasGet)
         {
            NpcDialog.show(1,"辛迪",[[0,"你今天已经领取过辛勤种子了，明天再来吧"]],["是！船长！"]);
         }
         else
         {
            SwapManager.swapItem(this.SWAP_FEED,1,this.onComplete);
         }
      }
      
      private function onComplete(param1:IDataInput) : void
      {
         this.hasGet = true;
         new SwapInfo(param1);
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getItem);
         ItemManager.requestSpecialItemList();
      }
      
      private function swapGad() : void
      {
         NpcDialog.show(1,"辛迪",[[0,"兑换劳动米咔纹章需要20个金米咔饲料，确认要兑换吗？"]],["确定！","我再想想"],[function():void
         {
            itemNum = ItemManager.getItemQuantityByReferenceId(ITEM_ID);
            if(itemNum < 20)
            {
               NpcDialog.show(1,"辛迪",[[0,"你的金米咔饲料数量不足"]],["哦"],[function():void
               {
                  ModuleManager.showAppModule("MiKaLaoDongJiePanel");
               }]);
            }
            else if(itemNum < 20)
            {
               AlertManager.showAlert("所需数量不足！");
            }
            else
            {
               SwapManager.swapItem(SWAP_GAD,1,onGad);
            }
         }]);
      }
      
      private function onGad(param1:IDataInput) : void
      {
         new SwapInfo(param1);
         this.itemNum = ItemManager.getItemQuantityByReferenceId(this.ITEM_ID);
      }
      
      private function fightMika() : void
      {
         NpcDialog.show(1,"辛迪",[[0,"需要10个金米咔饲料来引诱出劳动节米咔，并且米咔会在5回合内逃走，确定准备好了吗？"]],["确定！","我再想想"],[function():void
         {
            itemNum = ItemManager.getItemQuantityByReferenceId(ITEM_ID);
            if(itemNum < 10)
            {
               NpcDialog.show(1,"辛迪",[[0,"你的金米咔饲料数量不足"]],["哦"],[function():void
               {
                  ModuleManager.showAppModule("MiKaLaoDongJiePanel");
               }]);
            }
            else if(itemNum < 10)
            {
               AlertManager.showAlert("所需数量不足！");
            }
            else
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("MiKaLaoDongJieStartFightFull"),function():void
               {
                  SwapManager.swapItem(SWAP_FIGHT,1,onFight);
               },false,false,1,false);
            }
         }]);
      }
      
      private function onFight(param1:IDataInput) : void
      {
         new SwapInfo(param1);
         this.itemNum = ItemManager.getItemQuantityByReferenceId(this.ITEM_ID);
         FightManager.startFightWithWild(this.FIGHT_ID);
      }
   }
}
