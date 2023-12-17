package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.utils.IDataInput;
   
   public class PetKingRankMsgManager
   {
      
      private static var _instance:PetKingRankMsgManager;
      
      public static const RED_TEAM:int = 1;
      
      public static const BLUE_TEAM:int = 2;
      
      public static const GREEN_TEAM:int = 3;
       
      
      private var _teamName:String;
      
      private var _curtTeam:uint = 0;
      
      private var _teamNameList:Array;
      
      private var _teamList:Array;
      
      private var _curtHours:uint;
      
      public function PetKingRankMsgManager(param1:PrivateClass)
      {
         this._teamNameList = [null,"热辣队","冰沁队","丛林队"];
         this._teamList = new Array();
         super();
      }
      
      public static function instance() : PetKingRankMsgManager
      {
         if(_instance == null)
         {
            _instance = new PetKingRankMsgManager(new PrivateClass());
         }
         return _instance;
      }
      
      public function update() : void
      {
         if(QuestManager.isCompleteGudieTask() == false)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.ARENA)
         {
            return;
         }
         var _loc1_:uint = uint(TimeManager.getServerTime());
         var _loc2_:Date = new Date(_loc1_ * 1000);
         if(_loc2_.getMinutes() == 30 && _loc2_.getHours() != this._curtHours)
         {
            this.setTeam();
            Connection.addCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,this.onGetTotalVote);
            Connection.send(CommandSet.GET_TOTAL_VOTE_INFO_1219,1,1,3);
            this._curtHours = _loc2_.getHours();
         }
      }
      
      private function onGetTotalVote(param1:MessageEvent) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         Connection.removeCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,this.onGetTotalVote);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         this._teamList.length = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc5_ = uint(_loc2_.readUnsignedInt());
            _loc6_ = uint(_loc2_.readUnsignedInt());
            _loc7_ = {
               "name":this._teamNameList[_loc5_],
               "count":_loc6_
            };
            this._teamList.push(_loc7_);
            _loc8_++;
         }
         this.sortTeam();
         this.showTxt();
      }
      
      private function sortTeam() : void
      {
         this._teamList.sortOn("count",Array.NUMERIC);
      }
      
      private function showTxt() : void
      {
         ServerMessager.addMessage(this.checkColor(this._teamList[2]["name"]) + "精灵王争霸赛总积分为" + this._teamList[2]["count"] + "，现在排名第一|查看详情|PetKingFightIntegralPanel|正在努力加载中...");
         ServerMessager.addMessage(this.checkColor(this._teamList[1]["name"]) + "精灵王争霸赛总积分为" + this._teamList[1]["count"] + "，现在排名第二|查看详情|PetKingFightIntegralPanel|正在努力加载中...");
         ServerMessager.addMessage(this.checkColor(this._teamList[0]["name"]) + "精灵王争霸赛总积分为" + this._teamList[0]["count"] + "，现在排名第三|查看详情|PetKingFightIntegralPanel|正在努力加载中...");
      }
      
      private function checkColor(param1:String) : String
      {
         var _loc2_:* = param1;
         if(param1 == this._teamName)
         {
            _loc2_ = "<font color=\'#ff0000\'>" + this._teamName + "</font>";
         }
         return _loc2_;
      }
      
      private function setTeam() : void
      {
         switch(ActorManager.actorInfo.activityData[1])
         {
            case 500508:
               this._curtTeam = RED_TEAM;
               this._teamName = "热辣队";
               break;
            case 500509:
               this._teamName = "冰沁队";
               this._curtTeam = BLUE_TEAM;
               break;
            case 500510:
               this._teamName = "丛林队";
               this._curtTeam = GREEN_TEAM;
               break;
            default:
               this._curtTeam = 0;
         }
      }
   }
}

class PrivateClass
{
    
   
   public function PrivateClass()
   {
      super();
   }
}
