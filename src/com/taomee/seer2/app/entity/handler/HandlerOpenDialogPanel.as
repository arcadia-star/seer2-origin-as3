package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.npc.NpcEvent;
   import com.taomee.seer2.app.npc.NpcManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.sound.NpcSoundManager;
   
   public class HandlerOpenDialogPanel extends HandlerEntityClick
   {
       
      
      public function HandlerOpenDialogPanel()
      {
         super();
      }
      
      override public function initData(param1:XML) : void
      {
      }
      
      override protected function action() : void
      {
         NpcManager.dispatchEvent(NpcEvent.ACTOR_ARRIVE,_entityDefinition as NpcDefinition);
         var _loc1_:NpcDefinition = _entityDefinition as NpcDefinition;
         DialogPanel.showForNpc(_loc1_);
         NpcSoundManager.playNpcSound(_loc1_.id);
      }
   }
}
