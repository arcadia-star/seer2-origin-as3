package com.taomee.seer2.app.activity.processor.waterRecapture
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   
   public class WaterRecaptureMapHandler extends ActivityMapHandler
   {
      
      protected static const ACTIVITY_MONSTER_NUM:uint = 3;
       
      
      private var _lockedDragon:MovieClip;
      
      public function WaterRecaptureMapHandler(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override protected function getLeavAnimationPath() : String
      {
         return _activityProcessor.getActivityID() + "/4";
      }
      
      override protected function processActivityEnd() : void
      {
         if(SceneManager.active.mapID == 171)
         {
            this._lockedDragon = SceneManager.active.mapModel.content["lockedDragon"];
            this._lockedDragon.visible = false;
         }
         this.showLeavingDialog();
      }
      
      private function showLeavingDialog() : void
      {
         NpcDialog.show(23,"神谕祭司",[[0,"水脉的守护神终于苏醒了，我代表整个氏族感谢你的英勇事迹！愿水灵祝福你~"]],["正义一定能战胜邪恶！"],[function():void
         {
            ActivityManager.removeActivityProcessor(_activityProcessor.getActivityID());
            SceneManager.changeScene(SceneType.LOBBY,160);
         }]);
      }
      
      override public function dispose() : void
      {
         this._lockedDragon = null;
         super.dispose();
      }
   }
}
