package com.taomee.seer2.app.processor.activity.nextyearActivity
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class ActivityFriend
   {
      
      private static var _isWin:Boolean;
      
      private static var _isNoWin:Boolean;
       
      
      private var _map:MapModel;
      
      public function ActivityFriend(param1:MapModel)
      {
         super();
         this._map = param1;
         this.getFightCount();
      }
      
      private function getFightCount() : void
      {
         this.initFight();
      }
      
      private function initFight() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               if(_isNoWin == false)
               {
                  this.showGame();
               }
            }
            else if(_isWin)
            {
               NpcDialog.show(462,"提灯怪灵",[[0,"尼古尼古……福文已经派送完了，明天继续吧！"]],["（好友基地每天派送10张）"]);
            }
            this.getHomeInfo();
         }
         else
         {
            this.getHomeInfo();
         }
      }
      
      private function getHomeInfo() : void
      {
         if((SceneManager.active as HomeScene).homeInfo == null)
         {
            return;
         }
         if((SceneManager.active as HomeScene).homeInfo.nextyearActivityInfo == null)
         {
            return;
         }
         if((SceneManager.active as HomeScene).homeInfo.nextyearActivityInfo.noWinCount >= 10)
         {
            _isNoWin = true;
         }
         else
         {
            _isNoWin = false;
         }
         if((SceneManager.active as HomeScene).homeInfo.nextyearActivityInfo.winCount >= 10)
         {
            _isWin = true;
         }
         else
         {
            _isWin = false;
         }
      }
      
      private function showGame() : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NextyearActivityGamePanel"),"正在加载春节交互...");
      }
      
      public function dispose() : void
      {
         this._map = null;
      }
   }
}
