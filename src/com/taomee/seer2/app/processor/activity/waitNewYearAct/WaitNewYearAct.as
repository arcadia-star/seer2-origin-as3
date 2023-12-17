package com.taomee.seer2.app.processor.activity.waitNewYearAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class WaitNewYearAct
   {
      
      private static var _self:WaitNewYearAct;
      
      private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([8,1,2,7,190,5,4,6,3,195,48,153]);
      
      private static const NPC_DAILOGE_LIST:Vector.<int> = Vector.<int>([8,1,2,7,190,5,4,6,3,195,105,153]);
      
      private static const NPC_DIALOGE_ID_LIST:Vector.<int> = Vector.<int>([1,0,0,1,0,4,3,0,0,0,0,0]);
      
      private static const NPC_NAME_LIST:Vector.<String> = Vector.<String>(["艾农","船长辛迪","博士伊娃","娜威拉","金","乔休尔","菲鲁","克拉克","门罗","雷文","希尔顿","贾斯汀"]);
      
      private static const MAP_LIST:Vector.<int> = Vector.<int>([70,10,20,30,60,40,50,60,450,1300,8011,3818]);
      
      private static const TIME_LIST:Array = [[0,4],[5,9],[10,14],[15,19],[20,24],[25,29],[30,34],[35,39],[40,44],[45,49],[50,54],[55,59]];
      
      private static const TIPS_LIST:Vector.<String> = Vector.<String>(["啦啦啦~约瑟传说迎新春咯，神秘礼物等你来拿！还在等什么？","这是一个值得纪念的日子！新的一年里，不论遇到什么艰难险阻，我相信伟大的小赛尔们一定能战胜一切。","新的一年中，你还会得到更强大的伙伴吗？让我们一起期待吧！","想成为整个宇宙中最最聪明最最美丽的情报员吗？新的一年中你可要努力咯。","最近得到消息，约瑟王即将诞生，有没有兴趣和我一起等待精灵王的降临？","啊~在这么特殊的日子里，啊~我好紧张啊，不知道说什么好了。","忙碌了这么久终于能喘口气了，哈哈！看到如今的约瑟传说，我觉得再多的辛劳也是值得的……","咳咳……大家要严肃点，祝大家马年快乐，“马”上有钱！","新年到，财神到！","只有对抗才能磨练出真正的实力，新的一年里，我们要变得更强！","新的一年里，我们要创造出更多的奇迹！","约瑟传说陪伴大家从兔年跨越到了马年，更多的还是需要大家的支持，祝约瑟传说越飞越远！"]);
      
      private static const FOR_LIST:Vector.<uint> = Vector.<uint>([206156,206157,206146,206147,206148,206149,206150,206151,206152,206153,206154,206155]);
      
      private static const GET_NUM_RULE:Vector.<int> = Vector.<int>([1,2]);
       
      
      private var _map:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _curLeaveTime:int;
      
      private var _actTip:MovieClip;
      
      private var _npc:Mobile;
      
      private var _oldNpc:Mobile;
      
      private var _timeId:int;
      
      private var _index:int;
      
      private var _endDate:Date;
      
      public function WaitNewYearAct()
      {
         super();
      }
      
      public static function getInstance() : WaitNewYearAct
      {
         if(_self == null)
         {
            _self = new WaitNewYearAct();
         }
         return _self;
      }
      
      private function getURL(param1:Function) : void
      {
         var func:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("waitNewYearAct/WaitNewYearAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            func();
         });
      }
      
      public function handleNewYearTime(param1:MapModel) : void
      {
         var map:MapModel = param1;
         this._map = map;
         if(DateUtil.isDay(2015,12,31))
         {
            this.getURL(function():void
            {
               if(DateUtil.isInHourScope(14,20))
               {
                  _actTip = getMovie("ActTip");
                  _map.content.addChild(_actTip);
                  _actTip.x = 682;
                  _actTip.y = 76;
                  showTime();
               }
               if(TimeManager.getServerTime() * 1000 >= new Date(2015,11,31,20).getTime())
               {
                  _actTip = getMovie("ActTip");
                  _map.content.addChild(_actTip);
                  _actTip.x = 682;
                  _actTip.y = 76;
                  _actTip.buttonMode = true;
                  addActClickTip();
                  _actTip.addEventListener(MouseEvent.CLICK,onActTip);
               }
            });
         }
      }
      
      private function showTime() : void
      {
         this._curLeaveTime = (new Date(2015,11,31,20).getTime() - TimeManager.getServerTime() * 1000) / 1000;
         if(this._curLeaveTime > 0)
         {
            this.showTimeCountRes();
            Tick.instance.addRender(this.onTimeUpdate,1000);
         }
      }
      
      private function showTimeCountRes() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = this._curLeaveTime / 60;
         var _loc2_:Array = [0,0,0];
         while(_loc3_ < 3)
         {
            _loc2_[2 - _loc3_] = _loc1_ % 10;
            _loc1_ /= 10;
            _loc3_++;
         }
         if(this._curLeaveTime > 0 && this._curLeaveTime <= 60)
         {
            _loc2_ = [0,0,1];
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            (this._actTip["time"]["num" + _loc3_] as MovieClip).gotoAndStop(_loc2_[_loc3_] + 1);
            _loc3_++;
         }
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function onTimeUpdate(param1:int) : void
      {
         var sceneMC:MovieClip = null;
         var num:int = param1;
         if(this._curLeaveTime <= 0)
         {
            this._curLeaveTime = 0;
            this.showTimeCountRes();
            this.addActClickTip();
            Tick.instance.removeRender(this.onTimeUpdate);
            sceneMC = this.getMovie("SceneMC");
            sceneMC.x = 473;
            sceneMC.y = 336;
            this._map.front.addChild(sceneMC);
            MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
            {
               DisplayUtil.removeForParent(sceneMC);
               sceneMC = null;
               _actTip.buttonMode = true;
               _actTip.addEventListener(MouseEvent.CLICK,onActTip);
            });
         }
         --this._curLeaveTime;
         this.showTimeCountRes();
      }
      
      private function onActTip(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("WaitNewYearMainPanel"),"正在打开活动总面板...");
      }
      
      public function disposeNewYearTime() : void
      {
         Tick.instance.removeRender(this.onTimeUpdate);
         if(this._actTip)
         {
            this._actTip.removeEventListener(MouseEvent.CLICK,this.onActTip);
            DisplayUtil.removeForParent(this._actTip);
            this._actTip = null;
         }
         this._map = null;
         this._resLib = null;
         _self = null;
      }
      
      public function handleNpcHandle() : void
      {
         this._index = MAP_LIST.indexOf(SceneManager.active.mapID);
         if(this._index != -1)
         {
            if(SceneManager.active.mapID == 60)
            {
               if(TimeManager.getServerTime() * 1000 > new Date(2015,11,31,20,24,59).getTime())
               {
                  this._index = 7;
               }
            }
            if(DateUtil.isInTime(new Date(2015,11,31,20,TIME_LIST[this._index][0],0),new Date(2015,11,31,20,TIME_LIST[this._index][1],59)))
            {
               this._endDate = new Date(2015,11,31,20,TIME_LIST[this._index][1],59);
               if(!MobileManager.getMobile(NPC_ID_LIST[this._index],MobileType.NPC))
               {
                  this._timeId = setTimeout(function():void
                  {
                     initNpc();
                  },2000);
               }
               else
               {
                  this.initNpc();
               }
            }
            else
            {
               this.hideJustinNpc();
            }
         }
      }
      
      private function hideJustinNpc() : void
      {
         if(this._index == 11)
         {
            MobileManager.getMobile(NPC_ID_LIST[this._index],MobileType.NPC).visible = false;
         }
      }
      
      private function actTimeCount() : void
      {
         Tick.instance.addRender(this.timeCheck,1000);
      }
      
      private function timeCheck(param1:int) : void
      {
         if(this.isAfterDate())
         {
            Tick.instance.removeRender(this.timeCheck);
            ServerMessager.addMessage("当前领奖已结束了!");
            ModuleManager.closeForName("WaitNewYearHitEggPanel");
            this.afterFinish();
         }
      }
      
      private function isAfterDate() : Boolean
      {
         var _loc1_:Number = TimeManager.getPrecisionServerTime() * 1000;
         if(_loc1_ > this._endDate.getTime())
         {
            return true;
         }
         return false;
      }
      
      private function initNpc() : void
      {
         this._oldNpc = MobileManager.getMobile(NPC_ID_LIST[this._index],MobileType.NPC);
         this._oldNpc.visible = false;
         clearInterval(this._timeId);
         this._npc = new Mobile();
         this._npc.width = this._oldNpc.width;
         this._npc.height = this._oldNpc.height;
         this._npc.label = this._oldNpc.label;
         this._npc.setPostion(new Point(this._oldNpc.x,this._oldNpc.y));
         this._npc.resourceUrl = this._oldNpc.resourceUrl;
         this._npc.buttonMode = true;
         if(NPC_ID_LIST[this._index] == 1)
         {
            this._npc.gotoAndStop(1);
         }
         this.showMouseHintAtMonster(this._npc);
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         this.hideJustinNpc();
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 50;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private function addActClickTip() : void
      {
         var _loc1_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc1_.y = 50;
         _loc1_.x = 35;
         this._actTip.addChild(_loc1_);
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ActiveCountManager.requestActiveCount(FOR_LIST[this._index],function(param1:uint, param2:uint):void
         {
            var curMaxGetNum:int = 0;
            var str:String = null;
            var type:uint = param1;
            var val:uint = param2;
            if(FOR_LIST[_index] == type)
            {
               curMaxGetNum = VipManager.vipInfo.isVip() ? GET_NUM_RULE[1] : GET_NUM_RULE[0];
               if(val >= curMaxGetNum)
               {
                  if(_index < 11)
                  {
                     str = ActorManager.actorInfo.nick + " 我这里的蛋已经砸完咯，过5分钟去找其他指定NPC进行砸蛋吧。";
                  }
                  else
                  {
                     str = ActorManager.actorInfo.nick + " 新年快乐，新的一年里祝约瑟传说越办越好！";
                  }
                  NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],str]],["好的，知道啦！"],[]);
               }
               else
               {
                  NpcDialog.show(NPC_DAILOGE_LIST[_index],NPC_NAME_LIST[_index],[[NPC_DIALOGE_ID_LIST[_index],TIPS_LIST[_index]]],["过年砸蛋抽奖喽!"],[function():void
                  {
                     ModuleManager.showModule(URLUtil.getAppModule("WaitNewYearHitEggPanel"),"正在打开新年砸蛋面板...",{
                        "index":_index,
                        "okFunc":afterFinish
                     });
                  }]);
               }
            }
         });
      }
      
      private function afterFinish() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
         if(this._oldNpc)
         {
            this._oldNpc.visible = true;
         }
         if(this._index == 11)
         {
            if(this._actTip)
            {
               this._actTip.removeEventListener(MouseEvent.CLICK,this.onActTip);
               DisplayUtil.removeForParent(this._actTip);
               this._actTip = null;
            }
         }
      }
      
      public function disposeNpcHandle() : void
      {
         Tick.instance.removeRender(this.timeCheck);
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
         this._oldNpc = null;
      }
   }
}
