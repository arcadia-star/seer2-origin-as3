package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.stomach.MiqilinEntry;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_8032 extends MapProcessor
   {
       
      
      private var _miqilinManager:MiqilinEntry;
      
      public function MapProcessor_8032(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._miqilinManager = new MiqilinEntry(_map);
      }
      
      override public function dispose() : void
      {
         this._miqilinManager.dispose();
         super.dispose();
      }
   }
}
