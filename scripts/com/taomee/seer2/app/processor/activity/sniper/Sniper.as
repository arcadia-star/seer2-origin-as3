package com.taomee.seer2.app.processor.activity.sniper
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class Sniper
   {
      
      private static const mapList:Vector.<uint> = Vector.<uint>([880]);
      
      private static const pointList:Vector.<Point> = Vector.<Point>([new Point(111,111),new Point(222,222)]);
      
      private static var _load:DevilLoad;
      
      private static var _index:int;
      
      private static var _blood:MovieClip;
      
      private static var _boss:Mobile;
      
      private static var _rankingInfoList:Vector.<com.taomee.seer2.app.processor.activity.sniper.SniperInfo>;
      
      private static var _rankingList:Vector.<MovieClip>;
      
      private static var _currCount:uint;
      
      private static var _totalMC:MovieClip;
      
      private static var _rec:MovieClip;
       
      
      public function Sniper()
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
         _index = mapList.indexOf(SceneManager.active.mapID);
         if(_index != -1)
         {
            _boss = MobileManager.getMobile(514,MobileType.NPC);
            _boss.visible = false;
            startBlood();
         }
      }
      
      private static function startList() : void
      {
      }
      
      public static function startSniper() : void
      {
         if(SceneManager.active.mapID == 880)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("sniperLoad/sniperAnimation"),function():void
            {
               startBlood();
            });
         }
      }
      
      private static function onLoadComplete() : void
      {
         DisplayUtil.removeForParent(_blood);
         _blood = _load.getMC("blood");
         _blood.x = 249;
         _blood.y = 38;
         LayerManager.mapLayer.addChild(_blood);
         DisplayUtil.align(_blood,4,LayerManager.rootRect,new Point(0,-220));
         startRanking();
         startEvent();
         setBlood(_currCount);
      }
      
      private static function startRanking() : void
      {
         _rankingList = Vector.<MovieClip>([]);
         _rankingInfoList = Vector.<com.taomee.seer2.app.processor.activity.sniper.SniperInfo>([]);
         Connection.addCommandListener(CommandSet.GET_RANKING_LIST_1232,onRanking);
         Connection.send(CommandSet.GET_RANKING_LIST_1232,1,1);
      }
      
      private static function onRanking(param1:MessageEvent) : void
      {
         var _loc5_:com.taomee.seer2.app.processor.activity.sniper.SniperInfo = null;
         Connection.removeCommandListener(CommandSet.GET_RANKING_LIST_1232,onRanking);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint;
         if((_loc4_ = uint(_loc2_.readUnsignedInt())) > 10)
         {
            _loc4_ = 10;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            (_loc5_ = new com.taomee.seer2.app.processor.activity.sniper.SniperInfo()).userId = _loc2_.readUnsignedInt();
            _loc5_.nick = _loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN);
            _loc5_.hurt = _loc2_.readUnsignedInt();
            _rankingInfoList.push(_loc5_);
            _loc6_++;
         }
         addRanking();
      }
      
      private static function addRanking() : void
      {
         var mc:MovieClip = null;
         var count:uint = 0;
         var currMC:MovieClip = null;
         var i:int = 0;
         _rankingInfoList.sort(sortVec);
         for each(currMC in _rankingList)
         {
            DisplayUtil.removeForParent(currMC);
         }
         i = 0;
         while(i < _rankingInfoList.length)
         {
            count = uint(i);
            if(i > 3)
            {
               count = 3;
            }
            _rankingList.push(_load.getMC("ranking" + i));
            mc = _rankingList[i];
            mc["pos"].text = uint(i + 1).toString();
            mc["nick"].text = _rankingInfoList[i].nick;
            mc["hurt"].text = _rankingInfoList[i].hurt.toString();
            mc["proportion"].text = "(" + Number(_rankingInfoList[i].hurt / 200000000 * 100).toFixed(1) + "%" + ")";
            mc.x = 20;
            mc.y = 110 + i * 25;
            LayerManager.mapLayer.addChild(mc);
            i++;
         }
         if(_rankingInfoList.length <= 0)
         {
            return;
         }
         DisplayUtil.removeForParent(_totalMC);
         DayLimitManager.getDoCount(477,function(param1:uint):void
         {
            _totalMC = _load.getMC("total");
            _totalMC["hurt"].text = param1.toString();
            _totalMC["proportion"].text = "(" + Number(param1 / 200000000 * 100).toFixed(1) + "%" + ")";
            _totalMC.x = 20;
            _totalMC.y = 110 + _rankingInfoList.length * 25;
            LayerManager.mapLayer.addChild(_totalMC);
         });
      }
      
      private static function sortVec(param1:com.taomee.seer2.app.processor.activity.sniper.SniperInfo, param2:com.taomee.seer2.app.processor.activity.sniper.SniperInfo) : int
      {
         if(param1.hurt > param2.hurt)
         {
            return -1;
         }
         if(param1.hurt < param2.hurt)
         {
            return 1;
         }
         return 0;
      }
      
      private static function startBlood() : void
      {
         Connection.addCommandListener(CommandSet.GET_CURR_BLOOD_1231,onGetBlood);
         Connection.send(CommandSet.GET_CURR_BLOOD_1231);
      }
      
      private static function onGetBlood(param1:MessageEvent) : void
      {
         var _loc5_:MovieClip = null;
         Connection.removeCommandListener(CommandSet.GET_CURR_BLOOD_1231,onGetBlood);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         _currCount = _loc3_;
         var _loc4_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_currCount <= 0)
         {
            DisplayUtil.removeForParent(_blood);
            if(_boss)
            {
               _boss.visible = false;
            }
            for each(_loc5_ in _rankingList)
            {
               DisplayUtil.removeForParent(_loc5_);
            }
            DisplayUtil.removeForParent(_totalMC);
            if(_loc4_.hours > 19)
            {
               if(_load == null)
               {
                  _load = new DevilLoad();
               }
               _load.playLoad("sniperLoad/sniperLoad",startRanking);
            }
         }
         else
         {
            if(_boss)
            {
               _boss.visible = true;
               DisplayUtil.removeForParent(_rec);
               _rec = new MovieClip();
               _rec.graphics.beginFill(16711935,0);
               _rec.graphics.drawRect(0,0,150,150);
               _rec.graphics.endFill();
               _rec.x = 570;
               _rec.y = 100;
               LayerManager.mapLayer.addChild(_rec);
            }
            if(_load == null)
            {
               _load = new DevilLoad();
            }
            _load.playLoad("sniperLoad/sniperLoad",onLoadComplete);
         }
      }
      
      private static function setBlood(param1:uint) : void
      {
         _blood["blooda"].scaleX = param1 / 200000000;
         if(_blood["blooda"].scaleX < 0)
         {
            _blood["blooda"].scaleX = 0;
         }
         if(_blood["blooda"].scaleX < 1)
         {
            _blood["blooda"].scaleX = 1;
         }
      }
      
      private static function startEvent() : void
      {
         if(_rec)
         {
            _rec.buttonMode = true;
            _rec.addEventListener(MouseEvent.CLICK,onBoss);
         }
      }
      
      private static function onBoss(param1:MouseEvent) : void
      {
         FightManager.startFightWithBoss(148);
      }
      
      private static function onSwitchStart(param1:SceneEvent) : void
      {
         dispose();
      }
      
      public static function bossHide() : void
      {
         if(_boss)
         {
            _boss.visible = false;
         }
      }
      
      public static function dispose() : void
      {
         var _loc1_:MovieClip = null;
         Connection.removeCommandListener(CommandSet.GET_CURR_BLOOD_1231,onGetBlood);
         Connection.removeCommandListener(CommandSet.GET_RANKING_LIST_1232,onRanking);
         if(_rankingList)
         {
            for each(_loc1_ in _rankingList)
            {
               DisplayUtil.removeForParent(_loc1_);
            }
         }
         DisplayUtil.removeForParent(_blood);
         DisplayUtil.removeForParent(_totalMC);
         DisplayUtil.removeForParent(_rec);
         _blood = null;
         _totalMC = null;
         _rankingList = null;
         _rankingInfoList = null;
         _rec = null;
         if(_boss)
         {
            _boss.visible = false;
         }
         _boss = null;
      }
   }
}
