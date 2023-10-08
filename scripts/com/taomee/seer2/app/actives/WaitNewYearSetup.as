package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.processor.activity.waitNewYearAct.WaitNewYearAct;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class WaitNewYearSetup
   {
      
      private static var maps:Array = [3815,3818];
      
      private static var maps2:Array = [70,10,20,30,60,40,50,60,450,1300,8011,3818];
       
      
      public function WaitNewYearSetup()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(DateUtil.isDay(2015,12,31))
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
         }
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         if(maps.indexOf(SceneManager.active.mapID) != -1)
         {
            WaitNewYearAct.getInstance().handleNewYearTime(SceneManager.active.mapModel);
         }
         if(maps2.indexOf(SceneManager.active.mapID) != -1)
         {
            WaitNewYearAct.getInstance().handleNpcHandle();
         }
      }
      
      private static function onMapSwitchStart(param1:SceneEvent) : void
      {
         if(SceneManager.active == null)
         {
            return;
         }
         if(maps.indexOf(SceneManager.active.mapID) != -1)
         {
            WaitNewYearAct.getInstance().disposeNewYearTime();
         }
         if(maps2.indexOf(SceneManager.active.mapID) != -1)
         {
            WaitNewYearAct.getInstance().disposeNpcHandle();
         }
      }
   }
}
