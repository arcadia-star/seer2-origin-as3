package com.taomee.seer2.app.processor.quest.handler.story.quest34
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
   
   public class QuestMapHandler_34_660 extends QuestMapHandler
   {
       
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_34_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(3) as Teleport;
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this._teleport.visible = false;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "34_0")
         {
            this.processStep0();
         }
         if((param1.content as DialogPanelEventData).params == "34_3")
         {
            QuestManager.completeStep(_quest.id,3);
         }
      }
      
      private function processStep0() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("34_0"),2,[[1,0]],function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[0,"有人目击说，他近日出现在汲雨之岛。但是那家伙看见我就逃跑……你能帮我去暗探一下吗？必要的时候……直接抓住他！"]],["可是，我还无法进入汲雨之岛"],[function():void
            {
               NpcDialog.show(83,"萨伯尔兵团长",[[0,"那简单，我会带领你找到入口。"]],["（太好啦，又有新场景！）"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("34_0"),function():void
                  {
                     if(_teleport)
                     {
                        _teleport.visible = true;
                     }
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                     QuestManager.accept(_quest.id);
                  },true,false,2);
               }]);
            }]);
         });
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         SceneManager.changeScene(SceneType.LOBBY,760);
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
   }
}
