package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.data.LoginUserInfo;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class CreateSexPage extends Sprite
   {
       
      
      private const DEFAULT_MALE:Array = [100052,100053,100054,100055];
      
      private const DEFAULT_FEMALE:Array = [100056,100057,100058,100059];
      
      private var _boyBtn:MovieClip;
      
      private var _girlBtn:MovieClip;
      
      private var _sex0selectMC:MovieClip;
      
      private var _sex1selectMC:MovieClip;
      
      private var _actorPreview:com.taomee.seer2.module.login.view.EquipPreview;
      
      private var _color:int;
      
      public var sex:int = -1;
      
      public function CreateSexPage(param1:ApplicationDomain, param2:int)
      {
         super();
         this._color = param2;
         var _loc3_:MovieClip = DomainUtil.getMovieClip("sexPage",param1);
         addChild(_loc3_);
         this._boyBtn = _loc3_["sex_0"];
         this._girlBtn = _loc3_["sex_1"];
         this._sex0selectMC = _loc3_["sex0selectMC"];
         this._sex1selectMC = _loc3_["sex1selectMC"];
         this._sex0selectMC.visible = false;
         this._sex1selectMC.visible = false;
         this.initEventListener();
      }
      
      private function updateActorPreview() : void
      {
         if(!this._actorPreview)
         {
            this._actorPreview = new com.taomee.seer2.module.login.view.EquipPreview();
            this._actorPreview.x = 470;
            this._actorPreview.y = 400;
            this._actorPreview.scaleX = this._actorPreview.scaleY = 1.2;
            addChild(this._actorPreview);
         }
         var _loc1_:LoginUserInfo = new LoginUserInfo();
         _loc1_.color = this._color;
         if(this.sex == 0)
         {
            _loc1_.equipVec = Vector.<int>(this.DEFAULT_MALE);
         }
         else if(this.sex == 1)
         {
            _loc1_.equipVec = Vector.<int>(this.DEFAULT_FEMALE);
         }
         else
         {
            _loc1_.equipVec = new Vector.<int>();
         }
         EquipUtil.mergeDefaultEquip(this._color,_loc1_.equipVec);
         this._actorPreview.setData(_loc1_);
      }
      
      private function initEventListener() : void
      {
         this._boyBtn.buttonMode = true;
         this._boyBtn.addEventListener(MouseEvent.ROLL_OVER,this.onSexOver);
         this._boyBtn.addEventListener(MouseEvent.ROLL_OUT,this.onSexOut);
         this._boyBtn.addEventListener(MouseEvent.CLICK,this.onSexClick);
         this._girlBtn.buttonMode = true;
         this._girlBtn.addEventListener(MouseEvent.ROLL_OVER,this.onSexOver);
         this._girlBtn.addEventListener(MouseEvent.ROLL_OUT,this.onSexOut);
         this._girlBtn.addEventListener(MouseEvent.CLICK,this.onSexClick);
      }
      
      private function onSexOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.sex = int(_loc2_.name.substr(4,1));
         if(this.sex == 0)
         {
            this._sex0selectMC.visible = true;
            this._sex1selectMC.visible = false;
         }
         else
         {
            this._sex0selectMC.visible = false;
            this._sex1selectMC.visible = true;
         }
      }
      
      private function onSexOut(param1:MouseEvent) : void
      {
         if(this.sex == 0)
         {
            this._sex0selectMC.visible = false;
         }
         else if(this.sex == 1)
         {
            this._sex1selectMC.visible = false;
         }
         this.sex = -1;
      }
      
      private function onSexClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.sex = int(_loc2_.name.substr(4,1));
         dispatchEvent(new Event(CreateRolePanel.SELECT_SEX));
         this.dispose();
      }
      
      private function closeEventListner() : void
      {
         this._boyBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onSexOver);
         this._boyBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onSexOut);
         this._boyBtn.removeEventListener(MouseEvent.CLICK,this.onSexClick);
         this._girlBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onSexOver);
         this._girlBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onSexOut);
         this._girlBtn.removeEventListener(MouseEvent.CLICK,this.onSexClick);
      }
      
      private function dispose() : void
      {
         this.closeEventListner();
         this._boyBtn = null;
         this._girlBtn = null;
         this._sex0selectMC = null;
         this._sex1selectMC = null;
      }
   }
}
