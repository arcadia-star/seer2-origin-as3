package com.taomee.seer2.app.processor.quest.handler.branch.quest10013
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10013_490 extends BranchQuestMapHandler
   {
      
      private static var _fightIndex:int = 0;
       
      
      public function QuestMapHandler_10013_490(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="436" resId="436" name="" dir="1" width="25" height="50" pos="376,434" actorPos="388,450" path="">
					<dialog npcId="436" npcName="砂砂" transport="">
						<branch id="default" npcId="436" npcName="砂砂">
							<node emotion="0"><![CDATA[拳头克剪子，剪子克布，布，布克……剪子？？]]></node>
							<reply action="close"><![CDATA[布克拳头啦！]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         tip = "";
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(10013) && QuestManager.isStepComplete(10013,1) == false && _fightIndex == 1)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT && _fightIndex == 1)
            {
               QuestManager.completeStep(10013,1);
               _fightIndex = 0;
               this.win();
            }
            else
            {
               _fightIndex = 0;
               this.noWin();
            }
         }
      }
      
      override protected function onQuestAccept(param1:QuestEvent) : void
      {
         super.onQuestAccept(param1);
         if(_questId == param1.questId)
         {
            this.startFight();
         }
      }
      
      override protected function onQuestClick(param1:MouseEvent) : void
      {
         if(QuestManager.isAccepted(10013) && !QuestManager.isStepComplete(10013,1))
         {
            DialogPanel.showForSimple(439,"格西克",[[0,"砂砂，让这个小赛尔带着你和我打一架。如果你赢了，就说明你不是那么没用了……"]],"好像很好玩，看我的！",this.startFight);
         }
         if(QuestManager.isStepComplete(10013,1) && QuestManager.isStepComplete(10013,2) == false)
         {
            this.win();
         }
         super.onQuestClick(param1);
      }
      
      private function startFight() : void
      {
         _fightIndex = 1;
         FightManager.startFightWithNPC(1);
      }
      
      private function win() : void
      {
         DialogPanel.showForSimple(439,"格西克",[[0,"爸爸说，猜拳不是决胜负的唯一方法。只要找到自己的优点，坚持锻炼，就能变得很厉害了……"]],"嗯，说得有道理！",this.onWin);
      }
      
      private function onWin() : void
      {
         QuestManager.completeStep(_questId,2);
      }
      
      private function noWin() : void
      {
         var _loc1_:XML = new XML("<dialog npcId=\"436\" npcName=\"砂砂\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[我，我不行的，我果然是一根没用的响尾蛇！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[别放弃，再来一次！]]></reply>" + "<reply action=\"close\" params=\"no\"><![CDATA[还是算了。]]></reply></branch>" + "</dialog>");
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.addCloseEventListener(this.dialogComplete);
         DialogPanel.showForCommon(_loc2_);
      }
      
      private function dialogComplete(param1:DialogCloseEvent) : void
      {
         DialogPanel.removeCloseEventListener(this.dialogComplete);
         if(param1.params == "yes")
         {
            this.startFight();
         }
         if(param1.params == "no")
         {
            QuestManager.abortQuest(10013);
         }
      }
   }
}
