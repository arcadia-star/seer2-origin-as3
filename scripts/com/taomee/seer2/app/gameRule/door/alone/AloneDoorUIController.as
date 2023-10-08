package com.taomee.seer2.app.gameRule.door.alone
{
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AloneDoorUIController
   {
      
      private static const END_FRAME:uint = 5;
       
      
      private var _map:MapModel;
      
      private var _content:MovieClip;
      
      private var _roundMC:MovieClip;
      
      private var _npcStage:MovieClip;
      
      private var _npc:MovieClip;
      
      private var _onFight:Function;
      
      public function AloneDoorUIController()
      {
         super();
      }
      
      public function init(param1:MapModel, param2:Function) : void
      {
         if(this._map != null)
         {
            this.dispose();
         }
         this._map = param1;
         this._onFight = param2;
         this.initUI();
      }
      
      private function initUI() : void
      {
         this._content = this._map.content["iloveav"];
         this._roundMC = this._content["roundMC"];
         this._content.gotoAndStop(END_FRAME);
         this._roundMC.gotoAndStop(END_FRAME);
      }
      
      public function dispose() : void
      {
         this._map = null;
         this._content = null;
         this._roundMC = null;
         this._npcStage = null;
         this.npcDispose();
      }
      
      public function updateLevel(param1:uint, param2:Function = null) : void
      {
         var onEnterFrame:Function = null;
         var onNPCStageEnterFrame:Function = null;
         var level:uint = param1;
         var onComplete:Function = param2;
         onEnterFrame = function(param1:Event):void
         {
            _content.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            _npcStage = _content["npcStage"];
            _npcStage.addEventListener(Event.ENTER_FRAME,onNPCStageEnterFrame);
            _npcStage.gotoAndPlay(1);
            _npc = _npcStage["npcMC"];
            _npc.buttonMode = true;
            _npc.useHandCursor = true;
            _npc.addEventListener(MouseEvent.CLICK,onNPCClick);
         };
         onNPCStageEnterFrame = function(param1:Event):void
         {
            if(_npcStage.totalFrames == _npc.currentFrame)
            {
               _npcStage.removeEventListener(Event.ENTER_FRAME,onNPCStageEnterFrame);
               if(onComplete != null)
               {
                  onComplete();
               }
            }
         };
         this.npcDispose();
         this._content.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         this._content.gotoAndStop(level);
         this._roundMC.gotoAndStop(level);
      }
      
      private function npcDispose() : void
      {
         if(this._npc != null)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNPCClick);
            this._npc = null;
         }
      }
      
      private function onNPCClick(param1:MouseEvent) : void
      {
         this._onFight();
      }
   }
}
