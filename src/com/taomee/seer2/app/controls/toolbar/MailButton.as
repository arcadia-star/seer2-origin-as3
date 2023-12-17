package com.taomee.seer2.app.controls.toolbar
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class MailButton extends ToolBarButton
   {
       
      
      public function MailButton()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         _button = UIManager.getMovieClip("UI_Toolbar_MailBtn");
         _button.x = 845;
         _button.y = 28;
         _button.buttonMode = true;
         addChild(_button);
      }
      
      override protected function initTip() : void
      {
         TooltipManager.addCommonTip(_button,"邮件");
      }
      
      override protected function excuteIteractive(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_1);
         ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"),"正在打开精灵背包...");
      }
   }
}
