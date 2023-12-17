package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MapProcessor_3834 extends MapProcessor
   {
       
      
      private var _tm:Timer;
      
      public function MapProcessor_3834(param1:MapModel)
      {
         this._tm = new Timer(2500,1);
         super(param1);
      }
      
      override public function dispose() : void
      {
         this._tm.removeEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      override public function init() : void
      {
         this.animationFunc();
         (_map.content["npcMc"] as MovieClip).buttonMode = true;
         (_map.content["npcMc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onDialog);
      }
      
      private function onDialog(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1027,"伊鲁维特影像",[[0,"我是将军伊鲁维特,你们看到的是我的影像."]],["地球科技好先进啊！"],[function():void
         {
         }]);
      }
      
      private function animationFunc() : void
      {
         this._tm.addEventListener(TimerEvent.TIMER,this.onTimer);
         MovieClip(_map.content["shootMc"]).buttonMode = true;
         MovieClip(_map.content["shootMc"]).gotoAndStop(1);
         MovieClip(_map.content["shootMc"]).addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this._tm.reset();
         this._tm.start();
         MovieClip(_map.content["shootMc"]).removeEventListener(MouseEvent.CLICK,this.onClick);
         MovieClip(_map.content["shootMc"]).gotoAndStop(2);
      }
      
      private function onTimer(param1:Event) : void
      {
         MovieClip(_map.content["shootMc"]).addEventListener(MouseEvent.CLICK,this.onClick);
         MovieClip(_map.content["shootMc"]).gotoAndStop(1);
      }
   }
}
