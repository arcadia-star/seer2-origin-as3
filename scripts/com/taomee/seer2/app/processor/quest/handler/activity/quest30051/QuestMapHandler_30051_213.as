package com.taomee.seer2.app.processor.quest.handler.activity.quest30051
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import org.taomee.manager.EventManager;
   
   public class QuestMapHandler_30051_213 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_30051_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(4))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.clickCheck);
         }
         if(isNeedCompleteStep(5))
         {
            this.initStep5();
         }
         if(isNeedCompleteStep(6))
         {
            this.initStep6();
         }
      }
      
      private function initStep6() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30051_0"),4,[[1,0]],function():void
         {
            NpcDialog.show(626,"晨璨",[[0,"原来……原来，事情是这样的。"]],["我以为你是我最好的朋友"],[function():void
            {
               NpcDialog.show(626,"晨璨",[[0,"可是，你却嫉妒我的长发，设计阴谋来伤害我，我太伤心了。我认为最好的朋友……"]],["呜呜呜呜……"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30051_3"),function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                     QuestManager.completeStep(30051,6);
                  });
               }]);
            }]);
         });
      }
      
      private function initStep5() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      protected function clickCheck(param1:DialogPanelEvent) : void
      {
         if(DialogPanelEventData(param1.content).params == "cutHair")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.clickCheck);
            EventManager.addEventListener("CutComplete",this.cutComplete);
            ModuleManager.toggleModule(URLUtil.getAppModule("CutHairPanel"));
         }
      }
      
      private function cutComplete(param1:Event) : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         QuestManager.completeStep(30051,4);
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         var _loc2_:XML = null;
         if(param1.questId == 30051)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            if(param1.stepId == 4)
            {
               _loc2_ = new XML(<dialog npcId="27" npcName="占卜婆婆" transport="">
						<branch npcId="27" npcName="占卜婆婆" id="branch1">
							<node emotion="0"><![CDATA[吼吼吼~这头乌黑亮丽的头发真不错，我想我的新药又有了突飞猛进的发展，来这个是米拉的药，拿去给她涂上吧。]]></node>
							<reply action="goToBranch" params="branch2"><![CDATA[哎呀呀，新药啊]]></reply>
						</branch>
						<branch npcId="626" npcName="晨璨" id="branch2">
							<node emotion="0"><![CDATA[谢谢婆婆……]]></node>
							<reply action="goToBranch" params="branch3"><![CDATA[米拉，快涂上吧]]></reply>
						</branch>
						<branch npcId="626" npcName="晨璨" id="branch3">
							<node emotion="0"><![CDATA[咦？我的发卡好像刚刚掉落在了丛林里面，米拉你先休息着，我去找找看。]]></node>
							<reply action="close" params="complete5"><![CDATA[ 快去快回~]]></reply>
						</branch>
				</dialog>);
               DialogPanel.addCloseEventListener(this.dialogCloseHandler);
               DialogPanel.showForCommon(new DialogDefinition(_loc2_));
            }
            else if(param1.stepId == 5)
            {
               this.initStep6();
            }
         }
      }
      
      private function dialogCloseHandler(param1:DialogCloseEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.dialogCloseHandler);
         if(param1.params == "complete5")
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
            QuestManager.completeStep(questID,5);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
