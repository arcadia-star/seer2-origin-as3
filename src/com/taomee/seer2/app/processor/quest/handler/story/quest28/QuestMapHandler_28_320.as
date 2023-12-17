package com.taomee.seer2.app.processor.quest.handler.story.quest28
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_28_320 extends QuestMapHandler
   {
       
      
      private var _shaNpc:MovieClip;
      
      public function QuestMapHandler_28_320(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false)
         {
            this.createAcceptNpc();
            this._shaNpc["sha"].addEventListener(MouseEvent.CLICK,this.onAcceptClick);
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false)
         {
            this.createInprogressNpc();
            this._shaNpc["sha"].addEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
         }
      }
      
      private function onAcceptClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(56,"神爪财团老板",[[0,"汪总管已经布置下去了？嗯，他办事我真是一万个放心，到底跟在我身边好多年了。"]],["真的要对峙吗？"],[function():void
         {
            NpcDialog.show(57,"先知",[[0,"地沙之战……势在必行……化解多年的积怨……若非你死……便是我亡……！"]],["化解积怨不能通过战争啊！！"],[function():void
            {
               NpcDialog.show(56,"神爪财团老板",[[0,"注意你的言词朋友，先知大人曾引领我族走过重重危急，只要是先知大人的意思，我绝对尊崇！"]],["就不问清楚原因吗……"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
                  QuestManager.accept(_quest.id);
               }]);
            }]);
         }]);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
            this._shaNpc["sha"].removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this.onInterimNpcClick(null);
         }
      }
      
      private function onInterimNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(56,"神爪财团老板",[[0,"多亏了先知大人，我才看清楚地月粗鬼的真面目！如今我一定会彻底击溃他们的盲目自信。你，陪我去约定地点：三八跑道线。"]],["（去三八跑道线（沙）！）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,310);
         }]);
      }
      
      private function createInprogressNpc() : void
      {
         this._shaNpc = _processor.resLib.getMovieClip("npc_0_1");
         this._shaNpc.x = 650;
         this._shaNpc.y = 345;
         _map.content.addChild(this._shaNpc);
         this._shaNpc["sha"].buttonMode = true;
      }
      
      private function createAcceptNpc() : void
      {
         this._shaNpc = _processor.resLib.getMovieClip("npc_0_0");
         this._shaNpc.x = 650;
         this._shaNpc.y = 345;
         _map.content.addChild(this._shaNpc);
         this._shaNpc["sha"].buttonMode = true;
      }
      
      private function clearNpc() : void
      {
         if(this._shaNpc)
         {
            this._shaNpc["sha"].removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this._shaNpc["sha"].removeEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.clearNpc();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         super.processMapDispose();
      }
   }
}
