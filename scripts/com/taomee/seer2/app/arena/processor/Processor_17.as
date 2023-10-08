package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.data.PvpFightChangeInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.utils.IDataInput;
   
   public class Processor_17 extends ArenaProcessor
   {
       
      
      public function Processor_17(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         Connection.addCommandListener(CommandSet.PVP_FIGHT_NOTIFY_MON_POS_17,this.processor);
      }
      
      override public function processor(param1:MessageEvent) : void
      {
         var _loc6_:PvpFightChangeInfo = null;
         var _loc7_:ArenaScene = null;
         var _loc8_:Fighter = null;
         var _loc9_:PvpFightChangeInfo = null;
         var _loc10_:ArenaScene = null;
         var _loc11_:Fighter = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            (_loc6_ = new PvpFightChangeInfo()).user_id = _loc2_.readUnsignedInt();
            _loc6_.catch_time = _loc2_.readUnsignedInt();
            _loc6_.anger = _loc2_.readUnsignedInt();
            _loc6_.position = _loc4_ + 1;
            fightController.addPvpFightInfo(_loc6_);
            _loc8_ = (_loc7_ = SceneManager.active as ArenaScene).arenaData.getFighter(_loc6_.user_id,_loc6_.catch_time);
            _loc4_++;
         }
         _loc3_ = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            (_loc9_ = new PvpFightChangeInfo()).user_id = _loc2_.readUnsignedInt();
            _loc9_.catch_time = _loc2_.readUnsignedInt();
            _loc9_.anger = _loc2_.readUnsignedInt();
            _loc9_.position = _loc5_ + 1;
            fightController.addPvpFightInfo(_loc9_);
            _loc11_ = (_loc10_ = SceneManager.active as ArenaScene).arenaData.getFighter(_loc9_.user_id,_loc9_.catch_time);
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.PVP_FIGHT_NOTIFY_MON_POS_17,this.processor);
      }
   }
}
