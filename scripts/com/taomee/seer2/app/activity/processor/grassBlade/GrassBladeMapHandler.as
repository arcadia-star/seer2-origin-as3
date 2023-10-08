package com.taomee.seer2.app.activity.processor.grassBlade
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class GrassBladeMapHandler extends ActivityMapHandler
   {
      
      protected static const ACTIVITY_MONSTER_NUM:uint = 3;
       
      
      public function GrassBladeMapHandler(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override protected function getLeavAnimationPath() : String
      {
         return _activityProcessor.getActivityID() + "/4";
      }
      
      override protected function processActivityEnd() : void
      {
         this.showLeavingDialog();
      }
      
      private function showLeavingDialog() : void
      {
         NpcDialog.show(16,"神目酋长",[[0,"萨伦帝国的进攻已经被打退了！感谢你为保卫草系部落所作的一切，年轻的赛尔哟！"]],["正义一定能战胜邪恶！"],[function():void
         {
            ActivityManager.removeActivityProcessor(_activityProcessor.getActivityID());
            SceneManager.changeScene(SceneType.LOBBY,110);
         }]);
      }
   }
}
