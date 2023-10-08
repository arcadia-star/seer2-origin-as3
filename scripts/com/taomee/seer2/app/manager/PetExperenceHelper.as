package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.RevenueInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class PetExperenceHelper
   {
      
      public static const SPLIT_VALUE:int = 100;
      
      public static const HOME_TRAIN:int = 101;
      
      public static const ITEM_USE:int = 102;
      
      public static const VIP_TRAIN:int = 103;
      
      public static const INIT_PET_TRAIN:int = 104;
      
      public static const LEIKE_QUEST:int = 105;
      
      public static const BRANCH_EVOLVE:int = 106;
      
      public static const MAIN_TASK_REWARD:int = 107;
      
      public static const HOOK:int = 109;
      
      private static var _revenueInfo:RevenueInfo;
      
      private static var _resultInfo:FightResultInfo;
       
      
      public function PetExperenceHelper()
      {
         super();
      }
      
      public static function startListen() : void
      {
         _revenueInfo = null;
         _resultInfo = null;
         Connection.addCommandListener(CommandSet.FIGHT_GET_REVENUE_5,onGetRevenue);
         Connection.addCommandListener(CommandSet.FIGHT_END_1507,onGetFightResult);
      }
      
      public static function stopListen() : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5,onGetRevenue);
         Connection.removeCommandListener(CommandSet.FIGHT_END_1507,onGetFightResult);
      }
      
      private static function onGetRevenue(param1:MessageEvent) : void
      {
         if(SceneManager.currentSceneType == SceneType.ARENA)
         {
            return;
         }
         _revenueInfo = new RevenueInfo(param1.message.getRawData());
         check();
      }
      
      private static function onGetFightResult(param1:MessageEvent) : void
      {
         if(SceneManager.currentSceneType == SceneType.ARENA)
         {
            return;
         }
         _resultInfo = new FightResultInfo(param1.message.getRawData());
         check();
      }
      
      private static function check() : void
      {
         if(_resultInfo)
         {
            if(_resultInfo.endReason == MAIN_TASK_REWARD)
            {
               PetInfoManager.dispatchEvent(PetInfoEvent.PET_LEVEL_UP,null,{
                  "resultInfo":_resultInfo,
                  "revenueInfo":_revenueInfo
               });
            }
            else if(_resultInfo.endReason == HOOK)
            {
               PetInfoManager.dispatchEvent(PetInfoEvent.HOOK_PET_EXPERENCE_CHANGE,null,{
                  "resultInfo":_resultInfo,
                  "revenueInfo":_revenueInfo
               });
            }
            else if(_resultInfo.endReason == BRANCH_EVOLVE || _revenueInfo != null)
            {
               PetInfoManager.dispatchEvent(PetInfoEvent.PET_EXPERENCE_CHANGE,null,{
                  "resultInfo":_resultInfo,
                  "revenueInfo":_revenueInfo
               });
            }
            _revenueInfo = null;
            _resultInfo = null;
         }
      }
   }
}
