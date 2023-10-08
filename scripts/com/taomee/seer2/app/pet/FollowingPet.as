package com.taomee.seer2.app.pet
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.component.IBaseView;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.utils.NumberPlayUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.constant.MoveStyle;
   import com.taomee.seer2.core.entity.events.ActionEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.MovieClipUtil;
   
   public class FollowingPet extends Mobile implements IBaseView
   {
      
      private static const PERSONAL:String = "personal";
      
      private static const STAND_DOWN:String = "standDown";
      
      private static const MAX_IDEL_TIME:int = 250;
       
      
      private var _petInfo:PetInfo;
      
      private var _userInfo:UserInfo;
      
      private var _idleTime:int;
      
      private var _shadow:Sprite;
      
      private var _addMC:Sprite;
      
      private var _addokMC:Sprite;
      
      private var _effectMC:MovieClip;
      
      private var _addIsShow:Boolean;
      
      private var _addokIsShow:Boolean;
      
      private var _addLevels:int;
      
      public function FollowingPet()
      {
         super();
         this.init();
         this.initLevel();
         this.initAddOk();
      }
      
      public function init() : void
      {
         followDistance = 50;
         this._shadow = UIManager.getSprite("UI_PetShadow");
         this._addMC = UIManager.getMovieClip("adding");
         this._effectMC = UIManager.getMovieClip("UI_PetEffect");
      }
      
      public function initLevel() : void
      {
         if(this._addIsShow)
         {
            addChild(this._addMC);
            this._addMC.visible = true;
         }
         else
         {
            this._addMC.visible = false;
         }
      }
      
      private function initAddOk() : void
      {
         if(this._addokIsShow)
         {
            this._addokMC = UIManager.getMovieClip("addok");
            addChild(this._addokMC);
            this._addokMC.visible = true;
         }
         else if(this._addokMC)
         {
            this._addokMC.visible = false;
         }
      }
      
      private function initHookLevel() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Actor = null;
         _loc1_ = NumberPlayUtil.playNumber("EXP+" + this._addLevels,"UI_NumberCoin",NumberPlayUtil.PATH_UP,15);
         _loc2_ = ActorManager.getActor();
         _loc1_.y = -50;
         _loc1_.x = -20;
         _loc2_.getFollowingPet().addChild(_loc1_);
      }
      
      public function updateView(param1:*) : void
      {
         var _loc2_:String = null;
         this._userInfo = param1;
         this._petInfo = this._userInfo.followingPetInfo;
         if(this._petInfo != null)
         {
            this.visible = true;
            this.resourceUrl = URLUtil.getPetSwf(this._petInfo.resourceId);
            this.buttonMode = this._userInfo.isRemote();
            this.addEventListener(MouseEvent.CLICK,this.onFollowPetInfoPanel);
            if(this._petInfo.evolveLevel != 0)
            {
               if(this._petInfo.evolveLevel < 5)
               {
                  _loc2_ = "UI_ShenHua";
               }
               else if(this._petInfo.evolveLevel < 9)
               {
                  _loc2_ = "UI_ShengHua";
               }
               else if(this._petInfo.evolveLevel < 1005)
               {
                  _loc2_ = "UI_MoHua";
               }
               else
               {
                  _loc2_ = "UI_MingHua";
               }
               this._effectMC = UIManager.getMovieClip(_loc2_);
            }
            addChildAt(this._shadow,0);
            this.updateFollowingPetEffect();
         }
         else
         {
            this.clearView();
         }
      }
      
      private function updateFollowingPetEffect() : void
      {
         if(this._effectMC)
         {
            DisplayObjectUtil.removeFromParent(this._effectMC);
         }
         if(this._petInfo.evolveLevel != 0)
         {
            this._effectMC.scaleX = 1.25;
            this._effectMC.scaleY = 1.25;
            this._effectMC.x = -45;
            this._effectMC.y = -20;
            addChildAt(this._effectMC,1);
            return;
         }
         if(this._petInfo.totalPotential >= 720)
         {
            if(this._effectMC.parent == null)
            {
               this._effectMC.scaleX = 1.25;
               this._effectMC.scaleY = 1.25;
               this._effectMC.x = -45;
               this._effectMC.y = -20;
               this._effectMC.gotoAndPlay(2);
               addChildAt(this._effectMC,1);
               MovieClipUtil.childPlay(this._effectMC,1);
            }
         }
         else if(this._effectMC.parent)
         {
            DisplayUtil.removeForParent(this._effectMC);
         }
      }
      
      public function getEffect() : MovieClip
      {
         return this._effectMC;
      }
      
      public function clearView() : void
      {
         this.visible = false;
         this.removeEventListener(MouseEvent.CLICK,this.onFollowPetInfoPanel);
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
      
      private function onFollowPetInfoPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("FollowPetInfoPanel"),"正在打开精灵信息面板",{
            "type":0,
            "petInfo":this._petInfo,
            "ownerInfo":this._userInfo
         });
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
      
      public function getInfo() : PetInfo
      {
         return this._petInfo;
      }
      
      public function set addIsShow(param1:Boolean) : void
      {
         this._addIsShow = param1;
         this.initLevel();
      }
      
      public function set addokIsShow(param1:Boolean) : void
      {
         this._addokIsShow = param1;
         this.initAddOk();
      }
      
      public function set addLevels(param1:int) : void
      {
         this._addLevels = param1;
         this.initHookLevel();
      }
   }
}
