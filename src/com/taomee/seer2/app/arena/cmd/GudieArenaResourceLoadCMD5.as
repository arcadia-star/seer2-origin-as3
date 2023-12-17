package com.taomee.seer2.app.arena.cmd
{
   import com.taomee.seer2.app.arena.data.ArenaDataInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.data.TeamInfo;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import flash.utils.ByteArray;
   
   public class GudieArenaResourceLoadCMD5 implements IArenaBaseCMD
   {
       
      
      private var _arenaData:ArenaDataInfo;
      
      private var _onGetInfoComplete:Function;
      
      public function GudieArenaResourceLoadCMD5(param1:ArenaDataInfo, param2:Function)
      {
         super();
         this._arenaData = param1;
         this._onGetInfoComplete = param2;
      }
      
      public function init() : void
      {
      }
      
      public function send() : void
      {
         var _loc3_:SkillInfo = null;
         var _loc4_:ByteArray = null;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeByte(1);
         _loc1_.writeByte(1);
         _loc1_.writeUnsignedInt(50233);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(50233);
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes("233");
         _loc2_.length = 16;
         _loc1_.writeBytes(_loc2_,0,16);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(20);
         _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().resourceId);
         _loc1_.writeByte(1);
         _loc1_.writeShort(PetInfoManager.getFirstPetInfo().level);
         _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().hp);
         _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().maxHp);
         _loc1_.writeUnsignedInt(PetInfoManager.getFirstPetInfo().skillInfo.skillInfoVec.length);
         for each(_loc3_ in PetInfoManager.getFirstPetInfo().skillInfo.skillInfoVec)
         {
            _loc1_.writeUnsignedInt(_loc3_.id);
         }
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeByte(2);
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(0);
         (_loc4_ = new ByteArray()).writeUTFBytes("XXX");
         _loc4_.length = 16;
         _loc1_.writeBytes(_loc4_,0,16);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(2);
         _loc1_.writeUnsignedInt(20);
         _loc1_.writeUnsignedInt(21);
         _loc1_.writeByte(1);
         _loc1_.writeShort(5);
         _loc1_.writeUnsignedInt(10);
         _loc1_.writeUnsignedInt(100);
         _loc1_.writeUnsignedInt(5);
         _loc1_.writeUnsignedInt(10101);
         _loc1_.writeUnsignedInt(10102);
         _loc1_.writeUnsignedInt(10103);
         _loc1_.writeUnsignedInt(10104);
         _loc1_.writeUnsignedInt(10105);
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeByte(0);
         _loc1_.writeByte(0);
         this.onGetResourceInfo(_loc1_);
      }
      
      private function onGetResourceInfo(param1:ByteArray) : void
      {
         param1.position = 0;
         this._arenaData.fightMode = param1.readUnsignedByte();
         var _loc2_:TeamInfo = new TeamInfo(param1,this._arenaData.fightMode);
         var _loc3_:TeamInfo = new TeamInfo(param1,this._arenaData.fightMode);
         if(_loc2_.clientSide == FightSide.LEFT)
         {
            this._arenaData.leftTeam = new FighterTeam(_loc2_);
            this._arenaData.rightTeam = new FighterTeam(_loc3_);
         }
         else
         {
            this._arenaData.rightTeam = new FighterTeam(_loc2_);
            this._arenaData.leftTeam = new FighterTeam(_loc3_);
         }
         if(this._arenaData.leftTeam.subFighterInfo != null || this._arenaData.rightTeam.subFighterInfo != null)
         {
            this._arenaData.isDoubleMode = true;
         }
         this._arenaData.fightWeather = param1.readUnsignedByte();
         this._arenaData.canCatch = param1.readUnsignedByte() == 0;
         this._onGetInfoComplete();
         this.dispose();
      }
      
      public function dispose() : void
      {
      }
   }
}
