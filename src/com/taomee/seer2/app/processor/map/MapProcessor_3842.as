package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3842 extends MapProcessor
   {
       
      
      public function MapProcessor_3842(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.springFestivalManager();
      }
      
      private function springFestivalManager() : void
      {
         if(_map.content["experienceMc"])
         {
            (_map.content["experienceMc"] as MovieClip).buttonMode = true;
            (_map.content["experienceMc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onExperience);
         }
         if(_map.content["studyMc"])
         {
            (_map.content["studyMc"] as MovieClip).buttonMode = true;
            (_map.content["studyMc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onStudy);
         }
         if(_map.content["potentialMc"])
         {
            (_map.content["potentialMc"] as MovieClip).buttonMode = true;
            (_map.content["potentialMc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onPotential);
         }
      }
      
      private function onExperience(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("SpringFestivalExperiencePanel");
      }
      
      private function onStudy(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("SpringFestivalStudyPanel");
      }
      
      private function onPotential(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("SpringFestivalPotentialPanel");
      }
   }
}
