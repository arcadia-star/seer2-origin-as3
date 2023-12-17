package com.taomee.seer2.app.entity.handler
{
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class HandlerOpenShop extends HandlerEntityClick
   {
       
      
      public function HandlerOpenShop()
      {
         super();
      }
      
      override public function initData(param1:XML) : void
      {
      }
      
      override protected function action() : void
      {
         var _loc1_:Object = new Object();
         _loc1_.shopType = 1;
         ModuleManager.toggleModule(URLUtil.getAppModule("ShoppingPanel"),"正在打开精灵仓库...",_loc1_);
      }
   }
}
