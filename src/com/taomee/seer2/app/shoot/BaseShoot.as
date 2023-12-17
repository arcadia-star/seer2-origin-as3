package com.taomee.seer2.app.shoot
{
   public class BaseShoot
   {
       
      
      protected var _info:ShootInfo;
      
      protected var _isHide:Boolean;
      
      public function BaseShoot()
      {
         super();
         ShootController.addShoot(this);
      }
      
      public function dispose() : void
      {
         ShootController.removeShoot(this);
         this._info = null;
      }
      
      public function execute(param1:ShootInfo) : void
      {
         this._info = param1;
         ShootController.dispatchEvent(ShootEvent.PLAY_START,this._info);
      }
      
      public function hideEffect() : void
      {
         this._isHide = true;
      }
      
      public function get id() : uint
      {
         if(this._info)
         {
            return this._info.id;
         }
         return 0;
      }
   }
}
