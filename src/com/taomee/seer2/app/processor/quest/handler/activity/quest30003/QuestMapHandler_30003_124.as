package com.taomee.seer2.app.processor.quest.handler.activity.quest30003
{
   import com.taomee.seer2.app.animationInteractive.AnimationEvent;
   import com.taomee.seer2.app.animationInteractive.Interactive_41;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.target.BaseQuestStepTarget;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30003_124 extends QuestMapHandler
   {
       
      
      private var _fightStatus:Boolean = false;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _mc_3:MovieClip;
      
      private var _choosePanel:Interactive_41;
      
      private var _QuestFlag:BaseQuestStepTarget;
      
      public function QuestMapHandler_30003_124(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:int = 0;
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.executeStep1();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.loadNpc();
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false && this._fightStatus)
         {
            this._fightStatus = false;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
            }
            else
            {
               this.noWin();
            }
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isComplete(_quest.id) == false)
         {
            _loc1_ = int(_quest.getStepData(_quest.getCurrentOrNextStep().id,0));
            if(_loc1_ == 0)
            {
               this.loadClothes();
            }
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.prepareLoadPanel();
         }
      }
      
      private function executeStep1() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Handler);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onStep1Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         this.loadNpc();
      }
      
      private function loadNpc() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc_0);
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc_1);
         this._mc_1.buttonMode = true;
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onFightHandler);
      }
      
      private function onFightHandler(param1:MouseEvent) : void
      {
         this._fightStatus = true;
         FightManager.startFightWithWild(75);
      }
      
      private function win() : void
      {
         this.blackNpcSay();
      }
      
      private function noWin() : void
      {
         this.blackNpcSay();
      }
      
      private function blackNpcSay() : void
      {
         this._mc_1.removeEventListener(MouseEvent.CLICK,this.onFightHandler);
         NpcDialog.show(108,"黑衣人",[[0,"搞……什么……“伦家”都穿成这样了！还被发现了！哦妈咪妈咪哄！快看“灰机”！！！！"]],["切！你让我看我就看？"],[function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            if(_mc_1)
            {
               DisplayUtil.removeForParent(_mc_1);
            }
            _mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               NpcDialog.show(108,"黑衣人",[[0,"坑爹啊！我的衣服啊！俺娘新给俺织的！！！我们走着瞧！！！"]],[" 萨伦帝国的爪牙！！！"],[function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"异蘑谷！萨伦帝国爪牙！奇怪的图形！这背后肯定有什么阴谋！快抄写下这些图形文拿回去分析！"]],[" （点击墙壁上的图形）"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Handler);
                     QuestManager.completeStep(_quest.id,2);
                  }]);
               }]);
            },true);
         }]);
      }
      
      private function onStep2Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         this.loadClothes();
         this.prepareLoadPanel();
      }
      
      private function loadClothes() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_2 = _processor.resLib.getMovieClip("mc_4");
         _map.content.addChild(this._mc_2);
         this._mc_2.buttonMode = true;
         this._mc_2.addEventListener(MouseEvent.CLICK,this.onPickUpCloth);
      }
      
      private function onPickUpCloth(param1:MouseEvent) : void
      {
         this._mc_2.removeEventListener(MouseEvent.CLICK,this.onPickUpCloth);
         DisplayUtil.removeForParent(this._mc_2);
         this._mc_3 = _processor.resLib.getMovieClip("mc_13");
         _map.content.addChild(this._mc_3);
         _quest.setStepData(_quest.getCurrentOrNextStep().id,0,1);
         QuestManager.setStepBufferServer(_quest.id,_quest.getCurrentOrNextStep().id);
      }
      
      private function prepareLoadPanel() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onLoadPanel);
      }
      
      private function onLoadPanel(param1:MouseEvent) : void
      {
         this.loadPanel();
      }
      
      private function loadPanel() : void
      {
         this._choosePanel = new Interactive_41();
         this._choosePanel.setup("interactive_41");
         this._choosePanel.addEventListener(AnimationEvent.SELECT,this.onContinue);
      }
      
      private function onContinue(param1:Event) : void
      {
         var e:Event = param1;
         this._choosePanel.removeEventListener(AnimationEvent.SELECT,this.onContinue);
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"搞定！看来我天生记忆力不错啊！哎呀！差点误了正事！快赶往资料室找娜威拉翻译……"]],["（赶往资料室）"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Handler);
            QuestManager.completeStep(_quest.id,3);
         }]);
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         SceneManager.changeScene(SceneType.LOBBY,30);
      }
      
      override public function processMapDispose() : void
      {
         if(this._choosePanel)
         {
            this._choosePanel.dispose();
            this._choosePanel = null;
         }
      }
   }
}
