package com.taomee.seer2.app.activity.processor.salungInvade
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class DoomBoltSoldier extends SalungSoldierBase
   {
       
      
      public function DoomBoltSoldier(param1:uint)
      {
         super(param1);
         loadRes("SalungDoomBolt");
      }
      
      override protected function initUI() : void
      {
         _mc = new (_info.domain.getDefinition("doomBoltMc"))();
         _mc.x = MAP_OOSITION["m_" + _mapId][0];
         _mc.y = MAP_OOSITION["m_" + _mapId][1];
         LayerManager.uiLayer.addChild(_mc);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.destory);
         _mc["mc"].gotoAndPlay(1);
         (_mc["mc"] as MovieClip).addFrameScript(_mc["mc"].totalFrames - 1,function():void
         {
            DisplayUtil.removeForParent(_mc);
            getAward();
         });
      }
      
      private function destory(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.destory);
         DisplayUtil.removeForParent(_mc);
         DisplayUtil.removeForParent(this);
         _mc = null;
      }
   }
}
