package com.taomee.seer2.app.processor.quest.handler.branch.quest10160
{
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
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10160_1071 extends QuestMapHandler
   {
       
      
      private var duoluoMb:Mobile;
      
      private var badiMb:Mobile;
      
      private var s:Mobile;
      
      public function QuestMapHandler_10160_1071(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
         if(this.duoluoMb)
         {
            this.duoluoMb.removeEventListener(MouseEvent.CLICK,this.showDuoDia);
         }
         if(this.badiMb)
         {
            this.badiMb.removeEventListener(MouseEvent.CLICK,this.showDiaBadi);
         }
      }
      
      override public function processMapComplete() : void
      {
         if(isNeedToAccept())
         {
            this.s = MobileManager.getMobile(172,MobileType.NPC);
            this.s.addOverHeadMark(new AcceptableMark());
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         if(isNeedCompleteStep(1))
         {
            this.initStep1();
         }
         if(isNeedCompleteStep(6))
         {
            this.initStep6();
         }
      }
      
      private function initStep6() : void
      {
         this.badiMb = new Mobile();
         this.badiMb.resourceUrl = URLUtil.getNpcSwf(10);
         this.badiMb.x = 480;
         this.badiMb.y = 420;
         this.badiMb.height = 100;
         this.badiMb.buttonMode = true;
         this.badiMb.mouseChildren = false;
         this.badiMb.addOverHeadMark(new AcceptableMark());
         MobileManager.addMobile(this.badiMb,MobileType.NPC);
         this.badiMb.addEventListener(MouseEvent.CLICK,this.showDiaBadi);
         this.duoluoMb = new Mobile();
         this.duoluoMb.resourceUrl = URLUtil.getNpcSwf(11);
         this.duoluoMb.x = 600;
         this.duoluoMb.y = 420;
         this.duoluoMb.height = 100;
         this.duoluoMb.buttonMode = true;
         this.duoluoMb.mouseChildren = false;
         MobileManager.addMobile(this.duoluoMb,MobileType.NPC);
      }
      
      private function showDiaBadi(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.badiMb.removeOverHeadMark();
         NpcDialog.show(10,"巴蒂",[[0,"刚才是怎么回事？我的头好痛！"]],["你什么都不记得了？！ "],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"哦！我记得我看见了一个英俊潇洒气质非凡的人，长得有点像S！样子好帅啊！哎呀~"]],["真是花痴！我们要不要再进去一次了？ "],[function():void
            {
               NpcDialog.show(11,"多罗",[[0,"啊！不去了！再也不去了！太吓人了！里面的怪物下一次说不定变成辛迪船长呢！打死我也不去了！"]],["一个花痴一个胆小鬼！看来只能靠我自己了！ "],[function():void
               {
                  NpcDialog.show(11,"多罗",[[0,"你是队长嘛，虽然只比我厉害那么一点点，但是足够用啦，我们就不陪你啦！"]],["切！欲望回廊挑战模式应该已经开启了。 "],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_6"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                        QuestManager.completeStep(questID,6);
                     });
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10160)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            MobileManager.removeMobile(this.duoluoMb,MobileType.NPC);
            MobileManager.removeMobile(this.badiMb,MobileType.NPC);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         this.s.removeOverHeadMark();
         if(event.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_0"),function():void
            {
               NpcDialog.show(113,"NONO",[[0,"报告主人，我已经与多罗和巴蒂取得了联系！他们很快就来啦！"]],["嗯！做的好NONO！ "],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_1"),function():void
                  {
                     initStep1();
                  },false,false,1,false);
               }]);
            });
         }
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            if(param1.stepId == 1)
            {
               SceneManager.changeScene(SceneType.LOBBY,1080);
            }
         }
      }
      
      private function initStep1() : void
      {
         this.duoluoMb = new Mobile();
         this.duoluoMb.resourceUrl = URLUtil.getNpcSwf(11);
         this.duoluoMb.buttonMode = true;
         this.duoluoMb.mouseChildren = false;
         this.duoluoMb.x = 500;
         this.duoluoMb.y = 410;
         this.duoluoMb.height = 85;
         this.duoluoMb.addOverHeadMark(new AcceptableMark());
         MobileManager.addMobile(this.duoluoMb,MobileType.NPC);
         this.duoluoMb.addEventListener(MouseEvent.CLICK,this.showDuoDia);
      }
      
      private function showDuoDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(11,"多罗",[[0,"这是什么鬼地方呀！我们一定要进去吗？"]],["那当然了！ "],[function():void
         {
            NpcDialog.show(11,"多罗",[[0,"胆子这么小还跟过来！队长！我们赶快进去吧！"]],["好的！大家做好准备！ "],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_2"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
                  QuestManager.completeStep(questID,1);
               });
            }]);
         }]);
      }
   }
}
