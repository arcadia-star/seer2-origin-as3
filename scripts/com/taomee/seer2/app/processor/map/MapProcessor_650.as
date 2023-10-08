package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.frozen.FrozenManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_650 extends MapProcessor
   {
       
      
      private var _frozenManager:FrozenManager;
      
      public function MapProcessor_650(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(FrozenManager.isActivityTime())
         {
            this._frozenManager = new FrozenManager(_map);
         }
      }
      
      override public function dispose() : void
      {
         if(this._frozenManager)
         {
            this._frozenManager.dispose();
         }
         this._frozenManager = null;
      }
   }
}
