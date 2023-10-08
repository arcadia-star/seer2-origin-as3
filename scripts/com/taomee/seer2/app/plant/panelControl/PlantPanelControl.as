package com.taomee.seer2.app.plant.panelControl
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.group.UserGroupCookie;
   import com.taomee.seer2.app.controls.LeftMinorToolBar;
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.controls.ProcessBuddyPanel;
   import com.taomee.seer2.app.controls.TestAssistPanel;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.home.panel.HomeWelcome;
   import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
   import com.taomee.seer2.app.home.panel.events.HomePanelEvent;
   import com.taomee.seer2.app.plant.panelControl.bar.PlantSideBar;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class PlantPanelControl extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
       
      
      private var _sideBar:PlantSideBar;
      
      private var _buddyPanel:com.taomee.seer2.app.plant.panelControl.PlantBuddyPanel;
      
      private var _welcome:HomeWelcome;
      
      private var _selfDataUnit:HomeBuddyDataUnit;
      
      private var _homeInfo:HomeInfo;
      
      private var _addBuddyPanel:ProcessBuddyPanel;
      
      public function PlantPanelControl()
      {
         super();
         this.createChildren();
         this._selfDataUnit = new HomeBuddyDataUnit();
         this._selfDataUnit.status = HomeBuddyDataUnit.READY;
         this._selfDataUnit.userInfo = ActorManager.actorInfo;
         this._buddyPanel.setUnitData(this._selfDataUnit);
         this.initEventListener();
      }
      
      public static function show() : void
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.plant.panelControl.PlantPanelControl();
         }
         _instance.show();
      }
      
      public static function hide() : void
      {
         if(_instance)
         {
            _instance.hide();
         }
      }
      
      public static function onUpdate() : void
      {
         TestAssistPanel.updateTestAssist();
      }
      
      public static function update(param1:HomeInfo) : void
      {
         if(_instance)
         {
            _instance.closeProcessBuddyPanel();
            _instance.setData(param1);
         }
      }
      
      public static function isOpenBuddyMouse(param1:Boolean) : void
      {
         var b:Boolean = param1;
         if(_instance)
         {
            _instance._buddyPanel.mouseChildren = b;
            _instance._buddyPanel.mouseEnabled = b;
            if(b == false)
            {
               setTimeout(function():void
               {
                  _instance._buddyPanel.mouseChildren = true;
                  _instance._buddyPanel.mouseEnabled = true;
               },2000);
            }
         }
      }
      
      public static function showSomePanel() : void
      {
         if(_instance)
         {
            _instance.addChild(_instance._buddyPanel);
            _instance._sideBar.enableSomeBtn();
         }
      }
      
      public static function hideSomePanel() : void
      {
         if(_instance)
         {
            DisplayUtil.removeForParent(_instance._buddyPanel);
            _instance._sideBar.disEnableSomeBtn();
         }
      }
      
      public static function layIcons() : void
      {
         if(_instance)
         {
            _instance._buddyPanel.adjustPosition();
            _instance._sideBar.adjustPosition();
         }
      }
      
      public static function getSidBar() : PlantSideBar
      {
         return _instance._sideBar;
      }
      
      private function createChildren() : void
      {
         this._sideBar = new PlantSideBar();
         addChild(this._sideBar);
         this._buddyPanel = new com.taomee.seer2.app.plant.panelControl.PlantBuddyPanel();
         addChild(this._buddyPanel);
         this._welcome = new HomeWelcome();
         addChild(this._welcome);
      }
      
      private function show() : void
      {
         this.showTool();
         LayerManager.uiLayer.addChild(this);
         layIcons();
      }
      
      private function hide() : void
      {
         this.hideTool();
         DisplayObjectUtil.removeFromParent(this);
      }
      
      private function showTool() : void
      {
         PetAvatarPanel.show();
         MinorToolBar.show();
         LeftMinorToolBar.show();
         TestAssistPanel.show();
      }
      
      private function hideTool() : void
      {
         PetAvatarPanel.hide();
         MinorToolBar.hide();
         LeftMinorToolBar.hide();
         TestAssistPanel.hide();
      }
      
      private function initEventListener() : void
      {
         this._buddyPanel.addEventListener(HomePanelEvent.REQUEST_ADD_BUDDY,this.onRequestAddBuddy);
         this._sideBar.addEventListener(HomePanelEvent.REQUEST_ADD_BUDDY,this.onRequestAddBuddy);
      }
      
      private function onRequestAddBuddy(param1:Event) : void
      {
         param1.stopPropagation();
         if(this._addBuddyPanel != null)
         {
            this._addBuddyPanel.show();
            addChild(this._addBuddyPanel);
            return;
         }
         this._addBuddyPanel = new ProcessBuddyPanel(ProcessBuddyPanel.ADD_BUDDY,new Point(330,210));
         addChild(this._addBuddyPanel);
      }
      
      private function closeProcessBuddyPanel() : void
      {
         if(this._addBuddyPanel != null)
         {
            this._addBuddyPanel.hide();
         }
      }
      
      private function setData(param1:HomeInfo) : void
      {
         this._homeInfo = param1;
         this.updateCookie();
         this.updateDisplay();
      }
      
      private function updateCookie() : void
      {
         UserGroupCookie.addIntervieweeCount(this._homeInfo.userId);
      }
      
      private function updateDisplay() : void
      {
         MapTitlePanel.update(SceneManager.active.mapModel);
         this._sideBar.setData(this._homeInfo);
         this._buddyPanel.setData(this._homeInfo);
         this._welcome.setData(this._homeInfo);
      }
   }
}
