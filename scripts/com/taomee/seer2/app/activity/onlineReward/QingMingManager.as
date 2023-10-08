package com.taomee.seer2.app.activity.onlineReward
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class QingMingManager
   {
      
      private static const mapList:Vector.<uint> = Vector.<uint>([90,124,141,142,160,204,211,202,230,261,281,302]);
      
      private static const mapPoint:Vector.<Point> = Vector.<Point>([new Point(380,218),new Point(335,179),new Point(834,260),new Point(287,235),new Point(170,256),new Point(752,198),new Point(539,309),new Point(184,260),new Point(550,310),new Point(637,395),new Point(552,255),new Point(236,201)]);
      
      private static const mapDayLimet:Vector.<uint> = Vector.<uint>([346,347,349,348,350,351,353,352,354,355,356,357]);
      
      private static var _mc:MovieClip;
      
      private static var _bei:MovieClip;
      
      private static var _dayLimet:uint;
      
      private static var _isOpenPanel:Boolean;
      
      private static var _setTimeout:uint;
      
      private static var _playAnimation:MovieClip;
       
      
      public function QingMingManager()
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
         clearTimeout(_setTimeout);
         DisplayUtil.removeForParent(_mc);
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         if(Boolean(SceneManager.active) && (mapList.indexOf(SceneManager.active.mapID) == -1 || checkTime() == false))
         {
            return;
         }
         if(_mc)
         {
            showMC();
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("qingMingAnimation"),LoadType.SWF,onResLoaded);
         }
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         _mc = (param1.content as MovieClip)["mc"];
         _playAnimation = _mc["playAnimation"];
         _bei = _mc["bei"];
         TooltipManager.addCommonTip(_mc,"先祖石碑");
         showMC();
      }
      
      private static function showMC() : void
      {
         var _loc1_:uint = 0;
         _playAnimation.visible = false;
         _loc1_ = mapList.indexOf(SceneManager.active.mapID);
         var _loc2_:Point = mapPoint[_loc1_];
         _mc.x = _loc2_.x;
         _mc.y = _loc2_.y;
         SceneManager.active.mapModel.content.addChild(_mc);
         _mc.buttonMode = true;
         _mc.addEventListener(MouseEvent.CLICK,onClick);
         _bei.play();
         getInfo(_loc1_);
      }
      
      private static function getInfo(param1:uint) : void
      {
         _isOpenPanel = false;
         _dayLimet = mapDayLimet[param1];
         Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,onGetTime);
         Connection.send(CommandSet.DAILY_LIMIT_1065,_dayLimet);
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(_isOpenPanel)
         {
            _loc2_ = new Object();
            _loc2_.mc = _mc;
            _loc2_.getInfo = getInfoTime;
            ModuleManager.toggleModule(URLUtil.getAppModule("QingMingPanel"),"正在清明面板...",_loc2_);
         }
         else
         {
            Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,onGetTimeAlert);
            Connection.send(CommandSet.DAILY_LIMIT_1065,_dayLimet);
         }
      }
      
      private static function onGetTimeAlert(param1:MessageEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,onGetTimeAlert);
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         if(_loc2_.id == _dayLimet)
         {
            _loc3_ = _loc2_.count;
            if((_loc4_ = uint((600 - (TimeManager.getServerTime() - _loc3_)) / 60)) == 0)
            {
               _loc4_ = 1;
            }
            AlertManager.showAlert("你已经祭拜过一次了，等" + _loc4_ + "分钟再来试试看吧");
         }
      }
      
      public static function getInfoTime() : void
      {
         getInfo(mapList.indexOf(SceneManager.active.mapID));
      }
      
      private static function onGetTime(param1:MessageEvent) : void
      {
         var _loc3_:uint = 0;
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,onGetTime);
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         if(_loc2_.id == _dayLimet)
         {
            _loc3_ = _loc2_.count;
            if(_loc3_ == 0 || TimeManager.getServerTime() - _loc3_ >= 600)
            {
               _isOpenPanel = true;
            }
            else
            {
               startTime(600 - (TimeManager.getServerTime() - _loc3_));
            }
         }
      }
      
      private static function startTime(param1:uint) : void
      {
         var time:uint = param1;
         _setTimeout = setTimeout(function():void
         {
            _isOpenPanel = true;
         },time * 1000);
      }
      
      private static function checkTime() : Boolean
      {
         var _loc1_:uint = new Date(2012,3,2,13,1).getTime() / 1000;
         var _loc2_:uint = new Date(2012,3,2,15,1).getTime() / 1000;
         if(TimeManager.getServerTime() >= _loc1_ && TimeManager.getServerTime() < _loc2_)
         {
            return true;
         }
         return false;
      }
   }
}
