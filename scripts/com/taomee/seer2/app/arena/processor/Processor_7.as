package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.util.FightState;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class Processor_7 extends ArenaProcessor
   {
       
      
      public function Processor_7(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_NEXT_TURN_7,this.processor);
      }
      
      override public function processor(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedByte());
         _secne.arenaData.turnCount = _loc3_;
         var _loc4_:uint = uint(_loc2_.readUnsignedByte());
         _secne.updateWeather(_loc4_);
         var _loc5_:String = fightController.state;
         ArenaAnimationManager.abortCountDown();
         ArenaAnimationManager.hideWaiting();
         if(_loc5_ == FightState.CHANGE_LEFT_FIGHTER)
         {
            return;
         }
         if(_loc5_ == FightState.CATCH_FIGHTER_FAILED)
         {
            return;
         }
         fightController.parseTurnResult();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.FIGHT_NEXT_TURN_7,this.processor);
      }
   }
}
