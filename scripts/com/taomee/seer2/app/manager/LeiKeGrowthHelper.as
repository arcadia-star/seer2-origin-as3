package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class LeiKeGrowthHelper
   {
      
      private static const FIRE_DRAGON_EGG_FLAG:int = 272;
      
      private static const FIRE_DRAGON_PET_FLAG:int = 273;
      
      private static const LOONG_DRAGON_FLAG:int = 358;
      
      private static const SWAP_INDEX:int = 200;
      
      private static const QUEST_ID:int = 30001;
      
      private static var _resLoadLib:ResourceLibraryLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/fireDragonEgg" + URLUtil.POSTFIX_SWF));
      
      private static var _mapModel:MapModel;
      
      private static var _eggMc:MovieClip;
       
      
      public function LeiKeGrowthHelper()
      {
         super();
      }
      
      public static function enterHome(param1:MapModel) : void
      {
         var mapModel:MapModel = param1;
         _mapModel = mapModel;
         OnlyFlagManager.RequestFlag(function():void
         {
            if(isTimeForLoong())
            {
               if(OnlyFlagManager.getFlag(LOONG_DRAGON_FLAG) == 1 && OnlyFlagManager.getFlag(FIRE_DRAGON_PET_FLAG) == 0)
               {
                  _resLoadLib.getLib(onResLoadLib);
               }
            }
            else if(OnlyFlagManager.getFlag(LOONG_DRAGON_FLAG) == 1 && OnlyFlagManager.getFlag(FIRE_DRAGON_PET_FLAG) == 0)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("CareFireDragonPanel"),"加载资源");
            }
            if(isTimeForLeike())
            {
               if(OnlyFlagManager.getFlag(FIRE_DRAGON_EGG_FLAG) == 1 && OnlyFlagManager.getFlag(FIRE_DRAGON_PET_FLAG) == 0)
               {
                  _resLoadLib.getLib(onResLoadLib);
               }
            }
            else if(OnlyFlagManager.getFlag(FIRE_DRAGON_EGG_FLAG) == 1)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("CareFireDragonPanel"),"加载资源");
            }
         });
      }
      
      private static function isTimeForLoong() : Boolean
      {
         var _loc1_:int = 2012;
         var _loc2_:int = 0;
         var _loc3_:int = 27;
         var _loc4_:int = 14;
         var _loc6_:int;
         var _loc5_:Date;
         return (_loc6_ = (_loc5_ = new Date(_loc1_,_loc2_,_loc3_,_loc4_)).time / DateUtil.MILLISECONDS_PER_SECOND) <= TimeManager.getServerTime();
      }
      
      public static function leaveHome() : void
      {
         _resLoadLib.cancel(true);
         if(_eggMc)
         {
            _eggMc.removeEventListener(Event.ENTER_FRAME,onEggMcEnter);
            _eggMc.removeEventListener(MouseEvent.CLICK,onEggmcClick);
         }
      }
      
      private static function isTimeForLeike() : Boolean
      {
         var _loc1_:int = 2012;
         var _loc2_:int = 0;
         var _loc3_:int = 1;
         var _loc4_:int = 14;
         var _loc6_:int;
         var _loc5_:Date;
         return (_loc6_ = (_loc5_ = new Date(_loc1_,_loc2_,_loc3_,_loc4_)).time / DateUtil.MILLISECONDS_PER_SECOND) <= TimeManager.getServerTime();
      }
      
      private static function onResLoadLib(param1:ResourceLibrary) : void
      {
         _eggMc = param1.getMovieClip("eggMc");
         _eggMc.x = 363;
         _eggMc.y = 230;
         _mapModel.content.addChild(_eggMc);
         _eggMc.addEventListener(Event.ENTER_FRAME,onEggMcEnter);
         _eggMc.gotoAndPlay(1);
      }
      
      private static function onEggMcEnter(param1:Event) : void
      {
         switch(_eggMc.currentFrameLabel)
         {
            case "end":
               _eggMc.gotoAndPlay(ActorManager.actorInfo.sex == 0 ? "dad_start" : "mom_start");
               break;
            case "dad_end":
            case "mom_end":
               _eggMc.removeEventListener(Event.ENTER_FRAME,onEggMcEnter);
               _eggMc.stop();
               DisplayObjectUtil.enableButtonMode(_eggMc);
               _eggMc.addEventListener(MouseEvent.CLICK,onEggmcClick);
         }
      }
      
      private static function onEggmcClick(param1:MouseEvent) : void
      {
         DisplayObjectUtil.disableButtonMode(_eggMc);
         showGetLeikeDialog();
      }
      
      private static function showGetLeikeDialog() : void
      {
         NpcDialog.show(458,"雷克",[[0,ActorManager.actorInfo.sex == 0 ? "爸爸，爸爸……" : "妈妈，妈妈……"]],["（冒汗……）"],[function():void
         {
            NpcDialog.show(458,"雷克",[[2,"咕噜噜~~~~~~饿了……呜哇~~~~>_<~~~~~"]],["晕倒……"],[function():void
            {
               NpcDialog.show(11,"多罗",[[1,"哈哈哈，队长，这个爱哭鬼叫你" + (ActorManager.actorInfo.sex == 0 ? "爸爸" : "妈妈") + "呀！"]],["头疼，带上这家伙，去问问伊娃博士吧！"],[function():void
               {
                  DisplayObjectUtil.removeFromParent(_eggMc);
                  SwapManager.swapItem(SWAP_INDEX,1,onSwapSuccess);
               }]);
            }]);
         }]);
      }
      
      private static function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         QuestManager.acceptQuestLocal(QUEST_ID);
      }
   }
}
