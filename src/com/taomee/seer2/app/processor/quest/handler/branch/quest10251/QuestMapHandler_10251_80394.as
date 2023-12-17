package com.taomee.seer2.app.processor.quest.handler.branch.quest10251
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10251_80394 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _equipMc:MovieClip;
      
      public function QuestMapHandler_10251_80394(param1:QuestProcessor)
      {
         super(param1);
      }
      
      private static function onEquip(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(324,"白雪公主",[[0,ActorManager.actorInfo.nick + "，眼前这就是蚀魂兽之卵。用头部射击打破它，唤醒蚀魂兽吧！ "]],["使用头部射击打破蚀魂兽之卵"],[function():void
         {
         }]);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         QueueLoader.load(URLUtil.getActivityAnimation("vipAnimation/chongluan"),LoadType.SWF,this.onResLoaded);
      }
      
      private function onResLoaded(param1:ContentInfo) : void
      {
         var _loc2_:MovieClip = param1.content as MovieClip;
         this._equipMc = _loc2_["equipMc"];
         this._equipMc.x = 1030;
         this._equipMc.y = 440;
         this._equipMc.gotoAndStop(1);
         this._equipMc.buttonMode = true;
         this._equipMc.addEventListener(MouseEvent.CLICK,onEquip);
         _map.content.addChild(this._equipMc);
         RightToolbarConter.instance.hide();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         if(!QuestManager.isAccepted(questID))
         {
            this.initAccept();
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false)
         {
            if(QuestManager.isStepComplete(questID,1) == false)
            {
               this.initStep1();
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         super.processMapDispose();
      }
      
      private function initAccept() : void
      {
         QuestManager.accept(questID);
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == 10251)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(106,"斯坦因博士",[[0,"我能感受到蚀魂兽的呼唤~~~~~~~快来到我身边吧！奎尔斯之利齿！ "]],["那个蛋就是蚀魂兽吗？"],[function():void
         {
            NpcDialog.show(106,"斯坦因博士",[[0,"这是虫群氏族的守护魂兽特有的休眠方式，只要打破这虫卵就能够唤醒蚀魂兽。 "]],["我们动手吧！"],[function():void
            {
               _mc1 = _processor.resLib.getMovieClip("Mc10251_0");
               _map.front.addChild(_mc1);
               _mc1.gotoAndStop(1);
               MovieClipUtil.playMc(_mc1,1,_mc1.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc1);
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleted);
                  QuestManager.completeStep(questID,1);
               },true);
            }]);
         }]);
      }
      
      private function onCompleted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleted);
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         SceneManager.changeScene(SceneType.LOBBY,3838);
      }
   }
}
