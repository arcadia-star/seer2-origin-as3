package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.pandaMan.Panda1180Entry;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_1180 extends MapProcessor
   {
       
      
      private var _panda1180Entry:Panda1180Entry;
      
      public function MapProcessor_1180(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._panda1180Entry = new Panda1180Entry();
         this._panda1180Entry.setup();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._panda1180Entry.dispose();
         this._panda1180Entry = null;
      }
   }
}
