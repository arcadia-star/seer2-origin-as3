package com.taomee.seer2.app.processor.map.diceThing.chance
{
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.miniGame.MiniGameEvent;
   import com.taomee.seer2.app.miniGame.MiniGameManager;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class HotRockThing extends ChanceThing
   {
       
      
      public function HotRockThing(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override protected function setUpGame(param1:MouseEvent) : void
      {
         super.setUpGame(param1);
         ModuleManager.toggleModule(URLUtil.getAppModule("VipMiniGamePanel"),"正在打开vip小游戏...",{"gameId":20});
         MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME,this.onGameOverHandler);
      }
      
      private function onGameOverHandler(param1:MiniGameEvent) : void
      {
         if(param1.gameInfo.score >= 10000)
         {
            eventInfo.moveTile = 2;
         }
         else if(param1.gameInfo.score >= 5000)
         {
            eventInfo.moveTile = 1;
         }
         else
         {
            eventInfo.moveTile = 0;
         }
         this.dispatchEvent(new DiceThingEvent(DiceThingEvent.DICE_THING_OVER,eventInfo));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME,this.onGameOverHandler);
      }
   }
}
