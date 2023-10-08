package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80302 extends MapProcessor
   {
       
      
      private var _timeMC:MovieClip;
      
      private var _canChooseBtn:SimpleButton;
      
      private var _skipWaitBtn:SimpleButton;
      
      private var _buffTipsMc:MovieClip;
      
      private var _okBtn:SimpleButton;
      
      private var _closeBtn:SimpleButton;
      
      private var _itemShop:SimpleButton;
      
      private var _CDtime:int;
      
      private var _leftTime:int;
      
      private var SceneMC:MovieClip;
      
      private var tips2:SimpleButton;
      
      private var npcId:uint = 815;
      
      private var boosNpc:Mobile;
      
      private var _fightCount:int;
      
      private var RANDOM_ID:int = 104;
      
      private var _dayLimit:Array;
      
      private var _foreverLimit:Array;
      
      private var _idxBuff:int = 0;
      
      private var _isUseBuff:Boolean;
      
      private var _fight2ID:Array;
      
      private var _buyCount:int;
      
      private var _gameCount:int;
      
      private var _info:DayLimitListInfo;
      
      private var _mc:MovieClip;
      
      public function MapProcessor_80302(param1:MapModel)
      {
         this._dayLimit = [1309,1310,1311];
         this._foreverLimit = [204652,204653,204655];
         this._fight2ID = [1200];
         super(param1);
      }
      
      override public function init() : void
      {
         this.SceneMC = _map.content["SceneMC"];
         this.SceneMC.visible = false;
         this.SceneMC.gotoAndStop(1);
         this._timeMC = _map.content["timeMc"];
         this._timeMC.gotoAndStop(1);
         this._canChooseBtn = _map.content["canChooseBtn"];
         this.setBtnEnable(this._canChooseBtn,false);
         this._skipWaitBtn = _map.content["skipWaitBtn"];
         this._skipWaitBtn.visible = false;
         this._buffTipsMc = _map.content["buffTips"];
         this._buffTipsMc.gotoAndStop(1);
         _map.front.addChild(this._buffTipsMc);
         this.tips2 = _map.content["tips2"];
         _map.front.addChild(this.tips2);
         this._buffTipsMc.visible = false;
         this._itemShop = _map.content["itemShop"];
         this._okBtn = this._buffTipsMc["okBtn"];
         this._closeBtn = this._buffTipsMc["closeBtn"];
         this._canChooseBtn.addEventListener(MouseEvent.CLICK,this.onChoose);
         this._skipWaitBtn.addEventListener(MouseEvent.CLICK,this.onSkip);
         this._itemShop.addEventListener(MouseEvent.CLICK,this.onItemShop);
         this._okBtn.addEventListener(MouseEvent.CLICK,this.onCloseTips);
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseTips);
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function(param1:SceneEvent):void
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(_fight2ID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  ModuleManager.showModule(URLUtil.getAppModule("BuMieXieShenPanel"),"正在打开面板...");
               }
            }
         });
         this.createNPC();
         this.checkStatues();
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
         if(_loc2_.index == this.RANDOM_ID)
         {
            this._buffTipsMc.visible = true;
            this._skipWaitBtn.visible = true;
            this.checkStatues();
         }
      }
      
      private function onChoose(param1:MouseEvent) : void
      {
         if(this._idxBuff != 0 && this._isUseBuff == 0)
         {
            AlertManager.showAlert("抽取到BUFF没有使用，不能连续抽取！请进入对战使用该BUFF！");
         }
         else if(this._idxBuff == 0)
         {
            this.setBtnEnable(this._canChooseBtn,false);
            Connection.send(CommandSet.RANDOM_EVENT_1140,this.RANDOM_ID,0);
         }
      }
      
      private function onSkip(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ShopManager.buyItemForId(604137,function(param1:*):void
         {
            _timeMC.gotoAndStop(1);
            _skipWaitBtn.visible = false;
            _canChooseBtn.visible = true;
            Tick.instance.removeRender(updateTime);
            checkStatues();
         });
      }
      
      private function onCloseTips(param1:MouseEvent) : void
      {
         this._buffTipsMc.visible = false;
      }
      
      private function checkStatues() : void
      {
         DayLimitListManager.getDaylimitList(this._dayLimit,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            _fightCount = info.getCount(_dayLimit[0]);
            _CDtime = info.getCount(_dayLimit[1]);
            _info = info;
            ActiveCountManager.requestActiveCountList(_foreverLimit,function(param1:Parser_1142):void
            {
               _idxBuff = param1.infoVec[0];
               _isUseBuff = Boolean(BitUtil.getBit(param1.infoVec[1],0));
               _buyCount = param1.infoVec[2];
               if(ActorManager.actorInfo.vipInfo.isVip())
               {
                  _gameCount = getCanNum(_info.getCount(_dayLimit[2]),_buyCount,2);
               }
               else
               {
                  _gameCount = getCanNum(_info.getCount(_dayLimit[2]),_buyCount,1);
               }
               updateShow();
            });
         });
      }
      
      private function updateShow() : void
      {
         this._leftTime = this._CDtime - TimeManager.getPrecisionServerTime();
         if(this._leftTime > 0)
         {
            this.updateTimeTxt();
            this.setBtnEnable(this._canChooseBtn,false);
            this._skipWaitBtn.visible = true;
            Tick.instance.addRender(this.updateTime,1000);
         }
         else
         {
            this.setBtnEnable(this._canChooseBtn,true);
         }
         if(this._idxBuff > 0)
         {
            this._buffTipsMc.gotoAndStop(this._idxBuff);
         }
      }
      
      private function updateTime(param1:uint) : void
      {
         if(this._leftTime <= 0)
         {
            Tick.instance.removeRender(this.updateTime);
            this.setBtnEnable(this._canChooseBtn,true);
            this._skipWaitBtn.visible = false;
         }
         else
         {
            this.updateTimeTxt();
         }
      }
      
      private function updateTimeTxt() : void
      {
         --this._leftTime;
         var _loc1_:int = int(100 - 100 * this._leftTime / 300);
         this._timeMC.gotoAndStop(_loc1_);
      }
      
      private function createNPC() : void
      {
         this.boosNpc = new Mobile();
         this.boosNpc.resourceUrl = URLUtil.getNpcSwf(this.npcId);
         this.boosNpc.buttonMode = true;
         this.boosNpc.x = 545;
         this.boosNpc.y = 330;
         this.boosNpc.addEventListener(MouseEvent.CLICK,this.toFight);
         MobileManager.addMobile(this.boosNpc,MobileType.NPC);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this._gameCount <= 0)
         {
            AlertManager.showConfirm("今天的挑战次数用完了哈！是否要购买次数呢？",function():void
            {
               ShopManager.buyItemForId(604135,function(param1:*):void
               {
                  checkStatues();
               });
            });
         }
         else if(this._fightCount < 3)
         {
            if(this._fightCount == 0)
            {
               NpcDialog.show(this.npcId,"邪神",[[0,"魔域军团都被你打败了，看来你是个不错的对手 "]],["邪神你太嚣张了！ "],[function():void
               {
                  NpcDialog.show(npcId,"邪神",[[0,"今天先战胜我3次再说！（今日已累胜  " + "<font color=\'#ff0000\'>" + _fightCount + "</font>" + " 次） "]],["来吧！","准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(1199);
                  }]);
               }]);
            }
            else
            {
               NpcDialog.show(this.npcId,"邪神",[[0,"今天先战胜我3次再说！（今日已累胜  " + "<font color=\'#ff0000\'>" + this._fightCount + "</font>" + " 次） "]],["来吧！","准备一下"],[function():void
               {
                  FightManager.startFightWithWild(1199);
               }]);
            }
         }
         else
         {
            this.SceneMC.visible = true;
            MovieClipUtil.playMc(this.SceneMC,2,this.SceneMC.totalFrames,function():void
            {
               NpcDialog.show(npcId,"邪神",[[0,"好吧！现在就让我们最后战一场！赢了你就能得到你想要的！"]],["乖乖接招吧！","准备一下"],[function():void
               {
                  SceneMC.visible = false;
                  FightManager.startFightWithWild(1200);
               }]);
               SceneMC.visible = false;
            },true);
         }
      }
      
      private function setBtnEnable(param1:SimpleButton, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
         }
         else
         {
            ColorFilter.setGrayscale(param1);
         }
         param1.mouseEnabled = param2;
      }
      
      private function onItemShop(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("MedicineShopPanel");
      }
      
      public function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
   }
}
