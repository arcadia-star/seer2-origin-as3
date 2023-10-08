package com.taomee.seer2.app.processor.activity.devilActivityNext
{
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilActivity;
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.rightToolbar.RightToolbarTimeCheck;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class DevilActivityNext
   {
      
      private static const mapIdList:Vector.<uint> = Vector.<uint>([151,124,123,122,121,131,133,141]);
      
      private static const pointList:Vector.<Point> = Vector.<Point>([new Point(172,247),new Point(409,377),new Point(628,254),new Point(625,393),new Point(394,318),new Point(237,371),new Point(268,407),new Point(575,397)]);
      
      private static const pointList2:Vector.<Point> = Vector.<Point>([new Point(263,240),new Point(499,377),new Point(695,254),new Point(700,393),new Point(470,318),new Point(305,371),new Point(312,407),new Point(650,397)]);
      
      private static var _index:int;
      
      private static var _devilLoad:DevilLoad;
      
      private static var _npc1:MovieClip;
      
      private static var _npc2:MovieClip;
       
      
      public function DevilActivityNext()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onSwitchStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
      }
      
      private static function onSwitchComplete(param1:SceneEvent) : void
      {
         _index = mapIdList.indexOf(SceneManager.active.mapID);
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_index != -1 && RightToolbarTimeCheck.isTimeContent("2012_8_*_14_1","2012_8_*_15_0") && _loc2_.date != 10)
         {
            _devilLoad = new DevilLoad();
            _devilLoad.playLoad("devilLoadNext/devilLoadNext",onLoadComplete);
         }
         else if(RightToolbarTimeCheck.isTimeContent("2012_8_*_14_1","2012_8_*_15_0") == false && _index != -1 && _loc2_.date != 10)
         {
            TimeManager.addEventListener(TimeManager.TIME_UPDATE,onTimeContent);
         }
      }
      
      private static function onTimeContent(param1:Event) : void
      {
         if(RightToolbarTimeCheck.isTimeContent("2012_8_*_14_0","2012_8_*_15_0"))
         {
            DevilActivity.dispose();
            if(_devilLoad == null)
            {
               _devilLoad = new DevilLoad();
            }
            _devilLoad.playLoad("devilLoadNext/devilLoadNext",onLoadComplete);
         }
      }
      
      private static function onLoadComplete() : void
      {
         _npc1 = _devilLoad.getMC("npc" + _index);
         _npc1.name = "npc_1";
         _npc1.x = pointList[_index].x;
         _npc1.y = pointList[_index].y;
         SceneManager.active.mapModel.content.addChild(_npc1);
         eventNpc(_npc1);
         _npc2 = _devilLoad.getMC("npc" + _index + _index);
         _npc2.name = "npc_2";
         _npc2.x = pointList2[_index].x;
         _npc2.y = pointList2[_index].y;
         SceneManager.active.mapModel.content.addChild(_npc2);
         eventNpc(_npc2);
         TimeManager.addEventListener(TimeManager.TIME_UPDATE,onTimeUpdate);
         ServerBufferManager.getServerBuffer(ServerBufferType.DEVILACTIVITY_TIME,getServerTime);
      }
      
      private static function onTimeUpdate(param1:Event) : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.DEVILACTIVITY_TIME,getServerTime);
      }
      
      private static function getServerTime(param1:ServerBuffer) : void
      {
         if(TimeManager.getServerTime() - param1.readDataAtPostionGetInt(_index * 4) >= 60)
         {
            _npc1.gotoAndStop(1);
            _npc1.mouseChildren = true;
            _npc1.mouseEnabled = true;
         }
         else
         {
            _npc1.gotoAndStop(2);
            _npc1.mouseChildren = false;
            _npc1.mouseEnabled = false;
         }
         ServerBufferManager.getServerBuffer(ServerBufferType.DEVILACTIVITY_TIME2,getServerTime2);
      }
      
      private static function getServerTime2(param1:ServerBuffer) : void
      {
         if(TimeManager.getServerTime() - param1.readDataAtPostionGetInt(_index * 4) >= 60)
         {
            _npc2.gotoAndStop(1);
            _npc2.mouseChildren = true;
            _npc2.mouseEnabled = true;
         }
         else
         {
            _npc2.gotoAndStop(2);
            _npc2.mouseChildren = false;
            _npc2.mouseEnabled = false;
         }
      }
      
      private static function eventNpc(param1:MovieClip) : void
      {
         param1.buttonMode = true;
         param1.gotoAndStop(1);
         param1.addEventListener(MouseEvent.CLICK,onNpc);
      }
      
      private static function onNpc(param1:MouseEvent) : void
      {
         var currMC:MovieClip = null;
         var serbufType:uint = 0;
         var mc:MovieClip = null;
         var event:MouseEvent = param1;
         currMC = event.currentTarget as MovieClip;
         serbufType = ServerBufferType.DEVILACTIVITY_TIME2;
         if(currMC.name == "npc_1")
         {
            serbufType = ServerBufferType.DEVILACTIVITY_TIME;
         }
         currMC.gotoAndStop(2);
         currMC.mouseChildren = false;
         currMC.mouseEnabled = false;
         mc = _devilLoad.getMC("color");
         mc.x = currMC.x - 20;
         mc.y = currMC.y - 65;
         SceneManager.active.mapModel.front.addChild(mc);
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            mc.gotoAndStop(1);
            DisplayUtil.removeForParent(mc);
            currMC.gotoAndStop(2);
            currMC.mouseChildren = false;
            currMC.mouseEnabled = false;
            ServerMessager.addMessage("收集成功！1滴祝福雨露已放入瓶中。");
            var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
            var _loc2_:Vector.<ServerBufferData> = Vector.<ServerBufferData>([]);
            _loc2_.push(new ServerBufferData(_index * 4,_loc1_.getTime() / 1000,4));
            ServerBufferManager.updateServerBufferGroup(serbufType,_loc2_);
            ServerBufferManager.getServerBuffer(ServerBufferType.DEVILACTIVITY,onDevilactivity);
         });
      }
      
      private static function onDevilactivity(param1:ServerBuffer) : void
      {
         var _loc2_:uint = uint(param1.readDataAtPostion(0));
         if(param1.readDataAtPostion(0) >= 10)
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DevilActivityNextPanel"),"加载素材");
            RightToolbarConter.instance.toolbarLight("devilNextToolbar");
         }
         else
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.DEVILACTIVITY,0,param1.readDataAtPostion(0) + 1);
            if(_loc2_ >= 9)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("DevilActivityNextPanel"),"加载素材");
            }
         }
      }
      
      private static function onSwitchStart(param1:SceneEvent) : void
      {
         if(_devilLoad)
         {
            _devilLoad.dispose();
         }
         TimeManager.removeEventListener(TimeManager.TIME_UPDATE,onTimeContent);
         TimeManager.removeEventListener(TimeManager.TIME_UPDATE,onTimeUpdate);
         DisplayUtil.removeForParent(_npc1);
         DisplayUtil.removeForParent(_npc2);
         _devilLoad = null;
         _npc1 = null;
         _npc2 = null;
      }
   }
}
