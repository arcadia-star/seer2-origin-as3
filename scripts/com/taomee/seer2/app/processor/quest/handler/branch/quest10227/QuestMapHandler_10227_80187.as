package com.taomee.seer2.app.processor.quest.handler.branch.quest10227
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10227_80187 extends QuestMapHandler
   {
      
      public static var haveBattle:Boolean = true;
       
      
      private var _mc1:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10227_80187(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!haveBattle)
         {
            return;
         }
         super.processMapComplete();
         if(QuestManager.isAccepted(10227) && QuestManager.isStepComplete(10227,1) == false)
         {
            _map.content.visible = false;
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            onSpeak1();
         },true);
      }
      
      private function onSpeak1() : void
      {
         NpcDialog.show(400,ActorManager.actorInfo.nick + "",[[0,"切希尔！它……突然消失了！ "]],[" 好像钻到了一个洞里！"],[function():void
         {
            NpcDialog.show(616,"观星者",[[0,"那就是噬星界108星最可怕的能力！制造黑洞！"]],[" 制造黑洞！？"],[function():void
            {
               NpcDialog.show(616,"观星者",[[0,"他们可以随时随地的制造与自己能力相符的黑洞，通过黑洞隐藏在自己的世界中。要战胜他们唯一的方法，就是进入黑洞。"]],["进入黑洞？"],[function():void
               {
                  NpcDialog.show(736,"赫",[[0,"我听过一个传说，有位传说中的武士，可以斩开黑洞的空间。"]],["传说武士！"],[function():void
                  {
                     NpcDialog.show(616,"观星者",[[0,"是的，现在也只能去找这位传说中的武士了。不过可能的话，我还是不太想拜托他呢……"]],[" 究竟是谁？"],[function():void
                     {
                        DisplayUtil.removeForParent(_mack);
                        DisplayUtil.removeForParent(_mc1);
                        initStep2();
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10227_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(10227,1);
         },true,true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80145);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
