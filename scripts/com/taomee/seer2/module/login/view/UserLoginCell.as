package com.taomee.seer2.module.login.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.taomee.seer2.module.login.data.CookieInfo;
   import com.taomee.seer2.module.login.data.LoginUserInfo;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   
   public class UserLoginCell extends Sprite
   {
       
      
      public var info:CookieInfo;
      
      private var _mainUI:MovieClip;
      
      private var _hotArea:Sprite;
      
      private var _scale:Number;
      
      private var _sound:Sound;
      
      public function UserLoginCell(param1:ApplicationDomain, param2:CookieInfo = null)
      {
         var _loc3_:EquipPreview = null;
         var _loc4_:LoginUserInfo = null;
         super();
         this.info = param2;
         this._mainUI = DomainUtil.getMovieClip("userLoginCellUI",param1);
         this._sound = DomainUtil.getSound("UserSound_MouseOver",param1);
         addChild(this._mainUI);
         if(param2 == null)
         {
            this._mainUI["info"].visible = false;
            DisplayObjectUtil.disableSprite(this);
         }
         else
         {
            this.createHotArea();
            this._mainUI["info"]["userNameTxt"].text = param2.nick == null ? param2.account : param2.nick;
            if(Boolean(param2.loginAccount) && param2.loginAccount != "")
            {
               this._mainUI["info"]["userIdTxt"].text = param2.loginAccount;
            }
            else
            {
               this._mainUI["info"]["userIdTxt"].text = param2.account;
            }
            _loc3_ = new EquipPreview();
            (_loc4_ = new LoginUserInfo()).equipVec = new Vector.<int>();
            _loc4_.equipVec = Vector.<int>(param2.equipReferenceIdArr);
            EquipUtil.mergeDefaultEquip(0,_loc4_.equipVec);
            _loc3_.setData(_loc4_);
            _loc3_.x = 1;
            _loc3_.y = 118;
            this._mainUI.addChild(_loc3_);
         }
      }
      
      private function createHotArea() : void
      {
         this._hotArea = new Sprite();
         this._hotArea.graphics.beginFill(16777215,0);
         this._hotArea.graphics.drawRect(-86,-146,172,292);
         this._hotArea.graphics.endFill();
         addChild(this._hotArea);
         this._hotArea.buttonMode = true;
         this._hotArea.addEventListener(MouseEvent.CLICK,this.onLogin);
         this._hotArea.addEventListener(MouseEvent.ROLL_OVER,this.onLoginOver);
         this._hotArea.addEventListener(MouseEvent.ROLL_OUT,this.onLoginOut);
      }
      
      private function onLogin(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(MoreUserLoginPanel.CLICK_LOGIN));
      }
      
      private function onLoginOver(param1:MouseEvent) : void
      {
         TweenLite.to(this._mainUI,0,{
            "scaleX":0.9 * this._scale,
            "scaleY":0.9 * this._scale
         });
         TweenLite.to(this._mainUI,1,{
            "scaleX":this._scale,
            "scaleY":this._scale,
            "ease":Elastic.easeOut
         });
         if(this._sound)
         {
            this._sound.play();
         }
      }
      
      private function onLoginOut(param1:MouseEvent) : void
      {
         this._mainUI.scaleX = this._mainUI.scaleY = this._scale;
      }
      
      public function dispose() : void
      {
         this.info = null;
         if(Boolean(this._hotArea) && this._hotArea.hasEventListener(MouseEvent.CLICK))
         {
            this._hotArea.removeEventListener(MouseEvent.CLICK,this.onLogin);
            this._hotArea.removeEventListener(MouseEvent.ROLL_OVER,this.onLoginOver);
            this._hotArea.removeEventListener(MouseEvent.ROLL_OUT,this.onLoginOut);
         }
         this._hotArea = null;
         removeChild(this._mainUI);
         this._mainUI = null;
         this._sound = null;
      }
      
      public function setScale(param1:Number) : void
      {
         this._scale = param1;
         this._mainUI.scaleX = this._mainUI.scaleY = param1;
         if(this._hotArea)
         {
            this._hotArea.scaleX = this._hotArea.scaleY = param1;
         }
      }
   }
}
