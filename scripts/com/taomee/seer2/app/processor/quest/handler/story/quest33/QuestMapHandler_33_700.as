package com.taomee.seer2.app.processor.quest.handler.story.quest33
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_33_700 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      private var _npcDefinition:NpcDefinition;
      
      private var _mc:MovieClip;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_33_700(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(1) as Teleport;
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._teleport.visible = false;
            this.initNpc();
            this.initQuestAccept();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._teleport.visible = false;
            this.initNpc();
            this.questProcessor2();
         }
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this._teleport.visible = false;
            this.initNpc();
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.accept(_quest.id);
         }
      }
      
      private function initNpc() : void
      {
         var _loc1_:XML = <npc id="463" resId="463" name="萨伯尔" dir="1" width="25" height="90" pos="841,288" actorPos="821,288" path="">
					<dialog npcId="463" npcName="萨伯尔" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[就由我萨伯尔来保护您的安全！]]></node>
							<reply action="close"><![CDATA[我自己可以保护自己……]]></reply>
						</branch>
					</dialog>
				</npc>;
         this._npcDefinition = new NpcDefinition(_loc1_);
         this._npc = MobileManager.createNpc(this._npcDefinition);
         this._npc.addOverHeadMark(new InProgressMark());
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initQuestAccept();
         }
      }
      
      private function initQuestAccept() : void
      {
         this.questAccept();
         this.initMc();
      }
      
      private function initMc() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc);
         this._mc.visible = false;
      }
      
      private function questAccept() : void
      {
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         DialogPanel.showForNpc(this._npcDefinition);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "33_1")
         {
            this.processStep1();
         }
         if((param1.content as DialogPanelEventData).params == "33_2")
         {
            this.processStepAnimation2();
         }
      }
      
      private function processStep1() : void
      {
         this._mc.visible = true;
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.CLICK,this.onMc);
      }
      
      private function onMc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("33_1"),function():void
         {
            NpcDialog.show(463,"萨伯尔",[[0,"这把钥匙？！莫非是……我族丢失了数百年的遗忘之岛的钥匙！"]],["那是什么？"],[function():void
            {
               NpcDialog.show(463,"萨伯尔",[[0,"请您前去确认一下！我要在这段时间里请示兵团长。"]],["（去实验禁地找古老的钥匙！）"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            }]);
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            SceneManager.changeScene(SceneType.LOBBY,500);
         }
      }
      
      private function questProcessor2() : void
      {
         this.questAccept();
      }
      
      private function processStepAnimation2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("33_2"),function():void
         {
            _teleport.visible = true;
            SceneManager.changeScene(SceneType.LOBBY,710);
         },false);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         if(this._npc)
         {
            this._npc.dispose();
         }
         this._npcDefinition = null;
         this._npc = null;
         DisplayUtil.removeForParent(this._mc);
      }
   }
}
