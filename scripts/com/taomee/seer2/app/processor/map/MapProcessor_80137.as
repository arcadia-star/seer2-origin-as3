package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MapProcessor_80137 extends CopyMapProcessor
   {
       
      
      private const HURT_VALUE:uint = 203790;
      
      private const BUY_BUFF:uint = 203789;
      
      private const FIGHT_COUNT:uint = 988;
      
      private const BUY_BUFF_ID:uint = 500600;
      
      private const FIGHT_ID:uint = 818;
      
      private var allHurtTxt:TextField;
      
      private var fightItemBtn:SimpleButton;
      
      private var itemBtn:MovieClip;
      
      private var leftCount:int;
      
      private var hurtValue:uint;
      
      private var hasBuyBuff:Boolean;
      
      private var buyInfo:BuyPropInfo;
      
      public function MapProcessor_80137(param1:MapModel)
      {
         this.buyInfo = new BuyPropInfo();
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.allHurtTxt = _map.front["allHurtTxt"];
         this.itemBtn = _map.front["itemBtn"];
         this.itemBtn.buttonMode = true;
         this.fightItemBtn = _map.front["fightItemBtn"];
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
         this.itemBtn.addEventListener(MouseEvent.CLICK,this.toBuy);
         this.fightItemBtn.addEventListener(MouseEvent.CLICK,this.showBox);
         DayLimitManager.getDoCount(this.FIGHT_COUNT,this.getDayData);
         TooltipManager.addCommonTip(this.itemBtn,"使用魔天荣耀可以在下一场对战中的提升300%伤害");
      }
      
      private function showBox(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("MedicineShopPanel");
      }
      
      private function toBuy(param1:MouseEvent) : void
      {
         if(this.hasBuyBuff)
         {
            AlertManager.showAlert("你已经购买过了，赶紧去战斗吧!");
            return;
         }
         this.buyInfo.itemId = this.BUY_BUFF_ID;
         this.buyInfo.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(this.buyInfo);
      }
      
      private function buyComplete(param1:*) : void
      {
         this.hasBuyBuff = true;
      }
      
      private function getDayData(param1:uint) : void
      {
         if(param1 < 3)
         {
            this.leftCount = 3 - param1;
         }
         else
         {
            this.leftCount = 0;
         }
         ActiveCountManager.requestActiveCountList([this.HURT_VALUE,this.BUY_BUFF],this.getHurt);
      }
      
      private function getHurt(param1:Parser_1142) : void
      {
         this.hurtValue = param1.infoVec[0];
         this.hasBuyBuff = Boolean(param1.infoVec[1]);
         this.allHurtTxt.text = this.hurtValue.toString();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            ModuleManager.showAppModule("BlackPegasusResultPanel",this.hurtValue);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
         this.itemBtn.removeEventListener(MouseEvent.CLICK,this.toBuy);
         this.fightItemBtn.removeEventListener(MouseEvent.CLICK,this.showBox);
         TooltipManager.remove(this.itemBtn);
      }
      
      protected function toFight(param1:DialogPanelEvent) : void
      {
         if(this.leftCount == 0)
         {
            AlertManager.showAlert("今天挑战次数已用完，明天继续哦。");
            return;
         }
         if((param1.content as DialogPanelEventData).params == "toFight")
         {
            FightManager.startFightWithBoss(this.FIGHT_ID);
         }
      }
   }
}
