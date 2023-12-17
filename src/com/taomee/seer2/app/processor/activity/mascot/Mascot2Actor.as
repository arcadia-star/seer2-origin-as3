package com.taomee.seer2.app.processor.activity.mascot
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class Mascot2Actor extends Sprite
   {
       
      
      private const tempGiftList:Vector.<uint> = Vector.<uint>([205954]);
      
      private const mcPointList:Vector.<Point> = Vector.<Point>([new Point(450,180)]);
      
      private const mcCompletePointList:Vector.<Point> = Vector.<Point>([new Point(160,250)]);
      
      private const mcNumPosList:Vector.<Point> = Vector.<Point>([new Point(350,220)]);
      
      private const posTip:Point = new Point(790,560);
      
      private var maxBlood:uint = 100000;
      
      private var _bloodMc:MovieClip;
      
      private var _actor:MovieClip;
      
      private var _actorCompleteMC:MovieClip;
      
      private var _shootNumMcList:Vector.<MovieClip>;
      
      private var _teamInfo:Mascot2Info;
      
      private var _completeGiftMc:MovieClip;
      
      private var _completeGift:MovieClip;
      
      private var _completeGift2:SimpleButton;
      
      private var _fun:Function;
      
      private var _map:MapModel;
      
      private var forLimit:Array;
      
      private var playerBelong:int;
      
      private var idList:Array;
      
      private var _count:int = 0;
      
      public function Mascot2Actor()
      {
         this.forLimit = [250351];
         this.idList = [5];
         super();
         this._teamInfo = new Mascot2Info();
      }
      
      public function setActor(param1:MovieClip, param2:MapModel) : void
      {
         var mc:MovieClip = param1;
         var map:MapModel = param2;
         ActiveCountManager.requestActiveCountList(this.forLimit,function(param1:Parser_1142):void
         {
            playerBelong = param1.infoVec[0];
            if(playerBelong == 0)
            {
               ServerMessager.addMessage("你还没有报名参加雷影、超炎、神咒队！请参加再来玩哦~");
               return;
            }
            removeMC();
            _actor = mc;
            _actor.x = mcPointList[0].x;
            _actor.y = mcPointList[0].y;
            if(map == null)
            {
               return;
            }
            SeatTipsManager.registerSeat(posTip,10);
            _map = map;
            map.front.addChild(_actor);
            updateActor(map);
            setBlood(info.blood,null);
            _shootNumMcList = new Vector.<MovieClip>();
            var _loc2_:int = 0;
            while(_loc2_ < 2)
            {
               _shootNumMcList.push(Mascot2Animation.getMC("numMc" + _loc2_));
               _shootNumMcList[_loc2_].visible = false;
               _shootNumMcList[_loc2_].x = mcNumPosList[0].x;
               _shootNumMcList[_loc2_].y = mcNumPosList[0].y;
               map.front.addChild(_shootNumMcList[_loc2_]);
               _loc2_++;
            }
         });
      }
      
      private function onOpenActivityPanel(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
         ModuleManager.showAppModule("Mascot2Panel");
      }
      
      private function updateActor(param1:MapModel) : void
      {
         if(this._bloodMc == null)
         {
            this._bloodMc = Mascot2Animation.getMC("blood0");
         }
         DisplayUtil.align(this._bloodMc,4,LayerManager.rootRect,new Point(-300,-150));
         param1.front.addChild(this._bloodMc);
         this._bloodMc.gotoAndStop(1);
         ShootController.addEventListener(ShootEvent.SERVER_LEFT_PLAY_START,this.onServerStart);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShoot);
      }
      
      private function onServerStart(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(this._actor.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            ShootController.shootId = this.idList[0];
         }
      }
      
      private function onShoot(param1:ShootEvent) : void
      {
         var event:ShootEvent = param1;
         var shootInfo:ShootInfo = event.info;
         if(this._actor.hitTestPoint(shootInfo.endPos.x,shootInfo.endPos.y))
         {
            if(shootInfo.userID == ActorManager.actorInfo.id)
            {
               this._actor.gotoAndPlay(2);
               this._bloodMc["car"].gotoAndPlay(2);
               this.playNumMc(this._map);
               if(this._count > 0)
               {
                  return;
               }
               ActiveCountManager.requestActiveCount(205955,function(param1:int, param2:int):void
               {
                  _count = param2;
                  if(_count <= 0)
                  {
                     SwapManager.swapItem(4137);
                  }
               });
            }
            ShootController.shootId = 0;
         }
      }
      
      private function playNumMc(param1:MapModel) : void
      {
         var idx:int = 0;
         var map:MapModel = param1;
         idx = 0;
         if(VipManager.vipInfo.isVip())
         {
            idx = 1;
         }
         this._shootNumMcList[idx].visible = true;
         MovieClipUtil.playMc(this._shootNumMcList[idx],2,this._shootNumMcList[idx].totalFrames,function():void
         {
            _shootNumMcList[idx].visible = false;
         });
      }
      
      public function setBlood(param1:uint, param2:MapModel) : void
      {
         if(param1 > this.maxBlood)
         {
            param1 = this.maxBlood;
         }
         var _loc3_:uint = uint(35 - int(param1 / this.maxBlood * 35));
         if(_loc3_ == 0)
         {
            _loc3_ = 1;
         }
         if(Boolean(this._actor) && Boolean(this._actor.parent))
         {
            this._bloodMc["blood"].gotoAndStop(_loc3_);
         }
      }
      
      public function setComplete(param1:MovieClip, param2:MapModel) : void
      {
         this.showComplete(param1,param2);
      }
      
      private function showComplete(param1:MovieClip, param2:MapModel) : void
      {
         var mc:MovieClip = param1;
         var map:MapModel = param2;
         this.removeMC();
         this._actorCompleteMC = mc;
         this._actorCompleteMC.x = this.mcCompletePointList[0].x;
         this._actorCompleteMC.y = this.mcCompletePointList[0].y;
         this._completeGiftMc = this._actorCompleteMC["completeGiftMc"];
         this._completeGift = this._actorCompleteMC["completeGift"];
         this._completeGift2 = this._actorCompleteMC["completeGift2"];
         this._completeGift.buttonMode = true;
         this._completeGiftMc.visible = false;
         this._completeGift.visible = true;
         this._completeGift2.visible = false;
         ActiveCountManager.requestActiveCount(this.tempGiftList[0],function(param1:int, param2:int):void
         {
            if(param2 != 0 && param2 - TimeManager.getServerTime() > 0)
            {
               _completeGift.visible = false;
            }
         });
         this._completeGift.addEventListener(MouseEvent.CLICK,this.onGift);
         this._completeGift2.addEventListener(MouseEvent.CLICK,this.onGift2);
         if(Boolean(map) && Boolean(map.front))
         {
            map.front.addChild(this._actorCompleteMC);
         }
      }
      
      private function onGift2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SwapManager.swapItem(4135,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            _completeGift2.visible = false;
         },null,new SpecialInfo(1,this.info.id));
      }
      
      private function onGift(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._completeGift.visible = false;
         this._completeGiftMc.visible = true;
         MovieClipUtil.playMc(this._completeGiftMc,2,this._completeGiftMc.totalFrames,function():void
         {
            _completeGiftMc.visible = false;
            _completeGift2.visible = true;
         });
      }
      
      private function removeMC() : void
      {
         SeatTipsManager.removeSeat(this.posTip,10);
         DisplayUtil.removeForParent(this._actor);
         DisplayUtil.removeForParent(this._actorCompleteMC);
         DisplayUtil.removeForParent(this._bloodMc);
      }
      
      public function getTeamStatus(param1:Function) : void
      {
         this._fun = param1;
         Connection.addCommandListener(CommandSet.CLI_GET_MASCOT_BLOOD_AND_STATE_1566,this.onGetTeamStatus);
         Connection.send(CommandSet.CLI_GET_MASCOT_BLOOD_AND_STATE_1566);
      }
      
      private function onGetTeamStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.CLI_GET_MASCOT_BLOOD_AND_STATE_1566,this.onGetTeamStatus);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         this._teamInfo.id = 1;
         this._teamInfo.blood = _loc3_;
         this._teamInfo.status = _loc4_;
         this._fun();
         this._fun = null;
      }
      
      public function get info() : Mascot2Info
      {
         return this._teamInfo;
      }
      
      public function dispose() : void
      {
         this.removeMC();
         ShootController.removeEventListener(ShootEvent.SERVER_LEFT_PLAY_START,this.onServerStart);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShoot);
         Connection.removeCommandListener(CommandSet.CLI_GET_MASCOT_BLOOD_AND_STATE_1566,this.onGetTeamStatus);
      }
   }
}
