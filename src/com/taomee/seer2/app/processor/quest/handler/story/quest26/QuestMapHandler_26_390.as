package com.taomee.seer2.app.processor.quest.handler.story.quest26
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_26_390 extends QuestMapHandler
   {
       
      
      private var _diNpc:MovieClip;
      
      public function QuestMapHandler_26_390(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false)
         {
            this.createInprogressNpc();
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onInprogressNpcClick);
         }
      }
      
      private function onInprogressNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(55,"神月老大",[[0,"哼，洒家就在这里等那些沙爪财奴！"]],["三思啊老大……"],[function():void
         {
            NpcDialog.show(55,"神月老大",[[0,"不用三思了，洒家决心已定！另外，洒家需要一个使者出面交涉，就决定是你了！"]],["……"],[function():void
            {
               NpcDialog.show(55,"神月老大",[[0,"洒家不愿意和沙爪财奴说话！这是我亲手签名的使者令，拿去！"]],["亲手签名啊……"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleted);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            }]);
         }]);
      }
      
      private function onCompleted(param1:QuestEvent) : void
      {
         if(param1.questId == 26)
         {
            this.processMapDispose();
            this.showMessage();
         }
      }
      
      private function showMessage() : void
      {
         if(QuestManager.isCanAccepted(27) || QuestManager.isCanAccepted(28))
         {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>沙爪氏族主城</font> 找 <font color=\'#ffcc00\'>神爪财团老板</font>");
         }
         else if(QuestManager.isStepComplete(27,1) == false)
         {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>淘米市场</font> 找 <font color=\'#ffcc00\'>汪总管</font>");
         }
         else if(QuestManager.isStepComplete(28,1) == false)
         {
            ServerMessager.addMessage("下一步: 前往 <font color=\'#ffcc00\'>三八跑道线（沙）</font> 找 <font color=\'#ffcc00\'>神爪财团老板</font>");
         }
      }
      
      private function createInprogressNpc() : void
      {
         this._diNpc = _processor.resLib.getMovieClip("npc_1_0");
         this._diNpc.x = 567;
         this._diNpc.y = 355;
         _map.content.addChild(this._diNpc);
         this._diNpc.buttonMode = true;
      }
      
      private function clearDiNpc() : void
      {
         if(this._diNpc)
         {
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onInprogressNpcClick);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.clearDiNpc();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleted);
         super.processMapDispose();
      }
   }
}
