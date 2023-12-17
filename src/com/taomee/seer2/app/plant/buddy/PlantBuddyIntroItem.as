package com.taomee.seer2.app.plant.buddy
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.VipLogoDisplayer;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.home.panel.buddy.HomeBuddyIntroItem;
   import com.taomee.seer2.app.home.panel.buddy.HomeNumber;
   import com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.AlignType;
   
   public class PlantBuddyIntroItem extends HomeBuddyIntroItem
   {
       
      
      private var _levelNumber:HomeNumber;
      
      private var _lvMC:MovieClip;
      
      public function PlantBuddyIntroItem()
      {
         super();
         this.buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         this.x = 24;
         this.y = 11;
         _container = UIManager.getMovieClip("UI_PlantBuddySelfItem");
         this._lvMC = _container["lvMC"];
         super.createChildren();
         this.createNumber();
         this.createVipLogo();
         this.initEventListener();
      }
      
      private function createVipLogo() : void
      {
         _vipLogo = new VipLogoDisplayer();
         _vipLogo.setBoundary(22,16);
         _vipLogo.x = 3;
         _vipLogo.y = 6;
         _container.addChild(_vipLogo);
      }
      
      private function initEventListener() : void
      {
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(SceneManager.active.mapID != ActorManager.actorInfo.id)
         {
            PlantPanelControl.isOpenBuddyMouse(false);
            SceneManager.changeScene(SceneType.PLANT,ActorManager.actorInfo.id);
         }
      }
      
      private function createNumber() : void
      {
         this._levelNumber = new HomeNumber(_container["levelNumber"],AlignType.MIDDLE_LEFT);
         addChild(this._levelNumber);
      }
      
      public function setLevel(param1:HomeInfo) : void
      {
         if(SceneManager.active.type == SceneType.PLANT)
         {
            this._lvMC.gotoAndStop(2);
         }
         else
         {
            this._lvMC.gotoAndStop(1);
         }
         this._levelNumber.setNumber(ActorManager.actorInfo.plantLevel);
      }
      
      override protected function updateDisplay() : void
      {
         super.updateDisplay();
         this._levelNumber.setNumber(ActorManager.actorInfo.plantLevel);
      }
   }
}
