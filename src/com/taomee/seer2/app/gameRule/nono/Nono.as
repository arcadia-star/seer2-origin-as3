package com.taomee.seer2.app.gameRule.nono
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.component.IBaseView;
   import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.constant.MoveStyle;
   import com.taomee.seer2.core.entity.events.ActionEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Nono extends Mobile implements IBaseView
   {
      
      private static const PERSONAL:String = "personal";
      
      private static const STAND_DOWN:String = "standDown";
      
      private static const MAX_IDEL_TIME:int = 250;
       
      
      private var _userInfo:UserInfo;
      
      private var _nonoInfo:NonoInfo;
      
      private var _shadow:Sprite;
      
      private var _nonoBtnCollection:NonoBtnCollection;
      
      private var _hotArea:Sprite;
      
      private var _clock:MovieClip;
      
      private var _idleTime:int;
      
      private var _nonoAppearAnimation:MovieClip;
      
      private var _nonoDisAppearAnimation:MovieClip;
      
      public function Nono()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         followDistance = 100;
         this._shadow = UIManager.getSprite("UI_PetShadow");
         this._hotArea = UIManager.getSprite("UI_NONO_HOTAREA");
         this._hotArea.alpha = 0;
         this._hotArea.x = -13;
         this._hotArea.y = -95;
         addChild(this._hotArea);
         this._clock = UIManager.getMovieClip("UI_Nono_Msg");
         this._clock.y = -70;
         this._clock.x = 5;
         this._clock.visible = false;
         addChild(this._clock);
      }
      
      public function updateView(param1:*) : void
      {
         this._userInfo = param1;
         this._nonoInfo = this._userInfo.getNonoInfo();
         if(this._userInfo.id != ActorManager.actorInfo.id)
         {
            this.mouseChildren = false;
            this.mouseEnabled = false;
         }
         if(this._nonoInfo != null)
         {
            if(this._nonoInfo.isHava)
            {
               this.visible = true;
               this.updateNonoView();
               this.buttonMode = !this._userInfo.isRemote();
               this.addEventListener(MouseEvent.CLICK,this.onClick);
               this.addEventListener(MouseEvent.ROLL_OUT,this.onNonoRollOut);
               (animation as DisplayObject).x += Math.random() * 3;
               (animation as DisplayObject).y += Math.random() * 3;
               addChildAt(this._shadow,0);
            }
         }
         else
         {
            this.clearView();
         }
      }
      
      public function updateNonoView() : void
      {
         if(this._nonoInfo != null)
         {
            if(this._nonoInfo.equipId == 0)
            {
               this.resourceUrl = URLUtil.getNonoSWF(this._nonoInfo.getNonoType(this._userInfo));
            }
            else
            {
               this.resourceUrl = URLUtil.getNonoEquipSwf(this._nonoInfo.equipId);
            }
         }
      }
      
      public function clearView() : void
      {
         this.visible = false;
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onNonoRollOut);
         DisplayObjectUtil.removeFromParent(this._shadow);
      }
      
      override public function dispose() : void
      {
         this.clearView();
         if(this.animation)
         {
            removeActionEventListener(ActionEvent.FINISHED,this.onActionFinished);
         }
         super.dispose();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this._nonoInfo == ActorManager.actorInfo.getNonoInfo())
         {
            this.onNonoPanel();
         }
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_365);
      }
      
      private function onNonoRollOut(param1:MouseEvent) : void
      {
         if(this._nonoInfo == ActorManager.actorInfo.getNonoInfo() && this._nonoBtnCollection != null)
         {
            this._nonoBtnCollection.hideMenu();
         }
      }
      
      override public function update() : void
      {
         this.checkIdleState();
         super.update();
      }
      
      private function checkIdleState() : void
      {
         if(this.moveStyle == MoveStyle.STAND)
         {
            ++this._idleTime;
            if(this._idleTime > MAX_IDEL_TIME)
            {
               this._idleTime = 0;
               this.playIdelAnimation();
            }
         }
         else
         {
            this._idleTime = 0;
         }
      }
      
      private function playIdelAnimation() : void
      {
         if(this.action != STAND_DOWN)
         {
            return;
         }
         addActionEventListener(ActionEvent.FINISHED,this.onActionFinished);
         this.action = PERSONAL;
      }
      
      private function onActionFinished(param1:ActionEvent) : void
      {
         this.action = STAND_DOWN;
      }
      
      override public function set moveStyle(param1:String) : void
      {
         if(this.action == PERSONAL)
         {
            if(param1 == MoveStyle.STAND)
            {
               return;
            }
         }
         super.moveStyle = param1;
      }
      
      private function onNonoPanel() : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NonoPanel"),"正在打开...");
      }
      
      public function nonoAppear(param1:DisplayObjectContainer, param2:Function, param3:Boolean = false) : void
      {
         var anim:MovieClip = null;
         var onEnterFrame:Function = null;
         var container:DisplayObjectContainer = param1;
         var caller:Function = param2;
         var atnow:Boolean = param3;
         if(atnow)
         {
            caller();
         }
         else
         {
            onEnterFrame = function(param1:Event):void
            {
               if(anim.currentFrame == anim.totalFrames)
               {
                  anim.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  DisplayObjectUtil.removeFromParent(anim);
                  caller();
                  _nonoInfo.isFollowing = true;
               }
            };
            anim = this.getNonoAppearAnimation();
            anim.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            anim.x = this.x - 35;
            anim.y = this.y - 60;
            container.addChild(anim);
            anim.gotoAndPlay(1);
         }
      }
      
      public function nonoDisAppear(param1:DisplayObjectContainer, param2:Function) : void
      {
         var onEnterFrame:Function = null;
         var anim:MovieClip = null;
         var container:DisplayObjectContainer = param1;
         var caller:Function = param2;
         onEnterFrame = function(param1:Event):void
         {
            if(anim.currentFrame == anim.totalFrames)
            {
               anim.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
               DisplayObjectUtil.removeFromParent(anim);
               _nonoInfo.isFollowing = false;
            }
         };
         if(this.parent != null)
         {
            caller();
            anim = this.getNonoDisAppearAnimation();
            anim.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            anim.x = this.x - 35;
            anim.y = this.y - 60;
            container.addChild(anim);
            anim.gotoAndPlay(1);
         }
         else
         {
            caller();
         }
      }
      
      private function getNonoAppearAnimation() : MovieClip
      {
         if(this._nonoAppearAnimation == null)
         {
            if(this._userInfo.vipInfo.isVip())
            {
               this._nonoAppearAnimation = UIManager.getMovieClip("UI_NONO_APPERA");
            }
            else
            {
               this._nonoAppearAnimation = UIManager.getMovieClip("UI_VIP_NONO_APPERA");
            }
         }
         return this._nonoAppearAnimation;
      }
      
      private function getNonoDisAppearAnimation() : MovieClip
      {
         if(this._nonoDisAppearAnimation == null)
         {
            if(this._userInfo.vipInfo.isVip())
            {
               this._nonoDisAppearAnimation = UIManager.getMovieClip("UI_NONO_DISAPPERA");
            }
            else
            {
               this._nonoDisAppearAnimation = UIManager.getMovieClip("UI_VIP_NONO_DISAPPERA");
            }
         }
         return this._nonoDisAppearAnimation;
      }
      
      public function get nonoInfo() : NonoInfo
      {
         return this._nonoInfo;
      }
      
      public function get isFollowing() : Boolean
      {
         return this._nonoInfo.isFollowing;
      }
      
      public function showClock() : void
      {
         this._clock.visible = false;
      }
      
      public function hideClock() : void
      {
         this._clock.visible = false;
      }
      
      public function isClock() : Boolean
      {
         return this._clock.visible;
      }
   }
}
