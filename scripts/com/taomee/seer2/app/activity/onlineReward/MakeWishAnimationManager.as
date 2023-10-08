package com.taomee.seer2.app.activity.onlineReward
{
   import com.taomee.seer2.app.dream.DreamManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class MakeWishAnimationManager
   {
      
      private static var _mc:SimpleButton;
      
      private static var _birthBtn:MovieClip;
      
      private static var _btn:SimpleButton;
      
      private static var _time:MovieClip;
      
      private static var _timeCount:uint;
       
      
      public function MakeWishAnimationManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
      }
      
      private static function onMapSwitchStart(param1:SceneEvent) : void
      {
         DisplayUtil.removeForParent(_mc);
         DisplayUtil.removeForParent(_birthBtn);
         Tick.instance.removeRender(updateTimeMC);
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         if(Boolean(SceneManager.active) && (SceneManager.active.type == SceneType.ARENA || DreamManager.isDreamMap() || SceneManager.active.type == SceneType.HOME))
         {
            return;
         }
         if(_mc)
         {
            showMC();
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("makeWishAnimation"),LoadType.SWF,onResLoaded);
         }
      }
      
      public static function showYiTe() : void
      {
         if(_mc)
         {
            LayerManager.uiLayer.addChild(_mc);
         }
      }
      
      private static function checkTime() : Boolean
      {
         var _loc1_:uint = new Date(2012,3,2,15,1).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         _mc = (param1.content as MovieClip)["mc_2"];
         _mc.x = 901;
         _mc.y = 190;
         TooltipManager.addCommonTip(_mc,"新一轮的反击");
         _birthBtn = (param1.content as MovieClip)["mc"];
         _birthBtn.x = 890;
         _birthBtn.y = 135;
         TooltipManager.addCommonTip(_birthBtn,"许愿机");
         _btn = _birthBtn["mc"];
         _time = _birthBtn["time"];
         showMC();
      }
      
      private static function showMC() : void
      {
         if(QuestManager.isComplete(30006))
         {
            LayerManager.uiLayer.addChild(_mc);
         }
         LayerManager.uiLayer.addChild(_birthBtn);
         _mc.addEventListener(MouseEvent.CLICK,onClick);
         _btn.addEventListener(MouseEvent.CLICK,onBirth);
         updateTime();
      }
      
      private static function updateTime() : void
      {
         _time.visible = false;
         ServerBufferManager.getServerBuffer(ServerBufferType.MAKEWISH_TIME,onGetTime,false);
      }
      
      private static function onGetTime(param1:ServerBuffer) : void
      {
         var _loc2_:LittleEndianByteArray = param1.data;
         _timeCount = _loc2_.readUnsignedInt();
         if(_timeCount != 0)
         {
            if(TimeManager.getServerTime() - _timeCount > 900)
            {
               _timeCount = 0;
            }
            else
            {
               _timeCount = 900 - (TimeManager.getServerTime() - _timeCount);
            }
         }
         updateTimeMC(111);
         if(_timeCount <= 0)
         {
            _time.visible = false;
            Tick.instance.removeRender(updateTimeMC);
         }
         else
         {
            _time.visible = true;
            Tick.instance.addRender(updateTimeMC,1000);
         }
      }
      
      private static function updateTimeMC(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_timeCount > 0)
         {
            _loc2_ = _timeCount / 60;
            _loc3_ = _timeCount % 60;
            (_time["mcMinDecade"] as MovieClip).gotoAndStop(uint(_loc2_ / 10) + 1);
            (_time["mcMinUnit"] as MovieClip).gotoAndStop(uint(_loc2_ % 10) + 1);
            (_time["mcSecDecade"] as MovieClip).gotoAndStop(uint(_loc3_ / 10) + 1);
            (_time["mcSecUnit"] as MovieClip).gotoAndStop(uint(_loc3_ % 10) + 1);
            --_timeCount;
         }
         if(_timeCount <= 0)
         {
            _time.visible = false;
            Tick.instance.removeRender(updateTimeMC);
         }
      }
      
      private static function onBirth(param1:MouseEvent) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.updateTime = goTime;
         ModuleManager.toggleModule(URLUtil.getAppModule("MakeWishStartPanel"),"许愿机",_loc2_);
      }
      
      private static function goTime() : void
      {
         _timeCount = 900;
         updateTimeMC(111);
         _time.visible = true;
         Tick.instance.addRender(updateTimeMC,1000);
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NewTurnBeatPanel"),"正在新一轮的反击.");
      }
   }
}
