package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.app.processor.activity.decoration.Decoration8011;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_8011 extends TitleMapProcessor
   {
       
      
      private var _castBtn:MovieClip;
      
      private var _gameBtn:SimpleButton;
      
      private var _game2Btn:SimpleButton;
      
      private var _devilTrainBtn:SimpleButton;
      
      private var _vipPyramidBtn:SimpleButton;
      
      private var _giftMachine:MovieClip;
      
      private var _decoration:Decoration8011;
      
      private var _vipBack:SimpleButton;
      
      private var _newYearVip:SimpleButton;
      
      private var $tianma:SimpleButton;
      
      public function MapProcessor_8011(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         GrabXiaoYueSeAct.getInstance().setup(_map);
         this._castBtn = _map.content["castBtn"];
         this._castBtn.buttonMode = true;
         TooltipManager.addCommonTip(this._castBtn,"铸造装备");
         this._gameBtn = _map.content["gameBtn"];
         TooltipManager.addGameTip(this._gameBtn,"疯狂套牛");
         this._game2Btn = _map.content["game2Btn"];
         TooltipManager.addGameTip(this._game2Btn,"火箭赛尔");
         this._devilTrainBtn = _map.content["devilTrainBtn"];
         TooltipManager.addCommonTip(this._devilTrainBtn,"魔鬼训练");
         this._castBtn.addEventListener(MouseEvent.CLICK,this.onCastClick);
         this._gameBtn.addEventListener(MouseEvent.CLICK,this.onGameClick);
         this._game2Btn.addEventListener(MouseEvent.CLICK,this.onGame2Click);
         this._devilTrainBtn.addEventListener(MouseEvent.CLICK,this.onDevilTrain);
         this._giftMachine = _map.content["giftMachine"];
         this._giftMachine.buttonMode = true;
         TooltipManager.addCommonTip(this._giftMachine,"精灵扭蛋机");
         this._giftMachine.addEventListener(MouseEvent.CLICK,this.onGiftMachine);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         StatisticsManager.sendNovice(StatisticsManager.map_entry_8011);
         this.initVipPyramid();
         this.initDecoration();
         this._vipBack = _map.content["abc"];
         this._vipBack.addEventListener(MouseEvent.CLICK,this.onVipBack);
         this._newYearVip = _map.content["newYearVip"];
         this._newYearVip.addEventListener(MouseEvent.CLICK,this.onNewYearVip);
      }
      
      private function onNewYearVip(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewYearVipPetPanel");
      }
      
      private function onTianMa(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,3817);
      }
      
      private function onVipBack(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("YearPet2017ShengJiaLeiMingPanel"));
      }
      
      private function initOpen() : void
      {
         var _loc1_:Vector.<ServerBufferData> = Vector.<ServerBufferData>([]);
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            _loc1_.push(new ServerBufferData(_loc2_,0));
            _loc2_++;
         }
         ServerBufferManager.updateServerBufferGroup(ServerBufferType.OPEN_SCROOL,_loc1_);
      }
      
      private function initDecoration() : void
      {
         this._decoration = new Decoration8011();
      }
      
      private function onVip(param1:MouseEvent) : void
      {
      }
      
      private function onGiftMachine(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("GiftMachinePanel"),"正在打开扭蛋机");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_209);
      }
      
      private function initVipPyramid() : void
      {
         this._vipPyramidBtn = _map.content["VipPyramidBtn"];
         TooltipManager.addCommonTip(this._vipPyramidBtn,"VIP乐园金字塔");
         this._vipPyramidBtn.addEventListener(MouseEvent.CLICK,this.onVipPyramidBtn);
      }
      
      private function onVipPyramidBtn(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_281);
         ModuleManager.toggleModule(URLUtil.getAppModule("VipPyramidPanel"),"...");
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(evt.content.params == "whenVip")
         {
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_42);
            ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在vip面板...",{"currentTab":0});
         }
         else if(evt.content.params == "createCity")
         {
            this.checkIsComplete();
         }
         else if(evt.content.params == "whoAreYou")
         {
            NpcDialog.show(105,"希尔顿",[[0,"O(∩_∩)OHOHO~~乐园大酬宾啦！每天到我这里领<font color=\'#FF0000\' size=\'14\'>1格能量吧（VIP3格）</font>！另外，如果你能帮我收集材料建造乐园，还有更多能量哦！"]],[" 领取能量！"],[function():void
            {
               if(VipManager.vipInfo.isVip() == true)
               {
                  if(VipManager.isAddBeFull(3) == true)
                  {
                     Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,onGetReward);
                     Connection.addErrorHandler(CommandSet.ITEM_EXCHANGE_1055,onGetError);
                     Connection.send(CommandSet.ITEM_EXCHANGE_1055,251,1,0);
                  }
                  else
                  {
                     showResultDialog();
                  }
               }
               else if(VipManager.isAddBeFull(1) == true)
               {
                  Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,onGetReward);
                  Connection.addErrorHandler(CommandSet.ITEM_EXCHANGE_1055,onGetError);
                  Connection.send(CommandSet.ITEM_EXCHANGE_1055,251,1,0);
               }
               else
               {
                  showResultDialog();
               }
            }]);
         }
      }
      
      private function onGetError(param1:MessageEvent) : void
      {
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onGetReward);
         Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055,this.onGetError);
         if(event.message.statusCode == 66)
         {
            NpcDialog.show(105,"希尔顿",[[0,"HOHO~~你今天已经领过能量啦，明天再来吧！"]],["好的,再见！"],[function():void
            {
            }]);
         }
      }
      
      private function onGetReward(param1:MessageEvent) : void
      {
         var _loc3_:uint = 0;
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onGetReward);
         Connection.removeErrorHandler(CommandSet.ITEM_EXCHANGE_1055,this.onGetError);
         var _loc2_:IDataInput = param1.message.getRawData();
         if(VipManager.vipInfo.isVip() == true)
         {
            VipManager.vipInfo.point += 3;
            _loc3_ = 3;
         }
         else
         {
            VipManager.vipInfo.point += 1;
            _loc3_ = 1;
         }
         ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在打开VIP面板...",{
            "currentTab":0,
            "isShine":1,
            "num":_loc3_
         });
      }
      
      private function showResultDialog() : void
      {
         NpcDialog.show(105,"希尔顿",[[0,"你的能量格已经装不下了，先把能量格用掉再来领吧！"]],["打开能量格看看","好的，再见！"],[function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"),"正在打开VIP面板...",{"currentTab":1});
         }]);
      }
      
      private function checkIsComplete() : void
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:uint = _loc1_.getDay() % 3;
         var _loc3_:Array = [[10059,10060,10061],[10062,10063,10064],[10065,10066,10067]];
         if(QuestManager.isComplete(10068) == false)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("JBCollectMaterialPanel"),"正在打开面板...",_loc2_);
         }
         else
         {
            NpcDialog.show(70,"包工头",[[0,"谢谢你，热情的小家伙，今天你已经帮我收集过材料啦，明天再来吧！"]],["好的，再见！"]);
         }
      }
      
      private function onCastClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("CastEquipPanel"),"正在铸造装备面板...");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_205);
      }
      
      private function onGameClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_278);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开vip小游戏" + "...",{
            "gameId":19,
            "isVip":1
         });
      }
      
      private function onGame2Click(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_277);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开vip小游戏" + "...",{
            "gameId":12,
            "isVip":1
         });
      }
      
      private function onDevilTrain(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_279);
         ModuleManager.toggleModule(URLUtil.getAppModule("VipDevilTrain"),"正在打开vip魔鬼训练面板");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._decoration)
         {
            this._decoration.dispose();
         }
         TooltipManager.remove(this._gameBtn);
         TooltipManager.remove(this._game2Btn);
         TooltipManager.remove(this._castBtn);
         TooltipManager.remove(this._devilTrainBtn);
         this._castBtn.removeEventListener(MouseEvent.CLICK,this.onCastClick);
         this._gameBtn.removeEventListener(MouseEvent.CLICK,this.onGameClick);
         this._game2Btn.removeEventListener(MouseEvent.CLICK,this.onGame2Click);
         this._devilTrainBtn.removeEventListener(MouseEvent.CLICK,this.onDevilTrain);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         GrabXiaoYueSeAct.getInstance().dispose();
      }
   }
}
