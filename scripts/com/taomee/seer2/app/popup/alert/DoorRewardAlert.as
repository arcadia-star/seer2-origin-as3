package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.gameRule.door.core.DoorResultSwitchPetPanel;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DoorRewardAlert extends Sprite implements IAlert
   {
       
      
      private var _result:Boolean;
      
      private var _doorType:uint = 0;
      
      private var _doorRule:uint = 0;
      
      private var _rewardList:Vector.<ServerReward>;
      
      private var _rewardId:uint;
      
      private var _info:AlertInfo;
      
      private var _doorResultSwitchPetPanel:DoorResultSwitchPetPanel;
      
      private var _closeHandler:Function;
      
      public function DoorRewardAlert()
      {
         super();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._info = param1;
         this._result = param1.initInfo.result;
         this._doorType = param1.initInfo.doorType;
         this._doorRule = param1.initInfo.doorRule;
         this._rewardId = param1.initInfo.rewardId;
         this._rewardList = param1.initInfo.rewardList;
         this._closeHandler = param1.initInfo.closeHandler;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._doorResultSwitchPetPanel = new DoorResultSwitchPetPanel(this._rewardId,this._rewardList,true);
         this._doorResultSwitchPetPanel.addEventListener(DoorResultSwitchPetPanel.SELECT_SWITCH_COMPLETE,this.onSwitchComplete);
         this._doorResultSwitchPetPanel.addEventListener(DoorResultSwitchPetPanel.LOAD_COMPLETE_SHOW_PANEL,this.onLoadCompleteShowPanel);
         addChild(this._doorResultSwitchPetPanel);
      }
      
      private function onLoadCompleteShowPanel(param1:Event) : void
      {
         this._doorResultSwitchPetPanel.removeEventListener(DoorResultSwitchPetPanel.LOAD_COMPLETE_SHOW_PANEL,this.onLoadCompleteShowPanel);
         AlertManager.addPopUp(this._info,this);
      }
      
      private function onSwitchComplete(param1:Event) : void
      {
         this._doorResultSwitchPetPanel.removeEventListener(DoorResultSwitchPetPanel.SELECT_SWITCH_COMPLETE,this.onSwitchComplete);
         this._doorResultSwitchPetPanel.addEventListener(DoorResultSwitchPetPanel.CONFIRM_COMPLETE,this.onConfirmHandler);
      }
      
      private function onConfirmHandler(param1:Event) : void
      {
         this._doorResultSwitchPetPanel.removeEventListener(DoorResultSwitchPetPanel.CONFIRM_COMPLETE,this.onConfirmHandler);
         this.dispose();
      }
      
      public function dispose() : void
      {
         if(this._closeHandler != null)
         {
            this._closeHandler();
         }
         this._closeHandler = null;
         LayerManager.resetOperation();
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
