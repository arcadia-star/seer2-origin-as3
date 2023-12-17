package com.taomee.seer2.app.processor.quest.handler.story.quest63
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_63_10106 extends QuestMapHandler
   {
       
      
      private var _mother:MovieClip;
      
      private var _s:MovieClip;
      
      private var _pet:MovieClip;
      
      private var _mc_0:MovieClip;
      
      private var _xl:MovieClip;
      
      private var _game:Game63;
      
      public function QuestMapHandler_63_10106(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addNpc(0);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.addNpc(1);
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.addS();
         }
      }
      
      private function addNpc(param1:int) : void
      {
         this._mother = _processor.resLib.getMovieClip("ma");
         _map.content.addChild(this._mother);
         this._s = _processor.resLib.getMovieClip("s");
         _map.content.addChild(this._s);
         this._mother.buttonMode = true;
         if(param1 == 0)
         {
            this._mother.addEventListener(MouseEvent.CLICK,this.onPlayMCHandler);
         }
         else
         {
            this._mother.addEventListener(MouseEvent.CLICK,this.onMotherTalkHandler);
         }
      }
      
      private function onPlayMCHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("63_0"),6,[[1,0]],function():void
         {
            _mc_0 = _processor.resLib.getMovieClip("talk1");
            LayerManager.topLayer.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               _game = new Game63(_processor.resLib.getMovieClip("game63"),gameComplete);
            },true);
         });
      }
      
      private function gameComplete() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("63_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         },true,false,2);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         this.motherTalk();
      }
      
      private function onMotherTalkHandler(param1:MouseEvent) : void
      {
         this.motherTalk();
      }
      
      private function motherTalk() : void
      {
         NpcDialog.show(171,"S的妈妈",[[0,"我这里还有一件你爸爸让我留给你的礼物"]],[],[function():void
         {
            NpcDialog.show(171,"S的妈妈",[[0,"你看到这个房间中的那个雕像了吗？这曾经是你爸爸使用的精灵，他怕精灵被坏人利用，就把它封存在石像里了。"]],[],[function():void
            {
               NpcDialog.show(171,"S的妈妈",[[0,"你爸爸说能重新启用这只精灵的人只有你了。他说开启精灵的钥匙就在你的身上。"]],[],[function():void
               {
                  if(_s)
                  {
                     DisplayUtil.removeForParent(_s);
                  }
                  _s = _processor.resLib.getMovieClip("ls");
                  _map.content.addChild(_s);
                  _s.buttonMode = true;
                  _s.addEventListener(MouseEvent.CLICK,onClickLightSHandler);
                  if(_mother)
                  {
                     DisplayUtil.removeForParent(_mother);
                  }
                  _mother = _processor.resLib.getMovieClip("ma1");
                  _map.content.addChild(_mother);
               }]);
            }]);
         }]);
      }
      
      private function onClickLightSHandler(param1:MouseEvent) : void
      {
         this._xl = _processor.resLib.getMovieClip("xl");
         LayerManager.topLayer.addChild(this._xl);
         this._xl.startDrag(true);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         LayerManager.topLayer.addChild(this._mc_0);
         var _loc2_:MovieClip = this._mc_0["light"];
         _loc2_.buttonMode = true;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClickLightHandler);
      }
      
      private function onClickLightHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._xl.stopDrag();
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._xl)
         {
            DisplayUtil.removeForParent(this._xl);
         }
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("63_1"),function():void
         {
            if(_s)
            {
               DisplayUtil.removeForParent(_s);
            }
            if(_mother)
            {
               DisplayUtil.removeForParent(_mother);
            }
            _s = _processor.resLib.getMovieClip("s");
            _map.content.addChild(_s);
            _mother = _processor.resLib.getMovieClip("ma1");
            _map.content.addChild(_mother);
            _pet = _processor.resLib.getMovieClip("pet");
            _map.content.addChild(_pet);
            _pet.buttonMode = true;
            _pet.addEventListener(MouseEvent.CLICK,onClickPetHandler);
         },true,false,2);
      }
      
      private function onClickPetHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc_0 = _processor.resLib.getMovieClip("talk2");
         LayerManager.topLayer.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         },true);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         this.sTalk();
      }
      
      private function addS() : void
      {
         this._mother = _processor.resLib.getMovieClip("ma1");
         _map.content.addChild(this._mother);
         this._s = _processor.resLib.getMovieClip("s1");
         _map.content.addChild(this._s);
         this._s.buttonMode = true;
         this._s.addEventListener(MouseEvent.CLICK,this.onClickSMCHandler);
      }
      
      private function onClickSMCHandler(param1:MouseEvent) : void
      {
         this.sTalk();
      }
      
      private function sTalk() : void
      {
         NpcDialog.show(14,"S",[[0,"我的身世已经解开了，原来萨伦才是我真正的仇人！"]],["S跟我们一起对抗萨伦帝国吧！"],[function():void
         {
            NpcDialog.show(14,"S",[[0,"你们？呵呵！这条路我要一个人走下去！我要亲手……"]],["你……我们是想帮你"],[function():void
            {
               NpcDialog.show(14,"S",[[0,"我不需要依赖任何人！你们最好也别碍手碍脚！既然你把我妈妈送回来了，现在她安全了，你可以回去了。"]],["那对赛尔号2的袭击呢？"],[function():void
               {
                  NpcDialog.show(14,"S",[[0,"我会取消这次对赛尔号2的袭击，你回去告诉辛迪，这次就到此为止。"]],["你以后怎么打算？"],[function():void
                  {
                     NpcDialog.show(14,"S",[[0,"以后再见时将是一个全新的我！还有我的精灵撒旦！我会回到萨伦帝国，因为我有了一个新的计划！"]],["新的计划…"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep4Complete);
                        QuestManager.completeStep(_quest.id,4);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep4Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Complete);
         SceneManager.changeScene(SceneType.LOBBY,10);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mother)
         {
            DisplayUtil.removeForParent(this._mother);
         }
         if(this._s)
         {
            DisplayUtil.removeForParent(this._s);
         }
         if(this._pet)
         {
            DisplayUtil.removeForParent(this._pet);
         }
         if(this._xl)
         {
            DisplayUtil.removeForParent(this._xl);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Complete);
      }
   }
}
