package com.taomee.seer2.app.processor.quest.handler.story.quest34
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_34_760 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      private var _npcDefinition:NpcDefinition;
      
      private var _mc:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_34_760(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initNpc();
            this.initNpcEvent();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initNpc();
            this.initNpcEvent();
            this.initMC();
         }
      }
      
      private function initNpc() : void
      {
         var _loc1_:XML = <npc id="93" resId="93" name="" dir="1" width="25" height="90" pos="750,269" actorPos="710,209" path="">
					<dialog npcId="93" npcName="神秘人" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[命运与巧合，往往只有一线之差……]]></node>
							<reply action="close"><![CDATA[（离他远点……）]]></reply>
						</branch>
					</dialog>
				</npc>;
         this._npcDefinition = new NpcDefinition(_loc1_);
         this._npc = MobileManager.createNpc(this._npcDefinition);
      }
      
      private function initNpcEvent() : void
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
         if((param1.content as DialogPanelEventData).params == "34_1")
         {
            this.processStep1();
         }
         if((param1.content as DialogPanelEventData).params == "34_2")
         {
            this.processStep2();
         }
      }
      
      private function initMC() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc);
         this._mc.gotoAndStop(this._mc.totalFrames);
      }
      
      private function processStep1() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("34_1"),2,[[1,0]],function():void
         {
            NpcDialog.show(93,"神秘人",[[0,"如果这是命运……我就要反抗它！我不畏惧！！"]],["没什么事我先走了= =b"],[function():void
            {
               _npc.visible = false;
               _mc = _processor.resLib.getMovieClip("mc_1");
               _map.front.addChild(_mc);
               MovieClipUtil.playMc(_mc,1,_mc.totalFrames - 1,function():void
               {
                  _npc.visible = true;
                  _mc.gotoAndStop(_mc.totalFrames);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(_quest.id,1);
               },true);
            }]);
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
      }
      
      private function processStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("34_1"),function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[0,"唔……还是那么强……"]],["好厉害……都没有用精灵！"],[function():void
            {
               _npc.visible = false;
               DisplayUtil.removeForParent(_mc);
               _mc_1 = _processor.resLib.getMovieClip("mc_2");
               _map.front.addChild(_mc_1);
               MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_mc_1);
                  QuestManager.completeStep(_quest.id,2);
               },true);
            }]);
         },true,false,2);
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc);
         DisplayUtil.removeForParent(this._mc_1);
         this._mc = null;
         this._mc_1 = null;
         if(this._npc)
         {
            this._npc.dispose();
         }
         this._npcDefinition = null;
         this._npc = null;
      }
   }
}
