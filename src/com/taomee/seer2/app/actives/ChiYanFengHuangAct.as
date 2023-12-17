package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.inventory.item.SpecialItem;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   
   public class ChiYanFengHuangAct
   {
      
      private static var _instance:ChiYanFengHuangAct;
       
      
      private var _mainUI:Sprite;
      
      private var wuzixiangBtn:SimpleButton;
      
      private var zhufuBtn:SimpleButton;
      
      private var beVip:SimpleButton;
      
      private var exitbtn:SimpleButton;
      
      private var petBagBtn:SimpleButton;
      
      private var totalDamageTxt:TextField;
      
      private var canGetNumTxt:TextField;
      
      private var canFightTxt:TextField;
      
      private var npc:Sprite;
      
      private const current_turn_id:int = 204000;
      
      private const current_damage_id:int = 204001;
      
      private const buyed_turn_id:int = 204003;
      
      private const fight_chance_item_id:int = 603711;
      
      private const fight_index:int = 907;
      
      private const leave_map_swap_id:int = 2678;
      
      private const damage_get_value:Array = [200000,100000,50000,30000,10000,5000];
      
      private const damage_get_count:Array = [20,15,10,5,2,1];
      
      private const buy_zhu_fu_id:int = 500604;
      
      private var fightNum:int = 0;
      
      private var currentTurn:int = 0;
      
      private var currentDamage:int = 0;
      
      private var buyedTurn:int = 0;
      
      private var canFight:int = 0;
      
      public function ChiYanFengHuangAct()
      {
         super();
      }
      
      public static function getInstance() : ChiYanFengHuangAct
      {
         if(_instance == null)
         {
            _instance = new ChiYanFengHuangAct();
         }
         return _instance;
      }
      
      public function setUp() : void
      {
         this.initUI();
         this.getData();
         this.createNpc();
         this.initEvent();
         (SceneManager.active as LobbyScene).hideToolbar();
      }
      
      private function initUI() : void
      {
         this._mainUI = SceneManager.active.mapModel.front;
         this.wuzixiangBtn = this._mainUI["wuzixiangBtn"];
         this.zhufuBtn = this._mainUI["zhufuBtn"];
         this.beVip = this._mainUI["beVip"];
         this.exitbtn = this._mainUI["exitbtn"];
         this.totalDamageTxt = this._mainUI["totalDamageTxt"];
         this.canGetNumTxt = this._mainUI["canGetNumTxt"];
         this.canFightTxt = this._mainUI["canFightTxt"];
         this.petBagBtn = this._mainUI["petBagBtn"];
      }
      
      private function getData() : void
      {
         ActiveCountManager.requestActiveCountList([this.current_turn_id,this.current_damage_id,this.buyed_turn_id],this.getForlimitData);
      }
      
      private function getForlimitData(param1:Parser_1142) : void
      {
         this.currentTurn = param1.infoVec[0];
         this.currentDamage = param1.infoVec[1];
         this.buyedTurn = param1.infoVec[2];
         this.canFight = 5 + this.buyedTurn - this.currentTurn;
         this.canFightTxt.text = this.canFight.toString();
         this.totalDamageTxt.text = this.currentDamage.toString();
         this.calcuHowManyGet();
      }
      
      private function calcuHowManyGet() : void
      {
         var i:int = 0;
         var canGet:uint = 0;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.fight_index)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               canGet = 25;
               this.canGetNumTxt.text = canGet.toString();
               AlertManager.showAlert("由于你赢得了胜利,你将获得凤之羽25个",function():void
               {
                  SwapManager.swapItem(leave_map_swap_id,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     (SceneManager.active as LobbyScene).showToolbar();
                  });
               });
            }
            else
            {
               i = 0;
               while(i < this.damage_get_value.length)
               {
                  if(this.currentDamage >= this.damage_get_value[i])
                  {
                     canGet = uint(this.damage_get_count[i]);
                     break;
                  }
                  i++;
               }
               if(canGet > 0)
               {
                  AlertManager.showAlert("当前累计伤害值为 " + this.currentDamage + ",可获得凤之羽" + canGet + "个");
               }
               else
               {
                  AlertManager.showAlert("当前累计伤害值为 " + this.currentDamage + ",很可惜你没获得碎片");
               }
               this.canGetNumTxt.text = canGet.toString();
            }
         }
      }
      
      private function createNpc() : void
      {
         this.npc = this._mainUI["npc"];
         this.npc.buttonMode = true;
         TooltipManager.addCommonTip(this.npc,"点我开始战斗，【离开】后结束挑战输出奖励");
         this.npc.addEventListener(MouseEvent.CLICK,this.onCLick);
      }
      
      private function onCLick(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = null;
         if(this.canFight > 0)
         {
            FightManager.startFightWithBoss(this.fight_index);
         }
         else
         {
            _loc2_ = new BuyPropInfo();
            _loc2_.itemId = this.fight_chance_item_id;
            _loc2_.buyComplete = this.buyOver;
            ShopManager.buyVirtualItem(_loc2_);
         }
      }
      
      private function buyOver(param1:*) : void
      {
         FightManager.startFightWithBoss(this.fight_index);
      }
      
      private function initEvent() : void
      {
         this.wuzixiangBtn.addEventListener(MouseEvent.CLICK,this.onwuzixiangBtn);
         this.zhufuBtn.addEventListener(MouseEvent.CLICK,this.onzhufuBtn);
         this.beVip.addEventListener(MouseEvent.CLICK,this.onbeVip);
         this.exitbtn.addEventListener(MouseEvent.CLICK,this.onexitbtn);
         this.petBagBtn.addEventListener(MouseEvent.CLICK,this.onpetBagBtn);
      }
      
      private function onwuzixiangBtn(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("MedicineShopPanel");
      }
      
      private function onzhufuBtn(param1:MouseEvent) : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onSucc);
         ItemManager.requestSpecialItemList(true);
      }
      
      private function onSucc(param1:ItemEvent) : void
      {
         var item:SpecialItem;
         var count:int;
         var info1:BuyPropInfo = null;
         var event:ItemEvent = param1;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onSucc);
         item = ItemManager.getSpecialItem(500604);
         count = item != null ? int(item.quantity) : 0;
         if(count > 0)
         {
            AlertManager.showAlert("火凤祝福会在下次战斗中生效，请在战斗结束后再次购买");
         }
         else
         {
            info1 = new BuyPropInfo();
            info1.itemId = this.buy_zhu_fu_id;
            info1.buyComplete = function(param1:*):void
            {
            };
            ShopManager.buyVirtualItem(info1);
         }
      }
      
      private function onbeVip(param1:MouseEvent) : void
      {
         VipManager.navigateToPayPage();
      }
      
      private function onexitbtn(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         AlertManager.showConfirm("离开地图将结束此轮挑战，你确定要离开吗？",function():void
         {
            SwapManager.swapItem(leave_map_swap_id,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               SceneManager.changeScene(SceneType.LOBBY,70);
               (SceneManager.active as LobbyScene).showToolbar();
            });
         });
      }
      
      private function onpetBagBtn(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"));
      }
      
      private function removeEvent() : void
      {
         this.wuzixiangBtn.removeEventListener(MouseEvent.CLICK,this.onwuzixiangBtn);
         this.zhufuBtn.removeEventListener(MouseEvent.CLICK,this.onzhufuBtn);
         this.beVip.removeEventListener(MouseEvent.CLICK,this.onbeVip);
         this.exitbtn.removeEventListener(MouseEvent.CLICK,this.onexitbtn);
         this.petBagBtn.removeEventListener(MouseEvent.CLICK,this.onpetBagBtn);
      }
      
      public function dispose() : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onSucc);
         this.removeEvent();
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.onCLick);
            TooltipManager.remove(this.npc);
         }
      }
   }
}
