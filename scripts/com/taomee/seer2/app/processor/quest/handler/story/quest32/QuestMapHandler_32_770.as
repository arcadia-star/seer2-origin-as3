package com.taomee.seer2.app.processor.quest.handler.story.quest32
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_32_770 extends QuestMapHandler
   {
       
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_32_770(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) || QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         this._teleport = AnimateElementManager.getElement(1) as Teleport;
         this._teleport.visible = false;
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "32_0")
         {
            this.processStep0();
         }
         else if((param1.content as DialogPanelEventData).params == "32_2")
         {
            this.processStep2();
         }
      }
      
      private function processStep0() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("32"),1,[[1,0]],function():void
         {
            showDialog_0();
         });
      }
      
      private function showDialog_0() : void
      {
         NpcDialog.show(80,"葛蕾芬兵团长",[[0,"照片上的人曾经对我们飞翼氏族有恩，总督大人有令，如果你能拿出相关的证明，我们这里就放行。"]],["（照片上这人……好像很眼熟？）"],[function():void
         {
            NpcDialog.show(80,"葛蕾芬兵团长",[[0,"据说他来自外星，是一个博闻广记的天才博士。飞翼氏族的科技能够飞速发展多亏了他当年的提点。"]],["（越看越像斯坦因……去船长室找辛迪确认一下！）"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
               QuestManager.accept(_quest.id);
            }]);
         }]);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
            SceneManager.changeScene(SceneType.LOBBY,10);
         }
      }
      
      private function processStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("32"),function():void
         {
            if(_teleport)
            {
               _teleport.visible = true;
            }
            SceneManager.changeScene(SceneType.LOBBY,660);
         });
      }
      
      override public function processMapDispose() : void
      {
         this._teleport = null;
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         super.processMapDispose();
      }
   }
}
