package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.util.FightEndReason;
   import com.taomee.seer2.app.arena.util.FightState;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.sound.SoundManager;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class Processor_1507 extends ArenaProcessor
   {
       
      
      private var _intervalIndex:uint = 0;
      
      public function Processor_1507(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_END_1507,this.processor);
      }
      
      override public function processor(param1:MessageEvent) : void
      {
         if(_secne.arenaData.isDoubleMode)
         {
            ArenaAnimationManager.hideIndiator();
         }
         ArenaAnimationManager.abortCountDown();
         arenaUIController.updateStatusPanel();
         _secne.arenaData.isFightEnd = true;
         ArenaAnimationManager.hideWaiting();
         var _loc2_:FightResultInfo = new FightResultInfo(param1.message.getRawData());
         fightController.resultInfo = _loc2_;
         _loc2_.updateWinnerSider(_secne.fightMode,fightController.leftTeam,fightController.rightTeam);
         if(FightManager.currentFightRecord != null)
         {
            FightManager.currentFightRecord.endReason = _loc2_.endReason;
            FightManager.currentFightRecord.fightResult = _loc2_.showWinnerSider;
         }
         var _loc3_:Function = fightController.exitFight;
         var _loc4_:String;
         if((_loc4_ = fightController.state) == FightState.ESCAPE)
         {
            AlertManager.showAutoCloseAlert("逃跑成功",1,_loc3_);
            SoundManager.backgroundSoundEnabled = true;
            return;
         }
         if(_loc4_ == FightState.CATCH_FIGHTER_SUCCESS || _loc4_ == FightState.CATCH_FIGHTER_FAILED)
         {
            return;
         }
         if(_loc4_ == FightState.OPPOSITE_ESCAPE)
         {
            if(Processor_1031.CATCHING)
            {
               this._intervalIndex = setInterval(this.catchOver,1000);
            }
            else
            {
               AlertManager.showAutoCloseAlert("对手已逃跑",3,fightController.exitFight);
            }
            return;
         }
         if(_loc2_.endReason == FightEndReason.TIME_OUT_END)
         {
            AlertManager.showAutoCloseAlert("战斗超时结束",3,_loc3_);
            return;
         }
         fightController.parseTurnResult();
      }
      
      private function catchOver() : void
      {
         if(!Processor_1031.CATCHING)
         {
            clearInterval(this._intervalIndex);
            AlertManager.showAutoCloseAlert("对手已逃跑",3,fightController.exitFight);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.FIGHT_END_1507,this.processor);
      }
   }
}
