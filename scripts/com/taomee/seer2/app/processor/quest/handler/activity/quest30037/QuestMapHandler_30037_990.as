package com.taomee.seer2.app.processor.quest.handler.activity.quest30037
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
   
   public class QuestMapHandler_30037_990 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _soldier:MovieClip;
      
      private var _talkMC1:MovieClip;
      
      private var _talkMC2:MovieClip;
      
      public function QuestMapHandler_30037_990(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initFirstMc();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initAllMC();
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               this.initSoldier();
               this.duoluoTalk();
            }
            else
            {
               this.initSecondMC();
            }
         }
      }
      
      private function initFirstMc() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            if(_mc_0 != null)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("npc");
            _map.content.addChild(_mc_0);
            _mc_1 = _processor.resLib.getMovieClip("pet");
            _map.content.addChild(_mc_1);
            _mc_1.buttonMode = true;
            _mc_1.addEventListener(MouseEvent.CLICK,onNPCTalkHandler);
         },true);
      }
      
      private function onNPCTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(516,"卜古塔",[[2,"……嘤嘤嘤……一回到这里我就想起了那段可怕的回忆……"]],["什么回忆？"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30037_1"),function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"……………………"]],["……"],[function():void
               {
                  NpcDialog.show(11,"多罗",[[0,"……………………"]],["……"],[function():void
                  {
                     NpcDialog.show(516,"卜古塔",[[2,"这导致我患上了严重的颈椎病，而且，这里的空气质量越来越差，大家都不愿意再住在这里了……嘤嘤嘤……"]],["……"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2CompleteHandler);
                        QuestManager.completeStep(_quest.id,2);
                     }]);
                  }]);
               }]);
            },true,false,2);
         }]);
      }
      
      private function onStep2CompleteHandler(param1:QuestEvent) : void
      {
         this._mc_1.removeEventListener(MouseEvent.CLICK,this.onNPCTalkHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2CompleteHandler);
         this.initSecondMC();
      }
      
      private function initAllMC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("npc");
         _map.content.addChild(this._mc_0);
         this._mc_1 = _processor.resLib.getMovieClip("pet1");
         _map.content.addChild(this._mc_1);
      }
      
      private function initSecondMC() : void
      {
         var come:MovieClip = _processor.resLib.getMovieClip("come");
         _map.content.addChild(come);
         MovieClipUtil.playMc(come,1,come.totalFrames,function():void
         {
            initSoldier();
            _talkMC1 = _processor.resLib.getMovieClip("mc_5");
            _map.front.addChild(_talkMC1);
            MovieClipUtil.playMc(_talkMC1,1,_talkMC1.totalFrames,function():void
            {
               FightManager.startFightWithWild(166);
            },true);
         },true);
      }
      
      private function initSoldier() : void
      {
         this._soldier = _processor.resLib.getMovieClip("soldier");
         _map.content.addChild(this._soldier);
         this._soldier.buttonMode = true;
         this._soldier.addEventListener(MouseEvent.CLICK,this.onFightHandler);
      }
      
      private function onFightHandler(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(166);
      }
      
      private function duoluoTalk() : void
      {
         NpcDialog.show(11,"多罗",[[3,"都是因为你们这些砍伐者砍伐了过多的树木才导致二氧化碳浓度过高才导致草泥马宝宝慢性中毒！"]],["（什么时候那么有知识了……）"],[function():void
         {
            NpcDialog.show(11,"多罗",[[3,"咳！请叫我多罗老师……总之，植物可以通过光合作用将二氧化碳和水转化为有机物并释放出氧气！"]],["植物是我们的空气质量卫士！"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"没有植物，空气中的二氧化碳浓度就会超标，甚至形成温室效应……为了眼前的利益，破坏整个星球的环境，这是错误的！"]],["难道你们想让大家都变得和之前的卜古塔一样？！"],[function():void
               {
                  _talkMC2 = _processor.resLib.getMovieClip("mc_6");
                  _map.front.addChild(_talkMC2);
                  MovieClipUtil.playMc(_talkMC2,1,_talkMC2.totalFrames,function():void
                  {
                     var out:*;
                     if(_soldier != null)
                     {
                        DisplayUtil.removeForParent(_soldier);
                     }
                     out = _processor.resLib.getMovieClip("out");
                     _map.content.addChild(out);
                     MovieClipUtil.playMc(out,1,out.totalFrames,function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"虽然赶走了砍伐者，但是这并无法挽救普兰特山麓。看来我们有更重要的事情要做。"]],["为了草泥马宝宝的健康，我们还有很多事情要做"],[function():void
                        {
                           NpcDialog.show(516,"卜古塔",[[3,"喂……"]],["嗯，任重而道远啊！！"],[function():void
                           {
                              QuestManager.addEventListener(QuestEvent.COMPLETE,onStep3CompleteHandler);
                              QuestManager.completeStep(_quest.id,3);
                           }]);
                        }]);
                     },true);
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function onStep3CompleteHandler(param1:QuestEvent) : void
      {
         if(this._mc_0 != null)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1 != null)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3CompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._mc_0 != null)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1 != null)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2CompleteHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep3CompleteHandler);
      }
   }
}
