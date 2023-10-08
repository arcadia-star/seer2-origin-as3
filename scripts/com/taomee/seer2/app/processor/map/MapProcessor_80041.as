package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MapProcessor_80041 extends MapProcessor
   {
       
      
      private var hurt_id:int = 203057;
      
      private var fightId:uint = 557;
      
      private var hurt_item_id:int = 500576;
      
      private var buyHurtItemBtn:SimpleButton;
      
      private var buyFightItemBtn:SimpleButton;
      
      private var historyMaxHurtTxt:TextField;
      
      public function MapProcessor_80041(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.buyHurtItemBtn = _map.front["hurtItemBtn"];
         this.buyFightItemBtn = _map.front["fightItemBtn"];
         this.historyMaxHurtTxt = _map.front["allHurtTxt"];
         ActiveCountManager.requestActiveCount(this.hurt_id,this.getHurt);
         this.buyHurtItemBtn.addEventListener(MouseEvent.CLICK,this.tobuy);
         this.buyFightItemBtn.addEventListener(MouseEvent.CLICK,this.tobuy);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.toFight);
         (SceneManager.active as LobbyScene).hideToolbar();
         TooltipManager.addCommonTip(this.buyHurtItemBtn,"在下一次战斗中增加300%倍伤害");
         PetAvatarPanel.show();
      }
      
      private function toFight(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "startFight")
         {
            FightManager.startFightWithBoss(this.fightId);
         }
      }
      
      protected function tobuy(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = null;
         if(param1.target == this.buyHurtItemBtn)
         {
            _loc2_ = new BuyPropInfo();
            _loc2_.itemId = 500576;
            _loc2_.buyComplete = this.buyComplete;
            ShopManager.buyVirtualItem(_loc2_);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
         }
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         AlertManager.showAlert("购买成功，赶紧去点击Boss战斗吧!");
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getBuyState);
         ItemManager.requestSpecialItemList();
      }
      
      private function getHurt(param1:uint, param2:uint) : void
      {
         this.historyMaxHurtTxt.text = param2.toString();
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getBuyState);
         ItemManager.requestSpecialItemList();
      }
      
      private function getBuyState(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getBuyState);
         if(ItemManager.getSpecialItem(this.hurt_item_id))
         {
            DisplayObjectUtil.disableButton(this.buyHurtItemBtn);
         }
         else
         {
            DisplayObjectUtil.enableButton(this.buyHurtItemBtn);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.buyHurtItemBtn.removeEventListener(MouseEvent.CLICK,this.tobuy);
         this.buyFightItemBtn.removeEventListener(MouseEvent.CLICK,this.tobuy);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.toFight);
         TooltipManager.remove(this.buyHurtItemBtn);
      }
   }
}
