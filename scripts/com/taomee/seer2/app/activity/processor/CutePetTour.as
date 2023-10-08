package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.Proclaim;
   import flash.display.Loader;
   import org.taomee.utils.Tick;
   
   public class CutePetTour extends ActivityProcessor
   {
      
      private static const ACTIVITY_POINTER_POSITION:Object = {
         "x":660,
         "y":160,
         "mapName":"烈焰峡谷"
      };
      
      private static const MINUTES_PER_HOUR:uint = 60;
       
      
      private var _hasNotifyShowed:Boolean;
      
      private var _currentTimeVec:Vector.<uint>;
      
      private var _loader:Loader;
      
      public function CutePetTour(param1:ActivityDefinition)
      {
         super(param1);
         _relatedMapIDArr = [262];
         Tick.instance.addRender(this.onNotifyTimer,5 * 60 * 1000);
         this.initCurrentTimeVec();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         if(this._hasNotifyShowed == false)
         {
            return this.ShowTourNotify();
         }
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
      }
      
      private function onNotifyTimer(param1:int) : void
      {
         this.ShowTourNotify();
      }
      
      private function ShowTourNotify() : void
      {
         var _loc1_:uint = this.getCurrentPhaseIndex();
         if(_loc1_ && SceneManager.active && SceneManager.active.mapID != _relatedMapIDArr[_loc1_ - 1] && SceneManager.active.type != SceneType.ARENA)
         {
            this._hasNotifyShowed = true;
            Proclaim.addText("M粉注意，约定时间已到！赶快去烈焰峡谷接受M5的挑战！");
         }
      }
      
      public function getCurrentPhaseIndex() : uint
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:int = int(_loc1_.hours * 60 + _loc1_.minutes) - int(this._currentTimeVec[0]);
         if(_loc2_ < 0)
         {
            return 0;
         }
         return uint(_loc2_ < this._currentTimeVec[1] - this._currentTimeVec[0]);
      }
      
      private function initCurrentTimeVec() : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         this._currentTimeVec = new Vector.<uint>();
         var _loc1_:uint = uint(TimeManager.getServerTime());
         var _loc2_:Vector.<String> = _activity.getPhaseTimeVec(_loc1_);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].indexOf(":");
            _loc5_ = uint(_loc2_[_loc3_].substring(0,_loc4_)) * MINUTES_PER_HOUR + uint(_loc2_[_loc3_].substring(_loc4_ + 1));
            this._currentTimeVec.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function getCurrentTimeVec() : Vector.<uint>
      {
         return this._currentTimeVec;
      }
      
      override public function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         Tick.instance.removeRender(this.onNotifyTimer);
         this._currentTimeVec = null;
         super.dispose();
      }
   }
}
