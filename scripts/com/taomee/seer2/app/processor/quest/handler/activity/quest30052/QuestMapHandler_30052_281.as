package com.taomee.seer2.app.processor.quest.handler.activity.quest30052
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30052_281 extends QuestMapHandler
   {
       
      
      private var chenCan:Mobile;
      
      private var sceneMc:MovieClip;
      
      private var fightId:uint = 53;
      
      public function QuestMapHandler_30052_281(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this.chenCan)
         {
            this.chenCan.removeEventListener(MouseEvent.CLICK,this.toDia);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:Boolean = QuestManager.isCompletable(30052);
         var _loc2_:Boolean = QuestManager.isAccepted(30052);
         if(!QuestManager.isComplete(30052) || !QuestManager.isAccepted(30052))
         {
            this.chenCan = new Mobile();
            this.chenCan.buttonMode = true;
            this.chenCan.resourceUrl = URLUtil.getNpcSwf(626);
            this.chenCan.height = 165;
            this.chenCan.x = 535;
            this.chenCan.y = 370;
            this.chenCan.addOverHeadMark(new AcceptableMark());
            MobileManager.addMobile(this.chenCan,MobileType.NPC);
            this.chenCan.addEventListener(MouseEvent.CLICK,this.onChenCanClick);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
      }
      
      private function onChenCanClick(param1:MouseEvent) : void
      {
         if(!QuestManager.isAccepted(30052))
         {
            QuestManager.accept(30052);
            this.initStep1();
         }
         else
         {
            this.toDia();
         }
      }
      
      protected function toDia() : void
      {
         if(isNeedCompleteStep(1))
         {
            this.initStep1();
         }
         if(isNeedCompleteStep(2))
         {
            this.initStep2();
         }
         if(isNeedCompleteStep(3))
         {
            this.initStep3();
         }
      }
      
      protected function initStep1() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30052_0"),function():void
         {
            sceneMc = _processor.resLib.getMovieClip("SceneMc_30051_0");
            _map.content.addChild(sceneMc);
            chenCan.visible = false;
            MovieClipUtil.playMc(sceneMc,1,sceneMc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(sceneMc);
               NpcDialog.show(626,"晨璨",[[0,"你打呀你打呀，我不怕你。我会和你一战到底……"]],["我不怕你！"],[function():void
               {
                  NpcDialog.show(203,"霍克努尔",[[0,"一只自不量力的精灵，为什么非要和我较劲呢？"]],["逞强是没有用的"],[function():void
                  {
                     NpcDialog.show(626,"晨璨",[[0,"不行！我一定要得到我想要的东西，谁也不能抢走！"]],["快给我！"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30052_1"),function():void
                        {
                           chenCan.visible = true;
                           QuestManager.completeStep(30052,1);
                        });
                     }]);
                  }]);
               }]);
            },true);
         });
      }
      
      private function onStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            if(param1.stepId == 1)
            {
               this.initStep2();
            }
            else if(param1.stepId == 2)
            {
               this.initStep3();
            }
         }
      }
      
      private function initStep3() : void
      {
         NpcDialog.show(203,"霍克努尔",[[0,"知道我的厉害了吧，还逞强！快走快走！"]],[" 走走走！"],[function():void
         {
            NpcDialog.show(626,"晨璨",[[0,"我不会妥协的。它是属于我的！"]],[" 还给我！"],[function():void
            {
               NpcDialog.show(203,"霍克努尔",[[0,"找打吗？还想要！"]],["  快走，放你一条活路"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30052_2"),function():void
                  {
                     QuestManager.completeStep(30052,3);
                     chenCan.removeOverHeadMark();
                     MobileManager.removeMobile(chenCan,MobileType.NPC);
                  });
               }]);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(626,"晨璨",[[0,"你手中的发卡是我的！是我的好朋友送给我的！还给我！"]],[" 还给我！"],[function():void
         {
            NpcDialog.show(203,"霍克努尔",[[0,"我说，你怎么证明这个发卡就是你的啊？明明是我捡到的！"]],["在森林里捡到的！"],[function():void
            {
               NpcDialog.show(626,"晨璨",[[0,"不行！我一定要夺回属于我的东西！"]],[" 还给我！"],[function():void
               {
                  NpcDialog.show(203,"霍克努尔",[[0,"哼！没有人想从我手上抢走属于我的东西，何况它不是你的东西！哈哈哈哈"]],[" 有本事你来打我啊！"],[function():void
                  {
                     FightManager.addEventListener(FightStartEvent.FIGHT_OVER,onFightOver);
                     FightManager.startFightWithNPC(fightId);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onFightOver(param1:FightStartEvent) : void
      {
         var event:FightStartEvent = param1;
         if(FightManager.getPositionIndex() == this.fightId)
         {
            FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.onFightOver);
            this.sceneMc = _processor.resLib.getMovieClip("SceneMc_30051_1");
            _map.content.addChild(this.sceneMc);
            this.chenCan.visible = false;
            MovieClipUtil.playMc(this.sceneMc,1,this.sceneMc.totalFrames,function():void
            {
               chenCan.visible = true;
               DisplayObjectUtil.removeFromParent(sceneMc);
               QuestManager.completeStep(30052,2);
            },true);
         }
      }
   }
}
