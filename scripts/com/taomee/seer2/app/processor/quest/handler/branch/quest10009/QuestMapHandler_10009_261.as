package com.taomee.seer2.app.processor.quest.handler.branch.quest10009
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.LeaveAlone;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10009_261 extends BranchQuestMapHandler
   {
       
      
      private var _leaveAloneBtn:MovieClip;
      
      private var _leaveAloneAnimation:LeaveAlone;
      
      public function QuestMapHandler_10009_261(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="419" resId="419" name="" dir="1" width="25" height="50" pos="485, 500" actorPos="604,540" path="">
					<dialog npcId="419" npcName="赤焰兽" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[呼~~我最讨厌动脑筋了~]]></node>
							<reply action="close"><![CDATA[它好像很烦恼啊……]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         this.createLeaveAloneBtn();
         _tip = "";
      }
      
      private function createLeaveAloneBtn() : void
      {
         this._leaveAloneBtn = _processor.resLib.getMovieClip("item");
         this._leaveAloneBtn.gotoAndStop(1);
         _map.ground.addChild(this._leaveAloneBtn);
         if(!QuestManager.isStepComplete(_questId,1) && QuestManager.isAccepted(_questId))
         {
            this.addEventListenerBtn();
         }
      }
      
      private function addEventListenerBtn() : void
      {
         this._leaveAloneBtn.buttonMode = true;
         this._leaveAloneBtn.gotoAndPlay(2);
         this._leaveAloneBtn.addEventListener(MouseEvent.CLICK,this.onBtnClick);
      }
      
      private function removeEventListenerBtn() : void
      {
         this._leaveAloneBtn.buttonMode = false;
         this._leaveAloneBtn.gotoAndStop(1);
         this._leaveAloneBtn.removeEventListener(MouseEvent.CLICK,this.onBtnClick);
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         this._leaveAloneAnimation = new LeaveAlone();
         this._leaveAloneAnimation.setup("leaveAlone");
         this._leaveAloneAnimation.addEventListener(AnimationEvent.LEAVEALONE,this.onLeaveAlone);
         this._leaveAloneAnimation.addEventListener(Event.CLOSE,this.onCloseAnimation);
      }
      
      private function onLeaveAlone(param1:Event) : void
      {
         QuestManager.completeStep(_questId,1);
      }
      
      private function onCloseAnimation(param1:Event) : void
      {
         this.clearAnimation();
      }
      
      private function clearAnimation() : void
      {
         if(this._leaveAloneAnimation)
         {
            this._leaveAloneAnimation.removeEventListener(AnimationEvent.LEAVEALONE,this.onLeaveAlone);
            this._leaveAloneAnimation.removeEventListener(Event.CLOSE,this.onCloseAnimation);
         }
      }
      
      override protected function onQuestAccept(param1:QuestEvent) : void
      {
         super.onQuestAccept(param1);
         if(_questId == param1.questId)
         {
            this.addEventListenerBtn();
         }
      }
      
      override protected function onSepComplete(param1:QuestEvent) : void
      {
         super.onSepComplete(param1);
         if(_questId == param1.questId)
         {
            this.removeEventListenerBtn();
         }
      }
      
      override protected function completeQuest() : void
      {
         DialogPanel.showForSimple(419,"赤焰兽",[[0,"咦~~原来是这样，你真聪明！看来这神神秘秘的家伙没有骗我……"]],"呵呵！刚才你说最想知道什么？",function():void
         {
            DialogPanel.showForSimple(419,"赤焰兽",[[0,"传说我们一族是某位神手在勾画强大精灵时，落下的星火化身出的小精灵。我想知道，身上勾画的是什么精灵？"]],"真是神秘啊……",function():void
            {
               DialogPanel.showForSimple(419,"赤焰兽",[[0,"好啦，谢谢你，我找那个家伙去了，下次我们再见面的话，也许我就知道我是哪个强大精灵的化身了！"]]," 呵呵，再见！",function():void
               {
                  QuestManager.completeStep(_questId,2);
               });
            });
         });
      }
      
      private function clearBtn() : void
      {
         if(this._leaveAloneBtn)
         {
            DisplayObjectUtil.removeFromParent(this._leaveAloneBtn);
            this._leaveAloneBtn.removeEventListener(MouseEvent.CLICK,this.onBtnClick);
            this._leaveAloneBtn = null;
         }
      }
      
      override protected function clearQuest() : void
      {
         this.clearAnimation();
         this.clearBtn();
         super.clearQuest();
      }
   }
}
