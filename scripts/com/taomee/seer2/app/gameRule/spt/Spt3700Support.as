package com.taomee.seer2.app.gameRule.spt
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
   import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
   import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.quest.data.DialogDefinition;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Spt3700Support
   {
      
      private static var _fighterID:Number = -1;
       
      
      private var _sptBossId:uint = 1033;
      
      private var _sptBufferPosition:int = 6;
      
      private var _map:MapModel;
      
      private var _mogu:MovieClip;
      
      private var _shazhihe:MovieClip;
      
      private var _canFighter:Boolean = false;
      
      private var _isWinBefore:Boolean = false;
      
      protected var _animationPlayer:ProgressiveAnimationPlayer;
      
      public function Spt3700Support()
      {
         super();
      }
      
      public function init(param1:MapModel) : void
      {
         this._map = param1;
         this.initUI();
         ServerBufferManager.getServerBuffer(ServerBufferType.SPT,this.onServerBufferDataHandler);
      }
      
      private function initUI() : void
      {
         this._mogu = this._map.content["sptMoGu"]["hotZone"];
         this._mogu.buttonMode = true;
         this._mogu.useHandCursor = true;
         this._shazhihe = this._map.content["sptShaZhiHe"]["hotZone"];
         this._shazhihe.buttonMode = true;
         this._shazhihe.useHandCursor = true;
         this._mogu.addEventListener(MouseEvent.CLICK,this.onMoguClick);
         this._shazhihe.addEventListener(MouseEvent.CLICK,this.onShazhiHeClick);
      }
      
      private function onServerBufferDataHandler(param1:ServerBuffer) : void
      {
         var onChairAnimationEnd:Function = null;
         var result:uint = 0;
         var serverBuffer:ServerBuffer = param1;
         onChairAnimationEnd = function(param1:Event):void
         {
            _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END,onChairAnimationEnd);
            DisplayObjectUtil.removeFromParent(_animationPlayer);
            _animationPlayer = null;
            SoundManager.enabled = true;
         };
         this._isWinBefore = serverBuffer.readDataAtPostion(this._sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(_fighterID == FightManager.currentFightRecord.fightUniqueID)
            {
               result = FightManager.fightWinnerSide;
               if(result != FightSide.RIGHT)
               {
                  if(result == FightSide.LEFT)
                  {
                     if(!this._isWinBefore)
                     {
                        ServerBufferManager.updateServerBuffer(ServerBufferType.SPT,this._sptBufferPosition,SPTBufferStatus.FIGHT_WIN);
                        this._animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/map_3700_fullmovie"));
                        this._animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END,onChairAnimationEnd);
                        LayerManager.topLayer.addChild(this._animationPlayer);
                        SoundManager.enabled = false;
                     }
                  }
               }
            }
         }
         SptBossInfoManager.getSptBossInfo(this.parserSptBossInfo);
      }
      
      private function parserSptBossInfo(param1:LittleEndianByteArray) : void
      {
         var _loc2_:uint = SptBossInfoManager.resolveSpt(SPTBossID.MoGu,param1.clone());
         var _loc3_:uint = SptBossInfoManager.resolveSpt(SPTBossID.ShaZhiHe,param1);
         if(_loc2_ >= SptBossInfoManager.CHALLENGE_RULE_1 && _loc3_ >= SptBossInfoManager.CHALLENGE_RULE_1)
         {
            this._canFighter = true;
         }
      }
      
      private function onShazhiHeClick(param1:MouseEvent) : void
      {
         var startFighter:Function = null;
         var data:XML = null;
         var dialogDefinition:DialogDefinition = null;
         var event:MouseEvent = param1;
         startFighter = function(param1:String = ""):void
         {
            if("fight" == param1)
            {
               _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
         };
         if(this._canFighter)
         {
            if(this._isWinBefore)
            {
               _fighterID = FightManager.startFightWithSPTBoss(this._sptBossId);
            }
            else
            {
               data = new XML(SptDialogConfig.getSptDialog(this._sptBossId,1));
               dialogDefinition = new DialogDefinition(data);
               DialogPanel.showForCommon(dialogDefinition,startFighter);
            }
         }
         else
         {
            this.sayUnFighter();
         }
      }
      
      private function onMoguClick(param1:MouseEvent) : void
      {
         var _loc2_:XML = null;
         var _loc3_:DialogDefinition = null;
         if(this._canFighter)
         {
            if(this._isWinBefore)
            {
               _fighterID = FightManager.startFightWithSPTBoss(this._sptBossId);
            }
            else
            {
               _loc2_ = new XML(SptDialogConfig.getSptDialog(this._sptBossId,2));
               _loc3_ = new DialogDefinition(_loc2_);
               DialogPanel.showForCommon(_loc3_,this.sayShaZhiHe);
            }
         }
         else
         {
            this.sayUnFighter();
         }
      }
      
      private function sayShaZhiHe(param1:String = "") : void
      {
         var startFighter:Function = null;
         var params:String = param1;
         startFighter = function(param1:String = ""):void
         {
            if("fight" == param1)
            {
               _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
         };
         var data:XML = new XML(SptDialogConfig.getSptDialog(this._sptBossId,3));
         var dialogDefinition:DialogDefinition = new DialogDefinition(data);
         DialogPanel.showForCommon(dialogDefinition,startFighter);
      }
      
      private function sayUnFighter() : void
      {
         var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(this._sptBossId,4));
         var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
         DialogPanel.showForCommon(_loc2_);
      }
      
      public function dispose() : void
      {
         if(Boolean(this._mogu) && this._mogu.hasEventListener(MouseEvent.CLICK))
         {
            this._mogu.removeEventListener(MouseEvent.CLICK,this.onMoguClick);
         }
         if(Boolean(this._shazhihe) && this._shazhihe.hasEventListener(MouseEvent.CLICK))
         {
            this._shazhihe.removeEventListener(MouseEvent.CLICK,this.onShazhiHeClick);
         }
         this._map = null;
         this._mogu = null;
         this._shazhihe = null;
         this._canFighter = false;
         this._isWinBefore = false;
         this._animationPlayer = null;
      }
   }
}
