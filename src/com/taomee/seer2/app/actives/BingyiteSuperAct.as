package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.FightUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.EventListenerManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.Tick;
   
   public class BingyiteSuperAct
   {
      
      private static var _currentStep:int = 0;
      
      private static var _npc:Mobile;
      
      private static var _leftTime:int = 0;
      
      private static var _mapIds:Array;
      
      private static var _eventListenerMgr:EventListenerManager;
      
      public static const NPC_CONFIG:* = [{
         "npcId":49,
         "mapId":80595,
         "pos":[500,500],
         "name":"冰沁酋长",
         "clickFun":onQiuzhangClick,
         "initMapFun":int80595
      },{
         "npcId":122,
         "mapId":80596,
         "pos":[500,500],
         "name":"派瑞",
         "clickFun":onPerryClick
      },{
         "npcId":123,
         "mapId":80597,
         "pos":[500,500],
         "name":"文森特",
         "clickFun":onWensengteClick
      },{
         "npcId":114,
         "mapId":80598,
         "pos":[500,500],
         "name":"蒂芙伦",
         "clickFun":onTifulunClick,
         "initMapFun":int80598
      }];
       
      
      public function BingyiteSuperAct()
      {
         super();
      }
      
      public static function init() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapSwitch);
      }
      
      private static function onMapSwitch(param1:SceneEvent) : void
      {
         Tick.instance.removeRender(onTick);
         if(SceneManager.active.type != SceneType.ARENA)
         {
            if(mapIds.indexOf(SceneManager.active.mapID) != -1)
            {
               initMap();
            }
            else
            {
               if(_eventListenerMgr)
               {
                  _eventListenerMgr.clear();
               }
               if(_npc)
               {
                  _npc.dispose();
                  _npc = null;
               }
            }
         }
      }
      
      public static function initMap() : void
      {
         var pos:Array = null;
         var npc:Mobile = null;
         var npcId:int = int(NPC_CONFIG[currentStep]["npcId"]);
         pos = NPC_CONFIG[currentStep]["pos"];
         npc = new Mobile();
         npc.buttonMode = true;
         npc.resourceUrl = URLUtil.getNpcSwf(npcId);
         npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         npc.label = NPC_CONFIG[currentStep]["name"];
         npc.setPostion(new Point(pos[0],pos[1]));
         setTimeout(function():void
         {
            npc.addOverHeadMark(new AcceptableMark());
         },1000);
         MobileManager.addMobile(npc,MobileType.NPC);
         if(_eventListenerMgr == null)
         {
            _eventListenerMgr = new EventListenerManager();
         }
         _eventListenerMgr.addEventListener(npc,MouseEvent.CLICK,onNpcClick);
         if(NPC_CONFIG[currentStep]["initMapFun"])
         {
            NPC_CONFIG[currentStep]["initMapFun"]();
         }
         _npc = npc;
      }
      
      public static function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         DayLimitListManager.getDaylimitList([2005],function callback(param1:DayLimitListInfo):void
         {
            var _loc3_:Function = null;
            var _loc2_:int = int(param1.getCount(2005));
            if(BitUtil.getBit(_loc2_,currentStep) == 0)
            {
               _loc3_ = NPC_CONFIG[currentStep]["clickFun"];
               _loc3_();
            }
         });
      }
      
      private static function onPerryClick() : void
      {
         NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/3.json",function():void
         {
            ModuleManager.showAppModule("MusicBoxForBingyiteSuperPanel",function(param1:int):void
            {
               var dialogs:Array;
               var num:int = param1;
               SwapManager.swapItem(4660,2,null,null,new SpecialInfo(2,1,num));
               dialogs = [[122,"派瑞",[[0,"不错不错，没退步嘛~这些冰皮元宵就作为返乡礼物送给詹姆斯了。来，星际使者，你也有份啊~"]],[" 谢谢派瑞~"]],[122,"派瑞",[[0,"不客气不客气！话说回来，方便的话能不能帮我跑个腿去[冰脊山脉]找找文森特呢？这家伙上周开始处理上一个乐章的填词，脱稿了一周还没给我个声儿。我快要气的把板凳砸他头上了！"]],["哈哈哈哈别急别急，我们去冰脊山脉找他！"]]];
               NpcDialog.showDialogs(dialogs,function():void
               {
                  SceneManager.changeScene(SceneType.COPY,80597);
               });
            });
         });
      }
      
      private static function onWensengteClick() : void
      {
         NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/4.json",function():void
         {
            FightUtil.startFight(1885,function():void
            {
               NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/5.json",function():void
               {
                  SceneManager.changeScene(SceneType.COPY,80598);
               });
            });
         });
      }
      
      private static function onTifulunClick() : void
      {
         NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/6.json",function():void
         {
            var mv:MovieClip = SceneManager.active.mapModel.content["mv"];
            mv.visible = true;
            mv.gotoAndStop(1);
            _npc.visible = false;
            MovieClipUtil.playMc(mv,2,mv.totalFrames,function():void
            {
               FightUtil.startFight(1886,function():void
               {
                  if(!FightManager.isWinWar())
                  {
                     return;
                  }
                  NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/5.json",function():void
                  {
                     SceneManager.changeScene(SceneType.COPY,80598);
                  });
               });
            });
         });
      }
      
      private static function onQiuzhangClick() : void
      {
         var timeMc:MovieClip = null;
         if(_leftTime > 0)
         {
            return;
         }
         timeMc = SceneManager.active.mapModel.content["timeMc"];
         NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/1.json",function():void
         {
            AlertManager.showAlert("你需要在冰之谷站岗1分钟。如果你离开了冰之谷，本次站岗将无效，需要重新进行任务哦!",function():void
            {
               timeMc.visible = true;
               Tick.instance.addRender(onTick,1000);
               _leftTime = 60;
               onTick(0);
            });
         });
      }
      
      private static function onTick(param1:uint) : void
      {
         var timeMc:MovieClip;
         var n:uint = param1;
         --_leftTime;
         if(_leftTime <= 0)
         {
            Tick.instance.removeRender(onTick);
            SwapManager.swapItem(4660,1,null,null,new SpecialInfo(2,0,0));
            NpcDialog.showDialogsByText("activity/dialog/bingyitesuper/2.json",function():void
            {
               SceneManager.changeScene(SceneType.COPY,80596);
            });
            return;
         }
         timeMc = SceneManager.active.mapModel.content["timeMc"];
         timeMc["txtTime"].text = _leftTime;
      }
      
      private static function int80598() : void
      {
         SceneManager.active.mapModel.content["mv"].visible = false;
      }
      
      private static function int80595() : void
      {
         SceneManager.active.mapModel.content["timeMc"].visible = false;
      }
      
      private static function get mapIds() : Array
      {
         var _loc1_:int = 0;
         if(_mapIds == null)
         {
            _mapIds = [];
            _loc1_ = 0;
            while(_loc1_ < NPC_CONFIG.length)
            {
               mapIds.push(NPC_CONFIG[_loc1_].mapId);
               _loc1_++;
            }
         }
         return _mapIds;
      }
      
      private static function get currentStep() : int
      {
         return mapIds.indexOf(SceneManager.active.mapID);
      }
   }
}
