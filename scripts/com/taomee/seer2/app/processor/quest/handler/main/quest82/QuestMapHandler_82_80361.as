package com.taomee.seer2.app.processor.quest.handler.main.quest82
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_82_80361 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _npc:Mobile;
      
      private var _npc1:Mobile;
      
      private var fightFirstID:Array;
      
      public function QuestMapHandler_82_80361(param1:QuestProcessor)
      {
         this.fightFirstID = [1372];
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(questID))
         {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               this.onSwitchComplete();
            }
            else
            {
               this.createNpc();
            }
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
         {
            this.createNpc1();
         }
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete1(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._npc = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep1() : void
      {
         this.createNpcMoLian();
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("82_0"),function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"大家都还好吗？"]],["巴蒂、多罗、小梦、雷霆，你们怎么样？"],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"我们都好，但是雷霆，刚才为了保护我们，自己承受了大部分撞击的力量，现在晕过去了！"]],["！！"],[function():void
               {
                  NpcDialog.show(1021,"帕斯塔",[[0,"它没事，休息一会儿就会醒。"]],["你是谁？"],[function():void
                  {
                     NpcDialog.show(11,"多罗",[[0,"这、这是哪儿？"]],[" 似乎……是个武斗场？"],[function():void
                     {
                        NpcDialog.show(1021,"帕斯塔",[[0,"你们猜的不错，这里，就是太空武斗场。至于我，还有我身边这位，就是这里的主人。"]],[" ！！"],[function():void
                        {
                           NpcDialog.show(1022,"阿修雷",[[1,"哈哈哈哈，在这里，战斗就是一切！实力决定你的命运！"]],[" 我们还有正事要做，就不奉陪了"],[function():void
                           {
                              NpcDialog.show(1021,"帕斯塔",[[0,"不，你们走不了了。刚才你们的飞船直接撞到了这里，武斗场也因此遭到了破坏。所以，你们得留在这里。"]],[" 留在这里？留在这里做什么！"],[function():void
                              {
                                 NpcDialog.show(1022,"阿修雷",[[1,"笑话，当然是留下武斗了！你们破坏了武斗场，就必须有所惩罚！留在这里，赢得100场连胜，你们才能离开！否则，你们将在这里，永世为奴！"]],["什么！"],[function():void
                                 {
                                    NpcDialog.show(10,"巴蒂",[[3,"我们可以用其他方式弥补呀，凭什么要我们留在这里！"]],["就是！"],[function():void
                                    {
                                       NpcDialog.show(1021,"帕斯塔",[[0,"这里是太空武斗场，所以，你们必须遵守这里的规则。"]],["……"],[function():void
                                       {
                                          initContinue();
                                       }]);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },false);
      }
      
      private function initContinue() : void
      {
         MobileManager.removeMobile(this._npc1,MobileType.NPC);
         this._npc1 = null;
         this._mc1 = _processor.resLib.getMovieClip("Mc82_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            initStep1Complete();
         },true);
      }
      
      private function initStep1Complete() : void
      {
         QuestManager.completeStep(questID,1);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onComplete1);
      }
      
      private function onComplete1(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete1);
         this.initStep2();
      }
      
      private function initStep2() : void
      {
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(1021,MobileType.NPC);
            this._npc.buttonMode = true;
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
      }
      
      private function initStep2Continue(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1021,"帕斯塔",[[0,"不要妄想逃跑，否则，你们的下场将会和它一样。"]],["它、它死了么？"],[function():void
         {
            NpcDialog.show(1021,"帕斯塔",[[0,"它实力不弱，这么一下还死不了，不过得有很长一段时间失去战斗能力了。"]],["……"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"（这样倒不必担心堕落族长的追踪了，但留在这里恐怕也……）"]],["……"],[function():void
               {
                  NpcDialog.show(1022,"阿修雷",[[1,"哈哈哈哈，战斗吧，小赛尔们，你们没有其他选择！毁灭者，过来！替我招呼一下他们！"]],["小心！"],[function():void
                  {
                     initStep2Fight();
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep2Fight() : void
      {
         FightManager.startFightWithWild(this.fightFirstID[0]);
      }
      
      private function onSwitchComplete() : void
      {
         var result:uint = 0;
         if(this.fightFirstID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            result = FightManager.fightWinnerSide;
            if(result == FightSide.RIGHT)
            {
               NpcDialog.show(400,"小赛尔",[[0,"好……强……"]],["……"],[function():void
               {
                  NpcDialog.show(1022,"阿修雷",[[1,"此战，毁灭者胜！切，你们居然这么弱！好吧，既然这样，你们先和低级的精灵打打吧！"]],["……"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("82_1"),function():void
                     {
                        QuestManager.completeStep(questID,2);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete2);
                     },false);
                  }]);
               }]);
            }
            else if(result == FightSide.LEFT)
            {
               NpcDialog.show(400,"小赛尔",[[0,"好……强……"]],["……"],[function():void
               {
                  NpcDialog.show(1022,"阿修雷",[[1,"此战，毁灭者胜！切，你们居然这么弱！好吧，既然这样，你们先和低级的精灵打打吧！"]],["……"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("82_1"),function():void
                     {
                        QuestManager.completeStep(questID,2);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete2);
                     },false);
                  }]);
               }]);
            }
         }
      }
      
      private function onComplete2(param1:QuestEvent) : void
      {
         this._mc1 = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete2);
         this.initStep3();
      }
      
      private function initStep3() : void
      {
         this.createNpc1();
      }
      
      private function createNpc1() : void
      {
         var _loc1_:InProgressMark = null;
         MobileManager.removeMobile(this._npc,MobileType.NPC);
         this._npc = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(1021,MobileType.NPC);
            this._npc.buttonMode = true;
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep3Continue);
         }
      }
      
      private function initStep3Continue(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1021,"帕斯塔",[[0,"在太空武斗场，如果对手是弱势精灵，那么你也只能选择同等级别的精灵出战。小赛尔，你的高级精灵是不能使用。"]],["什么？！"],[function():void
         {
            NpcDialog.show(766,"小梦",[[0,"小赛尔，这种战斗模式对你的技术和平时的培养有很高的要求！但是你放心，我会陪你战斗！我相信，我们一定可以顺利离开这里，回到地球！"]],["嗯，我会尽力的"],[function():void
            {
               NpcDialog.show(829,"雷霆",[[0,"还有我，我会一直守护着你们。让我们一起为胜利而战！"]],["一起努力！"],[function():void
               {
                  initStep3End();
               }]);
            }]);
         }]);
      }
      
      private function initStep3End() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("82_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(questID,3);
         },false);
      }
      
      private function createNpcMoLian() : void
      {
         if(!this._npc1)
         {
            this._npc1 = new Mobile();
            this._npc1.width = 100;
            this._npc1.height = 200;
            this._npc1.setPostion(new Point(499,496));
            this._npc1.resourceUrl = URLUtil.getNpcSwf(830);
            this._npc1.buttonMode = true;
            MobileManager.addMobile(this._npc1,MobileType.NPC);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete1);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete2);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
         this._npc = null;
         super.processMapDispose();
      }
   }
}
