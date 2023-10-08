package com.taomee.seer2.app.processor.quest.handler.branch.quest10128
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_10128_160 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_10128_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onSecond);
         }
      }
      
      private function onStart(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "10128_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"阿宝它要去骰子星寻宝啦！我想邀请您去幽静浅滩为它饯行，壮壮胆！您知道它可从来没有出过远门呢。"]],[" 您愿意吗？"],[function():void
            {
               NpcDialog.show(23,"神谕祭司",[[0,"哦，我现在走不开呢，族谱里记录的这句秋日平安咒似乎不灵，我要研究一下“秋天的海底好安静，有一种纯净的力量——”"]],["原来你念的是咒语？不是诗啊? 我去找占卜婆婆帮帮你！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                  QuestManager.accept(_quest.id);
               }]);
            }]);
         }
      }
      
      private function onSecond(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10128_2")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onSecond);
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
            QuestManager.completeStep(_quest.id,2);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         SceneManager.changeScene(SceneType.LOBBY,213);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         ModuleManager.toggleModule(URLUtil.getAppModule("SayGood_byeToAboPanel"),"正在打开面板...");
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onSecond);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
      }
   }
}
