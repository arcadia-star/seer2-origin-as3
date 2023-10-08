package com.taomee.seer2.app.processor.quest.handler.activity.quest30050
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import org.taomee.filter.ColorFilter;
   
   public class Quest30050Content
   {
       
      
      public function Quest30050Content()
      {
         super();
      }
      
      public static function closeMapPro() : void
      {
         LayerManager.uiLayer.visible = false;
         MonsterManager.hideAllMonster();
         ActorManager.showRemoteActor = false;
         MapTitlePanel.hide();
         ColorFilter.setGrayscale(LayerManager.mapLayer);
      }
      
      public static function openMapPro() : void
      {
         MonsterManager.showAllMonster();
         LayerManager.uiLayer.visible = true;
         ActorManager.showRemoteActor = true;
         MapTitlePanel.show();
         LayerManager.mapLayer.filters = [];
      }
   }
}
