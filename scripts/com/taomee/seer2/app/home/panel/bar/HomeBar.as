package com.taomee.seer2.app.home.panel.bar
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class HomeBar extends Sprite
   {
       
      
      protected var _container:MovieClip;
      
      protected var _buttonVec:Vector.<SimpleButton>;
      
      protected var _homeInfo:HomeInfo;
      
      protected var currButtonVec:Vector.<SimpleButton>;
      
      public function HomeBar()
      {
         super();
      }
      
      public function setData(param1:HomeInfo) : void
      {
         this._homeInfo = param1;
         this.updateDisplay();
      }
      
      private function updateDisplay() : void
      {
         var _loc1_:uint = ActorManager.actorInfo.id;
         var _loc2_:uint = this._homeInfo.userId;
         var _loc3_:* = _loc1_ == _loc2_;
         var _loc4_:Vector.<int> = this.getShowButtonIndexVec(_loc3_);
         this.updateHomeButton(_loc4_);
         this.updateLayout();
      }
      
      protected function getShowButtonIndexVec(param1:Boolean) : Vector.<int>
      {
         return null;
      }
      
      private function updateHomeButton(param1:Vector.<int>) : void
      {
         this.currButtonVec = Vector.<SimpleButton>([]);
         var _loc2_:int = int(this._buttonVec.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.indexOf(_loc3_) != -1)
            {
               this._container.addChild(this._buttonVec[_loc3_]);
               this.currButtonVec.push(this._buttonVec[_loc3_]);
            }
            else
            {
               DisplayObjectUtil.removeFromParent(this._buttonVec[_loc3_]);
            }
            _loc3_++;
         }
         this.updateCurrBtn();
      }
      
      protected function updateCurrBtn() : void
      {
      }
      
      protected function updateLayout() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}
