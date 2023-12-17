package com.taomee.seer2.app.processor.activity.deliciousFood
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class DeliciousFoodTwo
   {
      
      private static const mapList:Vector.<uint> = Vector.<uint>([90,160,230,320,470,90,160,230,320,470,90]);
      
      public static const timeList:Vector.<DeliciousFoodTime> = Vector.<DeliciousFoodTime>([new DeliciousFoodTime(13,35,"草系主城"),new DeliciousFoodTime(13,40,"水系主城"),new DeliciousFoodTime(13,45,"火系主城"),new DeliciousFoodTime(13,50,"沙系主城"),new DeliciousFoodTime(13,55,"地系主城"),new DeliciousFoodTime(14,0,"草系主城"),new DeliciousFoodTime(14,5,"水系主城"),new DeliciousFoodTime(14,10,"火系主城"),new DeliciousFoodTime(14,15,"沙系主城"),new DeliciousFoodTime(14,20,"地系主城"),new DeliciousFoodTime(14,25,"草系主城")]);
      
      private static const npcPointList:Vector.<Point> = Vector.<Point>([new Point(449,189),new Point(575,194),new Point(734,300),new Point(651,271),new Point(496,324),new Point(449,189),new Point(575,194),new Point(734,300),new Point(654,271),new Point(496,324),new Point(449,189)]);
      
      private static var _currMap:uint;
      
      private static var _mc:MovieClip;
      
      private static var _currTime:uint;
      
      private static var _isShowNpc:Boolean;
      
      private static var _fightIndex:uint;
      
      private static var _playMC:MovieClip;
      
      private static var _activityCount:uint;
      
      private static var _hornTime:uint = 1990;
      
      private static var _currIndex:uint;
       
      
      public function DeliciousFoodTwo()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
      }
      
      private static function onMapSwitchComplete(param1:SceneEvent) : void
      {
         var event:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA && _fightIndex == 1)
         {
            _fightIndex = 0;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               InteractiveRewardManager.requestReward(120,function(param1:Parser_1060):void
               {
                  var par:Parser_1060 = param1;
                  ServerBufferManager.updateServerBuffer(DeliciousFoodOnePickup.getServerBuf(),_currTime + 7,1);
                  ServerBufferManager.updateServerBuffer(DeliciousFoodOnePickup.getServerBuf(),_currTime + 18,1);
                  par.showResult();
                  NpcDialog.show(485,"美食神猪",[[3,"哼！就是因为旁边的那台机器探测出我的踪迹，才让你这么轻易的找到我！"]],["这都被你发现了，你这头猪的智商也不低嘛！"],[function():void
                  {
                     winCount();
                  }]);
               });
            }
            else
            {
               InteractiveRewardManager.requestReward(121,function(param1:Parser_1060):void
               {
                  var par:Parser_1060 = param1;
                  ServerBufferManager.updateServerBuffer(DeliciousFoodOnePickup.getServerBuf(),_currTime + 7,1);
                  par.showResult();
                  NpcDialog.show(485,"美食神猪",[[3,"哼！就是因为旁边的那台机器探测出我的踪迹，才让你这么轻易的找到我！"]],["这都被你发现了，你这头猪的智商也不低嘛！"],[function():void
                  {
                     winCount();
                  }]);
               });
            }
            return;
         }
         startDeliciousFood();
      }
      
      public static function startDeliciousFood() : void
      {
         if(mapList.indexOf(SceneManager.active.mapID) != -1 && DeliciousFoodLoad.instance.checkTime)
         {
            _currMap = mapList.indexOf(SceneManager.active.mapID);
            ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),onGetServer,false);
         }
         if(isTimerLater())
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
            Tick.instance.removeRender(updateHorn);
         }
      }
      
      private static function winCount() : void
      {
         ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),onGetServer2,false);
      }
      
      private static function onGetServer2(param1:ServerBuffer) : void
      {
         var server:ServerBuffer = param1;
         _activityCount = getActivityCount(server);
         if(_activityCount >= 5)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("deliciousFood/deliciousFoodScreen"),function():void
            {
               InteractiveRewardManager.requestReward(122,function(param1:Parser_1060):void
               {
                  param1.showResult();
                  SceneManager.removeEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
                  SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
               });
            });
         }
         else
         {
            _playMC = DeliciousFoodLoad.instance.getMC("playMC");
            LayerManager.topLayer.addChild(_playMC);
            MovieClipUtil.playMc(_playMC,1,_playMC.totalFrames,function():void
            {
               Tick.instance.addRender(updateHorn,2000);
               DisplayUtil.removeForParent(_playMC);
               ModuleManager.toggleModule(URLUtil.getAppModule("DeliciousFoodPanel"),"美食神猪");
            },true);
         }
      }
      
      private static function onMapSwitchStart(param1:SceneEvent) : void
      {
         Tick.instance.removeRender(updateTime);
         DisplayUtil.removeForParent(_playMC);
         DisplayUtil.removeForParent(_mc);
         _isShowNpc = false;
      }
      
      private static function onGetServer(param1:ServerBuffer) : void
      {
         var _loc5_:Vector.<ServerBufferData> = null;
         var _loc6_:int = 0;
         var _loc2_:int = param1.readDataAtPostion(40);
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc2_ != 1)
         {
            _loc5_ = new Vector.<ServerBufferData>();
            _loc6_ = 0;
            while(_loc6_ < 38)
            {
               _loc5_.push(new ServerBufferData(_loc6_,0));
               _loc6_++;
            }
            _loc5_.push(new ServerBufferData(40,1));
            ServerBufferManager.updateServerBufferGroup(DeliciousFoodOnePickup.getServerBuf(),_loc5_);
            return;
         }
         _currTime = currTimeIndex;
         _activityCount = getActivityCount(param1);
         if(_activityCount >= 5)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_START,onMapSwitchStart);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitchComplete);
            Tick.instance.removeRender(updateHorn);
            return;
         }
         var _loc4_:int;
         if((_loc4_ = param1.readDataAtPostion(6)) == 1)
         {
            Tick.instance.addRender(updateTime,2000);
            Tick.instance.addRender(updateHorn,2000);
         }
         if(_currTime == 222)
         {
            return;
         }
         _currIndex = param1.readDataAtPostion(_currTime + 7);
         if(_loc4_ == 1 && _currIndex != 1 && SceneManager.active.mapID == mapList[_currTime] && _activityCount < 5)
         {
            showNpc();
         }
      }
      
      private static function getActivityCount(param1:ServerBuffer) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 18;
         while(_loc3_ < 29)
         {
            if(param1.readDataAtPostion(_loc3_) == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function showNpc() : void
      {
         DeliciousFoodLoad.instance.playLoad(function():void
         {
            _mc = DeliciousFoodLoad.instance.getMC("npcOne");
            LayerManager.mapLayer.addChild(_mc);
            _mc.buttonMode = true;
            _mc.x = npcPointList[_currTime].x;
            _mc.y = npcPointList[_currTime].y;
            _mc.addEventListener(MouseEvent.CLICK,onClick);
            _isShowNpc = true;
         });
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(485,"美食神猪",[[3,"嘿嘿！你速度挺快嘛！"]],["别废话，接招吧！"],[function():void
         {
            _fightIndex = 1;
            _currTime = currTimeIndex;
            FightManager.startFightWithWild(107);
         }]);
      }
      
      private static function updateTime(param1:uint) : void
      {
         if(_isShowNpc)
         {
            if(_currTime != currTimeIndex)
            {
               Tick.instance.removeRender(updateTime);
               DisplayUtil.removeForParent(_mc);
               _isShowNpc = false;
            }
         }
         else
         {
            if(_currTime != currTimeIndex)
            {
               Tick.instance.removeRender(updateTime);
               Tick.instance.removeRender(updateHorn);
               ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),onGetServer,false);
            }
            if(currTimeIndex != 222 && SceneManager.active.mapID == mapList[currTimeIndex] && _activityCount < 5 && _currIndex != 1)
            {
               _currTime = currTimeIndex;
               showNpc();
            }
         }
      }
      
      private static function updateHorn(param1:uint) : void
      {
         if(isTimerLater())
         {
            Tick.instance.removeRender(updateHorn);
         }
         if(_hornTime != currTimeIndex && currTimeIndex != 222)
         {
            _hornTime = currTimeIndex;
            showTip();
         }
      }
      
      private static function showTip() : void
      {
         ServerMessager.addMessage("生命监测仪发来最新消息，美食神猪在" + timeList[currTimeIndex].mapName + "出现啦！");
      }
      
      public static function get currTimeIndex() : uint
      {
         var _loc1_:DeliciousFoodTime = null;
         var _loc2_:int = 0;
         while(_loc2_ < 11)
         {
            _loc1_ = timeList[_loc2_];
            if(DateUtil.isInHourScope(_loc1_.hours,_loc1_.hours,_loc1_.minutes,_loc1_.minutes + 5))
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 222;
      }
      
      private static function isTimerLater() : Boolean
      {
         if(DateUtil.isInHourScope(13,14,30,30))
         {
            return false;
         }
         return true;
      }
   }
}
