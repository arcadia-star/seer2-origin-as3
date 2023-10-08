package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.manager.EventManager;
   
   public class MapProcessor_80059 extends MapProcessor
   {
       
      
      private const SPE_RANDOM:uint = 63;
      
      private const NORMAL_RANDOM:uint = 62;
      
      private const BUY_ACTION_NUM:uint = 203264;
      
      private const FIHGT_SEAT_ID:uint = 203265;
      
      private const FIGHT_BOSS25:uint = 616;
      
      private const FREE_ACTION_NUM:uint = 828;
      
      private const CLEAR_SWAP:uint = 1969;
      
      private const ACTION_MEE_ID:uint = 400199;
      
      private const NORMAL_RESULT:Array = ["TianlongCateranPanel","TianlongLuckyPanel","TianlongHinderPanel","TianlongFightSelfPanel"];
      
      private const SPE_RESULT:Array = ["TianlongSpeSelfPanel","TianlongFightBossPanel","TianlongEmptyPanel"];
      
      private const FINAL_BOSS_PANEL:String = "TianlongFinalBossPanel";
      
      private var roadMc:MovieClip;
      
      private var passTxt:TextField;
      
      private var actionTxt:TextField;
      
      private var buyActionBtn:SimpleButton;
      
      private var goBtn:SimpleButton;
      
      private var exitBtn:SimpleButton;
      
      private var stoneList:Vector.<MovieClip>;
      
      private var buyinfo:BuyPropInfo;
      
      private var actionNum:uint = 0;
      
      private var fightSeatNum:uint = 0;
      
      private var stoneNum:int;
      
      private var currentEvent:int;
      
      public function MapProcessor_80059(param1:MapModel)
      {
         this.buyinfo = new BuyPropInfo();
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice("0x10034159");
         this.initUI();
         this.initData();
         this.initStone();
         this.initEvent();
         LobbyScene(SceneManager.active).hideToolbar();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         PetAvatarPanel.show();
         if(FightManager.isJustWinFight())
         {
            MovieClipUtil.playMc(this.roadMc,1,this.roadMc.totalFrames,function():void
            {
               roadMc.gotoAndStop(1);
            },true);
         }
      }
      
      private function initStone() : void
      {
         this.stoneList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.stoneList.push(_map.content["hinder" + _loc1_]);
            this.stoneList[_loc1_].buttonMode = true;
            this.stoneList[_loc1_].visible = false;
            this.stoneList[_loc1_].mouseChildren = false;
            this.stoneList[_loc1_].addEventListener(MouseEvent.CLICK,this.clearStone);
            _loc1_++;
         }
      }
      
      private function clearStone(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         (event.target as DisplayObject).visible = false;
         --this.stoneNum;
         if(this.stoneNum == 0)
         {
            SwapManager.swapItem(this.CLEAR_SWAP,1,function():void
            {
               currentEvent = 0;
               updateSeat();
            },this.errorHandler);
         }
      }
      
      private function errorHandler(param1:uint) : void
      {
         ErrorMap.parseStatusCode(param1);
         this.currentEvent = 0;
         this.updateSeat();
      }
      
      private function initData() : void
      {
         DayLimitManager.getDoCount(this.FREE_ACTION_NUM,this.getFreeNum);
      }
      
      private function getFreeNum(param1:uint) : void
      {
         var _loc2_:int = VipManager.vipInfo.isVip() ? 5 : 3;
         this.actionNum = _loc2_ >= param1 ? uint(_loc2_ - param1) : 0;
         ActiveCountManager.requestActiveCountList([this.BUY_ACTION_NUM,this.FIHGT_SEAT_ID,203266],this.getData);
      }
      
      private function getData(param1:Parser_1142) : void
      {
         this.actionNum += param1.infoVec[0];
         this.fightSeatNum = param1.infoVec[1];
         this.currentEvent = param1.infoVec[2];
         this.updateDis();
         this.showResult();
      }
      
      private function showResult() : void
      {
         var _loc1_:uint = uint(this.fightSeatNum + 1);
         if(this.currentEvent < 4)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this.NORMAL_RESULT[this.currentEvent - 1]));
         }
         else if(this.currentEvent == 4)
         {
            if(_loc1_ % 5 == 0 && _loc1_ != 25)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule(this.SPE_RESULT[this.currentEvent - 4]),"",this.fightSeatNum + 1);
            }
            else
            {
               ModuleManager.toggleModule(URLUtil.getAppModule(this.NORMAL_RESULT[this.currentEvent - 1]),"",this.fightSeatNum + 1);
            }
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this.SPE_RESULT[this.currentEvent - 4]),"",this.fightSeatNum + 1);
         }
      }
      
      private function updateDis() : void
      {
         this.actionTxt.text = this.actionNum.toString();
         this.passTxt.text = this.fightSeatNum.toString() + "/25";
         if(this.fightSeatNum == 25)
         {
            AlertManager.showConfirm("你已经到达目的地了，需要重置之后才能玩了，确定要重置吗？",function():void
            {
               SwapManager.swapItem(2001,1,function():void
               {
                  initData();
               });
            });
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.buyActionBtn.removeEventListener(MouseEvent.CLICK,this.buyAction);
         this.goBtn.removeEventListener(MouseEvent.CLICK,this.getRandom);
         EventManager.removeEventListener("advance_event",this.updateSeat);
         EventManager.removeEventListener("create_stone_event",this.createStone);
         this.exitBtn.removeEventListener(MouseEvent.CLICK,this.to70);
      }
      
      private function initEvent() : void
      {
         this.buyActionBtn.addEventListener(MouseEvent.CLICK,this.buyAction);
         this.goBtn.addEventListener(MouseEvent.CLICK,this.getRandom);
         EventManager.addEventListener("advance_event",this.updateSeat);
         EventManager.addEventListener("create_stone_event",this.createStone);
         this.exitBtn.addEventListener(MouseEvent.CLICK,this.to70);
      }
      
      protected function to70(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function createStone(param1:Event) : void
      {
         this.stoneNum = 3;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            this.stoneList[_loc2_].visible = true;
            _loc2_++;
         }
      }
      
      private function updateSeat(param1:Event = null) : void
      {
         var event:Event = param1;
         this.currentEvent = 0;
         MovieClipUtil.playMc(this.roadMc,1,this.roadMc.totalFrames,function():void
         {
            roadMc.gotoAndStop(1);
            ++fightSeatNum;
            updateDis();
         },true);
      }
      
      protected function getRandom(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(this.fightSeatNum + 1);
         if(this.currentEvent != 0)
         {
            this.showResult();
            return;
         }
         if(this.actionNum == 0)
         {
            AlertManager.showAlert("剩余行动力不足！不能再前进了。你可以选择购买行动力哦！");
            return;
         }
         if(_loc2_ % 5 == 0 && _loc2_ != 25)
         {
            Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomSpe);
            Connection.send(CommandSet.RANDOM_EVENT_1140,this.SPE_RANDOM,0);
         }
         else if(_loc2_ < 25)
         {
            Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomNormal);
            Connection.send(CommandSet.RANDOM_EVENT_1140,this.NORMAL_RANDOM,0);
         }
         if(_loc2_ == 25)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this.FINAL_BOSS_PANEL));
         }
      }
      
      private function onRandomSpe(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomSpe);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         this.currentEvent = _loc4_;
         this.showResult();
         --this.actionNum;
         this.updateDis();
      }
      
      private function onRandomNormal(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomNormal);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         this.currentEvent = _loc4_;
         this.showResult();
         --this.actionNum;
         this.updateDis();
      }
      
      protected function buyAction(param1:MouseEvent) : void
      {
         this.buyinfo.itemId = this.ACTION_MEE_ID;
         this.buyinfo.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(this.buyinfo);
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         this.initData();
      }
      
      private function initUI() : void
      {
         this.roadMc = _map.ground["eftMC"];
         this.roadMc.gotoAndStop(1);
         this.passTxt = _map.front["passTxt"];
         this.actionTxt = _map.front["actionTxt"];
         this.buyActionBtn = _map.front["buyActionBtn"];
         this.goBtn = _map.front["goBtn"];
         this.exitBtn = _map.front["exitBtn"];
      }
   }
}
