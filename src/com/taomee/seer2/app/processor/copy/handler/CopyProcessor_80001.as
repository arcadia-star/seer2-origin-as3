package com.taomee.seer2.app.processor.copy.handler
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.config.info.CopyItemInfo;
   import com.taomee.seer2.app.copySystem.CopyEvent;
   import com.taomee.seer2.app.copySystem.CopyManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.copy.CopyProcessor;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class CopyProcessor_80001 extends CopyProcessor
   {
       
      
      private const SINGLE_INDEX:int = 263;
      
      private const DOUBLE_ONE_INDEX:int = 261;
      
      private const DOUBLE_TWO_INDEX:int = 262;
      
      private const GOLE_KILL_NUM:int = 10;
      
      private const POS_LIST:Array = [[208,254],[310,280],[270,280],[490,280]];
      
      private var _singleBoss:MovieClip;
      
      private var _doubleOneBoss:MovieClip;
      
      private var _doubleTwoBoss:MovieClip;
      
      private var _singleBossStart:Boolean;
      
      private var _killNum:int;
      
      public function CopyProcessor_80001(param1:CopyItemInfo)
      {
         super(param1);
      }
      
      override public function beforeAnimationHandle() : void
      {
      }
      
      override public function returnSceneHandle() : void
      {
         if(this._singleBoss)
         {
            this._singleBoss.play();
            _mapModel.content.addChild(this._singleBoss);
         }
         if(this._doubleOneBoss)
         {
            this._doubleOneBoss.play();
            _mapModel.content.addChild(this._doubleOneBoss);
         }
         if(this._doubleTwoBoss)
         {
            this._doubleTwoBoss.play();
            _mapModel.content.addChild(this._doubleTwoBoss);
         }
      }
      
      override public function onAnimationLoaded() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen("80001_1"),function():void
         {
            var _scenMc:MovieClip = null;
            _singleBoss = getResFromDomain("npc");
            _singleBoss.x = POS_LIST[1][0];
            _singleBoss.y = POS_LIST[1][1];
            _singleBoss.buttonMode = true;
            _mapModel.content.addChild(_singleBoss);
            _singleBoss.addEventListener(MouseEvent.CLICK,onSingleBossClick);
            _scenMc = getResFromDomain("sceneTalk_1");
            _mapModel.front.addChild(_scenMc);
            MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scenMc);
               _scenMc = null;
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
            },true);
         },true,true,2);
      }
      
      private function onSingleBossClick(param1:MouseEvent) : void
      {
         if(this._singleBossStart)
         {
            FightManager.startFightWithWild(this.SINGLE_INDEX);
         }
         else
         {
            AlertManager.showAlert("需要击败10个场地内的精灵才能够和莫利亚对战！");
         }
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var _scenMc:MovieClip = null;
         var evt:SceneEvent = param1;
         var obj1:Object = SceneManager.prevSceneType;
         var obj2:Object = FightManager.fightWinnerSide;
         var obj3:Object = FightManager.currentFightRecord.initData.positionIndex;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex <= 9)
         {
            ++this._killNum;
            if(this._killNum < this.GOLE_KILL_NUM)
            {
               ServerMessager.addMessage("你还需要击败" + (this.GOLE_KILL_NUM - this._killNum) + "只精灵就可以和莫利亚对战！");
            }
            else
            {
               _scenMc = getResFromDomain("sceneTalk_2");
               _mapModel.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scenMc);
                  _scenMc = null;
                  _singleBossStart = true;
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete1);
               },true);
            }
         }
      }
      
      private function onComplete1(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == this.SINGLE_INDEX)
         {
            DisplayUtil.removeForParent(this._singleBoss);
            this._singleBoss = null;
            MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen("80001_2"),function():void
            {
               _doubleOneBoss = getResFromDomain("npc");
               _doubleOneBoss.x = POS_LIST[2][0];
               _doubleOneBoss.y = POS_LIST[2][1];
               _doubleOneBoss.buttonMode = true;
               _mapModel.content.addChild(_doubleOneBoss);
               _doubleTwoBoss = getResFromDomain("npc");
               _doubleTwoBoss.scaleX = -1;
               _doubleTwoBoss.x = POS_LIST[3][0];
               _doubleTwoBoss.y = POS_LIST[3][1];
               _doubleTwoBoss.buttonMode = true;
               _mapModel.content.addChild(_doubleTwoBoss);
               _doubleOneBoss.addEventListener(MouseEvent.CLICK,onDoubleBossClick);
               _doubleTwoBoss.addEventListener(MouseEvent.CLICK,onDoubleBossClick);
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete1);
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete2);
            },true,true,2);
         }
      }
      
      private function onDoubleBossClick(param1:MouseEvent) : void
      {
         var _loc2_:int = param1.currentTarget == this._doubleOneBoss ? this.DOUBLE_ONE_INDEX : this.DOUBLE_TWO_INDEX;
         FightManager.startFightWithWild(_loc2_);
      }
      
      private function onComplete2(param1:SceneEvent) : void
      {
         var obj:Object = null;
         var _scenMc:MovieClip = null;
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && (FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_ONE_INDEX || FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_TWO_INDEX))
         {
            obj = FightManager.currentFightRecord.initData.positionIndex;
            if(FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_ONE_INDEX)
            {
               DisplayUtil.removeForParent(this._doubleOneBoss);
               this._doubleOneBoss = null;
            }
            else
            {
               DisplayUtil.removeForParent(this._doubleTwoBoss);
               this._doubleTwoBoss = null;
            }
            if(!this._doubleOneBoss && !this._doubleTwoBoss)
            {
               _scenMc = getResFromDomain("sceneTalk_3");
               _mapModel.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_scenMc);
                  _scenMc = null;
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onComplete2);
                  CopyManager.instance().addEventListener(CopyEvent.COMPLETE,onCopyComplete);
                  CopyManager.instance().completeCopyItem(_copyItem.mapId);
               },true);
            }
         }
      }
      
      private function onCopyComplete(param1:CopyEvent) : void
      {
         ServerMessager.addMessage("完成副本，获得10个炼狱粉末!");
         CopyManager.instance().removeEventListener(CopyEvent.COMPLETE,this.onCopyComplete);
         this.dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._singleBoss)
         {
            this._singleBoss.removeEventListener(MouseEvent.CLICK,this.onSingleBossClick);
         }
         if(this._doubleOneBoss)
         {
            this._doubleOneBoss.removeEventListener(MouseEvent.CLICK,this.onDoubleBossClick);
         }
         if(this._doubleTwoBoss)
         {
            this._doubleTwoBoss.removeEventListener(MouseEvent.CLICK,this.onDoubleBossClick);
         }
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete1);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete2);
         DisplayUtil.removeForParent(this._singleBoss);
         DisplayUtil.removeForParent(this._doubleOneBoss);
         DisplayUtil.removeForParent(this._doubleTwoBoss);
         CopyManager.instance().removeEventListener(CopyEvent.COMPLETE,this.onCopyComplete);
      }
   }
}
