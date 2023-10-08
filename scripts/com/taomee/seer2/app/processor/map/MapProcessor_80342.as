package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.expDoorAct.ExpDoorAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80342 extends MapProcessor
   {
       
      
      private var _expDoorAct:ExpDoorAct;
      
      public function MapProcessor_80342(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._expDoorAct = new ExpDoorAct(_map);
      }
      
      override public function dispose() : void
      {
         this._expDoorAct.dispose();
         super.dispose();
      }
   }
}
