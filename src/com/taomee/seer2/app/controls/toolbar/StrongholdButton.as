package com.taomee.seer2.app.controls.toolbar
{
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class StrongholdButton extends ToolBarButton
   {
       
      
      public function StrongholdButton()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         _button = UIManager.getMovieClip("UI_Toolbar_StrongholdBtn");
         _button.x = 901;
         _button.y = 26;
         addChild(_button);
      }
      
      override protected function initTip() : void
      {
         TooltipManager.addCommonTip(_button,"英格瓦要塞");
      }
      
      override protected function excuteIteractive(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("IngvarPanel"),"正在打开英格瓦要塞……");
      }
   }
}
