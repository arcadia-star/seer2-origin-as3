package com.taomee.seer2.app.processor.shoot
{
   import com.taomee.seer2.app.shoot.BaseShoot;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.core.cache.ShootCache;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import org.taomee.utils.DisplayUtil;
   
   public class Type_100 extends BaseShoot
   {
       
      
      private var _ui:MovieClip;
      
      public function Type_100()
      {
         super();
      }
      
      override public function execute(param1:ShootInfo) : void
      {
         super.execute(param1);
         this._ui = ShootCache.getEffectMovieClip(_info.id,1);
         this._ui.x = _info.startPos.x;
         this._ui.y = _info.startPos.y;
         this._ui.mouseEnabled = false;
         this._ui.mouseChildren = false;
         this._ui.scaleX = _info.endPos.x > _info.startPos.x ? 1 : -1;
         SceneManager.active.mapModel.front.addChild(this._ui);
         this._ui.addEventListener(Event.ENTER_FRAME,this.onEnter);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._ui)
         {
            this._ui.removeEventListener(Event.ENTER_FRAME,this.onEnter);
            DisplayUtil.removeForParent(this._ui);
            this._ui = null;
         }
      }
      
      private function onEnter(param1:Event) : void
      {
         ShootController.dispatchEvent(ShootEvent.PLAY_END,_info);
         this.dispose();
      }
   }
}
