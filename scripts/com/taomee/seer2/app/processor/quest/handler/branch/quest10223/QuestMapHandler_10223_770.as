package com.taomee.seer2.app.processor.quest.handler.branch.quest10223
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
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10223_770 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mc6:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10223_770(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10223) && QuestManager.isStepComplete(10223,3) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         MobileManager.getMobile(80,MobileType.NPC).visible = false;
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         this._mc4["pax"].visible = false;
         _map.front.addChild(this._mc4);
         MovieClipUtil.playMc(this._mc4,2,this._mc4.totalFrames,function():void
         {
            _mack = new AcceptableMark();
            _mack.x = _mc4["pax"].x - 20;
            _mack.y = _mc4["pax"].y;
            _map.front.addChild(_mack);
            _mc4["pax"].visible = true;
            _mc4["pax"].buttonMode = true;
            _mc4["pax"].addEventListener(MouseEvent.CLICK,onClick);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc4["pax"].removeEventListener(MouseEvent.CLICK,this.onClick);
         NpcDialog.show(728,"冰凤皇",[[0,"炎煞，你已经和雷伊一战了，现在再和我单挑是没有胜算的，还是快认输吧。"]],["冰凤皇威武！"],[function():void
         {
            NpcDialog.show(708,"炎煞",[[0,"你这只冻烤鸡，谁说我要和你单挑了？"]],["难道还有同伙？"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10223_2"),function():void
               {
                  DisplayUtil.removeForParent(_mack);
                  DisplayUtil.removeForParent(_mc4);
                  initStep2();
               },true,true);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         this._mc5 = _processor.resLib.getMovieClip("mc5");
         _map.front.addChild(this._mc5);
         MovieClipUtil.playMc(this._mc5,2,this._mc5.totalFrames,function():void
         {
            _mack = new AcceptableMark();
            _mack.x = _mc5["pax"].x + 20;
            _mack.y = _mc5["pax"].y - 35;
            _map.front.addChild(_mack);
            _mc5["pax"].buttonMode = true;
            _mc5["pax"].addEventListener(MouseEvent.CLICK,onClick2);
         },true);
      }
      
      private function onClick2(param1:MouseEvent) : void
      {
         this.initStep3();
      }
      
      private function initStep3() : void
      {
         NpcDialog.show(708,"炎煞",[[0,"冻烤鸡，现在，要换你认输了吧。"]],[" 冻烤鸡小心！"],[function():void
         {
            NpcDialog.show(728,"冰凤皇",[[0,"“王”让我带回雷伊，没完成任务前，我是不会认输的。"]],[" 王到底是谁？"],[function():void
            {
               NpcDialog.show(708,"炎煞",[[0,"武煞，地煞，暗煞，超煞，我们一起上吧。"]],["五打一不公平！"],[function():void
               {
                  DisplayUtil.removeForParent(_mack);
                  DisplayUtil.removeForParent(_mc5);
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10223_3"),function():void
                  {
                     initStep4();
                  },true,true);
               }]);
            }]);
         }]);
      }
      
      private function initStep4() : void
      {
         this._mc6 = _processor.resLib.getMovieClip("mc6");
         _map.front.addChild(this._mc6);
         MovieClipUtil.playMc(this._mc6,2,this._mc6.totalFrames,function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10223_4"),function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onStepComplete);
               QuestManager.completeStep(10223,3);
            },true,true);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.getMobile(80,MobileType.NPC).visible = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc5);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
