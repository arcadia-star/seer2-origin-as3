package com.taomee.seer2.app.arena.processor
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class Processor_18 extends ArenaProcessor
   {
       
      
      public function Processor_18(param1:ArenaScene)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         Connection.addCommandListener(CommandSet.FIT_CHANGE_HP_POS_18,this.processor);
         Connection.blockCommand(CommandSet.FIT_CHANGE_HP_POS_18);
      }
      
      override public function processor(param1:MessageEvent) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Fighter = null;
         var _loc9_:Fighter = null;
         var _loc12_:SkillInfo = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc10_:int = 0;
         while(_loc10_ < _loc3_)
         {
            _loc4_ = uint(_loc2_.readUnsignedInt());
            _loc5_ = uint(_loc2_.readUnsignedInt());
            _loc6_ = uint(_loc2_.readUnsignedInt());
            (_loc8_ = _secne.arenaData.getFighter(_loc4_,_loc5_)).fighterInfo.hp = _loc6_;
            if(FitConfig.isPetFit(_loc8_.fighterInfo.bunchId))
            {
               _loc9_ = _loc8_;
            }
            _loc10_++;
         }
         var _loc11_:uint = uint(_loc2_.readUnsignedInt());
         var _loc13_:Vector.<SkillInfo> = Vector.<SkillInfo>([]);
         var _loc14_:int = 0;
         while(_loc14_ < _loc11_)
         {
            _loc12_ = new SkillInfo(_loc2_.readUnsignedInt());
            _loc13_.push(_loc12_);
            _loc14_++;
         }
         if(_loc11_ != 0)
         {
            _loc9_.fighterInfo.setSkillList(_loc13_);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.FIT_CHANGE_HP_POS_18,this.processor);
      }
   }
}
