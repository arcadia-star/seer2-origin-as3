package com.taomee.seer2.app.rarePet.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.rarePet.RarePetManager;
   import com.taomee.seer2.app.rarePet.config.RarePetConfig;
   import com.taomee.seer2.app.rarePet.event.RarePetEvent;
   import com.taomee.seer2.app.rarePet.info.RarePetInfo;
   import com.taomee.seer2.core.scene.SceneManager;
   
   public class RarePetProcessor_453 extends BaseRarePetProcessor
   {
       
      
      public function RarePetProcessor_453(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.active.mapID == _mapId)
         {
            DialogPanel.addCloseEventListener(this.fightNpc);
            RarePetManager.addEventListener(RarePetEvent.START_TIME_UP,this.onRarePetShow);
            if(RarePetManager.isInTimeRange(RarePetConfig.getRarePetInfo(_npcId)) != 0)
            {
               showNPC();
            }
            else
            {
               hideNPC();
            }
         }
      }
      
      private function fightNpc(param1:DialogCloseEvent) : void
      {
         var info:RarePetInfo = null;
         var evt:DialogCloseEvent = param1;
         if(int(evt.params) != _npcId)
         {
            return;
         }
         info = RarePetConfig.getRarePetInfo(_npcId);
         if(info != null)
         {
            DayLimitManager.getDoCount(info.DayLimitType,function(param1:int):void
            {
               if(param1 < info.DayMaxNum)
               {
                  FightManager.startFightWithWild(info.index);
               }
               else
               {
                  NpcDialog.show(info.id,info.name,[[0,"虽然我很想和你再比试，不过现在有点累了明天再来吧！"]],["好吧"]);
               }
            });
         }
      }
      
      private function onRarePetShow(param1:RarePetEvent) : void
      {
         showNPC();
      }
      
      override public function processMapDispose() : void
      {
         if(SceneManager.active.mapID == _mapId)
         {
            DialogPanel.removeCloseEventListener(this.fightNpc);
            RarePetManager.removeEventListener(RarePetEvent.START_TIME_UP,this.onRarePetShow);
         }
         super.processMapDispose();
      }
   }
}
