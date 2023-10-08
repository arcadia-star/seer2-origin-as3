package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.core.scene.ImageLevelManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.StageQuality;
   import org.taomee.bean.BaseBean;
   
   public class ImageLevelBean extends BaseBean
   {
       
      
      public function ImageLevelBean()
      {
         super();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         finish();
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.ARENA)
         {
            if(ImageLevelManager.getFightImageQuality() == "")
            {
               ImageLevelManager.setFightImageLevel(StageQuality.MEDIUM);
            }
            else
            {
               ImageLevelManager.setFightImageLevel(ImageLevelManager.getFightImageQuality());
            }
         }
         else if(SceneManager.active)
         {
            if(ImageLevelManager.getImageQuality() == "")
            {
               ImageLevelManager.setImageLevel(StageQuality.HIGH);
            }
            else
            {
               ImageLevelManager.setImageLevel(ImageLevelManager.getImageQuality());
            }
         }
      }
   }
}
