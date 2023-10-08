package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.VipLogoDisplayer;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   import org.taomee.utils.AlignType;
   
   public class HomeBuddySelfItem extends HomeBuddyIntroItem
   {
       
      
      private var _levelNumber:com.taomee.seer2.app.home.panel.buddy.HomeNumber;
      
      public function HomeBuddySelfItem()
      {
         super();
         this.buttonMode = true;
      }
      
      override protected function createChildren() : void
      {
         this.adjustPosition();
         _container = UIManager.getMovieClip("UI_HomeBuddySelfItem");
         super.createChildren();
         this.createNumber();
         this.createVipLogo();
         this.initEventListener();
      }
      
      public function adjustPosition() : void
      {
         this.x = 117;
         this.y = LayerManager.stage.stageHeight - 137;
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
            SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
         }
      }
      
      private function createNumber() : void
      {
         this._levelNumber = new com.taomee.seer2.app.home.panel.buddy.HomeNumber(_container["levelNumber"],AlignType.MIDDLE_LEFT);
         addChild(this._levelNumber);
      }
      
      override protected function updateDisplay() : void
      {
         super.updateDisplay();
         this._levelNumber.setNumber(_dataUnit.userInfo.trainerLevel);
      }
   }
}
