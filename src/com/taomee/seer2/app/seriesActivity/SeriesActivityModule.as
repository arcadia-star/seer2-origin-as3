package com.taomee.seer2.app.seriesActivity
{
   import com.taomee.seer2.core.module.Module;
   
   public class SeriesActivityModule extends Module
   {
       
      
      protected var _controllerClass:*;
      
      protected var _activityIndex:int;
      
      protected var _controller:SeriesActivityController;
      
      public function SeriesActivityModule()
      {
         super();
      }
      
      public function get controller() : SeriesActivityController
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
