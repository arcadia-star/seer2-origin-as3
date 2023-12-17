package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.component.BlockableView;
   import com.taomee.seer2.app.controls.widget.NoticeWidgt;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class LeftMinorToolBar extends BlockableView
   {
      
      private static var _instance:LeftMinorToolBar;
       
      
      private var _notice:NoticeWidgt;
      
      public function LeftMinorToolBar()
      {
         super();
         this._notice = new NoticeWidgt();
         addChild(this._notice);
         this.x = 0;
         this.y = 64;
      }
      
      private static function get instance() : LeftMinorToolBar
      {
         if(_instance == null)
         {
            _instance = new LeftMinorToolBar();
            _instance.x = 0;
            _instance.y = 64;
         }
         return _instance;
      }
      
      public static function show() : void
      {
         instance._show();
      }
      
      public static function hide() : void
      {
         instance._hide();
      }
      
      private function _show() : void
      {
         LayerManager.uiLayer.addChild(this);
         this._notice.isBlock = false;
      }
      
      private function _hide() : void
      {
         DisplayObjectUtil.removeFromParent(this);
         this._notice.isBlock = true;
      }
   }
}
