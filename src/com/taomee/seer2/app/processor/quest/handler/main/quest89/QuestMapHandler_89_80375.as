package com.taomee.seer2.app.processor.quest.handler.main.quest89
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
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class QuestMapHandler_89_80375 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _picMc0:MovieClip;
      
      private var _picMc1:MovieClip;
      
      private var _picMc2:MovieClip;
      
      private var fightIDList:Array;
      
      private var _tm:Timer;
      
      private var _curIdx:int = 1;
      
      private var _npc:Mobile;
      
      private var NPCID:int = 1026;
      
      public function QuestMapHandler_89_80375(param1:QuestProcessor)
      {
         this.fightIDList = [1433,1434];
         this._tm = new Timer(5000);
         super(param1);
      }
      
      private function pictureMc() : void
      {
         this._tm.addEventListener(TimerEvent.TIMER,this.onChangePicture);
         this._tm.start();
         MovieClip(_map.content["picMc"]).gotoAndStop(1);
         MovieClip(_map.content["picMc"]).buttonMode = true;
         MovieClip(_map.content["picMc"]).addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this._tm.stop();
         this.onChangePicture(null);
         this._tm.reset();
         this._tm.start();
      }
      
      private function onChangePicture(param1:Event) : void
      {
         ++this._curIdx;
         if(this._curIdx >= 5)
         {
            this._curIdx = 1;
         }
         if(_map && _map.content && Boolean(_map.content["picMc"]))
         {
            MovieClip(_map.content["picMc"]).gotoAndStop(this._curIdx);
         }
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         _map.content["npcMc"].visible = false;
         RightToolbarConter.instance.hide();
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = false;
         ActorManager.getActor().blockFollowingPet = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         this.pictureMc();
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.fightIDList[0] == FightManager.currentFightRecord.initData.positionIndex)
            {
               NpcDialog.show(849,"粗眉毛",[[0,"将军，我失败了！下次我一定会变得更强给你看！"]],["粗眉毛你先去休息吧，这里交给我了！"],[function():void
               {
                  NpcDialog.show(1026,"伊鲁维塔",[[0,"小赛尔，回到陆地能量工厂中也许你们会面临更加艰巨的挑战。在这之前，先挑战深海巨兽吧！"]],[" 看我的！"],[function():void
                  {
                     FightManager.startFightWithWild(fightIDList[1]);
                  }]);
               }]);
            }
            else if(this.fightIDList[1] == FightManager.currentFightRecord.initData.positionIndex)
            {
               NpcDialog.show(1026,"伊鲁维塔",[[0,"很好，我可以放心让你们去寻找能量工厂了！"]],["现在就等超梦了！"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("89_1"),function():void
                  {
                     QuestManager.completeStep(questID,2);
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                  });
               }]);
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
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         this.initStep1();
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc89_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc1);
            ActorManager.getActor().isShow = true;
            ActorManager.getActor().blockNoNo = true;
            ActorManager.getActor().blockFollowingPet = true;
            MobileManager.showMoileVec(MobileType.NPC);
            createNpc();
         },true);
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(725,350));
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc.addChild(_loc1_);
         _loc1_.y = -160;
         this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function removeNpc() : void
      {
         if(this._npc != null)
         {
            MobileManager.removeMobile(this._npc,MobileType.NPC);
         }
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = false;
         ActorManager.getActor().blockFollowingPet = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         NpcDialog.show(1026,"伊鲁维塔",[[0,"你们一定有很多问题想问。"]],[" 人类为什么在海上？地球上的精灵哪里来的？"],[function():void
         {
            removeNpc();
            _picMc0 = _processor.resLib.getMovieClip("picMc0");
            _picMc0.x = 600;
            _picMc0.y = 300;
            _map.front.addChild(_picMc0);
            NpcDialog.show(1026,"伊鲁维塔",[[0,"超梦和阿兹尔等是小梦的师傅根据赛尔飞船传送回来的精灵信息，由人类自行试验、培养、训练出来的。"]],["人工培养的精灵竟然能够如此强大！"],[function():void
            {
               DisplayObjectUtil.removeFromParent(_picMc0);
               _picMc1 = _processor.resLib.getMovieClip("picMc1");
               _picMc1.x = 600;
               _picMc1.y = 300;
               _map.front.addChild(_picMc1);
               NpcDialog.show(1026,"伊鲁维塔",[[0,"其中最成功的超梦和阿兹尔，由小梦的师傅进行单独训练，并委以重任。"]],[" 原来阿兹尔和小梦是好朋友。"],[function():void
               {
                  DisplayObjectUtil.removeFromParent(_picMc1);
                  _picMc2 = _processor.resLib.getMovieClip("picMc2");
                  _picMc2.x = 600;
                  _picMc2.y = 300;
                  _map.front.addChild(_picMc2);
                  NpcDialog.show(1026,"伊鲁维塔",[[0,"小梦前往阿卡迪亚期间，阿兹尔独自担当起了保护地球的重任。"]],["那地心兽又是怎么回事？"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_picMc2);
                     NpcDialog.show(1026,"伊鲁维塔",[[0,"地心兽这类精灵原本存在于地心深处，以地下能源为食。地下能源的过度消耗使得它们失去了生存必须的食物"],[0,"地下精灵只能来与人类争夺宝贵的能源，对人类的城市造成了严重破坏，陆地已经不再安全。"],[0,"人类在海上建起了5座要塞，将存活的人类和剩余的能源都汇集在要塞中，你们现在位于的是阿尔达要塞中。"]],["海下就没有威胁吗？"],[function():void
                     {
                        NpcDialog.show(1026,"伊鲁维塔",[[0,"不，在建起要塞之后，我们发现海底也有被能源吸引来的精灵，所以将所有能源都存在封闭的能量室中。也许还有更多我们了解的强大精灵存在！"]],["那我们的能量碎片岂不是很危险"],[function():void
                        {
                           QuestManager.completeStep(questID,1);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         var e:QuestEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("89_0"),function():void
         {
            NpcDialog.show(1026,"伊鲁维塔",[[0,"要塞的设备无法转化无尽能量碎片中这么高强度的能量。"]],["那我们白拿来了吗？"],[function():void
            {
               NpcDialog.show(1026,"伊鲁维塔",[[0,"我们需要曾经建造在陆地下的能量工厂中的转化设施才能将其转化成可以使用的能量源。"]],["我们这就去！"],[function():void
               {
                  _mc2 = _processor.resLib.getMovieClip("Mc89_1");
                  _map.front.addChild(_mc2);
                  _mc2.gotoAndStop(1);
                  MovieClipUtil.playMc(_mc2,1,_mc2.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc2);
                     NpcDialog.show(1026,"伊鲁维塔",[[0,"能量碎片的能量场果然强大，竟然引来了深海巨兽！"]],["怎么办！怎么办！"],[function():void
                     {
                        NpcDialog.show(1026,"伊鲁维塔",[[0,"不要慌张，阿尔达要塞的防御能够坚持很长一段时间。在要塞防御设施的支援下深海巨兽的实力会被削弱。"]],["竟然这么有信心。"],[function():void
                        {
                           NpcDialog.show(849,"粗眉毛",[[0,"将军！让我去赶走深海巨兽吧，我一直以阿兹尔为目标努力的训练！"]],["你真的。。可以吗？"],[function():void
                           {
                              FightManager.startFightWithWild(fightIDList[0]);
                           }]);
                        }]);
                     }]);
                  },true);
               }]);
            }]);
         });
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = true;
         ActorManager.getActor().blockFollowingPet = true;
         MobileManager.showMoileVec(MobileType.NPC);
         RightToolbarConter.instance.show();
         this._mc1 = null;
         this._mc2 = null;
         this._picMc0 = null;
         this._picMc1 = null;
         this._picMc2 = null;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = true;
         ActorManager.getActor().blockFollowingPet = true;
         MobileManager.showMoileVec(MobileType.NPC);
         this._tm.stop();
         this._tm.removeEventListener(TimerEvent.TIMER,this.onChangePicture);
         super.processMapDispose();
      }
   }
}
