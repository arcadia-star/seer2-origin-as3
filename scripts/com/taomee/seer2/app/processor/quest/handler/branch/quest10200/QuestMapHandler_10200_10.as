package com.taomee.seer2.app.processor.quest.handler.branch.quest10200
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10200_10 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _processorMark:AcceptableMark;
      
      private var _comMark:InProgressMark;
      
      public function QuestMapHandler_10200_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(10200))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         else if(QuestManager.isAccepted(10200) && QuestManager.isStepComplete(10200,1) == false)
         {
            this.nextQuest1();
         }
         else if(QuestManager.isStepComplete(10200,2) && QuestManager.isStepComplete(10200,3) == false)
         {
            this.nextQuest3();
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         if(param1.questId == 10200)
         {
            this.nextQuest1();
         }
      }
      
      private function nextQuest1() : void
      {
         _processor.showMouseHintAt(480,227);
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.content.addChild(this._mc1);
         this._mc1.addEventListener(MouseEvent.CLICK,this.onMC1);
      }
      
      private function nextQuest3() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("mc2");
         this._processorMark = new AcceptableMark();
         this._processorMark.x = 643;
         this._processorMark.y = 417;
         _map.content.addChild(this._processorMark);
         _map.content.addChild(this._mc2);
         this._mc2.addEventListener(MouseEvent.CLICK,this.onMC2);
      }
      
      private function onMC2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc2.removeEventListener(MouseEvent.CLICK,this.onMC2);
         DisplayUtil.removeForParent(this._processorMark);
         NpcDialog.show(6,"克拉克",[[1,"船长！听说有来路不明的战书！"]],["克拉克你来的正好！"],[function():void
         {
            NpcDialog.show(1,"船长",[[0,"我正在召集大家开会，萨伦的幻灵骑士来了！很明显是冲着约瑟而来。战斗要开始了！"]],["船长!"],[function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[3,"船长！那个幽冥真的很厉害！我被它打败了（囧）"]],["幽冥？"],[function():void
               {
                  NpcDialog.show(6,"克拉克",[[4,"小赛尔！别着急，我想我的<font color=\'#ff0000\'>" + "伊鲁达" + "</font>能对付它！"]],["伊鲁达又是谁？"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10200_3"),function():void
                     {
                        _comMark = new InProgressMark();
                        _comMark.x = 643;
                        _comMark.y = 417;
                        _map.content.addChild(_comMark);
                        _mc2.addEventListener(MouseEvent.CLICK,onMC3);
                     });
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onMC3(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DisplayUtil.removeForParent(this._comMark);
         NpcDialog.show(6,"克拉克",[[4,"小赛尔！你想得到伊鲁达吗？"]],["那还用说！"],[function():void
         {
            NpcDialog.show(6,"克拉克",[[0,"那你必须<font color=\'#ff0000\'>" + "穿越时空" + "</font>回到我的过去才能得到它！如果你的速度比光速还快，就可以回到过去！"]],["穿越时空？好！让我试试吧！"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(_quest.id,3);
            }]);
         }]);
      }
      
      private function onMC1(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc1);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10200_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,1);
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,2911);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this.dispos();
         ModuleManager.showModule(URLUtil.getAppModule("YiludaAndYouminActPanel"),"正在打开面板...");
      }
      
      private function dispos() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._processorMark);
         DisplayUtil.removeForParent(this._comMark);
      }
      
      override public function processMapDispose() : void
      {
         this.dispos();
         super.processMapDispose();
      }
   }
}
