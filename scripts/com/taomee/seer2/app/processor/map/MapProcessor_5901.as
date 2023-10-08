package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.specialPetAct.SpecialPetTwoAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_5901 extends MapProcessor
   {
       
      
      private var _specialPetTwoAct:SpecialPetTwoAct;
      
      public function MapProcessor_5901(param1:MapModel)
      {
         super(param1);
         this._specialPetTwoAct = new SpecialPetTwoAct(param1);
      }
      
      override public function dispose() : void
      {
         if(this._specialPetTwoAct)
         {
            this._specialPetTwoAct.dispose();
            this._specialPetTwoAct = null;
         }
         super.dispose();
      }
   }
}
