package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class PetKingMatch2StartAct
   {
      
      private static var _instance:PetKingMatch2StartAct;
       
      
      private const MAP_LIST:Array = [90,124,230,304,204,160,520,480];
      
      private const OPEN_TIME1:Array = [1315,1330,1345,1400,1415,1430,1445,1500];
      
      private const OPEN_TIME2:Array = [1815,1830,1845,1900,1915,1930,1945,2000];
      
      private const SWAP_ID:int = 1688;
      
      private var stoneSeat:Array;
      
      private var time:Date;
      
      private var mapid:int;
      
      private var currentScore:uint;
      
      private var stone_mc:MovieClip;
      
      private var bloodMc:MovieClip;
      
      private var map:MapModel;
      
      private var mapIndex:int;
      
      private var isTime1:Boolean;
      
      private var isTime2:Boolean;
      
      private var isPlaying:Boolean;
      
      private var bg:MovieClip;
      
      public function PetKingMatch2StartAct()
      {
         this.stoneSeat = [new Point(440,280),new Point(500,300),new Point(460,415),new Point(500,330),new Point(300,400),new Point(210,370),new Point(675,340),new Point(510,430)];
         this.time = new Date();
         super();
      }
      
      public static function getInstance() : PetKingMatch2StartAct
      {
         if(!_instance)
         {
            _instance = new PetKingMatch2StartAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.time.time = TimeManager.getServerTime() * 1000;
         if(this.time.fullYear == 2013 && this.time.month == 6 && this.time.date == 27)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.switchComplete);
            SceneManager.addEventListener(SceneEvent.SWITCH_START,this.switchStart);
         }
      }
      
      private function switchStart(param1:SceneEvent) : void
      {
         if(!SceneManager.active)
         {
            return;
         }
         var _loc2_:int = this.MAP_LIST.indexOf(this.mapid);
         if(_loc2_ == -1)
         {
            return;
         }
         Connection.removeCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.getBlood);
         Connection.removeCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.updateBlood);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         if(this.bloodMc)
         {
            this.bloodMc.scaleX = 1;
         }
         if(Boolean(this.stone_mc) && Boolean(this.stone_mc.parent))
         {
            DisplayObjectUtil.removeFromParent(this.stone_mc);
         }
         this.isPlaying = false;
      }
      
      private function switchComplete(param1:SceneEvent) : void
      {
         this.mapid = SceneManager.active.mapID;
         this.map = SceneManager.active.mapModel;
         var _loc2_:int = this.MAP_LIST.indexOf(this.mapid);
         if(_loc2_ == -1)
         {
            return;
         }
         this.time.time = TimeManager.getServerTime() * 1000;
         this.isTime1 = this.time.hours >= 13 && this.time.hours < 15;
         this.isTime2 = this.time.hours >= 18 && this.time.hours < 20;
         if(this.isTime1)
         {
            this.checkIndex(this.OPEN_TIME1);
            return;
         }
         if(this.isTime2)
         {
            this.checkIndex(this.OPEN_TIME2);
            return;
         }
      }
      
      private function checkIndex(param1:Array) : void
      {
         var _loc6_:LittleEndianByteArray = null;
         var _loc2_:String = this.time.hours.toString();
         var _loc3_:String = this.time.minutes < 10 ? "0" + this.time.minutes.toString() : this.time.minutes.toString();
         var _loc4_:uint = uint(_loc2_ + _loc3_);
         this.mapIndex = -1;
         var _loc5_:int = 0;
         while(_loc5_ < 8)
         {
            if(_loc4_ < param1[_loc5_])
            {
               this.mapIndex = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(this.mapIndex == -1)
         {
            return;
         }
         if(this.mapid == this.MAP_LIST[this.mapIndex])
         {
            Connection.addCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.getBlood);
            (_loc6_ = new LittleEndianByteArray()).writeByte(1);
            Connection.send(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,_loc6_);
         }
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var spe:SpecialInfo = null;
         var cup:MovieClip = null;
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         if(!this.stone_mc || this.stone_mc.currentFrame == 5)
         {
            return;
         }
         if(info.userID == ActorManager.actorInfo.id && this.stone_mc.hitTestPoint(info.endPos.x,info.endPos.y))
         {
            this.time.time = TimeManager.getServerTime() * 1000;
            this.isTime1 = this.time.hours >= 13 && this.time.hours < 15;
            this.isTime2 = this.time.hours >= 18 && this.time.hours < 20;
            if(this.isTime1)
            {
               this.checkIndex(this.OPEN_TIME1);
            }
            if(this.isTime2)
            {
               this.checkIndex(this.OPEN_TIME2);
            }
            if(this.mapIndex == -1 || this.mapid != this.MAP_LIST[this.mapIndex])
            {
               DisplayObjectUtil.removeFromParent(this.stone_mc);
               AlertManager.showAlert("石碑已经消失了!",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("PetKingMatch2StartPanel"));
               });
               return;
            }
            if(this.isTime1 || this.isTime2)
            {
               if(this.isTime1)
               {
                  spe = new SpecialInfo(1,this.mapIndex + 1);
               }
               else
               {
                  spe = new SpecialInfo(1,this.mapIndex + 9);
               }
               SwapManager.swapItem(this.SWAP_ID,1,null,null,spe);
               --this.currentScore;
               this.updateShowBlood();
               if(this.currentScore <= 0)
               {
                  ShootController.close();
               }
               cup = this.stone_mc["stone"] as MovieClip;
               if(!this.isPlaying)
               {
                  this.isPlaying = true;
                  MovieClipUtil.playMc(cup,1,cup.totalFrames,function():void
                  {
                     cup.gotoAndStop(1);
                     isPlaying = false;
                     checkStoneState();
                  });
               }
            }
            else
            {
               DisplayObjectUtil.removeFromParent(this.stone_mc);
               AlertManager.showAlert("石碑已经消失了!",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("PetKingMatch2StartPanel"));
               });
            }
         }
      }
      
      private function checkStoneState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 2000 - this.currentScore;
         if(_loc2_ <= 500)
         {
            _loc1_ = 1;
         }
         if(_loc2_ > 500 && this.currentScore <= 1000)
         {
            _loc1_ = 2;
         }
         if(_loc2_ > 1000 && this.currentScore <= 1500)
         {
            _loc1_ = 3;
         }
         if(_loc2_ > 1500 && this.currentScore < 2000)
         {
            _loc1_ = 4;
         }
         if(_loc2_ == 2000)
         {
            _loc1_ = 5;
         }
         this.stone_mc.gotoAndStop(_loc1_);
      }
      
      private function getBlood(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.getBlood);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readByte());
         this.currentScore = _loc2_.readUnsignedInt();
         var _loc4_:uint = uint(_loc2_.readByte());
         if(!this.stone_mc)
         {
            this.createStoneCup();
         }
         else
         {
            this.showStone();
            this.updateShowBlood();
         }
         if(this.currentScore > 0)
         {
            Connection.addCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.updateBlood);
            ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         }
      }
      
      private function showStone() : void
      {
         this.map.content.addChild(this.stone_mc);
         this.stone_mc.x = this.stoneSeat[this.mapIndex].x;
         this.stone_mc.y = this.stoneSeat[this.mapIndex].y;
         this.checkStoneState();
      }
      
      private function updateBlood(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readByte());
         this.currentScore = _loc2_.readUnsignedInt();
         var _loc4_:uint = uint(_loc2_.readByte());
         this.updateShowBlood();
         if(this.stone_mc)
         {
            this.checkStoneState();
         }
         if(this.currentScore == 0)
         {
            Connection.removeCommandListener(CommandSet.CLI_GET_WORLD_BOSS_BLOOD_DIMUSEN_1538,this.updateBlood);
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         }
      }
      
      private function updateShowBlood() : void
      {
         var _loc1_:Number = this.currentScore / 2000;
         if(this.bloodMc)
         {
            this.bloodMc.scaleX = _loc1_;
         }
         if(this.currentScore == 0)
         {
            DisplayObjectUtil.removeFromParent(this.bg);
            DisplayObjectUtil.removeFromParent(this.bloodMc);
         }
      }
      
      private function createStoneCup() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("StoneCup"),LoadType.SWF,this.loadComplete);
      }
      
      private function loadComplete(param1:ContentInfo) : void
      {
         this.stone_mc = param1.content["cup"] as MovieClip;
         this.stone_mc.mouseChildren = false;
         this.stone_mc.buttonMode = true;
         this.stone_mc.addEventListener(MouseEvent.CLICK,this.openPanel);
         this.bloodMc = this.stone_mc["bloodMc"];
         this.bg = this.stone_mc["wolfBloodBarBg"];
         this.updateShowBlood();
         this.showStone();
      }
      
      private function openPanel(param1:MouseEvent) : void
      {
         if(this.stone_mc.currentFrame == 5)
         {
            ShootController.close();
            ModuleManager.toggleModule(URLUtil.getAppModule("PetKingMatch2StartPanel"));
            DisplayObjectUtil.removeFromParent(this.stone_mc);
         }
         else
         {
            AlertManager.showAlert("使用头部射击和大家一起打碎它，将会有意外的收获哦！");
         }
      }
   }
}
