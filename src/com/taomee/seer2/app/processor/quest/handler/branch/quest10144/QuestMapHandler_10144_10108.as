package com.taomee.seer2.app.processor.quest.handler.branch.quest10144
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.taomee.utils.Tick;
   
   public class QuestMapHandler_10144_10108 extends QuestMapHandler
   {
       
      
      private var xiaolvAndOld:MovieClip;
      
      private var xiaolv:MovieClip;
      
      private var santaClaus:MovieClip;
      
      private var sceneAnimation1:MovieClip;
      
      private var sceneAnimation2:MovieClip;
      
      private var counter:MovieClip;
      
      private var mark:AcceptableMark;
      
      private var ball:MovieClip;
      
      private var killNum:int;
      
      private var runList:Vector.<PathMobile>;
      
      private var bloodNum:int = 10;
      
      private var currentTime:int;
      
      private var blood:Sprite;
      
      public function QuestMapHandler_10144_10108(param1:QuestProcessor)
      {
         this.blood = new Sprite();
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         ActorManager.showRemoteActor = true;
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isNeedCompleteStep(3))
         {
            this.createNpc();
            this.initStep3();
         }
         if(isNeedCompleteStep(4))
         {
            this.createNpc();
            this.initStep4();
         }
         if(isNeedCompleteStep(5))
         {
            this.createNpc();
            this.initStep5();
         }
      }
      
      private function initStep3() : void
      {
         this.xiaolv.buttonMode = true;
         if(!this.mark)
         {
            this.mark = new AcceptableMark();
         }
         this.mark.x = 250;
         this.mark.y = 210;
         this.xiaolvAndOld.addChild(this.mark);
         this.xiaolv.addEventListener(MouseEvent.CLICK,this.showDia);
      }
      
      private function showDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.xiaolv.removeEventListener(MouseEvent.CLICK,this.showDia);
         NpcDialog.show(177,"小绿",[[3,"看来我的康特被萨伦帝国绑架了！哼！"]],["情况有些不妙"],[function():void
         {
            NpcDialog.show(177,"小绿",[[3,"刚才爹哋的跟踪器中显示康特他们应该正在地铁站中，可是现在跟踪器没电了，怎么知道他们在哪呀？！"]],["真是关键时刻掉链子"],[function():void
            {
               NpcDialog.show(177,"小绿",[[3,"呜呜呜…我的康特！康特康特康特！你在哪呀……呜呜呜。"]],["别哭呀…"],[function():void
               {
                  xiaolvAndOld.visible = false;
                  sceneAnimation1 = _processor.resLib.getMovieClip("sceneAnimation1");
                  _map.content.addChild(sceneAnimation1);
                  MovieClipUtil.playMc(sceneAnimation1,1,sceneAnimation1.totalFrames,function():void
                  {
                     sceneAnimation1.gotoAndStop(sceneAnimation1.totalFrames);
                     counter = sceneAnimation1["counter"];
                     if(!mark)
                     {
                        mark = new AcceptableMark();
                     }
                     mark.x = 270;
                     mark.y = 355;
                     sceneAnimation1.addChild(mark);
                     counter.buttonMode = true;
                     counter.addEventListener(MouseEvent.CLICK,clickCounter);
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function clickCounter(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.xiaolvAndOld.visible = true;
         this.santaClaus.gotoAndStop("stand");
         DisplayObjectUtil.removeFromParent(this.mark);
         this.counter.buttonMode = false;
         this.counter.removeEventListener(MouseEvent.CLICK,this.clickCounter);
         DisplayObjectUtil.removeFromParent(this.sceneAnimation1);
         NpcDialog.show(178,"康特",[[0,"老爹！家里有客人呀，哈哈，看看我又带来了两个小家伙，他们也很想看看雪人村，我看他们挺老实的就带他们过来了。"]],[],[function():void
         {
            NpcDialog.show(178,"康特",[[0,"哈啊~走了一整天了，现在感觉好困，我先去睡一会儿去了啦！你们慢…慢…聊…zzZZ"]],[],[function():void
            {
               sceneAnimation2 = _processor.resLib.getMovieClip("sceneAnimation2");
               _map.content.addChild(sceneAnimation2);
               DisplayObjectUtil.removeFromParent(sceneAnimation1);
               MovieClipUtil.playMc(sceneAnimation2,1,sceneAnimation2.totalFrames,function():void
               {
                  sceneAnimation2.gotoAndStop(sceneAnimation2.totalFrames);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(questID,3);
               },true);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            if(param1.stepId == 3)
            {
               this.initStep4();
            }
            else if(param1.stepId == 4)
            {
               this.initStep5();
            }
         }
      }
      
      private function initStep5() : void
      {
         this.santaClaus.gotoAndStop("stand");
         this.xiaolvAndOld["counter"].visible = true;
         this.counter = this.xiaolvAndOld["counter"];
         this.mark = new AcceptableMark();
         this.mark.x = 650;
         this.mark.y = 130;
         this.xiaolvAndOld.addChild(this.mark);
         this.counter.buttonMode = true;
         this.counter.addEventListener(MouseEvent.CLICK,this.showDiaCounter);
      }
      
      private function showDiaCounter(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.counter.removeEventListener(MouseEvent.CLICK,this.showDiaCounter);
         NpcDialog.show(178,"康特",[[0,"哈啊~呵呵。这群小鬼竟然敢骗我，哼！康特很生气，后果很严重！"]],[],[function():void
         {
            NpcDialog.show(178,"康特",[[0,"老爹和小绿可以安心的筹备圣诞节啦，刚才的美梦刚到一半，我回去继续了……zzZ"]],[],[function():void
            {
               NpcDialog.show(178,"康特",[[0,"小赛尔要不要留下来帮跟我们一起筹备圣诞节呀"]],["飞船上还有其他事情等着我"],[function():void
               {
                  NpcDialog.show(178,"康特",[[0,"好吧！那就等着圣诞节到了我们去带给你惊喜吧！"]],["恩！好的！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                     QuestManager.completeStep(questID,5);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10144)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            ActorManager.showRemoteActor = true;
            DisplayObjectUtil.removeFromParent(this.xiaolvAndOld);
         }
      }
      
      private function initStep4() : void
      {
         if(!this.sceneAnimation2)
         {
            this.sceneAnimation2 = _processor.resLib.getMovieClip("sceneAnimation2");
            this.sceneAnimation2.gotoAndStop(this.sceneAnimation2.totalFrames);
         }
         _map.content.addChild(this.sceneAnimation2);
         _map.ground.mouseEnabled = true;
         this.santaClaus.gotoAndStop("stand");
         this.mark = new AcceptableMark();
         DisplayObjectUtil.removeFromParent(this.mark);
         this.mark.x = 365;
         this.mark.y = 170;
         this.blood.y = 125;
         this.blood.x = 615;
         this.blood.graphics.clear();
         this.blood.graphics.beginFill(16711680);
         this.blood.graphics.lineStyle(1);
         this.blood.graphics.drawRect(0,0,100,15);
         this.xiaolvAndOld.addChild(this.mark);
         this.santaClaus.buttonMode = true;
         this.santaClaus.addEventListener(MouseEvent.CLICK,this.showSantaClausDia);
      }
      
      protected function showSantaClausDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DisplayObjectUtil.removeFromParent(this.mark);
         this.santaClaus.removeEventListener(MouseEvent.CLICK,this.showSantaClausDia);
         NpcDialog.show(180,"圣诞老人",[[0,"啊啊！要打仗啦！还好我有秘密武器！"]],["什么？秘密武器？"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[0,"这个是我爷爷的爷爷教我做的“超级雪球”咳咳！用它来攻击对手简直是坚固耐用！美观大方！是冬季防身及把玩的极品呐！"]],["哦？快拿出来！"],[function():void
            {
               NpcDialog.show(180,"圣诞老人",[[0,"我只能给你这么多！你可要瞄准了再用呀！在雪人村只有使用雪球才能够将敌人击退！"]],["好！看我的吧！"],[function():void
               {
                  blood.graphics.clear();
                  blood.graphics.beginFill(16711680);
                  blood.graphics.lineStyle(1);
                  blood.graphics.drawRect(0,0,100,15);
                  xiaolvAndOld.addChild(blood);
                  startCreateShalun();
               }]);
            }]);
         }]);
      }
      
      private function startCreateShalun() : void
      {
         Mouse.hide();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         _map.ground.mouseEnabled = false;
         if(!this.ball)
         {
            this.ball = _processor.resLib.getMovieClip("ball");
         }
         this.ball.gotoAndStop(1);
         LayerManager.topLayer.addChild(this.ball);
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.changeBallSeat);
         this.killNum = 0;
         this.runList = new Vector.<PathMobile>();
         this.currentTime = 0;
         Tick.instance.addRender(this.createShalun,800);
      }
      
      private function clearShalun() : void
      {
         Tick.instance.removeRender(this.createShalun);
         var _loc1_:int = 0;
         while(_loc1_ < this.runList.length)
         {
            this.runList[_loc1_].removeEventListener(MoveEvent.FINISHED,this.onCompleteMove);
            this.runList[_loc1_].removeEventListener(MouseEvent.CLICK,this.killShalun);
            MobileManager.removeMobile(this.runList[_loc1_],MobileType.PET);
            _loc1_++;
         }
         Mouse.show();
         LayerManager.mapLayer.removeEventListener(MouseEvent.MOUSE_MOVE,this.changeBallSeat);
         DisplayObjectUtil.removeFromParent(this.ball);
         DisplayObjectUtil.removeFromParent(this.blood);
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
      }
      
      private function changeBallSeat(param1:MouseEvent) : void
      {
         this.ball.x = param1.stageX;
         this.ball.y = param1.stageY;
      }
      
      private function createShalun(param1:int) : void
      {
         var _loc2_:PathMobile = new PathMobile();
         _loc2_.resourceUrl = URLUtil.getNpcSwf(182);
         _loc2_.mouseChildren = false;
         _loc2_.x = 280;
         _loc2_.y = 300 + int(Math.random() * 150);
         _loc2_.addEventListener(MoveEvent.FINISHED,this.onCompleteMove);
         _loc2_.addEventListener(MouseEvent.CLICK,this.killShalun);
         _loc2_.walkToLocation(645,245);
         MobileManager.addMobile(_loc2_,MobileType.PET);
         this.runList.push(_loc2_);
      }
      
      private function onCompleteMove(param1:MoveEvent) : void
      {
         --this.bloodNum;
         this.blood.graphics.clear();
         this.blood.graphics.beginFill(0);
         this.blood.graphics.lineStyle(1);
         this.blood.graphics.drawRect(0,0,100,20);
         this.blood.graphics.beginFill(16711680);
         this.blood.graphics.drawRect(0,0,10 * this.bloodNum,20);
         if(this.bloodNum <= 0)
         {
            this.clearShalun();
            this.bloodNum = 10;
            AlertManager.showAlert("太慢了！阻击失败！再跟圣诞老人要一些雪球吧！",this.initStep4);
         }
      }
      
      private function killShalun(param1:MouseEvent) : void
      {
         var eft:MovieClip = null;
         var event:MouseEvent = param1;
         var shalun:PathMobile = event.target as PathMobile;
         shalun.stand();
         MobileManager.removeMobile(shalun,MobileType.PET);
         ++this.killNum;
         if(this.killNum >= 15)
         {
            this.clearShalun();
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10144_3"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(questID,4);
               _map.ground.mouseEnabled = true;
               DisplayObjectUtil.removeFromParent(sceneAnimation2);
            });
         }
         eft = _processor.resLib.getMovieClip("ball");
         eft.x = event.stageX;
         eft.y = event.stageY;
         _map.content.addChild(eft);
         MovieClipUtil.playMc(eft,1,eft.totalFrames,function():void
         {
            eft.gotoAndStop(1);
            DisplayObjectUtil.removeFromParent(eft);
         });
      }
      
      private function createNpc() : void
      {
         this.xiaolvAndOld = _processor.resLib.getMovieClip("XiaolvAndOld");
         this.xiaolv = this.xiaolvAndOld["xiaolv"];
         this.santaClaus = this.xiaolvAndOld["oldman"];
         this.xiaolvAndOld["counter"].visible = false;
         _map.content.addChild(this.xiaolvAndOld);
         ActorManager.showRemoteActor = false;
      }
   }
}
