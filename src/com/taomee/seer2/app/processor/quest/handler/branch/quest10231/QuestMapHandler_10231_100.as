package com.taomee.seer2.app.processor.quest.handler.branch.quest10231
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10231_100 extends QuestMapHandler
   {
      
      public static var haveBattle:Boolean = true;
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10231_100(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!haveBattle)
         {
            this.onOver(null);
            return;
         }
         if(QuestManager.isAccepted(10231) && QuestManager.isStepComplete(10231,2) == false)
         {
            _map.content.visible = false;
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc1 = _processor.resLib.getMovieClip("mc3");
         _map.front.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            onClick(null);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(477,"雷伊",[[0,"远古的黑暗势力就要来了……借助约瑟的力量，我们应当能与他们一战！"]],["战神联盟！ "],[function():void
         {
            NpcDialog.show(400,ActorManager.actorInfo.nick + "",[[0,"雷伊！需要我做什么吗？"]],[" 我也要加入战斗!"],[function():void
            {
               NpcDialog.show(477,"雷伊",[[0,ActorManager.actorInfo.nick + ",你先在一边看着，如果我们倒下了，就快去通知约瑟。"]],["好的！"],[function():void
               {
                  DisplayUtil.removeForParent(_mc1);
                  initStep2();
               }]);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc2 = _processor.resLib.getMovieClip("mc4");
         _map.front.addChild(this._mc2);
         MovieClipUtil.playMc(this._mc2,2,this._mc2.totalFrames,function():void
         {
            _mc2.gotoAndStop(_mc2.totalFrames - 1);
            onClick2(null);
         },true);
      }
      
      private function onClick2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(763,"小魔尊",[[0,"救命……救救我…………"]],["看起来不像是坏人？！"],[function():void
         {
            NpcDialog.show(763,"小魔尊",[[0,"远古的黑暗魔尊……正在追杀我……"]],[" 没事！有我们在！!"],[function():void
            {
               NpcDialog.show(477,"雷伊",[[0,"不要怕！战神联盟会保护你的！"]],["恩！"],[function():void
               {
                  NpcDialog.show(763,"小魔尊",[[0,"上古魔尊的部队……就要来了…………"]],[" 准备战斗！"],[function():void
                  {
                     DisplayUtil.removeForParent(_mack);
                     DisplayUtil.removeForParent(_mc2);
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10231_0"),function():void
                     {
                        if(!PetInfoManager.getFirstPetInfo())
                        {
                           initStep3();
                        }
                        else if(PetInfoManager.getFirstPetInfo().hp == 0)
                        {
                           initStep3();
                        }
                        else
                        {
                           FightManager.startFightWithWild(1053);
                        }
                        haveBattle = false;
                     });
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onOver(param1:Event) : void
      {
         if(FightManager.getPositionIndex() == 1053)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.initStep3();
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               this.initStep3();
            }
         }
      }
      
      private function initStep3() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc3 = _processor.resLib.getMovieClip("mc5");
         _map.front.addChild(this._mc3);
         MovieClipUtil.playMc(this._mc3,2,this._mc3.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc3);
            initStep4();
         },true);
      }
      
      private function initStep4() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10231_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStepComplete);
            QuestManager.completeStep(10231,2);
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
