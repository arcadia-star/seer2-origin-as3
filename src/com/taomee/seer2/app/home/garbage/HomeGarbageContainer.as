package com.taomee.seer2.app.home.garbage
{
   import com.taomee.seer2.app.extendEvent.EventWithString;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import flash.events.Event;
   import org.taomee.manager.EventManager;
   
   public class HomeGarbageContainer
   {
       
      
      private var _garbageVec:Vector.<HomeGarbage>;
      
      public function HomeGarbageContainer()
      {
         super();
      }
      
      public function fillGarbage(param1:HomeScene, param2:MapModel, param3:ResourceLibrary) : void
      {
         var _loc6_:HomeGarbage = null;
         this._garbageVec = new Vector.<HomeGarbage>();
         HomeGarbageHelper.prepare();
         var _loc4_:int = param1.homeInfo.garbageCount;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new HomeGarbage(HomeGarbageHelper.getGarbageData(),param3);
            param2.content.addChild(_loc6_);
            this._garbageVec.push(_loc6_);
            _loc6_.addEventListener(Event.OPEN,this.onGarbageStart);
            _loc6_.addEventListener(Event.COMPLETE,this.onGarbageComplete);
            _loc5_++;
         }
      }
      
      private function onGarbageStart(param1:Event) : void
      {
         var _loc2_:HomeGarbage = null;
         for each(_loc2_ in this._garbageVec)
         {
            _loc2_.enable = false;
         }
      }
      
      private function onGarbageComplete(param1:Event) : void
      {
         var _loc2_:HomeGarbage = null;
         for each(_loc2_ in this._garbageVec)
         {
            _loc2_.enable = true;
         }
         EventManager.dispatchEvent(new EventWithString("COUNT_GARBAGE_EVENT"));
      }
      
      public function clearGarbage() : void
      {
         var _loc1_:HomeGarbage = null;
         for each(_loc1_ in this._garbageVec)
         {
            _loc1_.removeEventListener(Event.OPEN,this.onGarbageStart);
            _loc1_.removeEventListener(Event.COMPLETE,this.onGarbageComplete);
            _loc1_.dispose();
         }
         this._garbageVec = null;
      }
      
      public function dispose() : void
      {
         this._garbageVec = null;
      }
   }
}
