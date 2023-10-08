package com.taomee.seer2.app.rarePet.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.events.MouseEvent;
   
   public class RarePetProcessor_437 extends BaseRarePetProcessor
   {
       
      
      private var _shashaFightStatus:Object;
      
      public function RarePetProcessor_437(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.active.mapID == _mapId)
         {
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         if(this._shashaFightStatus != null)
         {
            this.showShashaDialog();
         }
         else
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.RARE_PET_SHASHA,this.onGetShashaFightStatus);
         }
      }
      
      private function showShashaDialog() : void
      {
         if(this._shashaFightStatus.count < 5)
         {
            NpcDialog.show(437,"砂吉塔",[[0,"沙沙——！你也是来抢财宝的……我可没有小时候那么没出息。来，出手吧！沙——！"]],["来就来！","（算了，赛尔不一定防毒）"],[this.fightShasha,null]);
         }
         else
         {
            NpcDialog.show(437,"砂吉塔",[[0,"沙沙——！"]],["（它看起来很生气，还是明天再来吧）"]);
         }
      }
      
      private function onGetShashaFightStatus(param1:ServerBuffer) : void
      {
         var _loc2_:Date = null;
         var _loc3_:Vector.<ServerBufferData> = null;
         if(param1.type == ServerBufferType.RARE_PET_SHASHA)
         {
            _loc2_ = new Date(TimeManager.getServerTime() * 1000);
            this._shashaFightStatus = new Object();
            this._shashaFightStatus.month = param1.readDataAtPostion(0);
            this._shashaFightStatus.date = param1.readDataAtPostion(1);
            this._shashaFightStatus.count = param1.readDataAtPostion(2);
            if(this._shashaFightStatus.month != _loc2_.month || this._shashaFightStatus.date != _loc2_.date)
            {
               _loc3_ = new Vector.<ServerBufferData>();
               _loc3_.push(new ServerBufferData(0,_loc2_.month));
               this._shashaFightStatus.month = _loc2_.month;
               _loc3_.push(new ServerBufferData(1,_loc2_.date));
               this._shashaFightStatus.date = _loc2_.date;
               _loc3_.push(new ServerBufferData(2,0));
               this._shashaFightStatus.count = 0;
               ServerBufferManager.updateServerBufferGroup(ServerBufferType.RARE_PET_SHASHA,_loc3_);
            }
            this.showShashaDialog();
         }
      }
      
      private function fightShasha() : void
      {
         Connection.addErrorHandler(CommandSet.FIGHT_START_WILD_1500,this.onOverFightShasha);
         FightManager.startFightWithWild(30,this.onFightShashaStartSuccess,this.onFightShashaStartError);
      }
      
      private function onOverFightShasha(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 2)
         {
            AlertManager.showAlert("每天只能和砂吉塔对战5次哦，请明天再来");
            this._shashaFightStatus.count = 5;
            ServerBufferManager.updateServerBuffer(ServerBufferType.RARE_PET_SHASHA,2,this._shashaFightStatus.count);
         }
      }
      
      private function onFightShashaStartSuccess() : void
      {
         Connection.removeErrorHandler(CommandSet.FIGHT_START_WILD_1500,this.onOverFightShasha);
         ++this._shashaFightStatus.count;
         ServerBufferManager.updateServerBuffer(ServerBufferType.RARE_PET_SHASHA,2,this._shashaFightStatus.count);
      }
      
      private function onFightShashaStartError() : void
      {
         Connection.removeErrorHandler(CommandSet.FIGHT_START_WILD_1500,this.onOverFightShasha);
      }
      
      override public function processMapDispose() : void
      {
         if(SceneManager.active.mapID == _mapId)
         {
            _npc.buttonMode = false;
            _npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         super.processMapDispose();
      }
   }
}
