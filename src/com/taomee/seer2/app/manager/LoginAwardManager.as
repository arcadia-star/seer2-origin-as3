package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.announcement.AnnouncementTime;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.RevenueInfo;
   import com.taomee.seer2.app.controls.GiftRemind;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class LoginAwardManager
   {
      
      private static var _loginData:uint;
      
      private static var _isewardShow:Boolean = false;
      
      private static const VIP_TIMES:uint = 2;
      
      private static const NOMARL_TIMES:uint = 1;
      
      private static const SUPER_PET_FOR:uint = 202957;
      
      private static const SUPER_PET_SWAP:int = 1632;
      
      private static const ASK_RANK_SWAP:int = 1622;
      
      private static const CUR_SIGN_DAY:int = 5018;
      
      private static const FOR_HAS_GET:uint = 250214;
      
      private static const FOR_LOGIN:uint = 250213;
      
      public static var isAskRankSwap:Boolean = false;
       
      
      public function LoginAwardManager()
      {
         super();
      }
      
      public static function isShowPanel(param1:uint) : void
      {
         _loginData = param1;
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         if(isNewGuide())
         {
            return;
         }
         showLoginReward();
         showConisActivityPanel();
         //showPhoneGamePanle();
         showAttentionPanel();
         KingFightTrialWinHandle();
         if(SceneManager.active.type == SceneType.LOBBY && SceneManager.prevSceneType != SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
            if(GlobalsManager.isRemoteLogin)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("RemoteLoginAlertPanel"),"正在打开异地登录警告面板...");
            }
         }
      }
      
      private static function showPhoneGamePanle() : void
      {
         var date:Date = null;
         ModuleManager.toggleModule(URLUtil.getAppModule("SeerShouyouPanel"),"正在打开...");
         date = new Date(TimeManager.getServerTime() * 1000);
         ServerBufferManager.getServerBuffer(ServerBufferType.SEER_PHONE_GAME_SHOW_PANEL2,function(param1:ServerBuffer):void
         {
            if(param1.readDataAtPostion(date.date) == 0)
            {
            }
         });
      }
      
      private static function showAttentionPanel() : void
      {
         ActiveCountManager.requestActiveCount(206230,function(param1:int, param2:int):void
         {
            if(param2 < 2)
            {
               ModuleManager.showAppModule("AttentionDesktopShotCutPanel");
            }
         });
      }
      
      private static function isNewGuide() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = new Date(2014,8,26).getTime() / 1000;
         if(ActorManager.actorInfo.createTime >= _loc2_)
         {
            if(NewPlayerGuideTimeManager.timeCheckNewGuide())
            {
               if(QuestManager.isCanAccepted(99) || QuestManager.isAccepted(99))
               {
                  _loc1_ = true;
               }
            }
            else if(QuestManager.isCanAccepted(83) || QuestManager.isAccepted(83))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private static function showVipOverTip() : void
      {
         ActiveCountManager.requestActiveCount(206029,function(param1:int, param2:int):void
         {
            if(VipManager.vipInfo.leftDay <= 10 && param2 <= 0)
            {
               ModuleManager.showAppModule("VipDeadlineTipPanel");
            }
         });
      }
      
      private static function showJLPanel() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.JL_BROAD_FIRST,function(param1:ServerBuffer):void
         {
            if(param1.readDataAtPostion(1) == 0)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("JLPanel"),"正在打开...");
               ServerBufferManager.updateServerBuffer(ServerBufferType.JL_BROAD_FIRST,1,1);
            }
         });
      }
      
      private static function showLoginOnePanel() : void
      {
         var date:Date = null;
         date = new Date(TimeManager.getServerTime() * 1000);
         ServerBufferManager.getServerBuffer(ServerBufferType.CHUANG_XIANG_SHOW_PANEL_17,function(param1:ServerBuffer):void
         {
            if(param1.readDataAtPostion(date.date) == 0)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("BroadCastSevenPanel"),"正在打开...");
               ServerBufferManager.updateServerBuffer(ServerBufferType.CHUANG_XIANG_SHOW_PANEL_17,date.date,1);
            }
         });
      }
      
      private static function showConisActivityPanel() : void
      {
         OnlyFlagManager.RequestFlag(function():void
         {
            if(OnlyFlagManager.getFlag(374) == 1)
            {
               if(OnlyFlagManager.getFlag(375) == 0)
               {
                  SwapManager.swapItem(258,1,function(param1:IDataInput):void
                  {
                     OnlyFlagManager.updataFlag(375,1);
                     new SwapInfo(param1);
                     ModuleManager.toggleModule(URLUtil.getAppModule("ActivityConis"),"正在打开赛尔豆大放送");
                  });
               }
            }
         });
      }
      
      private static function checkHotWheelTip() : void
      {
         ActiveCountManager.requestActiveCount(204880,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var count:uint = param2;
            if(type == 204880)
            {
               if(count > 0)
               {
                  ServerBufferManager.getServerBuffer(214,function(param1:ServerBuffer):void
                  {
                     if(param1.readDataAtPostion(10) == 0)
                     {
                        ModuleManager.showAppModule("HotWheelsVipTipPanel");
                        ServerBufferManager.updateServerBuffer(214,10,1);
                     }
                  });
               }
            }
         });
      }
      
      private static function checkTianZun() : void
      {
         ActiveCountManager.requestActiveCount(203664,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var count:uint = param2;
            if(type == 203664)
            {
               if(count > 0)
               {
                  ServerBufferManager.getServerBuffer(192,function(param1:ServerBuffer):void
                  {
                     if(param1.readDataAtPostion(0) == 0)
                     {
                        ModuleManager.showModule(URLUtil.getAppModule("TianZunNoticePanel"),"");
                        ServerBufferManager.updateServerBuffer(192,0,1);
                     }
                  });
               }
            }
         });
      }
      
      private static function showNewYearVip() : void
      {
      }
      
      private static function showLoginReward() : void
      {
         if(_isewardShow)
         {
            return;
         }
         AnnouncementTime.startRingerAnnoumce();
         playAnnouncementTime();
         GiftRemind.instance.stateHandle();
         checkHotWheelTip();
         if(isGrassSignTime())
         {
            DayLimitManager.getDoCount(724,function(param1:int):void
            {
               var num:int = param1;
               if(num == 0)
               {
                  ModuleManager.addEventListener("GoSchoolSignPanel",ModuleEvent.HIDE,onGrassSignHide);
                  ModuleManager.toggleModule(URLUtil.getAppModule("GoSchoolSignPanel"),"开学签到送超级精灵 ...");
               }
               else
               {
                  ActiveCountManager.requestActiveCount(203025,function(param1:uint, param2:uint):void
                  {
                     if(param1 == 203025 && param2 == 1 && ActorManager.actorInfo.vipInfo.isRealVip() == false)
                     {
                        GiftRemind.instance.startFirstRecharge();
                     }
                  });
               }
            });
         }
         setSuperPetInitNum();
         showGanEnAwardPanel();
         vipMonthBack();
         godFirePkAward();
         bestKingCatchAward();
      }
      
      private static function KingFightTrialWinHandle() : void
      {
         ActiveCountManager.requestActiveCount(250321,function(param1:int, param2:int):void
         {
            var type:int = param1;
            var val:int = param2;
            if(type == 250321)
            {
               if(val)
               {
                  PetInfoManager.addEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE,onPetExperenceChange);
                  PetExperenceHelper.startListen();
                  SwapManager.swapItem(4052,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                  });
               }
            }
         });
      }
      
      private static function onPetExperenceChange(param1:PetInfoEvent) : void
      {
         var _loc2_:RevenueInfo = null;
         var _loc3_:FightResultInfo = null;
         _loc2_ = param1.content.revenueInfo;
         _loc3_ = param1.content.resultInfo;
         PetInfoManager.removeEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE,onPetExperenceChange);
         if(_loc2_.fighterRevenueInfoVec.length > 0)
         {
            new FightResultPanelWrapper().show(PetInfoManager.getAllBagPetInfo(),_loc2_,_loc3_);
         }
      }
      
      private static function vipMonthBack() : void
      {
         ActiveCountManager.requestActiveCountList([250339,250337],function(param1:Parser_1142):void
         {
            if(param1.infoVec[0] == 0 && param1.infoVec[1] == 1)
            {
               ModuleManager.showAppModule("BackWriteCodePanel");
            }
            else
            {
               showNewYearVip();
               _isewardShow = true;
            }
         });
         if(VipManager.vipInfo.isRealVip())
         {
         }
      }
      
      private static function godFirePkAward() : void
      {
         ActiveCountManager.requestActiveCountList([250200,250233],function(param1:Parser_1142):void
         {
            if(param1.infoVec[0] > 0 && param1.infoVec[1] <= 0)
            {
               ModuleManager.showAppModule("GodFirePkAwardPanel");
            }
         });
      }
      
      private static function bestKingCatchAward() : void
      {
         ActiveCountManager.requestActiveCountList([250351,250431],function(param1:Parser_1142):void
         {
            if(param1.infoVec[0] > 0 && param1.infoVec[1] <= 0)
            {
               ModuleManager.showAppModule("BestKingCatchAwardPanel");
            }
         });
      }
      
      private static function showGanEnAwardPanel() : void
      {
         DayLimitManager.getDoCount(CUR_SIGN_DAY,function(param1:int):void
         {
            var num:int = param1;
            ActiveCountManager.requestActiveCountList([FOR_LOGIN,FOR_HAS_GET,205741],function(param1:Parser_1142):void
            {
               if(num <= 0)
               {
                  ModuleManager.showAppModule("WinterSignPanel");
               }
            });
         });
      }
      
      private static function setSuperPetInitNum() : void
      {
         if(!DateUtil.isInTime(new Date(2013,6,12,6),new Date(2013,7,29,21)))
         {
            return;
         }
         ActiveCountManager.requestActiveCount(SUPER_PET_FOR,function(param1:int, param2:int):void
         {
            var type:int = param1;
            var count:int = param2;
            if(count == 0)
            {
               SwapManager.swapItem(SUPER_PET_SWAP,1,function(param1:IDataInput):void
               {
                  var data:IDataInput = param1;
                  new SwapInfo(data);
                  SwapManager.swapItem(ASK_RANK_SWAP,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     isAskRankSwap = true;
                  });
               });
            }
            else
            {
               SwapManager.swapItem(ASK_RANK_SWAP,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  isAskRankSwap = true;
               });
            }
         });
      }
      
      private static function isWinterSignTime() : Boolean
      {
         var _loc1_:uint = new Date(2013,0,25,6).getTime() / 1000;
         var _loc2_:uint = new Date(2013,1,21,24).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc2_ && TimeManager.getServerTime() > _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private static function isGrassSignTime() : Boolean
      {
         var _loc1_:uint = new Date(2013,10,1,6).getTime() / 1000;
         var _loc2_:uint = new Date(2013,10,21,23).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc2_ && TimeManager.getServerTime() > _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private static function onGrassSignHide(param1:ModuleEvent) : void
      {
         var evt:ModuleEvent = param1;
         ModuleManager.removeEventListener("GoSchoolSignPanel",ModuleEvent.HIDE,onGrassSignHide);
         ActiveCountManager.requestActiveCount(203133,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var count:uint = param2;
            if(type == 203133 && ActorManager.actorInfo.vipInfo.isRealVip() == false)
            {
               if(count == 1)
               {
                  ModuleManager.addEventListener("VipRechargeBtnPanel",ModuleEvent.HIDE,function onVipRechargeHide(param1:ModuleEvent):void
                  {
                     ModuleManager.removeEventListener("VipRechargeBtnPanel",ModuleEvent.HIDE,onVipRechargeHide);
                     ModuleManager.showModule(URLUtil.getAppModule("FirstChargeGiveFullLevelPanel"),"正在打开首充送礼面板...");
                  });
                  ModuleManager.toggleModule(URLUtil.getAppModule("VipRechargeBtnPanel"));
               }
               else
               {
                  ModuleManager.showModule(URLUtil.getAppModule("FirstChargeGiveFullLevelPanel"),"正在打开首充送礼面板...");
               }
            }
         });
      }
      
      private static function playAnnouncementTime() : void
      {
         if(isActivityTime())
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.PLAY_ANNOUNCEMET,onGetBufferStatus);
         }
      }
      
      public static function isActivityTime() : Boolean
      {
         var _loc1_:uint = new Date(2012,0,19,6).getTime() / 1000;
         var _loc2_:uint = new Date(2012,0,19,24).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc2_ && TimeManager.getServerTime() > _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private static function onGetBufferStatus(param1:ServerBuffer) : void
      {
         var _loc2_:uint = uint(param1.readDataAtPostion(1));
         if(_loc2_ == 0)
         {
            AnnouncementTime.playAnnouncement("赛尔社最新消息：1月20日15:00至16:00，赛尔号空间传送过来的神秘新年礼物将会抵达赛尔号Ⅱ。");
            ServerBufferManager.updateServerBuffer(ServerBufferType.PLAY_ANNOUNCEMET,1,1);
         }
      }
   }
}
