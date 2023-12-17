package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.ShanMoDiShaAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class MapProcessor_80156 extends CopyMapProcessor
   {
       
      
      public function MapProcessor_80156(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         ShanMoDiShaAct.getInstance().setUp();
         if(SceneManager.prevSceneType != SceneType.ARENA)
         {
            ModuleManager.showAppModule("ShanMoDiShaAlertPanel");
         }
      }
      
      override public function dispose() : void
      {
         ShanMoDiShaAct.getInstance().dispose();
         super.dispose();
      }
   }
}
