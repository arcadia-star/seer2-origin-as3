package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.constant.FunctionalityPriority;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class ModuleUnit extends BaseUnit
   {
       
      
      public function ModuleUnit()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
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
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc2_:String = this.params;
         var _loc3_:Array = _loc2_.split(" ");
         if(_loc3_.length > 1)
         {
            _loc4_ = new Object();
            (_loc5_ = (_loc5_ = String(_loc3_[1])).substr(1,_loc5_.length - 2)).replace(" ");
            _loc6_ = _loc5_.split(",");
            for each(_loc7_ in _loc6_)
            {
               _loc8_ = _loc7_.split(":");
               _loc4_[_loc8_[0]] = _loc8_[1];
            }
            ModuleManager.toggleModule(URLUtil.getAppModule(_loc3_[0]),"正在打开" + "..." + this.label + "...",_loc4_);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(_loc3_[0]),"正在打开" + "..." + this.label + "...");
         }
         DialogPanel.hide();
      }
   }
}
