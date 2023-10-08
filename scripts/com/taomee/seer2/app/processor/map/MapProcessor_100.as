package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.events.ActionEvent;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class MapProcessor_100 extends TitleMapProcessor
   {
       
      
      private const ACTION_NPC_18_0:String = "常态";
      
      private const ACTION_NPC_18_1:String = "睡觉";
      
      private const ACTION_NPC_18_2:String = "抓屁股";
      
      private const ACTION_NPC_18_3:String = "挖鼻孔";
      
      private const ACTION_NPC_18_4:String = "流口水";
      
      private const ACTION_SLEEP:String = "睡觉动作";
      
      private var _npcSleep:Mobile;
      
      private var _npcKeshui:Mobile;
      
      private var _npcSleepClickedTime:int;
      
      private var _feather:MovieClip;
      
      public function MapProcessor_100(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.processNpc();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_130);
      }
      
      private function processNpc() : void
      {
         this._npcSleep = MobileManager.getMobile(18,MobileType.NPC);
         if(this._npcSleep != null)
         {
            this._npcSleep.action = this.ACTION_NPC_18_1;
         }
         this._npcKeshui = MobileManager.getMobile(22,MobileType.NPC);
         if(this._npcKeshui != null)
         {
            this._npcKeshui.action = this.ACTION_SLEEP;
         }
         this.initNpcSleep();
      }
      
      private function initNpcSleep() : void
      {
         this._npcSleepClickedTime = 0;
         this._npcSleep.addEventListener(MouseEvent.CLICK,this.onNpcSleepClick,false,1);
         this._npcSleep.addEventListener(MouseEvent.MOUSE_OVER,this.onNpcSleepOver,false,1);
         this._npcSleep.addEventListener(MouseEvent.MOUSE_MOVE,this.onNpcSleepMouseMove);
         this._npcSleep.addEventListener(MouseEvent.MOUSE_OUT,this.onNpcSleepOut);
      }
      
      private function onNpcSleepClick(param1:MouseEvent) : void
      {
         if(this._npcSleepClickedTime == 0)
         {
            this._npcSleep.addActionEventListener(ActionEvent.FINISHED,this.onNpcSleepAction2End);
            this._npcSleep.action = this.ACTION_NPC_18_2;
            ++this._npcSleepClickedTime;
            DisplayObjectUtil.disableSprite(this._npcSleep);
         }
         else if(this._npcSleepClickedTime == 1)
         {
            this._npcSleep.action = this.ACTION_NPC_18_0;
            ++this._npcSleepClickedTime;
         }
      }
      
      private function onNpcSleepAction2End(param1:ActionEvent) : void
      {
         this._npcSleep.removeActionEventListener(ActionEvent.FINISHED,this.onNpcSleepAction2End);
         this._npcSleep.action = this.ACTION_NPC_18_1;
         DisplayObjectUtil.enableSprite(this._npcSleep);
      }
      
      private function onNpcSleepOver(param1:MouseEvent) : void
      {
         Mouse.hide();
         this.showFeather();
         param1.stopImmediatePropagation();
      }
      
      private function showFeather() : void
      {
         if(this._feather == null)
         {
            this._feather = _map.libManager.getMovieClip("Map_100_Feather");
            this._feather.x = _map.front.mouseX;
            this._feather.y = _map.front.mouseY;
            _map.front.addChild(this._feather);
         }
      }
      
      private function onNpcSleepMouseMove(param1:MouseEvent) : void
      {
         if(this._feather != null)
         {
            this._feather.x = _map.front.mouseX;
            this._feather.y = _map.front.mouseY;
         }
      }
      
      private function onNpcSleepOut(param1:MouseEvent) : void
      {
         Mouse.show();
         if(this._feather != null)
         {
            DisplayObjectUtil.removeFromParent(this._feather);
            this._feather = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
