package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.data.LoginUserInfo;
   import com.taomee.seer2.module.login.util.ColorFilter;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class CreateColorPage extends Sprite
   {
       
      
      private const COLOR_BTN_NUM:int = 8;
      
      private var _colorMCVec:Vector.<MovieClip>;
      
      private var _colorBtnVec:Vector.<SimpleButton>;
      
      private var _actorPreview:com.taomee.seer2.module.login.view.EquipPreview;
      
      public var color:int;
      
      public function CreateColorPage(param1:ApplicationDomain)
      {
         var _loc4_:SimpleButton = null;
         super();
         var _loc2_:MovieClip = DomainUtil.getMovieClip("colorPage",param1);
         addChild(_loc2_);
         this._colorBtnVec = new Vector.<SimpleButton>();
         this._colorMCVec = new Vector.<MovieClip>();
         var _loc3_:int = 0;
         while(_loc3_ < this.COLOR_BTN_NUM)
         {
            (_loc4_ = _loc2_["colorBtn_" + _loc3_]).addEventListener(MouseEvent.CLICK,this.onColorClick);
            _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.onColorOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.onColorOut);
            this._colorBtnVec.push(_loc4_);
            this._colorMCVec.push(_loc2_["colorMC_" + _loc3_]);
            _loc3_++;
         }
         this.createActor();
         this.color = 0;
         this.updateActorPreview();
         ColorFilter.setBrightness(this._actorPreview,-80);
      }
      
      private function createActor() : void
      {
         this._actorPreview = new com.taomee.seer2.module.login.view.EquipPreview();
         this._actorPreview.scaleX = this._actorPreview.scaleY = 1.3;
         this._actorPreview.x = 470;
         this._actorPreview.y = 430;
         addChild(this._actorPreview);
      }
      
      private function onColorOver(param1:MouseEvent) : void
      {
         this._actorPreview.filters = [];
         this.color = int(param1.currentTarget.name.split("_")[1]);
         this.updateActorPreview();
      }
      
      private function onColorOut(param1:MouseEvent) : void
      {
         ColorFilter.setBrightness(this._actorPreview,-80);
      }
      
      private function onColorClick(param1:MouseEvent) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.COLOR_BTN_NUM)
         {
            _loc3_ = this._colorBtnVec[_loc2_];
            _loc3_.mouseEnabled = false;
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onColorClick);
            _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onColorOver);
            _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onColorOut);
            this._colorMCVec[_loc2_].stop();
            this._colorMCVec[_loc2_].visible = false;
            _loc2_++;
         }
         this._actorPreview.filters = [];
         this.color = int(param1.currentTarget.name.split("_")[1]);
         this.updateActorPreview();
         dispatchEvent(new Event(CreateRolePanel.SELECT_COLOR));
         this.dispose();
      }
      
      private function updateActorPreview() : void
      {
         var _loc1_:LoginUserInfo = new LoginUserInfo();
         _loc1_.color = this.color;
         _loc1_.equipVec = new Vector.<int>();
         EquipUtil.mergeDefaultEquip(this.color,_loc1_.equipVec);
         this._actorPreview.setData(_loc1_);
      }
      
      private function dispose() : void
      {
         if(this._actorPreview)
         {
            this._actorPreview.dispose();
            this._actorPreview = null;
         }
         this._colorBtnVec = null;
         this._colorMCVec = null;
      }
   }
}
