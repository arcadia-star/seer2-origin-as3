package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class Processor_2 extends ArenaProcessor
   {
       
      
      public function Processor_2(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_TURN_START_2,this.processor);
      }
      
      override public function processor(param1:MessageEvent) : void
      {
         fightController.arenaUIController.startSelectOperate();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.FIGHT_TURN_START_2,this.processor);
      }
   }
}
