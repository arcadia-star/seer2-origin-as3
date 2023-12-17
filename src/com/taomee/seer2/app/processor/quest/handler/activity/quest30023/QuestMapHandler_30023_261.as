package com.taomee.seer2.app.processor.quest.handler.activity.quest30023
{
   import com.taomee.seer2.app.actor.attach.PetKingTeamAttach;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30023_261 extends QuestMapHandler
   {
      
      public static const TEAM_INDEX:int = 1;
      
      public static var FIGHT_SIGN:int = -1;
       
      
      private var _talkMc:MovieClip;
      
      private var _peopleMcBegin:MovieClip;
      
      private var _peopleMcEnd:MovieClip;
      
      public function QuestMapHandler_30023_261(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:int = 0;
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            _loc1_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               if(_loc1_ == 125)
               {
                  this.playFinishMc();
               }
               else if(QuestMapHandler_30023_80.isPlayTalkMc && PetKingTeamAttach.myTeamIndex == TEAM_INDEX)
               {
                  QuestMapHandler_30023_80.isPlayTalkMc = false;
                  this.playTalkMc();
               }
            }
            else if(QuestMapHandler_30023_80.isPlayTalkMc && PetKingTeamAttach.myTeamIndex == TEAM_INDEX)
            {
               QuestMapHandler_30023_80.isPlayTalkMc = false;
               this.playTalkMc();
            }
            SceneManager.addEventListener(SceneEvent.SWITCH_START,this.destory);
         }
      }
      
      private function playTalkMc() : void
      {
         QuestMapHandler_30023_80.isPlayTalkMc = false;
         this._talkMc = _processor.resLib.getMovieClip("talk1");
         this._peopleMcBegin = _processor.resLib.getMovieClip("talk1_1");
         LayerManager.mapLayer.addChild(this._peopleMcBegin);
         LayerManager.topLayer.addChild(this._talkMc);
         LayerManager.focusOnTopLayer();
         MovieClipUtil.playMc(this._talkMc,1,this._talkMc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_talkMc);
            startFight();
         });
      }
      
      private function startFight() : void
      {
         FightManager.addEventListener(FightStartEvent.START_ERROR,this.fightStartError);
         FightManager.startFightWithWild(125);
         FIGHT_SIGN = 1;
      }
      
      private function fightStartError(param1:Event) : void
      {
         FIGHT_SIGN = -1;
         this.finishActivity();
      }
      
      private function playFinishMc() : void
      {
         this._peopleMcEnd = _processor.resLib.getMovieClip("talk1_2");
         DisplayUtil.removeForParent(this._peopleMcBegin);
         LayerManager.topLayer.addChild(this._peopleMcEnd);
         MovieClipUtil.playMc(this._peopleMcEnd,1,this._peopleMcEnd.totalFrames,function():void
         {
            NpcDialog.show(504,"火幻甲",[[0,"恩公的救命之恩我无以为报！热辣队果然充满了热情！我已经加入其中！希望在日后的比赛中贡献绵薄之力！"]],["（YE！拉人成功！）"],[function():void
            {
               DisplayUtil.removeForParent(_peopleMcEnd);
               QuestManager.completeStep(_quest.id,1);
               QuestManager.addEventListener(QuestEvent.COMPLETE,complateStep);
            }]);
         });
      }
      
      private function complateStep(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.complateStep);
         SwapManager.swapItem(475,1,function(param1:IDataInput):void
         {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            destory();
         });
      }
      
      private function playTalk() : void
      {
      }
      
      private function destory(param1:Event = null) : void
      {
         this.finishActivity();
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,this.destory);
         FightManager.removeEventListener(FightStartEvent.START_ERROR,this.fightStartError);
      }
      
      private function finishActivity() : void
      {
         DisplayUtil.removeForParent(this._talkMc);
         DisplayUtil.removeForParent(this._peopleMcBegin);
         DisplayUtil.removeForParent(this._peopleMcEnd);
         this._talkMc = null;
         this._peopleMcBegin = null;
         this._peopleMcEnd = null;
         LayerManager.resetOperation();
      }
   }
}
