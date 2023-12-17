package com.taomee.seer2.app.actives
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ZhuQueProcessAct
   {
      
      private static const DAY_LIST:Array = [1297];
      
      public static const ZHUQUE_BUY_BOMB_COMPLETE:String = "zhuQue_buy_bomb_complete";
      
      public static const ZHUQUE_BUY_WIN_BOSS:String = "zhuQue_buy_win_boss";
      
      public static const ZHUQUE_WIN_LEAVE:String = "zhuQue_win_leave";
      
      public static const ZHUQUE_FAIL_LEAVE:String = "zhuQue_fail_leave";
      
      private static const FIGHT_NUM:Vector.<int> = Vector.<int>([4,6]);
      
      private static const MAX_NUM:uint = 12;
      
      private static const GUARD_ID:uint = 667;
      
      private static const BOSS_ID:uint = 810;
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1175,1176]);
      
      private static const BOSS_SEAT:Point = new Point(442,425);
      
      private static const GUARD_SEAT:Array = [new Point(250,235),new Point(460,260),new Point(570,280),new Point(760,260),new Point(830,330),new Point(830,400),new Point(430,515),new Point(540,510),new Point(340,330),new Point(350,420),new Point(540,390),new Point(630,365)];
      
      private static const MODULE_LIST:Vector.<String> = Vector.<String>(["ZhuQueKillMonsterPanel","ZhuQueFightFailPanel","ZhuQueFightWinPanel"]);
      
      private static var _guardKilledList:Vector.<int> = Vector.<int>([]);
      
      private static var _selectGuardIndex:int;
       
      
      private var _resLib:ResourceLibrary;
      
      private var map:MapModel;
      
      private var boxBtn:SimpleButton;
      
      private var bombBtn:SimpleButton;
      
      private var mapBombBtn:SimpleButton;
      
      private var eftList:Vector.<MovieClip>;
      
      private var fight_state:uint;
      
      private var guard_list:Vector.<Mobile>;
      
      private var boss_npc:Mobile;
      
      private var eft_mobile_list:Array;
      
      public function ZhuQueProcessAct()
      {
         super();
      }
      
      public function setup() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         this.map = SceneManager.active.mapModel;
         this.boxBtn = this.map.front["boxBtn"];
         this.bombBtn = this.map.front["bombBtn"];
         FishEventDispatcher.getInstance().addEventListener(ZHUQUE_BUY_BOMB_COMPLETE,this.buyBombComplete);
         FishEventDispatcher.getInstance().addEventListener(ZHUQUE_BUY_WIN_BOSS,this.buyWinBoss);
         FishEventDispatcher.getInstance().addEventListener(ZHUQUE_WIN_LEAVE,this.winLeave);
         FishEventDispatcher.getInstance().addEventListener(ZHUQUE_FAIL_LEAVE,this.failLeave);
         this.updateData();
      }
      
      private function updateData() : void
      {
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            fight_state = param1.getCount(DAY_LIST[0]);
            boxBtn.addEventListener(MouseEvent.CLICK,showBox);
            bombBtn.addEventListener(MouseEvent.CLICK,showBombPane);
            if(fight_state >= MAX_NUM)
            {
               bombBtn.visible = false;
               _guardKilledList = Vector.<int>([]);
               if(SceneManager.prevSceneType == SceneType.ARENA)
               {
                  if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[0])
                  {
                     createBoss();
                  }
                  if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[1])
                  {
                     if(FightManager.fightWinnerSide == FightSide.LEFT)
                     {
                        ModuleManager.showAppModule(MODULE_LIST[2]);
                     }
                     else
                     {
                        createBoss();
                        ModuleManager.showAppModule(MODULE_LIST[1]);
                     }
                  }
               }
               else
               {
                  createBoss();
               }
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[0])
               {
                  if(FightManager.fightWinnerSide == FightSide.LEFT)
                  {
                     _guardKilledList.push(_selectGuardIndex);
                  }
                  createGuard();
                  createBoss();
               }
               if(FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[1])
               {
                  if(FightManager.fightWinnerSide == FightSide.LEFT)
                  {
                     _guardKilledList = Vector.<int>([]);
                     ModuleManager.showAppModule(MODULE_LIST[2]);
                  }
                  else
                  {
                     createBoss();
                     ModuleManager.showAppModule(MODULE_LIST[1]);
                  }
               }
            }
            else
            {
               createGuard();
               createBoss();
            }
         });
      }
      
      private function createBoss() : void
      {
         if(this.boss_npc)
         {
            return;
         }
         this.boss_npc = new Mobile();
         this.boss_npc.x = BOSS_SEAT.x;
         this.boss_npc.y = BOSS_SEAT.y;
         this.boss_npc.buttonMode = true;
         this.boss_npc.mouseChildren = false;
         this.boss_npc.resourceUrl = URLUtil.getNpcSwf(BOSS_ID);
         this.boss_npc.addEventListener(MouseEvent.CLICK,this.clickBoss);
         MobileManager.addMobile(this.boss_npc,MobileType.NPC);
      }
      
      private function clearBoss() : void
      {
         if(this.boss_npc)
         {
            this.boss_npc.removeEventListener(MouseEvent.CLICK,this.clickBoss);
            DisplayObjectUtil.removeFromParent(this.boss_npc);
            this.boss_npc = null;
         }
      }
      
      private function createGuard() : void
      {
         this.guard_list = new Vector.<Mobile>();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < MAX_NUM)
         {
            this.guard_list.push(null);
            if(_loc1_ < MAX_NUM - this.fight_state && _guardKilledList.indexOf(_loc2_) == -1)
            {
               this.guard_list[_loc2_] = new Mobile();
               this.guard_list[_loc2_].x = GUARD_SEAT[_loc2_].x;
               this.guard_list[_loc2_].y = GUARD_SEAT[_loc2_].y;
               this.guard_list[_loc2_].buttonMode = true;
               this.guard_list[_loc2_].mouseChildren = false;
               this.guard_list[_loc2_].resourceUrl = URLUtil.getNpcSwf(GUARD_ID);
               this.guard_list[_loc2_].addEventListener(MouseEvent.CLICK,this.onGuardClick);
               MobileManager.addMobile(this.guard_list[_loc2_],MobileType.NPC);
               _loc1_++;
            }
            _loc2_++;
         }
      }
      
      private function clearGuard() : void
      {
         var _loc1_:Mobile = null;
         for each(_loc1_ in this.guard_list)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onGuardClick);
            }
            DisplayObjectUtil.removeFromParent(_loc1_);
         }
         this.guard_list = null;
      }
      
      private function onGuardClick(param1:MouseEvent) : void
      {
         _selectGuardIndex = this.guard_list.indexOf(param1.currentTarget as Mobile);
         FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
      }
      
      private function showBombPane(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule(MODULE_LIST[0]);
      }
      
      private function showBox(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
      }
      
      private function clickBoss(param1:MouseEvent) : void
      {
         if(this.fight_state != MAX_NUM)
         {
            NpcDialog.show(BOSS_ID,"神兽•朱雀",[[0,"吾乃神兽•朱雀，想挑战我，请先击败我的12只守护精灵吧！"]],["谁怕谁！这就去！"]);
         }
         else
         {
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[1]);
         }
      }
      
      private function buyBombComplete(param1:Event) : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("ZhuQueEft"),LoadType.DOMAIN,this.onLoadComplete);
      }
      
      private function winLeave(param1:Event) : void
      {
         var evt:Event = param1;
         this.clearBoss();
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(2,function():void
         {
            ModuleManager.showAppModule("ZhuQueProcessActPanel");
         });
      }
      
      private function failLeave(param1:Event) : void
      {
         var evt:Event = param1;
         this.clearBoss();
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(2,function():void
         {
            ModuleManager.showAppModule("ZhuQueProcessActPanel");
         });
      }
      
      private function buyWinBoss(param1:Event) : void
      {
         var evt:Event = param1;
         this.clearBoss();
         ServerMessager.addMessage("恭喜完成挑战哦!");
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(2,function():void
         {
            ModuleManager.showAppModule("ZhuQueProcessActPanel");
         });
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         var _loc4_:MovieClip = null;
         this._resLib = new ResourceLibrary(param1.content);
         this.eftList = new Vector.<MovieClip>();
         this.eft_mobile_list = [];
         var _loc2_:int = 0;
         while(_loc2_ < MAX_NUM)
         {
            if(this.guard_list[_loc2_])
            {
               (_loc4_ = this._resLib.getMovieClip("ZhuQueEft")).x = GUARD_SEAT[_loc2_].x;
               _loc4_.y = GUARD_SEAT[_loc2_].y;
               this.map.content.addChild(_loc4_);
               this.eftList.push(_loc4_);
               this.eft_mobile_list.push(this.guard_list[_loc2_]);
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.eftList.length)
         {
            MovieClipUtil.playMc(this.eftList[_loc3_],1,this.eftList[_loc3_].totalFrames,this.playComplete);
            _loc3_++;
         }
      }
      
      private function playComplete() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.eftList.length)
         {
            if(Boolean(this.eftList[_loc1_].parent) && this.eftList[_loc1_].currentFrame == this.eftList[_loc1_].totalFrames)
            {
               DisplayObjectUtil.removeFromParent(this.eftList[_loc1_]);
               MobileManager.removeMobile(this.eft_mobile_list[_loc1_],MobileType.NPC);
               break;
            }
            _loc1_++;
         }
         this.fight_state = 12;
         _guardKilledList = Vector.<int>([]);
         this.createBoss();
      }
      
      public function dispose() : void
      {
         FishEventDispatcher.getInstance().removeEventListener(ZHUQUE_BUY_BOMB_COMPLETE,this.buyBombComplete);
         FishEventDispatcher.getInstance().removeEventListener(ZHUQUE_BUY_WIN_BOSS,this.buyWinBoss);
         FishEventDispatcher.getInstance().removeEventListener(ZHUQUE_WIN_LEAVE,this.winLeave);
         FishEventDispatcher.getInstance().removeEventListener(ZHUQUE_FAIL_LEAVE,this.failLeave);
         this.clearGuard();
         this.clearBoss();
         if(this.boxBtn)
         {
            this.boxBtn.removeEventListener(MouseEvent.CLICK,this.showBox);
            this.boxBtn = null;
         }
         if(this.bombBtn)
         {
            this.bombBtn.removeEventListener(MouseEvent.CLICK,this.showBombPane);
            this.bombBtn = null;
         }
      }
   }
}
