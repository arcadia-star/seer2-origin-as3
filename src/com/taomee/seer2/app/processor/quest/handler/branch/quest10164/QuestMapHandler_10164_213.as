package com.taomee.seer2.app.processor.quest.handler.branch.quest10164
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.npc.NpcEvent;
   import com.taomee.seer2.app.npc.NpcManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_10164_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10164_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!isAccepted())
         {
            ActiveCountManager.requestActiveCount(202125,function(param1:int, param2:int):void
            {
               if(param1 == 202125 && param2 > 6)
               {
                  NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE,onArriveNpc);
               }
            });
         }
      }
      
      private function onArriveNpc(param1:NpcEvent) : void
      {
         var _loc2_:XML = null;
         if(param1.npcDefinition.id == 27)
         {
            _loc2_ = <node type="quest" name="脉灵兽试炼第二章" params="10164_0"/>;
            param1.npcDefinition.resetFunctionalityData();
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_,0);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
         }
      }
      
      private function onUnit(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(event.content.params == "10164_0")
         {
            NpcDialog.show(400,"赛尔",[[0,"被污染的精灵已经被我净化了。"]],["脉灵兽现在怎么样了？"],[function():void
            {
               NpcDialog.show(27,"婆婆",[[0,"虽然精灵已经净化，但是脉灵兽每一次的失控都有可能污染水源，脉灵兽还有着不一样的故事。"]],["哦。我倒是很想听听。"],[function():void
               {
                  NpcDialog.show(489,"卡特琳娜",[[0,"欲望即为污垢……吾生于精灵王的心脏，为了让心灵归于纯净，吾只能选择将那污浊封印，即便……伴随着牺牲。"]],["不，你的理解过于偏激。"],[function():void
                  {
                     NpcDialog.show(400,"我",[[0,"每一个月圆之夜，都是洛水陪着脉灵兽度过，这种过程，不是一般人可以做到的。"]],["那是？"],[function():void
                     {
                        NpcDialog.show(489,"卡特琳娜",[[0,"脉灵兽曾经告诉过我它的故事，这里我已经写成了一封信件，你可以拿去给洛水看看，看完你就知道了。"]],["没问题，那我就带给洛水吧"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                           QuestManager.accept(10164);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 10164)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,160);
         }
      }
   }
}
