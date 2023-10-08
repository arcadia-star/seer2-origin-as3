package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.activity.snow.Snow;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class SnowManager
   {
      
      private static var snow:Snow;
       
      
      public function SnowManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitch);
      }
      
      private static function onSwitch(param1:SceneEvent) : void
      {
         hideSnow();
         if(SceneManager.active.mapID != 70 && SceneManager.currentSceneType == SceneType.LOBBY)
         {
            snow = new Snow();
            LayerManager.mapLayer.addChild(snow);
         }
      }
      
      public static function hideSnow() : void
      {
         if(snow)
         {
            snow.dispose();
            DisplayUtil.removeForParent(snow);
         }
         snow = null;
      }
   }
}
