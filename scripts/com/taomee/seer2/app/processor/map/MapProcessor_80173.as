package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80173 extends MapProcessor
   {
       
      
      private var npc0:Mobile;
      
      private var npc1:Mobile;
      
      private var npcLight:MovieClip;
      
      private var ruleBtn:SimpleButton;
      
      private var getTaiYangShenBtn:SimpleButton;
      
      private var wuzixiang:SimpleButton;
      
      private var openVip:SimpleButton;
      
      private var buyNum:int;
      
      private var usedNum:int;
      
      private var yadiannaStatus:int;
      
      private var leftNum:int;
      
      private var index:int = 0;
      
      private const forlimitAry:Array = [203979,203996,203973];
      
      private const buy_chance_id:int = 603678;
      
      private const fightIdAry:Array = [888,889,890];
      
      private const fightTipAry:Array = ["触碰神光！你已进入阿波罗之战","触碰神光！你已进入雅典娜之战","触碰神光！你已进入兄妹认可之战"];
      
      public function MapProcessor_80173(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.npc0 = MobileManager.getMobile(734,MobileType.NPC);
         this.npc1 = MobileManager.getMobile(738,MobileType.NPC);
         this.npcLight = _map.content["npcLight"];
         _map.content.setChildIndex(this.npc0,0);
         _map.content.setChildIndex(this.npc1,1);
         _map.content.setChildIndex(this.npcLight,2);
         if(this.npcLight)
         {
            this.npcLight.mouseChildren = this.npcLight.mouseEnabled = false;
            this.npcLight.gotoAndStop(1);
         }
         this.ruleBtn = _map.front["ruleBtn"];
         this.getTaiYangShenBtn = _map.front["getTaiYangShenBtn"];
         this.wuzixiang = _map.front["wuzixiang"];
         this.openVip = _map.front["openVipBtn"];
         this.requestData();
      }
      
      private function requestData() : void
      {
         ActiveCountManager.requestActiveCountList(this.forlimitAry,this.getForlimitData);
      }
      
      private function getForlimitData(param1:Parser_1142) : void
      {
         this.buyNum = param1.infoVec[0];
         this.usedNum = param1.infoVec[1];
         this.yadiannaStatus = param1.infoVec[2];
         this.leftNum = 3 + this.buyNum - this.usedNum;
         this.updateDisplay();
      }
      
      private function updateDisplay() : void
      {
         if(this.yadiannaStatus == 1)
         {
            if(this.npcLight)
            {
               MovieClipUtil.playMc(this.npcLight,2,this.npcLight.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(npcLight);
                  ModuleManager.showModule(URLUtil.getAppModule("YaDianNaPanel"),"");
               });
            }
         }
         if(this.yadiannaStatus == 2)
         {
            if(this.npcLight)
            {
               DisplayObjectUtil.removeFromParent(this.npcLight);
            }
         }
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         if(this.npc0)
         {
            this.npc0.addEventListener(MouseEvent.CLICK,this.onNpc);
         }
         if(this.npc1)
         {
            this.npc1.addEventListener(MouseEvent.CLICK,this.onNpc);
         }
         this.getTaiYangShenBtn.addEventListener(MouseEvent.CLICK,this.onTaiYangShen);
         this.wuzixiang.addEventListener(MouseEvent.CLICK,this.onWuZiXiang);
         this.openVip.addEventListener(MouseEvent.CLICK,this.onVip);
      }
      
      private function removeEvent() : void
      {
         if(this.npc0)
         {
            this.npc0.removeEventListener(MouseEvent.CLICK,this.onNpc);
         }
         if(this.npc1)
         {
            this.npc1.removeEventListener(MouseEvent.CLICK,this.onNpc);
         }
         this.getTaiYangShenBtn.removeEventListener(MouseEvent.CLICK,this.onTaiYangShen);
         this.wuzixiang.removeEventListener(MouseEvent.CLICK,this.onWuZiXiang);
         this.openVip.removeEventListener(MouseEvent.CLICK,this.onVip);
      }
      
      private function onVip(param1:MouseEvent) : void
      {
         VipManager.navigateToPayPage();
      }
      
      private function onWuZiXiang(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
      }
      
      protected function onTaiYangShen(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("AboLuoPanel"),"");
      }
      
      protected function onNpc(param1:MouseEvent) : void
      {
         var info:BuyPropInfo = null;
         var event:MouseEvent = param1;
         if(this.yadiannaStatus > 0)
         {
            AlertManager.showAlert("你已经可以领取雅典娜了，赶紧去领取吧",function():void
            {
               ModuleManager.showModule(URLUtil.getAppModule("YaDianNaPanel"),"");
            });
         }
         else if(this.leftNum > 0)
         {
            this.clickNpc();
         }
         else
         {
            info = new BuyPropInfo();
            info.itemId = this.buy_chance_id;
            info.buyComplete = this.clickNpc;
            ShopManager.buyVirtualItem(info);
         }
      }
      
      private function clickNpc(param1:* = null) : void
      {
         var obj:* = param1;
         SwapManager.swapItem(2638,1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            ActiveCountManager.requestActiveCount(203972,function(param1:uint, param2:uint):void
            {
               index = param2;
               if(index != 0)
               {
                  ServerMessager.addMessage(fightTipAry[index - 1]);
                  FightManager.startFightWithBoss(fightIdAry[index - 1]);
               }
            });
         });
      }
      
      override public function dispose() : void
      {
         this.removeEvent();
         super.dispose();
      }
   }
}
