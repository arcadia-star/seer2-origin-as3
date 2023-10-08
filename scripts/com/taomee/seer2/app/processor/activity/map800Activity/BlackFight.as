package com.taomee.seer2.app.processor.activity.map800Activity
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class BlackFight
   {
      
      private static const swapList:Vector.<uint> = Vector.<uint>([1226,1227,1228]);
      
      private static const itemList:Vector.<uint> = Vector.<uint>([603052,603053,603054]);
      
      private static const MI_BUY_PET:Vector.<uint> = Vector.<uint>([603349,603348,603347]);
       
      
      private var _mainNpc:Mobile;
      
      private var _ruikeNpc:Mobile;
      
      private var _loulanNpc:Mobile;
      
      private var _bifuNpc:Mobile;
      
      private var _onlyFlagList:Vector.<uint>;
      
      private var _activity:SimpleButton;
      
      public function BlackFight()
      {
         super();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_428);
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onGetCount);
         ItemManager.requestSpecialItemList();
         this.setMobile();
         this._activity = SceneManager.active.mapModel.front["activity"];
         this._activity.addEventListener(MouseEvent.CLICK,this.onActivity);
      }
      
      private function onActivity(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopMainPanel"),"正在打开...");
      }
      
      private function onGetCount(param1:ItemEvent) : void
      {
         var event:ItemEvent = param1;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onGetCount);
         ActiveCountManager.requestActiveCountList([202214,202215,202216],function(param1:Parser_1142):void
         {
            _onlyFlagList = param1.infoVec;
         });
      }
      
      private function setMobile() : void
      {
         this._mainNpc = MobileManager.getMobile(565,MobileType.NPC);
         this._ruikeNpc = MobileManager.getMobile(524,MobileType.NPC);
         this._loulanNpc = MobileManager.getMobile(525,MobileType.NPC);
         this._bifuNpc = MobileManager.getMobile(526,MobileType.NPC);
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
         this._mainNpc.addEventListener(MouseEvent.CLICK,this.onMain,false,1);
         this._ruikeNpc.addEventListener(MouseEvent.CLICK,this.onRuike,false,1);
         this._loulanNpc.addEventListener(MouseEvent.CLICK,this.onLoulan,false,1);
         this._bifuNpc.addEventListener(MouseEvent.CLICK,this.onBifu,false,1);
      }
      
      private function onMain(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DayLimitManager.getDoCount(644,function(param1:uint):void
         {
            var _loc2_:BaseUnit = DialogPanel.functionalityBox.getUnit("黑羽之战");
            if(_loc2_)
            {
               DialogPanel.functionalityBox.removeUnit(_loc2_);
            }
            if(param1 < 50)
            {
               DialogPanel.showForSimple(565,"渡鸦之首",[[0,"哇嘎嘎~ 暗黑的渡鸦之首在此，有何贵干？"]],"快走，小心感染病毒");
               _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"黑羽之战","heiyu");
               DialogPanel.addFunctionalityBox();
               DialogPanel.functionalityBox.addUnit(_loc2_);
            }
            else
            {
               DialogPanel.showForSimple(565,"渡鸦之首",[[0,"我今天好累啊，我需要休息以下，你明天再来挑战我吧。"]],"默默走掉");
            }
         });
      }
      
      private function onUint(param1:DialogPanelEvent) : void
      {
         var params:String = null;
         var arr:Array = null;
         var currCount:int = 0;
         var tmp:Vector.<String> = null;
         var petProp:Array = null;
         var index:int = 0;
         var event:DialogPanelEvent = param1;
         params = String(event.content.params);
         if(params == "heiyu")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("BlackFightPanel"),"正在打开...");
         }
         else if(params == "1" || params == "2" || params == "3")
         {
            arr = [20,20,20];
            currCount = 0;
            if(ItemManager.getSpecialItem(itemList[uint(params) - 1]))
            {
               currCount = int(ItemManager.getSpecialItem(itemList[uint(params) - 1]).quantity);
            }
            if(this._onlyFlagList[uint(params) - 1] == 0 && currCount >= arr[uint(params) - 1])
            {
               SwapManager.swapItem(swapList[uint(params) - 1],1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  _onlyFlagList[uint(params) - 1] = 1;
               });
            }
            else if(this._onlyFlagList[uint(params) - 1] != 0)
            {
               AlertManager.showAlert("你已经拥有了这只精灵哟，不用再次兑换了。");
            }
            else
            {
               AlertManager.showAlert("你还没有足够的羽毛来兑换精灵，可以去击败渡鸦之首获得羽毛哟。");
            }
         }
         else if(params == "4" || params == "5" || params == "6")
         {
            tmp = Vector.<String>(["4","5","6"]);
            petProp = [[150,"瑞克克"],[150,"楼兰斯"],[150,"碧芙莱"]];
            index = tmp.indexOf(params);
            AlertManager.showConfirm("你确定花费" + petProp[index][0] + "星钻一键购买" + petProp[index][1] + "吗？",function():void
            {
               PayManager.buyItem(MI_BUY_PET[index],function():void
               {
               });
            });
         }
      }
      
      private function onRuike(param1:MouseEvent) : void
      {
         DialogPanel.showForSimple(524,"瑞克克",[[0,"我是水一般的仙鹤，集齐<font color=\'#ff0000\'>" + 20 + "</font>个<font color=\'#ff0000\'>" + "水源羽毛" + "</font>，你可以兑换到我。你现在拥有<font color=\'#ff0000\'>" + this.getItemCount(603052) + "</font>个<font color=\'#ff0000\'>" + "水源羽毛" + "</font>。"]],"默默走掉");
         this.clearUnit();
         this.addMiBuyUint("4");
         this.addUnit("1");
      }
      
      private function onLoulan(param1:MouseEvent) : void
      {
         DialogPanel.showForSimple(525,"楼兰斯",[[0,"火焰让我重生，集齐<font color=\'#ff0000\'>" + 20 + "</font>个<font color=\'#ff0000\'>" + "火焰羽毛" + "</font>，你可以兑换到我哟。你现在拥有<font color=\'#ff0000\'>" + this.getItemCount(603053) + "</font>个<font color=\'#ff0000\'>" + "火焰羽毛" + "</font>。"]],"默默走掉");
         this.clearUnit();
         this.addMiBuyUint("5");
         this.addUnit("2");
      }
      
      private function onBifu(param1:MouseEvent) : void
      {
         DialogPanel.showForSimple(526,"碧芙莱",[[0,"生命的力量源于草的灵性，集齐<font color=\'#ff0000\'>" + 20 + "</font>个<font color=\'#ff0000\'>" + "草灵羽毛" + "</font>，你可以兑换到我哟。你现在拥有<font color=\'#ff0000\'>" + this.getItemCount(603054) + "</font>个<font color=\'#ff0000\'>" + "草灵羽毛" + "</font>。"]],"默默走掉");
         this.clearUnit();
         this.addMiBuyUint("6");
         this.addUnit("3");
      }
      
      private function getItemCount(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         if(ItemManager.getSpecialItem(param1))
         {
            _loc2_ = ItemManager.getSpecialItem(param1).quantity;
         }
         return _loc2_;
      }
      
      private function addUnit(param1:String) : void
      {
         var _loc2_:BaseUnit = DialogPanel.functionalityBox.getUnit("兑换精灵");
         if(_loc2_)
         {
            DialogPanel.functionalityBox.removeUnit(_loc2_);
         }
         _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"兑换精灵",param1);
         DialogPanel.functionalityBox.addUnit(_loc2_);
      }
      
      private function clearUnit() : void
      {
         DialogPanel.addFunctionalityBox();
      }
      
      private function addMiBuyUint(param1:String) : void
      {
         var _loc2_:BaseUnit = DialogPanel.functionalityBox.getUnit("一键获得");
         if(_loc2_)
         {
            DialogPanel.functionalityBox.removeUnit(_loc2_);
         }
         _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"一键获得",param1);
         DialogPanel.functionalityBox.addUnit(_loc2_);
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
         this._mainNpc.removeEventListener(MouseEvent.CLICK,this.onMain);
         this._ruikeNpc.removeEventListener(MouseEvent.CLICK,this.onRuike);
         this._loulanNpc.removeEventListener(MouseEvent.CLICK,this.onLoulan);
         this._bifuNpc.removeEventListener(MouseEvent.CLICK,this.onBifu);
         this._mainNpc = null;
         this._ruikeNpc = null;
         this._loulanNpc = null;
         this._bifuNpc = null;
      }
   }
}
