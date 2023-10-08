package com.taomee.seer2.app.processor.quest.handler.main.quest88
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class QuestMapHandler_88_80374 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var fightID:int = 1426;
      
      private var NPCID:int = 837;
      
      private var _tm:Timer;
      
      private var _count:int = 0;
      
      private var rangePos:Array;
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_88_80374(param1:QuestProcessor)
      {
         this._tm = new Timer(2800,1);
         this.rangePos = [[395,310],[568,530]];
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var result:uint = 0;
         super.processMapComplete();
         RightToolbarConter.instance.hide();
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         this._tm.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimer);
         MovieClip(_map.front["shootMc"]).gotoAndStop(1);
         _map.front["shootMc"].visible = false;
         _map.content["npcMc"].visible = false;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.fightID == FightManager.currentFightRecord.initData.positionIndex)
            {
               result = FightManager.fightWinnerSide;
               if(result == FightSide.RIGHT)
               {
                  NpcDialog.show(825,"超梦",[[0,"不要放弃，它已经露出破绽了！"]],[" 再试一次！","我需要准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(fightID);
                  },function():void
                  {
                     createNpc();
                  }]);
               }
               else if(result == FightSide.LEFT)
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("88_0"),function():void
                  {
                     ActorManager.getActor().isShow = true;
                     ActorManager.getActor().blockNoNo = true;
                     MobileManager.showMoileVec(MobileType.NPC);
                     _map.front["shootMc"].visible = true;
                     _map.content["npcMc"].visible = true;
                     NpcDialog.show(846,"阿兹尔",[[0,"地心兽正在呼唤它的同伴！快阻止它！"],[0,"趁现在！对着他的头部射击（射击三次）！"]],["瞄准地心兽的头部射击（射击三次）"],[function():void
                     {
                        ShootController.addEventListener(ShootEvent.PLAY_END,onShootEnd);
                        ShootController.addEventListener(ShootEvent.PLAY_START,onShootStart);
                     }]);
                  });
               }
            }
         }
         else
         {
            if(!QuestManager.isAccepted(questID))
            {
               QuestManager.accept(questID);
               QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
            }
            if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
            {
               this.initStep1();
            }
            if(QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
            {
               this.initStep2(null);
            }
            if(QuestManager.isStepComplete(questID,2) && QuestManager.isComplete(questID))
            {
               this.onComplete(null);
            }
         }
      }
      
      private function onShootStart(param1:ShootEvent) : void
      {
         this._tm.reset();
         this._tm.start();
         MovieClip(_map.front["shootMc"]).gotoAndStop(2);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         this.initStep1();
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = true;
         MobileManager.showMoileVec(MobileType.NPC);
         RightToolbarConter.instance.show();
         this._mc1 = null;
         this._mc2 = null;
         this._mc3 = null;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc88_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc1);
            showDialog1();
         },true);
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var shoot:Boolean = false;
         var evt:ShootEvent = param1;
         var shootInfo:ShootInfo = evt.info;
         var actorInfo:UserInfo = ActorManager.actorInfo;
         if(shootInfo.userID == actorInfo.id)
         {
            shoot = Boolean(_map.content["npcMc"].hitTestPoint(evt.info.endPos.x,evt.info.endPos.y,true));
            if(shoot)
            {
               _processor.hideMouseClickHint();
               ++this._count;
               if(this._count == 3)
               {
                  ActorManager.getActor().isShow = false;
                  ActorManager.getActor().blockNoNo = false;
                  MobileManager.hideMoileVec(MobileType.NPC);
                  _map.content["npcMc"].visible = false;
                  _map.front["shootMc"].visible = false;
                  this._mc2 = _processor.resLib.getMovieClip("Mc88_1");
                  _map.front.addChild(this._mc2);
                  this._mc2.gotoAndStop(1);
                  MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc2);
                     QuestManager.completeStep(questID,1);
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
                  },true);
               }
            }
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         MovieClip(_map.front["shootMc"]).gotoAndStop(1);
      }
      
      private function showDialog1() : void
      {
         NpcDialog.show(846,"阿兹尔",[[0,"小赛尔！不用害怕，地心兽已经没有刚才那么凶猛了"]],[" 它怎么会认识我？"],[function():void
         {
            NpcDialog.show(825,"超梦",[[0,"小赛尔，上吧！"]],["我们上！"],[function():void
            {
               FightManager.startFightWithWild(fightID);
            }]);
         }]);
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         var e:QuestEvent = param1;
         NpcDialog.show(1027,"伊鲁维塔影像",[[0,"你好，赛尔机器人！"]],["  你就是地球人？"],[function():void
         {
            NpcDialog.show(1027,"伊鲁维塔影像",[[0,"我是伊鲁维塔将军，你们现在看到的是我的影像。"]],["原来如此"],[function():void
            {
               NpcDialog.show(1027,"伊鲁维塔影像",[[0,"我的精灵阿兹尔将会带你们传送到海上要塞。我们将恭候来自阿卡迪亚的伙伴！"]],["海上要塞？要怎么去呢？"],[function():void
               {
                  NpcDialog.show(846,"阿兹尔",[[0,"人类在地球上的往来主要依靠传送装置，跟我来吧。"]],["我们走!"],[function():void
                  {
                     _mc3 = _processor.resLib.getMovieClip("Mc88_2");
                     _map.front.addChild(_mc3);
                     _mc3.gotoAndStop(1);
                     MovieClipUtil.playMc(_mc3,1,_mc3.totalFrames,function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc3);
                        QuestManager.completeStep(questID,2);
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                     },true);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function createNpc() : void
      {
         var mark:AcceptableMark;
         this._npc = new Mobile();
         this._npc.setPostion(new Point(110,420));
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         mark = new AcceptableMark();
         this._npc.addChild(mark);
         mark.y = -120;
         this._npc.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            FightManager.startFightWithWild(fightID);
         });
      }
      
      private function removeNpc() : void
      {
         MobileManager.removeMobile(this._npc,MobileType.NPC);
      }
      
      override public function processMapDispose() : void
      {
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = true;
         MobileManager.showMoileVec(MobileType.NPC);
         RightToolbarConter.instance.show();
         super.processMapDispose();
      }
   }
}
