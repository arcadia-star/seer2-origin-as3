package com.taomee.seer2.app.processor.quest.handler.activity.quest30011
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_30011_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30011_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30011_0"),2,[[1,0]],function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哇，漂亮婆婆！你提供的信息太有价值了！我这就回赛尔号和伙伴一起商量，为迎接美食神猪做计划！"]],["……"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"嘿嘿，你们的行动必须得有我参与，我也要借助科学的力量和英雄来场亲密接触。"]],["呵呵，放心吧，有安排了马上通知你。"],[function():void
                  {
                     NpcDialog.show(27,"占卜婆婆",[[0,"一言为定，我等你的消息。"]],["Ok！（返回资料室）"],[function():void
                     {
                        SceneManager.changeScene(SceneType.LOBBY,30);
                     }]);
                  }]);
               }]);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         super.processMapDispose();
      }
   }
}
