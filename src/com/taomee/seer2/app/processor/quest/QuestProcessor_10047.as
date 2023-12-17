package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestProcessor_10047 extends QuestProcessor
   {
      
      private static const MAP_ID:Array = [10,60,81];
       
      
      private var _npc:Mobile;
      
      public function QuestProcessor_10047(param1:Quest)
      {
         super(param1);
         if(QuestManager.isAccepted(10047))
         {
            this.updateQuestStatus();
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
         }
      }
      
      private function onQuestAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == 10047)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
            this.updateQuestStatus();
         }
      }
      
      private function updateQuestStatus() : void
      {
         if(QuestManager.isStepComplete(10047,1) == false && _quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else if(QuestManager.isStepComplete(10047,1) == false)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         }
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(MAP_ID.indexOf(SceneManager.active.mapID) != -1 && Boolean(_quest.isStepCompletable(1)))
         {
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         var _loc1_:uint = 0;
         if(_quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else
         {
            _loc1_ = this.getNPCId();
            if(_loc1_)
            {
               this._npc = MobileManager.getMobile(_loc1_,MobileType.NPC);
               this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick,false,1);
            }
         }
      }
      
      private function getNPCId() : uint
      {
         switch(SceneManager.active.mapID)
         {
            case 10:
               if(_quest.getStepData(1,0) == 0)
               {
                  return 1;
               }
               break;
            case 60:
               if(_quest.getStepData(1,1) == 0)
               {
                  return 6;
               }
               break;
            case 81:
               if(_quest.getStepData(1,2) == 0)
               {
                  return 3;
               }
               break;
         }
         return 0;
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         evt.stopImmediatePropagation();
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            switch(this._npc.id)
            {
               case 1:
                  NpcDialog.show(1,"船长",[[0,"新年快乐我的孩子！把一切不可能变为可能，这个才是精灵训练师的最高领悟！我想你会是赛尔号Ⅱ的新星！"]],["酷！！！船长万岁！！！"],[function():void
                  {
                     _quest.setStepData(1,0,1);
                     QuestManager.setStepBufferServer(10047,1);
                     ServerMessager.addMessage("得到船长的 <font color=\'#ffcc00\'>祝福</font>");
                     refresh();
                  }]);
                  break;
               case 6:
                  NpcDialog.show(6,"克拉克",[[0,"定力目标！制定计划！努力实践！我想在新的一年里我能看到更出色的你！"]],["克拉克！敬礼！！！"],[function():void
                  {
                     _quest.setStepData(1,1,1);
                     QuestManager.setStepBufferServer(10047,1);
                     ServerMessager.addMessage("得到克拉克的 <font color=\'#ffcc00\'>祝福</font>");
                     refresh();
                  }]);
                  break;
               case 3:
                  NpcDialog.show(3,"上尉门罗",[[0,"付出和得到是永远是成正比的……"]],["啧啧啧……简短有内涵……"],[function():void
                  {
                     _quest.setStepData(1,2,1);
                     QuestManager.setStepBufferServer(10047,1);
                     ServerMessager.addMessage("得到上尉门罗的 <font color=\'#ffcc00\'>祝福</font>");
                     refresh();
                  }]);
            }
         }
      }
      
      private function refresh() : void
      {
         if(_quest.getStepData(1,0) >= 1 && _quest.getStepData(1,1) >= 1 && _quest.getStepData(1,2) >= 1)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            QuestManager.completeStep(_quest.id,1);
         }
         else
         {
            ModuleManager.showModule(URLUtil.getAppModule("DecorateQuestPanel"),"正在打开装修图纸……");
         }
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY)
            {
               ServerMessager.addMessage("获得三位训练师的祝福啦，快回 <font color=\'#ffcc00\'>小屋</font> 看看装修进度吧");
            }
         }
      }
      
      override public function dispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            this._npc = null;
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccepted);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
         super.dispose();
      }
   }
}
