package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_780 extends MapProcessor
   {
      
      private static const NPC_ID_50:uint = 59;
      
      private static const NPC_ID_40:uint = 58;
      
      private static const NPC_ID_30:uint = 57;
       
      
      public function MapProcessor_780(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onStartFight);
      }
      
      private function onStartFight(param1:DialogPanelEvent) : void
      {
         var _loc2_:String = (param1.content as DialogPanelEventData).params;
         var _loc3_:ButtonPanelData = new ButtonPanelData();
         _loc3_.catchEnabled = false;
         switch(_loc2_)
         {
            case "fight_npc_780_50":
               FightManager.startFightBinaryWild(NPC_ID_50,null,null,_loc3_);
               break;
            case "fight_npc_780_40":
               FightManager.startFightBinaryWild(NPC_ID_40,null,null,_loc3_);
               break;
            case "fight_npc_780_30":
               FightManager.startFightBinaryWild(NPC_ID_30,null,null,_loc3_);
         }
      }
      
      override public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onStartFight);
         super.dispose();
      }
   }
}
