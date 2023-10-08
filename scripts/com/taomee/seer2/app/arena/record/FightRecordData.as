package com.taomee.seer2.app.arena.record
{
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.FightSide;
   
   public class FightRecordData
   {
      
      public static const FIGHT_WILD:String = "fightWild";
      
      public static const FIGHT_TRAINER:String = "fightTrainer";
      
      public static const FIGHT_BOSS:String = "fightBoss";
      
      public static const FIGHT_MINI_BOSS:String = "fightMiniBoss";
      
      public static const FIGHT_GUDIE:String = "fightGudie";
      
      public static const FIGHT_PVP_WOHOO:String = "fightPVPWohoo";
      
      public static const FIGHT_PVP_TRAINER:String = "fightPVPTrainer";
      
      public static const FIGHT_PVP:String = "fightPVP";
       
      
      public var fightUniqueID:Number;
      
      public var fightResult:uint;
      
      public var endReason:uint;
      
      public var initData:Object;
      
      public var btnPanelData:ButtonPanelData;
      
      public function FightRecordData(param1:Number, param2:Object, param3:ButtonPanelData)
      {
         super();
         this.fightUniqueID = param1;
         this.initData = param2;
         this.btnPanelData = param3;
      }
      
      public function isWinWar() : Boolean
      {
         return this.fightResult == FightSide.LEFT;
      }
   }
}
