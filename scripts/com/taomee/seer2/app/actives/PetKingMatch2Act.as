package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class PetKingMatch2Act
   {
      
      private static var _instance:com.taomee.seer2.app.actives.PetKingMatch2Act;
       
      
      private const ARMY_ID:uint = 202997;
      
      private const ICON_NAME:Array = ["waterIcon","fireIcon","grassIcon"];
      
      private var army:uint;
      
      private var icon:IconDisplayer;
      
      public function PetKingMatch2Act()
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.actives.PetKingMatch2Act
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.actives.PetKingMatch2Act();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ActiveCountManager.requestActiveCount(this.ARMY_ID,this.getArmy);
      }
      
      private function getArmy(param1:uint, param2:uint) : void
      {
         this.army = param2;
         if(this.army == 0)
         {
            return;
         }
         this.icon = new IconDisplayer();
         this.icon.setIconUrl(URLUtil.getActivityAnimation(this.ICON_NAME[this.army - 1]),this.onComplete);
      }
      
      private function onComplete() : void
      {
      }
   }
}
