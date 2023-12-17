package com.taomee.seer2.app.processor.quest.handler.story.quest39
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.PointUtil;
   import com.taomee.seer2.core.utils.effect.EffectShake;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_39_7201 extends QuestMapHandler
   {
       
      
      private var _fightStatus:Boolean = false;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_39_7201(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initmc();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initFight();
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false && this._fightStatus)
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
      }
      
      private function initmc() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         this._mc_1 = _processor.resLib.getMovieClip("mc_5");
         this._mc = this._mc_1.getChildAt(0) as MovieClip;
         if(this._mc)
         {
            PointUtil.switchPointToParent(this._mc);
            _map.content.addChild(this._mc);
         }
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onStewardTalk);
      }
      
      private function onStewardTalk(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(97,"财务官",[[1,"博士，是不是已经大功告成了？他们已经开始怀疑我了……不过没关系，我们马上就离开这里！"]],["(斯坦因……斯坦因居然在这里？！）"],[function():void
         {
            NpcDialog.show(106,"斯坦因博士",[[1,"桀桀桀……太美妙了……太美妙了……这拘束器……桀桀桀……"]],["（他果然是个疯子……！）"],[function():void
            {
               NpcDialog.show(97,"财务官",[[1,"太好了，看来是完成了，博士，我们赶快走吧？"]],["想走哪去！当我是摆设啊！"],[function():void
               {
                  NpcDialog.show(106,"斯坦因博士",[[1,"（用怪异的眼神打量我）桀桀桀……新一代的赛尔机型……很出色……太美妙了……"]],["？？？=。="],[function():void
                  {
                     NpcDialog.show(41,"紫电队大兵",[[0,"女王陛下将会亲自迎接博士回去，我二人将负责掩护撤退！请博士做好准备！"]],["女王陛下要过来？"],[function():void
                     {
                        _mc_0.removeEventListener(MouseEvent.CLICK,onStewardTalk);
                        DisplayUtil.removeForParent(_mc_0);
                        DisplayUtil.removeForParent(_mc);
                        _mc_0 = _processor.resLib.getMovieClip("mc_6");
                        _map.front.addChild(_mc_0);
                        EffectShake.addShake(LayerManager.root,20,20,99,99);
                        MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                        {
                           EffectShake.deleteShake(LayerManager.root);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
                           QuestManager.completeStep(_quest.id,2);
                        },true);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         NpcDialog.show(41,"紫电队大兵",[[0,"那么……我们现在开始料理后事。"]],["要打架？！放马过来！！"],[function():void
         {
            FightManager.startFightWithWild(74,function():void
            {
               _fightStatus = true;
            },function():void
            {
               _fightStatus = false;
            });
         }]);
      }
      
      private function initFight() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_7");
         this._mc = this._mc_0.getChildAt(0) as MovieClip;
         if(this._mc)
         {
            PointUtil.switchPointToParent(this._mc);
            _map.content.addChild(this._mc);
         }
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.CLICK,this.onFightHandler);
      }
      
      private function onFightHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(41,"紫电队大兵",[[0,"那么……我们现在开始料理后事。"]],["要打架？！放马过来！！"],[function():void
         {
            FightManager.startFightWithWild(74,function():void
            {
               _fightStatus = true;
            },function():void
            {
               _fightStatus = false;
            });
         }]);
      }
      
      private function win() : void
      {
         NpcDialog.show(41,"紫电队大兵",[[0,"暂时撤退！！"]],["站住！！"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         }]);
      }
      
      private function noWin() : void
      {
         NpcDialog.show(41,"撤退！！",[[0,"撤退！！"]],["等一下！","还是算了……"],[function():void
         {
            FightManager.startFightWithWild(74,function():void
            {
               _fightStatus = true;
            },function():void
            {
               _fightStatus = false;
            });
         }]);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         DisplayUtil.removeForParent(this._mc);
         SceneManager.changeScene(SceneType.LOBBY,660);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mc_1);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
      }
   }
}
