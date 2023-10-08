package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.app.component.VipLogoDisplayer;
   import com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
   import com.taomee.seer2.app.utils.ColorConstants;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.AlignType;
   
   public class HomeBuddyFullItem extends HomeBuddyIntroItem
   {
       
      
      private var _orderNumber:com.taomee.seer2.app.home.panel.buddy.HomeNumber;
      
      private var _levelNumber:com.taomee.seer2.app.home.panel.buddy.HomeNumber;
      
      private var _bgmc:MovieClip;
      
      private var _select:Boolean;
      
      private var _type:uint = 3;
      
      private var _lvMC:MovieClip;
      
      public function HomeBuddyFullItem(param1:uint = 3)
      {
         this._type = param1;
         buttonMode = true;
         mouseChildren = false;
         super();
      }
      
      override protected function createChildren() : void
      {
         if(this._type == SceneType.HOME)
         {
            _container = UIManager.getMovieClip("UI_HomeBuddyFullItem");
         }
         else if(this._type == SceneType.PLANT)
         {
            _container = UIManager.getMovieClip("UI_PlantBuddyFullItem");
         }
         super.createChildren();
         this._bgmc = _container["bgmc"];
         this._lvMC = _container["lvMC"];
         this._bgmc.gotoAndStop(1);
         this.createNumber();
         this.createVipLogo();
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      public function set select(param1:Boolean) : void
      {
         this._select = param1;
         if(this._select)
         {
            this._bgmc.gotoAndStop(2);
            mouseEnabled = false;
         }
         else
         {
            this._bgmc.gotoAndStop(1);
            mouseEnabled = true;
         }
      }
      
      public function get select() : Boolean
      {
         return this._select;
      }
      
      public function setLevel() : void
      {
         if(this._type == SceneType.PLANT)
         {
            this._lvMC.gotoAndStop(2);
         }
         else
         {
            this._lvMC.gotoAndStop(1);
         }
      }
      
      private function createVipLogo() : void
      {
         _vipLogo = new VipLogoDisplayer();
         _vipLogo.setBoundary(22,16);
         _vipLogo.x = 3;
         _vipLogo.y = 18;
         _container.addChild(_vipLogo);
      }
      
      private function createNumber() : void
      {
         this._orderNumber = new com.taomee.seer2.app.home.panel.buddy.HomeNumber(_container["orderNumber"],AlignType.MIDDLE_CENTER);
         this._orderNumber.visible = false;
         addChild(this._orderNumber);
         this._levelNumber = new com.taomee.seer2.app.home.panel.buddy.HomeNumber(_container["levelNumber"],AlignType.MIDDLE_LEFT);
         this._levelNumber.visible = false;
         addChild(this._levelNumber);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(this._select == false)
         {
            this._bgmc.gotoAndStop(2);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(this._select == false)
         {
            this._bgmc.gotoAndStop(1);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         this._bgmc.gotoAndStop(3);
         if(SceneManager.active.type == SceneType.PLANT)
         {
            PlantPanelControl.isOpenBuddyMouse(false);
         }
         SceneManager.changeScene(this._type,_dataUnit.id);
      }
      
      override protected function updateDisplay() : void
      {
         if(_dataUnit.userInfo.vipInfo.isVip())
         {
            _nickTxt.textColor = ColorConstants.VIP_TEXT_COLOR;
         }
         else
         {
            _nickTxt.textColor = ColorConstants.NORMAL_TEXT_COLOR;
         }
         super.updateDisplay();
         if(this._type == SceneType.PLANT)
         {
            this._levelNumber.setNumber(_dataUnit.userInfo.plantLevel);
         }
         else
         {
            this._levelNumber.setNumber(_dataUnit.userInfo.trainerLevel);
         }
         this._levelNumber.visible = true;
         if(_dataUnit.order > 0)
         {
            this._orderNumber.visible = true;
            this._orderNumber.setNumber(_dataUnit.order);
         }
         else
         {
            this._orderNumber.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         super.dispose();
      }
   }
}
