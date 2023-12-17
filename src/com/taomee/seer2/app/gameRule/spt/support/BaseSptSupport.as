package com.taomee.seer2.app.gameRule.spt.support
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
   import com.taomee.seer2.app.gameRule.core.ISupportable;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaseSptSupport implements ISupportable
   {
       
      
      protected var _map:MapModel;
      
      protected var _sptNPC:Sprite;
      
      protected var _winHistory:Boolean;
      
      protected var _sptBufferPosition:int;
      
      protected var _sptBossId:uint = 0;
      
      protected var _petMaxLevelLimit:uint = 0;
      
      protected var _animationPlayer:ProgressiveAnimationPlayer;
      
      protected var _fighterID:Number = -1;
      
      public function BaseSptSupport()
      {
         super();
      }
      
      public function init(param1:MapModel) : void
      {
         this._map = param1;
         this.initSPTNPC();
         ServerBufferManager.getServerBuffer(ServerBufferType.SPT,this.onServerBufferDataHandler);
      }
      
      public function checkSptBossInfo(param1:Function) : void
      {
         SptBossInfoManager.getSptBossInfo(param1);
      }
      
      private function onServerBufferDataHandler(param1:ServerBuffer) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         param1.printDataInfo();
         this._winHistory = param1.readDataAtPostion(this._sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
         if(SceneManager.prevSceneType != SceneType.ARENA)
         {
            this.dealWithMapInit();
         }
         else
         {
            _loc2_ = FightManager.currentFightRecord.fightUniqueID;
            if(_loc2_ == this._fighterID)
            {
               _loc3_ = FightManager.fightWinnerSide;
               if(_loc3_ == FightSide.RIGHT)
               {
                  SptBossInfoManager.getSptBossInfo(this.fightFailure);
               }
               else if(_loc3_ == FightSide.LEFT)
               {
                  this.fightWin();
               }
               else
               {
                  this.fightError();
               }
            }
            else
            {
               this.dealWithMapInit();
            }
         }
      }
      
      protected function initSPTNPC() : void
      {
         if(this._sptNPC)
         {
            this._sptNPC.addEventListener(MouseEvent.CLICK,this.onSPTClickHandler);
         }
         this.hideSPT();
      }
      
      protected function showSPT(param1:String = null) : void
      {
         if(this._sptNPC)
         {
            this._sptNPC.visible = true;
            if(param1 != null)
            {
               (this._sptNPC as Mobile).action = param1;
            }
         }
      }
      
      protected function hideSPT() : void
      {
         if(this._sptNPC)
         {
            this._sptNPC.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(this._sptNPC) && this._sptNPC.hasEventListener(MouseEvent.CLICK))
         {
            this._sptNPC.removeEventListener(MouseEvent.CLICK,this.onSPTClickHandler);
         }
         this._animationPlayer = null;
         this._sptNPC = null;
      }
      
      protected function dealWithMapInit() : void
      {
      }
      
      protected function fightFailure(param1:LittleEndianByteArray) : void
      {
      }
      
      protected function fightWin() : void
      {
      }
      
      protected function fightError() : void
      {
      }
      
      protected function onSPTClickHandler(param1:MouseEvent) : void
      {
      }
   }
}
