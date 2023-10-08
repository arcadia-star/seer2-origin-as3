package com.taomee.seer2.app.processor.quest.handler.branch.quest10146
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.Sprite;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10146_302 extends QuestMapHandler
   {
       
      
      private var _npc:SpawnedPet;
      
      private const RES_ID:int = 346;
      
      private const INDEX:int = 247;
      
      private var _mouseHint:Sprite;
      
      public function QuestMapHandler_10146_302(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id))
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         }
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint;
         if((_loc4_ = uint(_loc2_.readUnsignedInt())) != 0)
         {
            if(_loc4_ == 1)
            {
               this.addNpc();
            }
         }
      }
      
      private function addNpc() : void
      {
         this.removeNpc();
         this._npc = new SpawnedPet(this.RES_ID,this.INDEX,0);
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this.showMouseHintAtMonster(this._npc);
      }
      
      public function showMouseHintAtMonster(param1:SpawnedPet) : void
      {
         this.hideMouseHintAtMonster();
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -this._mouseHint.height + 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 - 10;
         param1.addChild(this._mouseHint);
      }
      
      private function hideMouseHintAtMonster() : void
      {
         if(Boolean(this._mouseHint) && Boolean(this._mouseHint.parent))
         {
            DisplayUtil.removeForParent(this._mouseHint);
         }
         this._mouseHint = null;
      }
      
      private function removeNpc() : void
      {
         if(Boolean(this._npc) && Boolean(this._npc.parent))
         {
            DisplayUtil.removeForParent(this._npc);
         }
         this._npc = null;
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            DayLimitManager.getDoCount(586,function(param1:int):void
            {
               if(param1 == 1)
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                  QuestManager.completeStep(_quest.id,1);
               }
               else if(FightManager.currentFightRecord.isWinWar() && FightManager.currentFightRecord.initData.positionIndex <= 9)
               {
                  missOrSuccess();
               }
            });
         }
         if(SceneManager.active.mapID != this._map.id && SceneManager.currentSceneType == SceneType.LOBBY)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         }
      }
      
      private function missOrSuccess() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,38,0);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         ServerMessager.addMessage("你获得3金币哦!");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_292);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this.hideMouseHintAtMonster();
         this.removeNpc();
      }
   }
}
