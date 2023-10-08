package com.taomee.seer2.app.processor.quest.handler.branch.quest10090
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
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
   
   public class QuestMapHandler_10090_870 extends QuestMapHandler
   {
       
      
      private var _fightStatus:Boolean;
      
      private var _hasPlay:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      public function QuestMapHandler_10090_870(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            if(!this._hasPlay)
            {
               this.playFullMc();
            }
            else if(this._fightStatus)
            {
               this._fightStatus = false;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.win();
               }
               else
               {
                  this.lose();
               }
            }
         }
      }
      
      private function playFullMc() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10090_0"),function():void
         {
            _hasPlay = true;
            _mc_1 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(_mc_1);
            NpcDialog.show(118,"洛奇",[[0,"怎么？不到黄河心不死？要不要让我的小宝贝来教训你呢？黑暗……米咔！上！"]],["小米……"],[function():void
            {
               _mc_0 = _processor.resLib.getMovieClip("mc_6");
               _map.front.addChild(_mc_0);
               MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_mc_0);
                  _mc_0 = _processor.resLib.getMovieClip("mc_2");
                  _map.front.addChild(_mc_0);
                  _mc_0.buttonMode = true;
                  _mc_0.addEventListener(MouseEvent.CLICK,fightMikaHandler);
               },true);
            }]);
         },false,false,1);
      }
      
      private function fightMikaHandler(param1:MouseEvent) : void
      {
         this._fightStatus = true;
         FightManager.startFightWithWild(106);
      }
      
      private function win() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10090_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         },true,false,2);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         SceneManager.changeScene(SceneType.LOBBY,770);
      }
      
      private function lose() : void
      {
         var myself:Actor = null;
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.fightMikaHandler);
         this._mc_1 = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._mc_1);
         this._mc_2 = _processor.resLib.getMovieClip("State_1");
         myself = ActorManager.getActor();
         myself.hide();
         this._mc_2.x = myself.x;
         this._mc_2.y = myself.y;
         _map.content.addChild(this._mc_2);
         MovieClipUtil.playMc(this._mc_2,1,this._mc_2.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc_2);
            myself.show();
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"我们说好的！你不走我就不走！我不会丢下你一个！（咦？黑色的火焰似乎有点削弱了）"]],["继续挑战，直到它清醒"," 我一会就来！我不会扔下你！"],[function():void
            {
               _fightStatus = true;
               myself.show();
               FightManager.startFightWithWild(106);
            }]);
         },true);
      }
      
      override public function processMapDispose() : void
      {
      }
   }
}
