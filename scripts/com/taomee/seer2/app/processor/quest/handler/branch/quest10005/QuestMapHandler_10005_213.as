package com.taomee.seer2.app.processor.quest.handler.branch.quest10005
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.MakeBubbleAnimation;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10005_213 extends BranchQuestMapHandler
   {
       
      
      private var _stoneBtn:MovieClip;
      
      private var _makeBubble:MakeBubbleAnimation;
      
      public function QuestMapHandler_10005_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="412" resId="412" name="" dir="1" width="25" height="50" pos="610,360" actorPos="500,400" path="">
					<dialog npcId="412" npcName="" transport="1,300,400">
						<branch id="default" npcId="412" npcName="安迷亚">
							<node emotion="0"><![CDATA[唉~~这可怎么办，这里一直冒着水泡的，最近是怎么了……]]></node>
							<reply action="close"><![CDATA[它好像遇到麻烦了…]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         tip = "点点安迷亚附近的石头堆看看。";
         this.createInteractive();
      }
      
      private function createInteractive() : void
      {
         this._makeBubble = new MakeBubbleAnimation();
         this._stoneBtn = _processor.resLib.getMovieClip("item");
         _map.ground.addChild(this._stoneBtn);
         if(QuestManager.isAccepted(_questId))
         {
            this.openStoneClick();
         }
      }
      
      override protected function onQuestAccept(param1:QuestEvent) : void
      {
         super.onQuestAccept(param1);
         if(_questId == param1.questId)
         {
            this.openStoneClick();
         }
      }
      
      private function openStoneClick() : void
      {
         if(!QuestManager.isStepComplete(_questId,1))
         {
            this._stoneBtn.addEventListener(MouseEvent.CLICK,this.onStoneClick);
            this._stoneBtn.buttonMode = true;
         }
      }
      
      private function closeStoneClick() : void
      {
         this._stoneBtn.removeEventListener(MouseEvent.CLICK,this.onStoneClick);
         this._stoneBtn.buttonMode = false;
      }
      
      private function onStoneClick(param1:MouseEvent) : void
      {
         this._makeBubble.setup("makeBubble");
         this._makeBubble.addEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeBubble.addEventListener(AnimationEvent.MAKEBUBBLE,this.onMakeBubbleOver);
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this._makeBubble.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         this._makeBubble.removeEventListener(AnimationEvent.MAKEBUBBLE,this.onMakeBubbleOver);
      }
      
      private function onMakeBubbleOver(param1:Event) : void
      {
         var evt:Event = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10005_0"),function():void
         {
            QuestManager.completeStep(_questId,1);
         });
      }
      
      override protected function onSepComplete(param1:QuestEvent) : void
      {
         if(_questId == param1.questId)
         {
            this.closeStoneClick();
         }
         super.onSepComplete(param1);
      }
      
      override protected function completeQuest() : void
      {
         DialogPanel.showForSimple(412,"安迷亚",[[0,"噢~~谢谢，真不知道该怎么感谢你，这点心意请你收下，你真是帮我们解决了一个超大的难题。"]],"呵呵，不客气。",this.onDialogOver);
      }
      
      private function onDialogOver() : void
      {
         QuestManager.completeStep(_questId,2);
      }
      
      override protected function clearQuest() : void
      {
         this.clearStone();
         super.clearQuest();
      }
      
      private function clearStone() : void
      {
         if(this._stoneBtn)
         {
            this.closeStoneClick();
            DisplayObjectUtil.removeFromParent(this._stoneBtn);
            this._stoneBtn = null;
         }
      }
   }
}
