package com.taomee.seer2.app.init
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.CookieUserInfo;
   import com.taomee.seer2.app.actor.group.UserGroupManager;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.widget.BatteryTimeWidget;
   import com.taomee.seer2.app.guide.manager.GuideManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.bean.BaseBean;
   import org.taomee.utils.DisplayUtil;
   
   public class SeerIISetup extends BaseBean
   {
       
      
      private var _coverUI:Sprite;
      
      private var _isWaiting:Boolean = false;
      
      private var _time:uint;
      
      private var _startTime:uint;
      
      public function SeerIISetup()
      {
         super();
      }
      
      override public function start() : void
      {
         ActorManager.actorInfo = LoginInfo.userInfo;
         SharedObjectManager.setUserId(LoginInfo.userInfo.id);
         CookieUserInfo.serialize(LoginInfo.userInfo);
         QuestManager.setup(LoginInfo.completeQuestIdVec,LoginInfo.lastCompleteQuestIdVec,LoginInfo.inProgressQuestIdVec);
         UserGroupManager.setup(LoginInfo.userData);
         GuideManager.instance.addParent(LayerManager.root,0);
         this.checkCover();
         Connection.addCommandListener(CommandSet.BATTERY_SWITCH_1516,this.onBattery);
         LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
         finish();
      }
      
      private function onBattery(param1:MessageEvent) : void
      {
         var _loc2_:int = int(param1.message.getRawData().readUnsignedInt());
         TimeManager.loginTime = TimeManager.getServerTime();
         TimeManager.availableTime = _loc2_;
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         clearTimeout(this._time);
         this._time = setTimeout(this.outTime,1000 * 60 * 5);
      }
      
      private function outTime() : void
      {
         if(SceneManager.currentSceneType == SceneType.ARENA)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA2)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA3)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA4)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA5)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA1)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA2)
         {
            return;
         }
         if(SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA3)
         {
            return;
         }
         if(GlobalsManager.isPlayingGame)
         {
            return;
         }
         if(LayerManager.topLayer.contains(this._coverUI) == false)
         {
            this.close();
         }
      }
      
      private function checkCover() : void
      {
         var _loc1_:MovieClip = null;
         if(this._coverUI == null)
         {
            this._coverUI = new UI_ScreenCover();
            _loc1_ = UIManager.getMovieClip("WaitLockUI");
            _loc1_.x = 460;
            _loc1_.y = 252;
            this._coverUI.addChild(_loc1_);
            this._coverUI.cacheAsBitmap = true;
            this._coverUI.addEventListener(MouseEvent.CLICK,this.onCover);
         }
      }
      
      private function onCover(param1:MouseEvent) : void
      {
         if(Boolean(this._coverUI) && LayerManager.topLayer.contains(this._coverUI) == true)
         {
            this.open();
            this.onMove(new MouseEvent(MouseEvent.MOUSE_MOVE));
         }
      }
      
      private function open() : void
      {
         this._isWaiting = false;
         DisplayUtil.removeForParent(this._coverUI,false);
         Connection.send(CommandSet.BATTERY_SWITCH_1516,1);
         (ToolBar.getWidget("time") as BatteryTimeWidget).isPause = false;
      }
      
      private function close() : void
      {
         this._isWaiting = true;
         LayerManager.topLayer.addChildAt(this._coverUI,0);
         Connection.send(CommandSet.BATTERY_SWITCH_1516,0);
         (ToolBar.getWidget("time") as BatteryTimeWidget).isPause = true;
      }
   }
}
