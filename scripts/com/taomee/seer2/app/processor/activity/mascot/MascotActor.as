package com.taomee.seer2.app.processor.activity.mascot
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
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
   
   public class MascotActor extends Sprite
   {
      
      public static var _isFight:Boolean;
       
      
      private const tempGiftList:Vector.<uint> = Vector.<uint>([205007,205010,205011]);
      
      private const mcPointList:Vector.<Point> = Vector.<Point>([new Point(-290,50),new Point(-270,50),new Point(-290,50)]);
      
      private const mcCompletePointList:Vector.<Point> = Vector.<Point>([new Point(60,180),new Point(130,295),new Point(100,200)]);
      
      private const mcCheerPosList:Vector.<Point> = Vector.<Point>([new Point(490,220),new Point(335,390),new Point(590,250)]);
      
      private const mcNumPosList:Vector.<Point> = Vector.<Point>([new Point(220,155),new Point(230,95),new Point(190,150)]);
      
      private var maxBlood:uint = 30000;
      
      private var _bloodMc:MovieClip;
      
      private var _actor:MovieClip;
      
      private var _actorCompleteMC:MovieClip;
      
      private var _cheerRoleMc:MovieClip;
      
      private var _shootNumMcList:Vector.<MovieClip>;
      
      private var _teamInfo:com.taomee.seer2.app.processor.activity.mascot.MascotTeamInfo;
      
      private var _completeGiftMc:MovieClip;
      
      private var _completeGift:MovieClip;
      
      private var _completeGift2:SimpleButton;
      
      private var _thisActor:com.taomee.seer2.app.processor.activity.mascot.MascotActor;
      
      private var _fun:Function;
      
      private var _isShowPet:Boolean;
      
      private var _map:MapModel;
      
      private var forLimit:Array;
      
      private var playerBelong:int;
      
      private var idList:Array;
      
      public function MascotActor()
      {
         this.forLimit = [204720];
         this.idList = [2,3,4];
         super();
         this._teamInfo = new com.taomee.seer2.app.processor.activity.mascot.MascotTeamInfo();
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
               ServerMessager.addMessage("你还没有报名参加创世、混沌、开元队！请参加再来玩哦~");
               return;
            }
            removeMC();
            _actor = mc;
            _actor.mouseChildren = true;
            _actor.mouseEnabled = true;
            _actor.buttonMode = true;
            _actor.addEventListener(MouseEvent.CLICK,onOpenActivityPanel);
            _actor.x = mcPointList[info.id - 1].x;
            _actor.y = mcPointList[info.id - 1].y;
            if(map == null)
            {
               return;
            }
            _map = map;
            map.front.addChild(_actor);
            updateActor(map);
            setBlood(info.blood,null);
            _shootNumMcList = new Vector.<MovieClip>();
            var _loc2_:int = 0;
            while(_loc2_ < 2)
            {
               _shootNumMcList.push(MascotAnimation.getMC("numMc" + _loc2_));
               _shootNumMcList[_loc2_].visible = false;
               _shootNumMcList[_loc2_].x = mcNumPosList[info.id - 1].x;
               _shootNumMcList[_loc2_].y = mcNumPosList[info.id - 1].y;
               map.front.addChild(_shootNumMcList[_loc2_]);
               _loc2_++;
            }
         });
      }
      
      private function onOpenActivityPanel(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
         ModuleManager.showAppModule("FightLuckGoodsPanel");
      }
      
      private function setRoleCheer(param1:MapModel) : void
      {
         this._cheerRoleMc = MascotAnimation.getMC("cheer");
         this._cheerRoleMc.x = this.mcCheerPosList[this.info.id - 1].x;
         this._cheerRoleMc.y = this.mcCheerPosList[this.info.id - 1].y;
         param1.front.addChild(this._cheerRoleMc);
      }
      
      private function updateActor(param1:MapModel) : void
      {
         if(this._bloodMc == null)
         {
            this._bloodMc = MascotAnimation.getMC("blood" + this.info.id);
         }
         DisplayUtil.align(this._bloodMc,4,LayerManager.rootRect,new Point(0,-200));
         param1.front.addChild(this._bloodMc);
         this._bloodMc.gotoAndStop(1);
         ShootController.addEventListener(ShootEvent.SERVER_LEFT_PLAY_START,this.onServerStart);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShoot);
      }
      
      private function onServerStart(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(this._actor.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y) && this.playerBelong != this.info.id)
         {
            ShootController.shootId = this.idList[this.info.id - 1];
         }
      }
      
      private function onShoot(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(this._actor.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            if(this.playerBelong != this.info.id)
            {
               if(_loc2_.userID == ActorManager.actorInfo.id)
               {
                  this._actor.gotoAndPlay(2);
                  this._bloodMc["car"].gotoAndPlay(2);
                  this.playNumMc(this._map);
               }
               ShootController.shootId = 0;
            }
            else
            {
               AlertManager.showAlert("你不能攻击自己队伍的吉祥物哟！");
            }
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
      
      public function setComplete(param1:MovieClip, param2:MapModel, param3:int) : void
      {
         this.showComplete(param1,param2);
      }
      
      public function setShowPet(param1:Boolean) : void
      {
         this._isShowPet = param1;
      }
      
      private function showComplete(param1:MovieClip, param2:MapModel) : void
      {
         var mc:MovieClip = param1;
         var map:MapModel = param2;
         this.removeMC();
         this._actorCompleteMC = mc;
         this._actorCompleteMC.x = this.mcCompletePointList[this.info.id - 1].x;
         this._actorCompleteMC.y = this.mcCompletePointList[this.info.id - 1].y;
         this._completeGiftMc = this._actorCompleteMC["completeGiftMc"];
         this._completeGift = this._actorCompleteMC["completeGift"];
         this._completeGift2 = this._actorCompleteMC["completeGift2"];
         this._completeGift.buttonMode = true;
         this._completeGiftMc.visible = false;
         this._completeGift.visible = true;
         this._completeGift2.visible = false;
         ActiveCountManager.requestActiveCount(this.tempGiftList[this.info.id - 1],function(param1:int, param2:int):void
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
         SwapManager.swapItem(3343,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            _completeGift2.visible = false;
         },null,new SpecialInfo(1,this.info.id));
      }
      
      private function onGift(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.info.id == this.playerBelong)
         {
            AlertManager.showAlert("你不能拿自己基地的礼包哟。");
            return;
         }
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
         DisplayUtil.removeForParent(this._actor);
         DisplayUtil.removeForParent(this._actorCompleteMC);
         DisplayUtil.removeForParent(this._bloodMc);
         DisplayUtil.removeForParent(this._cheerRoleMc);
      }
      
      public function getTeamStatus(param1:Function) : void
      {
         this._fun = param1;
         Connection.addCommandListener(CommandSet.GET_TEAM_BLOOD_1227,this.onGetTeamStatus);
         Connection.send(CommandSet.GET_TEAM_BLOOD_1227);
      }
      
      private function onGetTeamStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_TEAM_BLOOD_1227,this.onGetTeamStatus);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:uint = uint(_loc2_.readUnsignedInt());
         var _loc7_:uint = uint(_loc2_.readUnsignedInt());
         var _loc8_:uint = uint(_loc2_.readUnsignedInt());
         switch(this._teamInfo.mapId)
         {
            case 40:
               this._teamInfo.id = 1;
               this._teamInfo.blood = _loc3_;
               this._teamInfo.status = _loc4_;
               break;
            case 30:
               this._teamInfo.id = 2;
               this._teamInfo.blood = _loc5_;
               this._teamInfo.status = _loc6_;
               break;
            case 81:
               this._teamInfo.id = 3;
               this._teamInfo.blood = _loc7_;
               this._teamInfo.status = _loc8_;
         }
         this._fun();
         this._fun = null;
      }
      
      public function setThisActor(param1:com.taomee.seer2.app.processor.activity.mascot.MascotActor) : void
      {
         this._thisActor = param1;
      }
      
      public function get info() : com.taomee.seer2.app.processor.activity.mascot.MascotTeamInfo
      {
         return this._teamInfo;
      }
      
      public function dispose() : void
      {
         this.removeMC();
         ShootController.removeEventListener(ShootEvent.SERVER_LEFT_PLAY_START,this.onServerStart);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShoot);
         Connection.removeCommandListener(CommandSet.GET_TEAM_BLOOD_1227,this.onGetTeamStatus);
      }
   }
}
