package com.taomee.seer2.app.arena.cmd
{
   import com.taomee.seer2.app.arena.data.ArenaDataInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.data.TeamInfo;
   import com.taomee.seer2.app.arena.decoration.DecorationControl;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class ArenaResourceLoadCMD implements IArenaBaseCMD
   {
       
      
      private var _arenaData:ArenaDataInfo;
      
      private var _onGetInfoComplete:Function;
      
      public function ArenaResourceLoadCMD(param1:ArenaDataInfo, param2:Function)
      {
         super();
         this._arenaData = param1;
         this._onGetInfoComplete = param2;
         this.init();
      }
      
      public function init() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_LOAD_RES_1,this.onGetResourceInfo);
      }
      
      public function send() : void
      {
         Connection.send(CommandSet.FIGHT_LOAD_RES_1);
      }
      
      private function onGetResourceInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_LOAD_RES_1,this.onGetResourceInfo);
         var _loc2_:IDataInput = param1.message.getRawData();
         this._arenaData.fightMode = _loc2_.readUnsignedByte();
         var _loc3_:TeamInfo = new TeamInfo(_loc2_,this._arenaData.fightMode);
         var _loc4_:TeamInfo = new TeamInfo(_loc2_,this._arenaData.fightMode);
         if(_loc3_.clientSide == FightSide.LEFT)
         {
            this._arenaData.leftTeam = new FighterTeam(_loc3_);
            this._arenaData.rightTeam = new FighterTeam(_loc4_);
         }
         else
         {
            this._arenaData.rightTeam = new FighterTeam(_loc3_);
            this._arenaData.leftTeam = new FighterTeam(_loc4_);
         }
         if(this._arenaData.leftTeam.subFighterInfo != null || this._arenaData.rightTeam.subFighterInfo != null)
         {
            this._arenaData.isDoubleMode = true;
         }
         this._arenaData.fightWeather = _loc2_.readUnsignedByte();
         this._arenaData.canCatch = _loc2_.readUnsignedByte() == 0;
         if(FightMode.isPVPMode(this._arenaData.fightMode) == false || this._arenaData.rightTeam.fighterVec.length == 1)
         {
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 301)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 302)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 304)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 305)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 306)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 307)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 1276)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
            if(_loc4_.fightUserInfoVec[0].fighterInfoVec[0].resourceId == 1296)
            {
               DecorationControl.fightPetInfo = _loc4_.fightUserInfoVec[0].fighterInfoVec[0];
            }
         }
         this._onGetInfoComplete();
         this.dispose();
      }
      
      public function dispose() : void
      {
         this._arenaData = null;
         this._onGetInfoComplete = null;
      }
   }
}
