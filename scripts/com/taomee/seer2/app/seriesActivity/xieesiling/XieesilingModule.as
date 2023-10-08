package com.taomee.seer2.app.seriesActivity.xieesiling
{
   import com.taomee.seer2.app.seriesActivity.SeriesActivityModule;
   
   public class XieesilingModule extends SeriesActivityModule
   {
       
      
      public function XieesilingModule()
      {
         super();
         _controllerClass = XieesilingController;
      }
      
      public function get xieesilignConfig() : XieesilingConfig
      {
         return config as XieesilingConfig;
      }
   }
}
