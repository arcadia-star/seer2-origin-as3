package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.module.ModuleProxy;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class WorldMapWidgetClick implements IToolBarWidgetClick
   {
      
      public static const MAP:String = "map";
       
      
      private var _widget:com.taomee.seer2.app.controls.widget.ToolBarWidget;
      
      public function WorldMapWidgetClick()
      {
         super();
      }
      
      public function get widget() : com.taomee.seer2.app.controls.widget.ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:com.taomee.seer2.app.controls.widget.ToolBarWidget) : void
      {
         this._widget = param1;
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_3);
         if(ModuleManager.getModuleStatus("DoorMapPanel") == ModuleProxy.SHOW)
         {
            ModuleManager.closeForName("DoorMapPanel");
         }
         if(ModuleManager.getModuleStatus("MapSignPanel") == ModuleProxy.SHOW)
         {
            ModuleManager.closeForName("MapSignPanel");
         }
         if(ModuleManager.getModuleStatus("ShipMap2Panel") == ModuleProxy.SHOW)
         {
            ModuleManager.closeForName("ShipMap2Panel");
         }
         var _loc2_:Object = new Object();
         _loc2_["mapCategoryId"] = SceneManager.active.mapCategoryID;
         _loc2_["mapId"] = SceneManager.active.mapID;
         ModuleManager.toggleModule(URLUtil.getAppModule("MapPanel"),"正在打开地图导航...",_loc2_);
      }
   }
}
