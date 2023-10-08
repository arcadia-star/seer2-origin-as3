package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.dreamGift.DreamGiftAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80467 extends MapProcessor
   {
       
      
      private var _dreamGiftAct:DreamGiftAct;
      
      public function MapProcessor_80467(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._dreamGiftAct = new DreamGiftAct(_map);
      }
      
      override public function dispose() : void
      {
         this._dreamGiftAct.dispose();
      }
   }
}
