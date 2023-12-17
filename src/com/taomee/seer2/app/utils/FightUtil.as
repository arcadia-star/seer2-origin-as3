package com.taomee.seer2.app.utils
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class FightUtil
   {
      
      private static var _fightId:int;
      
      private static var _callBack:Function;
       
      
      public function FightUtil()
      {
         super();
      }
      
      public static function startFight(param1:int, param2:Function) : void
      {
         _fightId = param1;
         _callBack = param2;
         FightManager.startFightWithWild(param1);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onFightOver);
      }
      
      private static function onFightOver(param1:* = null) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(_fightId == FightManager.currentFightRecord.initData.positionIndex)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onFightOver);
               if(_callBack != null)
               {
                  _callBack();
               }
            }
         }
      }
   }
}
