package com.taomee.seer2.app.arena.cmd
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   
   public class UseSkillCMD implements IArenaBaseCMD
   {
       
      
      private var _operateId:uint;
      
      public function UseSkillCMD(param1:uint)
      {
         super();
         this._operateId = param1;
      }
      
      public function init() : void
      {
      }
      
      public function send() : void
      {
         Connection.send(CommandSet.FIGHT_USE_SKILL_1502,this._operateId);
      }
      
      public function dispose() : void
      {
      }
   }
}
