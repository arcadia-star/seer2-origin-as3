package com.taomee.seer2.app.processor.quest.handler.branch.quest10012
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.Interactive_10012;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10012_360 extends BranchQuestMapHandler
   {
       
      
      private var _makeStone:Interactive_10012;
      
      public function QuestMapHandler_10012_360(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="435" resId="435" name="" dir="1" width="25" height="50" pos="376,434" actorPos="388,450" path="">
					<dialog npcId="435" npcName="稚壳鸡" transport="">
						<branch id="default" npcId="435" npcName="稚壳鸡">
							<node emotion="0"><![CDATA[太热了咕！紫外线，退散！！]]></node>
							<reply action="close"><![CDATA[（再过不久它就要变成烤鸡了！）]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         tip = "";
         this._makeStone = new Interactive_10012();
      }
      
      override protected function onQuestAccept(param1:QuestEvent) : void
      {
         super.onQuestAccept(param1);
         if(_questId == param1.questId)
         {
            DialogPanel.showForSimple(435,"稚壳鸡",[[0,"很简单，在我抵达绿荫之前，帮我避开所有的阳光咕！真热，我都快变成烤鸡了咕~~"]],"看我的！",this.onAcceptOver);
         }
      }
      
      override protected function onQuestClick(param1:MouseEvent) : void
      {
         if(QuestManager.isAccepted(10012) && !QuestManager.isStepComplete(10012,1))
         {
            DialogPanel.showForSimple(435,"稚壳鸡",[[0,"很简单，在我抵达绿荫之前，帮我避开所有的阳光咕！真热，我都快变成烤鸡了咕~~"]],"看我的！",this.onAcceptOver);
         }
         if(QuestManager.isStepComplete(10012,1) && QuestManager.isStepComplete(10012,2) == false)
         {
            DialogPanel.showForSimple(435,"稚壳鸡",[[0,"咕咕！好凉快！休息一下，我又可以去阳光下蹦蹦跳跳咕~~"]],"晒太阳虽然好，但也要适度呢~",this.complete10012);
         }
         super.onQuestClick(param1);
      }
      
      private function onAcceptOver() : void
      {
         this._makeStone.setup("interactive_10012");
         this._makeStone.addEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeStone.addEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this._makeStone.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeStone.removeEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
         var _loc2_:XML = new XML("<dialog npcId=\"435\" npcName=\"稚壳鸡\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[我晕了咕……天堂的爷爷，我来见你了咕……]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[我再帮你一次！]]></reply>" + "<reply action=\"close\" params=\"no\"><![CDATA[你忍耐一下，我下次再来！]]></reply></branch>" + "</dialog>");
         var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
         DialogPanel.addCloseEventListener(this.dialogComplete);
         DialogPanel.showForCommon(_loc3_);
      }
      
      private function dialogComplete(param1:DialogCloseEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.dialogComplete);
         if(param1.params == "yes")
         {
            this.onAcceptOver();
         }
         if(param1.params == "no")
         {
            QuestManager.abortQuest(10012);
         }
      }
      
      private function onMakeBubbleOver(param1:Event) : void
      {
         this._makeStone.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeStone.removeEventListener(AnimationEvent.STONE,this.onMakeBubbleOver);
         QuestManager.completeStep(_questId,1);
         DialogPanel.showForSimple(435,"稚壳鸡",[[0,"咕咕！好凉快！休息一下，我又可以去阳光下蹦蹦跳跳咕~~"]],"晒太阳虽然好，但也要适度呢~",this.complete10012);
      }
      
      private function complete10012() : void
      {
         QuestManager.completeStep(_questId,2);
      }
   }
}
