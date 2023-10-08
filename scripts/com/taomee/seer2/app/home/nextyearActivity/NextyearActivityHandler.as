package com.taomee.seer2.app.home.nextyearActivity
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.ISceneHandler;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class NextyearActivityHandler implements ISceneHandler
   {
      
      private static var _resourceLoader:ResourceLibraryLoader;
      
      {
         initialize();
      }
      
      private var _scene:HomeScene;
      
      private var _nextyearActivity:com.taomee.seer2.app.home.nextyearActivity.NextyearActivityHome;
      
      public function NextyearActivityHandler()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("common/home/nextyearActivity" + URLUtil.POSTFIX_SWF));
      }
      
      public function init(param1:BaseScene) : void
      {
         this._scene = param1 as HomeScene;
      }
      
      public function onMapStart() : void
      {
         if(Boolean(this._scene.homeInfo) && Boolean(this._scene.homeInfo.nextyearActivityInfo))
         {
            _resourceLoader.getLib(this.initChrismasSocks);
         }
      }
      
      private function initChrismasSocks(param1:ResourceLibrary) : void
      {
         this._nextyearActivity = new com.taomee.seer2.app.home.nextyearActivity.NextyearActivityHome(this._scene.homeInfo.nextyearActivityInfo,param1);
      }
      
      private function clearChrismasSocks() : void
      {
         if(this._nextyearActivity)
         {
            this._nextyearActivity.dispose();
         }
         this._nextyearActivity = null;
      }
      
      public function onTick(param1:int) : void
      {
      }
      
      public function onMapEnd() : void
      {
         this.clearChrismasSocks();
      }
      
      public function disopse() : void
      {
         this._scene = null;
         this.clearChrismasSocks();
      }
   }
}
