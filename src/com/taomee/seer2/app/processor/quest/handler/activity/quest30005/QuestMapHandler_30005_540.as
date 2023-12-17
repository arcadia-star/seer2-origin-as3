package com.taomee.seer2.app.processor.quest.handler.activity.quest30005
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30005_540 extends QuestMapHandler
   {
       
      
      private var _fightStatus:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_30005_540(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(3) as Teleport;
         if(QuestManager.isComplete(_quest.id) == false)
         {
            ActorManager.showRemoteActor = false;
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._teleport.visible = false;
            this.loadFullScreen();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this._teleport.visible = false;
            this.loadTortoise();
            if(this._fightStatus)
            {
               this._fightStatus = false;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winFirst();
               }
               else
               {
                  this.noWinFirst();
               }
               return;
            }
         }
      }
      
      private function loadFullScreen() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30005_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Handler);
            QuestManager.completeStep(_quest.id,2);
         },true,false,2);
      }
      
      private function onStep2Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         this.loadTortoise();
      }
      
      private function loadTortoise() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onFightTortoise);
      }
      
      private function onFightTortoise(param1:MouseEvent) : void
      {
         this._fightStatus = true;
         FightManager.startFightWithWild(81);
      }
      
      private function winFirst() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30005_1"),function():void
         {
            if(_mc_0)
            {
               _mc_0.removeEventListener(MouseEvent.CLICK,onFightTortoise);
               DisplayUtil.removeForParent(_mc_0);
            }
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"什么……他们究竟在精灵身上做了什么！！！雷伊……雷伊不会也……！"]],["（他们就在冰之监狱）"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Handler);
               QuestManager.completeStep(_quest.id,3);
            }]);
         },false,false,2);
      }
      
      private function noWinFirst() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"可恶！他们怎么像铜墙铁壁！让开啊！我要救雷伊！！！"]],["（继续对战）","（我准备好再来！）"],[function():void
         {
            _fightStatus = true;
            FightManager.startFightWithWild(81);
         }]);
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         this._teleport.visible = true;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         SceneManager.changeScene(SceneType.LOBBY,570);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
      }
   }
}
