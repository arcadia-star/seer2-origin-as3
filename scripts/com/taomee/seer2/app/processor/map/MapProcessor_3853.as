package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.LeagueCruise.LeagueCruise;
   import com.taomee.seer2.app.processor.activity.bestKingEndAct.BestKingEndAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_3853 extends MapProcessor
   {
       
      
      private var _bestKingEndAct:BestKingEndAct;
      
      private var _leagueCruise:LeagueCruise;
      
      public function MapProcessor_3853(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._bestKingEndAct = new BestKingEndAct(_map);
         this._leagueCruise = new LeagueCruise(_map);
      }
      
      override public function dispose() : void
      {
         this._bestKingEndAct.dispose();
         this._leagueCruise.dispose();
         super.dispose();
      }
   }
}
