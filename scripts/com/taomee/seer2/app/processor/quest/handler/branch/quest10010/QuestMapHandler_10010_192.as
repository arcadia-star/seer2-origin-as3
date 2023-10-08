package com.taomee.seer2.app.processor.quest.handler.branch.quest10010
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.FindDuduAnimation;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10010_192 extends BranchQuestMapHandler
   {
       
      
      private var _findFlower:FindDuduAnimation;
      
      public function QuestMapHandler_10010_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="423" resId="423" name="" dir="1" width="25" height="50" pos="554, 370" actorPos="250,415" path="">
					<dialog npcId="423" npcName="蓝喵" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[@。@~~~~~~]]></node>
							<reply action="close"><![CDATA[它好像晕过去了。]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         _tip = "";
      }
      
      override protected function onQuestClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(QuestManager.isAccepted(_questId) && !QuestManager.isStepComplete(_questId,1))
         {
            DialogPanel.showForSimple(423,"蓝喵",[[0,"你能在附近采几株带红尖的水草给我吗？听说吃这伤口会好得快一点。"]],"带红尖的水草吗？采10株行吧！",function():void
            {
               addInteractive();
            });
            return;
         }
         super.onQuestClick(evt);
      }
      
      override protected function onQuestAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _questId)
         {
            this.addInteractive();
         }
      }
      
      private function addInteractive() : void
      {
         this._findFlower = new FindDuduAnimation();
         this._findFlower.setup("findFlower");
         this._findFlower.addEventListener(AnimationEvent.FINDDUDU,this.onFindFlower);
         this._findFlower.addEventListener(Event.CLOSE,this.onCloseAnimation);
      }
      
      private function onFindFlower(param1:Event) : void
      {
         QuestManager.completeStep(_questId,1);
         this._findFlower.dispose();
         this._findFlower = null;
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this._findFlower.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._findFlower.removeEventListener(AnimationEvent.FINDDUDU,this.onFindFlower);
      }
      
      override protected function completeQuest() : void
      {
         DialogPanel.showForSimple(423,"蓝喵",[[0,"哈~~谢谢，给我给我。"]],"真是个着急的孩子，给你吧！",function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10010_0"),function():void
            {
               DialogPanel.showForSimple(423,"蓝喵",[[0,"哇呜~~阿卡纳斯的水盾比最硬的石头还硬……"]]," 呃……",function():void
               {
                  DialogPanel.showForSimple(423,"蓝喵",[[0,"呜~~哼！等我变厉害了，星光之尾变两条的时候，我要把阿卡纳斯的水盾撞破！！我要变成水里最强最强的！"]],"O(∩_∩)O~加油！",function():void
                  {
                     QuestManager.completeStep(_questId,2);
                  });
               });
            });
         });
      }
   }
}
