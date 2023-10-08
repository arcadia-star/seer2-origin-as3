package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ShouyouWidgetClick extends Sprite implements IWidgetable
   {
      
      public static const SHOUYOU_WIDGET:String = "SHOUYOU_WIDGET";
       
      
      public function ShouyouWidgetClick(param1:DisplayObject)
      {
         var mc:DisplayObject = param1;
         super();
         mc.addEventListener(MouseEvent.CLICK,function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("SeerShouyouPanel"),"正在打开...");
         });
      }
   }
}
