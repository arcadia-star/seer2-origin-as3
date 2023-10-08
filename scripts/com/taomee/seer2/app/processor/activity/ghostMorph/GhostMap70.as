package com.taomee.seer2.app.processor.activity.ghostMorph
{
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import org.taomee.utils.DisplayUtil;
   
   public class GhostMap70
   {
       
      
      private var _library:DevilLoad;
      
      public function GhostMap70()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         if(GhostMorphLibrary.checkTime())
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.GHOST_MORPH,this.onGhostMorph);
         }
         else if(GhostMorphLibrary.timePar())
         {
            TimeManager.addEventListener(TimeManager.TIME_UPDATE,this.onTimeUpdate);
         }
      }
      
      private function onTimeUpdate(param1:Event) : void
      {
         if(GhostMorphLibrary.timePar() == false)
         {
            TimeManager.removeEventListener(TimeManager.TIME_UPDATE,this.onTimeUpdate);
            this.playAnimation();
         }
      }
      
      private function onGhostMorph(param1:ServerBuffer) : void
      {
         if(param1.readDataAtPostion(0) != 1)
         {
            this.playAnimation();
         }
      }
      
      private function playAnimation() : void
      {
         var mc:MovieClip = null;
         this._library = new DevilLoad();
         this._library.playLoad("ghostMorph/ghostMorph",function():void
         {
            mc = _library.getMC("map70");
            LayerManager.topLayer.addChild(mc);
            MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(mc);
               ServerBufferManager.updateServerBuffer(ServerBufferType.GHOST_MORPH,0,1);
               ModuleManager.toggleModule(URLUtil.getAppModule("GhostMorphPanel"),"正在打开...");
            },true);
         });
      }
   }
}
