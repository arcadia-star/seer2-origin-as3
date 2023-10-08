package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class MapProcessor_80138 extends MapProcessor
   {
       
      
      protected var fightId:uint = 0;
      
      public function MapProcessor_80138(param1:MapModel)
      {
         super(param1);
         this.fightId = 813;
      }
      
      override public function init() : void
      {
         this.check();
      }
      
      protected function check() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.getPositionIndex() == this.fightId)
         {
            AlertManager.showAlert("今天得挑战次数已经用尽，明天再来吧",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
            return;
         }
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.toFight);
      }
      
      protected function toFight(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "toFight")
         {
            FightManager.startFightWithBoss(this.fightId);
         }
      }
   }
}
