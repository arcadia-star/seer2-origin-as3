package com.taomee.seer2.app.processor.quest.handler.main.quest90
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
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
   import flash.geom.Point;
   
   public class QuestMapHandler_90_80374 extends QuestMapHandler
   {
       
      
      private var fightID:int = 1435;
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _npc:Mobile;
      
      private var NPCID:int = 837;
      
      private var _npc_0:Mobile;
      
      private var _npc_1:Mobile;
      
      private var _npc1:Mobile;
      
      private var NPCID1:int = 839;
      
      private var _npc1_0:Mobile;
      
      private var _npc1_1:Mobile;
      
      public function QuestMapHandler_90_80374(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         RightToolbarConter.instance.hide();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         _map.content["npcMc"].visible = false;
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(this.fightID == FightManager.currentFightRecord.initData.positionIndex)
               {
                  this._mc2 = _processor.resLib.getMovieClip("Mc90_1");
                  _map.content.addChild(this._mc2);
                  this._mc2.gotoAndStop(1);
                  MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc2);
                     NpcDialog.show(855,"极梦",[[0,"好强大的气场，竟然能将地心兽和深海巨兽给吓退。"]],["这是什么精灵?"],[function():void
                     {
                        NpcDialog.show(855,"极梦",[[0,"看起来是远古生物。曾经听师傅说过，古书记载：在远古时代，地球上生存着众神都为之颤抖的精灵，但从没有人见过。"]],["是能量碎片吸引它来的吗？"],[function():void
                        {
                           NpcDialog.show(855,"极梦",[[0,"无尽能源的诱惑太过强大，连传说中的远古精灵都被吸引来了。"]],["我们还是先逃跑吧！"],[function():void
                           {
                              NpcDialog.show(855,"极梦",[[0,"你们先带着能量碎片先走！我来拖住它！"]],["这怎么行，我们是共同战斗的伙伴！"],[function():void
                              {
                                 NpcDialog.show(855,"极梦",[[0,"不要浪费时间快走！"]],["好吧，你小心！"],[function():void
                                 {
                                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("90_1"),function():void
                                    {
                                       QuestManager.completeStep(questID,2);
                                       QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                    });
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  },true);
               }
            }
            else
            {
               this.initStep1();
            }
         }
         if(QuestManager.isStepComplete(questID,2) && QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc90_0");
         _map.content.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc1);
            createNpc();
            createNpc_0();
            createNpc_1();
            createNpc1();
            createNpc1_0();
            createNpc1_1();
         },true);
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(150,440));
         this._npc.scaleX = this._npc.scaleY = 0.7;
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc.addChild(_loc1_);
         _loc1_.y = -130;
         this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function createNpc_0() : void
      {
         this._npc_0 = new Mobile();
         this._npc_0.setPostion(new Point(64,530));
         this._npc_0.scaleX = this._npc_0.scaleY = 0.7;
         this._npc_0.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc_0.buttonMode = true;
         MobileManager.addMobile(this._npc_0,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc_0.addChild(_loc1_);
         _loc1_.y = -130;
         this._npc_0.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function createNpc_1() : void
      {
         this._npc_1 = new Mobile();
         this._npc_1.setPostion(new Point(170,595));
         this._npc_1.scaleX = this._npc_1.scaleY = 0.7;
         this._npc_1.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc_1.buttonMode = true;
         MobileManager.addMobile(this._npc_1,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc_1.addChild(_loc1_);
         _loc1_.y = -130;
         this._npc_1.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function createNpc1() : void
      {
         this._npc1 = new Mobile();
         this._npc1.setPostion(new Point(110,190));
         this._npc1.scaleX = this._npc1.scaleY = 0.7;
         this._npc1.resourceUrl = URLUtil.getNpcSwf(this.NPCID1);
         this._npc1.buttonMode = true;
         MobileManager.addMobile(this._npc1,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc1.addChild(_loc1_);
         _loc1_.y = -160;
         this._npc1.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function createNpc1_0() : void
      {
         this._npc1_0 = new Mobile();
         this._npc1_0.setPostion(new Point(220,227));
         this._npc1_0.scaleX = this._npc1_0.scaleY = 0.7;
         this._npc1_0.resourceUrl = URLUtil.getNpcSwf(this.NPCID1);
         this._npc1_0.buttonMode = true;
         MobileManager.addMobile(this._npc1_0,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc1_0.addChild(_loc1_);
         _loc1_.y = -160;
         this._npc1_0.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function createNpc1_1() : void
      {
         this._npc1_1 = new Mobile();
         this._npc1_1.setPostion(new Point(290,149));
         this._npc1_1.scaleX = this._npc1_1.scaleY = 0.7;
         this._npc1_1.resourceUrl = URLUtil.getNpcSwf(this.NPCID1);
         this._npc1_1.buttonMode = true;
         MobileManager.addMobile(this._npc1_1,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc1_1.addChild(_loc1_);
         _loc1_.y = -160;
         this._npc1_1.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(855,"极梦",[[0,"看我解决掉他们!"]],["不要太轻敌。"],[function():void
         {
            NpcDialog.show(400,"赛尔",[[0,"极梦，我们一起上吧。"]],["为了地球！进攻！","准备一下"],[function():void
            {
               FightManager.startFightWithWild(fightID);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         this._mc1 = null;
         this._mc2 = null;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         super.processMapDispose();
      }
   }
}
