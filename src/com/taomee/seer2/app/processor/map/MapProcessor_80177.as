package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80177 extends MapProcessor
   {
       
      
      private var barMc:MovieClip;
      
      private var boxMc:MovieClip;
      
      private var timeTxt:TextField;
      
      private var bossList:Vector.<MovieClip>;
      
      private var buyTimeBtn:SimpleButton;
      
      private var buyCountBtn:SimpleButton;
      
      private var buyPassBtn:SimpleButton;
      
      private const TIME_VALUE:uint = 1080;
      
      private const BOSS_STATE:uint = 1081;
      
      private const FIGHT_NUM:uint = 1083;
      
      private const FIGHT_ID:Array = [927,928,929];
      
      private const MAX_TIME:uint = 180;
      
      private const BUY_TIME_ID:uint = 603683;
      
      private const BUY_COUNT_ID:uint = 603682;
      
      private const BUY_PASS_ID:uint = 603684;
      
      private var preTime:uint;
      
      private var bossState:uint;
      
      private var leftFightNum:uint;
      
      private var leftTime:uint;
      
      private var buyInfo:BuyPropInfo;
      
      public function MapProcessor_80177(param1:MapModel)
      {
         this.buyInfo = new BuyPropInfo();
         super(param1);
      }
      
      override public function init() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         this.buyTimeBtn = _map.front["buyTimeBtn"];
         this.buyCountBtn = _map.front["buyCountBtn"];
         this.buyPassBtn = _map.front["buyPassBtn"];
         this.timeTxt = _map.front["timeTxt"];
         this.barMc = _map.front["barMc"];
         this.boxMc = _map.front["boxMc"];
         this.bossList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.bossList.push(_map.front["bossList" + _loc1_]);
            this.bossList[_loc1_].buttonMode = true;
            _loc1_++;
         }
         this.barMc.gotoAndStop(1);
         DayLimitListManager.getDaylimitList([this.TIME_VALUE,this.BOSS_STATE,this.FIGHT_NUM],this.getDayData);
      }
      
      private function getDayData(param1:DayLimitListInfo) : void
      {
         this.preTime = param1.getCount(this.TIME_VALUE);
         this.bossState = param1.getCount(this.BOSS_STATE);
         this.leftFightNum = param1.getCount(this.FIGHT_NUM) >= 3 ? 0 : uint(3 - param1.getCount(this.FIGHT_NUM));
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_211,this.getFullState);
      }
      
      private function getFullState(param1:ServerBuffer) : void
      {
         var i:int = 0;
         var buffer:ServerBuffer = param1;
         if(!buffer.readDataAtPostion(2))
         {
            i = 0;
            while(i < 3)
            {
               this.bossList[i].visible = false;
               i++;
            }
            ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_211,2,1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("PanDuoLaScene1"),function():void
            {
               var _loc1_:int = 0;
               while(_loc1_ < 3)
               {
                  bossList[_loc1_].visible = true;
                  _loc1_++;
               }
               setBoss();
            },false,false,1,false);
         }
         else
         {
            this.setBoss();
         }
      }
      
      private function setBoss() : void
      {
         var overTime:uint;
         var i:int = 0;
         while(i < 3)
         {
            this.bossList[i].mouseChildren = false;
            if(BitUtil.getBit(this.bossState,i))
            {
               this.bossList[i].visible = false;
            }
            this.bossList[i].addEventListener(MouseEvent.CLICK,this.toFight);
            i++;
         }
         this.buyTimeBtn.addEventListener(MouseEvent.CLICK,this.buyTime);
         this.buyCountBtn.addEventListener(MouseEvent.CLICK,this.buyCount);
         this.buyPassBtn.addEventListener(MouseEvent.CLICK,this.buyPass);
         this.barMc.gotoAndStop(4 - this.leftFightNum);
         overTime = TimeManager.getServerTime() - this.preTime;
         if(overTime < this.MAX_TIME)
         {
            this.leftTime = this.MAX_TIME - overTime;
            this.startTime();
         }
         else
         {
            this.leftTime = 0;
         }
         this.timeTxt.text = DateUtil.getMS(this.leftTime);
         if(this.bossState == 7)
         {
            this.boxMc.visible = false;
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("PanDuoLaScene2"),function():void
            {
               boxMc.visible = true;
               ModuleManager.showAppModule("PanDuoLaPanel");
            },false,false,1,false);
         }
      }
      
      private function buyTime(param1:MouseEvent) : void
      {
         this.buyInfo.itemId = this.BUY_TIME_ID;
         this.buyInfo.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(this.buyInfo);
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         DayLimitListManager.getDaylimitList([this.TIME_VALUE,this.BOSS_STATE,this.FIGHT_NUM],this.getDayData);
      }
      
      private function buyPass(param1:MouseEvent) : void
      {
         this.buyInfo.itemId = this.BUY_PASS_ID;
         this.buyInfo.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(this.buyInfo);
      }
      
      private function buyCount(param1:MouseEvent) : void
      {
         this.buyInfo.itemId = this.BUY_COUNT_ID;
         this.buyInfo.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(this.buyInfo);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var index:uint = 0;
         var event:MouseEvent = param1;
         if(this.leftTime == 0 && this.preTime != 0)
         {
            AlertManager.showConfirm("你已经没有时间战斗了！要购买战斗时间吗?",function():void
            {
               buyTime(null);
            });
            return;
         }
         if(this.leftFightNum == 0)
         {
            AlertManager.showConfirm("剩余战斗次数不足,需要购买次数吗?",function():void
            {
               buyCount(null);
            });
            return;
         }
         index = this.bossList.indexOf(event.target as MovieClip);
         switch(index)
         {
            case 0:
               NpcDialog.show(742,"天马",[[0,"大神叫我守住盒子的！你表过来！表过来！"]],["小马别挡路","最烦这种萌的了"],[function():void
               {
                  FightManager.startFightWithBoss(FIGHT_ID[index]);
               }]);
               break;
            case 1:
               NpcDialog.show(743,"圣兽天马",[[0,"魔盒不可触碰！后果不堪设想！"]],["我就摸一下，一下","好吧……"],[function():void
               {
                  FightManager.startFightWithBoss(FIGHT_ID[index]);
               }]);
               break;
            case 2:
               NpcDialog.show(505,"帕拉丁",[[0,"守护魔盒是我之责任！"]],["对不住了！","我闪就是了"],[function():void
               {
                  FightManager.startFightWithBoss(FIGHT_ID[index]);
               }]);
         }
      }
      
      private function startTime() : void
      {
         Tick.instance.addRender(this.updateTime,1000);
      }
      
      private function updateTime(param1:uint) : void
      {
         --this.leftTime;
         this.timeTxt.text = DateUtil.getMS(this.leftTime);
         if(this.leftTime == 0)
         {
            Tick.instance.removeRender(this.updateTime);
         }
      }
   }
}
