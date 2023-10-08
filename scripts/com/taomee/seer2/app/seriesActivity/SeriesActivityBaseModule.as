package com.taomee.seer2.app.seriesActivity
{
   import com.taomee.seer2.core.module.BaseModule;
   
   public class SeriesActivityBaseModule extends BaseModule
   {
       
      
      protected var _controllerClass;
      
      protected var _activityIndex:int;
      
      protected var _controller:com.taomee.seer2.app.seriesActivity.SeriesActivityController;
      
      public function SeriesActivityBaseModule()
      {
         super();
      }
      
      public function get controller() : com.taomee.seer2.app.seriesActivity.SeriesActivityController
      {
         if(this._controller == null)
         {
            this._controller = new this._controllerClass();
         }
         return this._controller;
      }
      
      public function get config() : SeriesActivityConfig
      {
         return this.controller.getConfigByIndex(this._activityIndex);
      }
   }
}
