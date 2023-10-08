package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.CookieAgent;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.data.CookieInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   public class MoreUserLoginPanel extends Sprite
   {
      
      public static const CLICK_LOGIN:String = "clickLogin";
       
      
      private var _domain:ApplicationDomain;
      
      private var _oneUserLoginBtn:SimpleButton;
      
      private var _cellVec:Vector.<com.taomee.seer2.module.login.view.UserLoginCell>;
      
      private var _title:MovieClip;
      
      private const posVec:Vector.<Point> = Vector.<Point>([new Point(485,256),new Point(80,232),new Point(891,232)]);
      
      private const scaleVec:Vector.<Number> = Vector.<Number>([262 / 211,1,1]);
      
      public function MoreUserLoginPanel()
      {
         super();
         LoaderAgent.addEventListener("moreUserLogin",this.onLoadMoreUserPage);
         LoaderAgent.loadDomain("moreUserLogin");
      }
      
      private function onLoadMoreUserPage(param1:Event) : void
      {
         LoaderAgent.removeEventListner("moreUserLogin",this.onLoadMoreUserPage);
         this._domain = LoaderAgent.getDomain("moreUserLogin");
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._oneUserLoginBtn = DomainUtil.getSimpleButton("otherUserloginBtn",this._domain);
         this._oneUserLoginBtn.x = 315;
         this._oneUserLoginBtn.y = 534;
         addChild(this._oneUserLoginBtn);
         this._title = DomainUtil.getMovieClip("loginTltle",this._domain);
         this._title.x = 265;
         this._title.y = -40;
         addChildAt(this._title,this.numChildren - 1);
         this._title.mouseChildren = false;
         this._title.mouseEnabled = false;
         this._oneUserLoginBtn.addEventListener(MouseEvent.CLICK,this.onOneLogin);
         this.createUserCellVec();
      }
      
      private function createUserCellVec() : void
      {
         var _loc3_:com.taomee.seer2.module.login.view.UserLoginCell = null;
         this._cellVec = new Vector.<com.taomee.seer2.module.login.view.UserLoginCell>();
         var _loc1_:Vector.<CookieInfo> = CookieAgent.getCookieInfoVec();
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(_loc2_ < _loc1_.length)
            {
               _loc3_ = new com.taomee.seer2.module.login.view.UserLoginCell(this._domain,_loc1_[_loc2_]);
               _loc3_.addEventListener(CLICK_LOGIN,this.onCellClick);
            }
            else
            {
               _loc3_ = new com.taomee.seer2.module.login.view.UserLoginCell(this._domain);
            }
            _loc3_.x = this.posVec[_loc2_].x;
            _loc3_.y = this.posVec[_loc2_].y;
            _loc3_.setScale(this.scaleVec[_loc2_]);
            addChild(_loc3_);
            this._cellVec.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function onCellClick(param1:Event) : void
      {
         var _loc2_:com.taomee.seer2.module.login.view.UserLoginCell = param1.currentTarget as com.taomee.seer2.module.login.view.UserLoginCell;
         if(_loc2_.info == null)
         {
            return;
         }
         dispatchEvent(new LoginEvent(LoginEvent.ONE_USER_LOGIN,_loc2_.info));
      }
      
      private function onOneLogin(param1:MouseEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ONE_USER_LOGIN));
      }
      
      public function dispose() : void
      {
         var _loc1_:com.taomee.seer2.module.login.view.UserLoginCell = null;
         this._domain = null;
         this._oneUserLoginBtn.removeEventListener(MouseEvent.CLICK,this.onOneLogin);
         this._oneUserLoginBtn = null;
         for each(_loc1_ in this._cellVec)
         {
            if(_loc1_.hasEventListener(MouseEvent.CLICK))
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onCellClick);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._cellVec = null;
      }
   }
}
