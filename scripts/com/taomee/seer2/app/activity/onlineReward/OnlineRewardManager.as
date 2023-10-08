package com.taomee.seer2.app.activity.onlineReward
{
   import com.taomee.seer2.app.dream.DreamManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class OnlineRewardManager
   {
      
      private static var _isVipReward:uint;
      
      private static var _totalVipTime:uint;
      
      private static var _whichStage:uint;
      
      private static var _count:uint = 10000;
      
      private static var _resideTime:uint;
      
      private static var _rewardToggle:MovieClip;
      
      private static var _toggleMc:MovieClip;
      
      private static var _timeMC:MovieClip;
      
      private static var _isGetAll:Boolean = false;
      
      private static var _isInit:Boolean = false;
       
      
      public function OnlineRewardManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
      }
      
      private static function onGetOnlineInfo(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         _isVipReward = _loc2_.readUnsignedInt();
         _totalVipTime = _loc2_.readUnsignedInt();
         _whichStage = _loc2_.readUnsignedInt();
         _count = _loc2_.readUnsignedInt();
         _resideTime = _loc2_.readUnsignedInt();
         Nono1122Info.instance().isVipReward = _isVipReward;
         Nono1122Info.instance().totalVipTime = _totalVipTime;
         Nono1122Info.instance().whichStage = _whichStage;
         Nono1122Info.instance().resideTime = _resideTime;
         if(_whichStage == 5)
         {
            _isGetAll = true;
         }
         if(_isInit == false)
         {
            _isInit = true;
            onMapSwitchComplete(null);
         }
         else
         {
            updateDisplay();
         }
      }
      
      private static function onMapSwitchStart(param1:SceneEvent) : void
      {
         if(Boolean(_rewardToggle) && Boolean(_rewardToggle.parent))
         {
            DisplayObjectUtil.removeFromParent(_rewardToggle);
         }
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.type == SceneType.ARENA)
         {
            return;
         }
         if(_isInit == false)
         {
            Connection.send(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122);
            return;
         }
         if(Boolean(SceneManager.active) && DreamManager.isDreamMap())
         {
            return;
         }
         if(_rewardToggle)
         {
            showRewardBox();
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("onlineReward"),LoadType.SWF,onResLoaded);
         }
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         initRewardToggle(param1);
         showRewardBox();
      }
      
      private static function initRewardToggle(param1:ContentInfo) : void
      {
         _rewardToggle = (param1.content as MovieClip)["box"];
         _rewardToggle.x = 887;
         _rewardToggle.y = 65;
         _toggleMc = _rewardToggle["mc"];
         TooltipManager.addCommonTip(_toggleMc,"NoNo在线送好礼");
         _toggleMc.buttonMode = true;
         _toggleMc.gotoAndStop(1);
         _toggleMc["hotArea"].addEventListener(MouseEvent.CLICK,onToggleClick);
         _toggleMc["hotArea"].addEventListener(MouseEvent.MOUSE_OVER,onToggleOver);
         _toggleMc.addEventListener(Event.ENTER_FRAME,onToggleEnterFrame);
         _toggleMc.gotoAndStop(1);
         _timeMC = _rewardToggle["time"];
      }
      
      private static function onToggleEnterFrame(param1:Event) : void
      {
         if(_isGetAll)
         {
            _toggleMc.gotoAndStop(1);
            _toggleMc.removeEventListener(Event.ENTER_FRAME,onToggleEnterFrame);
            return;
         }
         if(_toggleMc.currentFrameLabel == "1_end")
         {
            if(Tick.instance.hasRender(onTick) == false)
            {
               _toggleMc.gotoAndPlay("1_start");
            }
            else
            {
               _toggleMc.gotoAndStop("1_end");
            }
         }
         else if(_toggleMc.currentFrame == _toggleMc.totalFrames)
         {
            _toggleMc.gotoAndStop(1);
         }
      }
      
      private static function onToggleClick(param1:MouseEvent) : void
      {
         _toggleMc.gotoAndPlay("3_start");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_21);
         var _loc2_:Object = new Object();
         _loc2_.cookbook = onClosePanel;
         ModuleManager.showModule(URLUtil.getAppModule("OnlineReward"),"正在NONO在线领奖",_loc2_);
      }
      
      private static function onToggleOver(param1:MouseEvent) : void
      {
         _toggleMc["hotArea"].removeEventListener(MouseEvent.MOUSE_OVER,onToggleOver);
         if(_isGetAll)
         {
            return;
         }
         _toggleMc["hotArea"].addEventListener(MouseEvent.MOUSE_OUT,onToggleOut);
         _toggleMc.gotoAndPlay("2_start");
      }
      
      private static function onToggleOut(param1:MouseEvent) : void
      {
         _toggleMc["hotArea"].addEventListener(MouseEvent.MOUSE_OVER,onToggleOver);
         if(Tick.instance.hasRender(onTick) == false)
         {
            _toggleMc.gotoAndPlay("1_start");
         }
         else
         {
            _toggleMc.gotoAndStop("1_start");
         }
      }
      
      private static function onClosePanel() : void
      {
         _toggleMc.gotoAndStop("1_start");
      }
      
      private static function showRewardBox() : void
      {
         LayerManager.uiLayer.addChild(_rewardToggle);
         updateDisplay();
      }
      
      private static function updateDisplay() : void
      {
         if(_rewardToggle == null)
         {
            onMapSwitchComplete(null);
            return;
         }
         if(Nono1122Info.instance().resideTime == 0)
         {
            Tick.instance.removeRender(onTick);
         }
         else
         {
            Tick.instance.addRender(onTick,1000);
         }
         if(Tick.instance.hasRender(onTick) == false)
         {
            _toggleMc.gotoAndPlay("1_start");
         }
         else
         {
            _toggleMc.gotoAndStop("1_start");
         }
         updateTime();
      }
      
      private static function updateTime() : void
      {
         var _loc1_:uint = Nono1122Info.instance().resideTime / 60;
         var _loc2_:uint = Nono1122Info.instance().resideTime % 60;
         _timeMC.visible = true;
         if(Nono1122Info.instance().resideTime == 0)
         {
            _timeMC.visible = false;
         }
         (_timeMC["mcMinDecade"] as MovieClip).gotoAndStop(uint(_loc1_ / 10) + 1);
         (_timeMC["mcMinUnit"] as MovieClip).gotoAndStop(uint(_loc1_ % 10) + 1);
         (_timeMC["mcSecDecade"] as MovieClip).gotoAndStop(uint(_loc2_ / 10) + 1);
         (_timeMC["mcSecUnit"] as MovieClip).gotoAndStop(uint(_loc2_ % 10) + 1);
      }
      
      private static function onTick(param1:uint) : void
      {
         if(Nono1122Info.instance().resideTime == 0 && SceneManager.active.type != SceneType.ARENA)
         {
            Tick.instance.removeRender(onTick);
            Connection.send(CommandSet.GET_ONLINE_CAN_SWAP_NUM_1122);
         }
         else if(Nono1122Info.instance().resideTime > 0)
         {
            --Nono1122Info.instance().resideTime;
            updateTime();
         }
      }
   }
}
