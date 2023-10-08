package com.taomee.seer2.app.processor.quest.handler.branch.quest10135
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10135_770 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _fightStatus:Boolean;
      
      public function QuestMapHandler_10135_770(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && this._fightStatus)
            {
               this._fightStatus = false;
               this.playFullMC();
            }
            else
            {
               this.addSMC();
               this.addTalk();
            }
         }
      }
      
      private function addSMC() : void
      {
         var _loc1_:MovieClip = null;
         this._mc_0 = _processor.resLib.getMovieClip("chuan");
         _map.content.addChild(this._mc_0);
         _loc1_ = this._mc_0["xi"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onMeTalkHandler);
      }
      
      private function addTalk() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("talk");
         _map.front.addChild(this._mc_1);
         MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,function():void
         {
            meSay();
         },true);
      }
      
      private function onMeTalkHandler(param1:MouseEvent) : void
      {
         this.meSay();
      }
      
      private function meSay() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"拿……拿开你的脏手！橡皮神君！我来带你走！"]],["进行精灵对战","我准备好再来找你！"],[function():void
         {
            _fightStatus = true;
            FightManager.startFightWithWild(198);
         }]);
      }
      
      private function playFullMC() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10135_1"),function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            if(_mc_1)
            {
               DisplayUtil.removeForParent(_mc_1);
            }
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"解铃还须系铃人，看来只有找马良才能找寻橡皮神君了！"]],["（马良在风暴悬崖）"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
               QuestManager.completeStep(_quest.id,1);
            }]);
         },false,false,2);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         SceneManager.changeScene(SceneType.LOBBY,891);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
      }
   }
}
