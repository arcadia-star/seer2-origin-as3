package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityPriority;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   
   public class CookingUnit extends BaseUnit
   {
       
      
      public function CookingUnit()
      {
         super();
         this.label = "烹饪食材";
         this.type = FunctionalityType.MODULE;
         this.priority = FunctionalityPriority.MODULE;
      }
      
      override protected function addIcon() : void
      {
         _icon = UIManager.getSprite("UI_DialogModule");
         addChild(_icon);
      }
      
      override protected function onBtnClick(param1:MouseEvent) : void
      {
         dispatchEvent(new FunctionalityBoxEvent(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,"cooking"));
         DialogPanel.hide();
      }
   }
}
