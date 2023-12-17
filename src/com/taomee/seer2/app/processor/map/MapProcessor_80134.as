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
   
   public class MapProcessor_80134 extends MapProcessor
   {
       
      
      public function MapProcessor_80134(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.getPositionIndex() == 812)
         {
            AlertManager.showAlert("你今天的挑战次数用完了，明天继续吧！",function():void
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
            FightManager.startFightWithBoss(812);
         }
      }
   }
}
