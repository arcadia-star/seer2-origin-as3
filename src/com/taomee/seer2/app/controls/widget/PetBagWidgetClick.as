package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class PetBagWidgetClick implements IToolBarWidgetClick
   {
      
      public static const PET_BAG:String = "petBag";
       
      
      private var _widget:ToolBarWidget;
      
      public function PetBagWidgetClick()
      {
         super();
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         if(PetInfoManager.getAllBagPetInfo().length == 0)
         {
            AlertManager.showAlert("很抱歉，你的背包中没有精灵");
         }
         else
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_1);
            ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"),"正在打开精灵背包...");
         }
      }
      
      public function get widget() : ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:ToolBarWidget) : void
      {
         this._widget = param1;
      }
   }
}
