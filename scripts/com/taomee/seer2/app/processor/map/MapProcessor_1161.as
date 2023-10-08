package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.StanceFightPetAct;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_1161 extends MapProcessor
   {
       
      
      public function MapProcessor_1161(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         StatisticsManager.sendNovice("0x1003463b");
         RightToolbarConter.instance.hide();
         StanceFightPetAct.getInstance().npcId = 727;
         StanceFightPetAct.getInstance().showFull = "showDragonPrince";
         StanceFightPetAct.getInstance().leaveFull = "leaveDragonPrince";
         StanceFightPetAct.getInstance().setup(846);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         RightToolbarConter.instance.show();
         StanceFightPetAct.getInstance().dispose();
      }
   }
}
