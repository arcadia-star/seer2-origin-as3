package com.taomee.seer2.app.processor.activity.maiMaiDiProcessAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MaiMaiDiProcessAct
   {
      
      private static const RANDOM_INDEX:int = 76;
      
      private static const COIN_SWAP:int = 2280;
      
      private static const CATCH_USE_SWAP:int = 2279;
      
      private static const DAY_LIST:Vector.<int> = Vector.<int>([938]);
      
      private static const FOR_LIST:Array = [203615,203614,203616,203618];
      
      private static const CATH_NUM_RULE:Vector.<int> = Vector.<int>([6,12]);
       
      
      private var pointNum:uint = 2;
      
      private var camera:MovieClip;
      
      private var ghost:MovieClip;
      
      private var maskMc:MovieClip;
      
      private var bgMc:MovieClip;
      
      private var grayBg:MovieClip;
      
      private var leave:SimpleButton;
      
      private var pointList:Vector.<Point>;
      
      private var _giftList:Vector.<MovieClip>;
      
      private var _canNum:int;
      
      private var _fightState:int;
      
      private var _map:MapModel;
      
      public function MaiMaiDiProcessAct(param1:MapModel)
      {
         var map:MapModel = param1;
         super();
         this._map = map;
         this.initSet();
         if(SceneManager.prevSceneType != SceneType.ARENA)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("maiMaiDiSuperProcess/MaiMaiDiSuperAct"),function():void
            {
               fightStateHandle();
            },true,false,2,true);
         }
         else
         {
            this.fightStateHandle();
         }
      }
      
      private function fightStateHandle() : void
      {
         this.forwardFilter();
         if(this._fightState == 0)
         {
            this.update();
         }
         else
         {
            Tick.instance.addRender(this.fightStateValidate,1000);
         }
      }
      
      private function fightStateValidate(param1:int) : void
      {
         var _loc2_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(Boolean(_loc2_) && _loc2_.hp > 0)
         {
            Tick.instance.removeRender(this.fightStateValidate);
            this.update();
         }
      }
      
      private function initSet() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         this.camera = this._map.front["cameraMc"];
         this.maskMc = this._map.front["maskMc"];
         this.bgMc = this._map.front["bgMc"];
         this.grayBg = this._map.front["grayBg"];
         this.ghost = this.camera["ghostMc"];
         this.ghost.gotoAndStop(1);
         this.ghost.visible = false;
         this.setGameUIShow(false);
         this._giftList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            this._giftList.push(this._map.content["gift" + _loc1_]);
            (this._giftList[_loc1_] as MovieClip).buttonMode = true;
            (this._giftList[_loc1_] as MovieClip).visible = false;
            _loc1_++;
         }
         this.leave = this._map.content["leave"];
         this.leave.addEventListener(MouseEvent.CLICK,this.onLeave);
      }
      
      private function onLeave(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function update() : void
      {
         DayLimitManager.getDoCount(DAY_LIST[0],function(param1:int):void
         {
            var val:int = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function getData(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               if(VipManager.vipInfo.isVip())
               {
                  _canNum = getCanNum(val,par.infoVec[0] + par.infoVec[1],CATH_NUM_RULE[1]);
               }
               else
               {
                  _canNum = getCanNum(val,par.infoVec[0] + par.infoVec[1],CATH_NUM_RULE[0]);
               }
               if(_canNum > 0)
               {
                  catchInit();
               }
               else
               {
                  catchDispose();
                  ModuleManager.showModule(URLUtil.getAppModule("BuyDreanCatchNumPanel"),"正在打开购买捕捉次数面板...",{"func":function():void
                  {
                     ModuleManager.closeForName("BuyDreanCatchNumPanel");
                     update();
                  }});
               }
            });
         });
      }
      
      private function setGameUIShow(param1:Boolean) : void
      {
         this.grayBg.visible = this.bgMc.visible = this.maskMc.visible = this.camera.visible = param1;
      }
      
      private function catchInit() : void
      {
         this.pointList = new Vector.<Point>();
         this.getPoint();
         this.initMouse();
         this.initUI();
         this.setGameUIShow(true);
      }
      
      private function catchDispose() : void
      {
         this.setGameUIShow(false);
         Tick.instance.removeTimeout(this.clear);
         this.stopMove();
         this.camera.removeEventListener(MouseEvent.CLICK,this.reqResult);
      }
      
      private function getPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         if(this.pointList.length != this.pointNum)
         {
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               _loc2_ = new Point();
               _loc2_.x = Math.floor(760 * Math.random()) + 100;
               _loc2_.y = Math.floor(360 * Math.random()) + 100;
               this.pointList.push(_loc2_);
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.pointNum)
            {
               _loc2_ = this.pointList[_loc1_];
               _loc2_.x = Math.floor(760 * Math.random()) + 100;
               _loc2_.y = Math.floor(360 * Math.random()) + 100;
               _loc1_++;
            }
         }
      }
      
      private function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
      
      private function stopMove() : void
      {
         if(this._map.content.stage)
         {
            this._map.content.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.moveCamera);
         }
      }
      
      private function initUI() : void
      {
         this.ghost.gotoAndStop(1);
         this.ghost.visible = false;
         this.camera.addEventListener(MouseEvent.CLICK,this.reqResult);
      }
      
      private function reqResult(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(!this.ghost.visible)
         {
            return;
         }
         this.ghost.stop();
         this.camera.removeEventListener(MouseEvent.CLICK,this.reqResult);
         ActiveCountManager.requestActiveCountList([FOR_LIST[2],FOR_LIST[3],FOR_LIST[1]],function getData(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            var index:int = int(par.infoVec[0]);
            if(index != 0)
            {
               if(index == 2)
               {
                  ModuleManager.showModule(URLUtil.getAppModule("CatchResultPanel"),"正在打开捕捉结果面板...",{
                     "index":index,
                     "func":function():void
                     {
                        catchDispose();
                        addRandomGift(par.infoVec[1]);
                     },
                     "closeBtnFuc":function():void
                     {
                        catchDispose();
                        catchInit();
                     }
                  });
               }
               else
               {
                  ModuleManager.showModule(URLUtil.getAppModule("CatchResultPanel"),"正在打开捕捉结果面板...",{
                     "index":index,
                     "closeBtnFuc":function():void
                     {
                        catchDispose();
                        update();
                     }
                  });
               }
            }
            else if(par.infoVec[2] > 0)
            {
               SwapManager.swapItem(CATCH_USE_SWAP,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  update();
               });
            }
            else
            {
               Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,getResult);
               Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_INDEX,0);
            }
         });
      }
      
      private function getResult(param1:MessageEvent) : void
      {
         var data:IDataInput;
         var index:uint;
         var id:uint;
         var evt:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.getResult);
         data = evt.message.getRawDataCopy();
         index = uint(data.readUnsignedInt());
         id = uint(data.readUnsignedInt());
         this.stopMove();
         if(id == 2)
         {
            ModuleManager.showModule(URLUtil.getAppModule("CatchResultPanel"),"正在打开捕捉结果面板...",{
               "index":id,
               "func":function():void
               {
                  ActiveCountManager.requestActiveCount(FOR_LIST[3],function(param1:uint, param2:uint):void
                  {
                     catchDispose();
                     addRandomGift(param2);
                  });
               },
               "closeBtnFuc":function():void
               {
                  catchDispose();
                  catchInit();
               }
            });
         }
         else
         {
            ModuleManager.showModule(URLUtil.getAppModule("CatchResultPanel"),"正在打开捕捉结果面板...",{
               "index":id,
               "closeBtnFuc":function():void
               {
                  catchDispose();
                  update();
               }
            });
         }
      }
      
      private function initMouse() : void
      {
         if(this._map.content.stage == null)
         {
            TweenNano.delayedCall(1,function():void
            {
               _map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE,moveCamera);
            });
         }
         else
         {
            this._map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.moveCamera);
         }
      }
      
      private function moveCamera(param1:MouseEvent) : void
      {
         if(this.camera == null)
         {
            return;
         }
         this.camera.x = this.maskMc.x = param1.stageX;
         this.camera.y = this.maskMc.y = param1.stageY;
         if(this.ghost.visible)
         {
            return;
         }
         if(Math.random() > 0.5)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.pointNum)
         {
            if(this.camera.hitTestPoint(this.pointList[_loc2_].x,this.pointList[_loc2_].y))
            {
               this.showGhost();
               break;
            }
            _loc2_++;
         }
      }
      
      private function showGhost() : void
      {
         this.ghost.visible = true;
         MovieClipUtil.playMc(this.ghost,1,this.ghost.totalFrames,this.clear);
      }
      
      private function clear() : void
      {
         Tick.instance.removeTimeout(this.clear);
         this.ghost.visible = false;
         this.ghost.gotoAndStop(1);
         this.getPoint();
      }
      
      private function forwardFilter() : void
      {
         this._fightState = 0;
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(_loc1_ != null)
         {
            if(_loc1_.hp == 0)
            {
               AlertManager.showAlert("首发精灵体力耗尽,暂时不可捕梦,以防遇到对战不可进入战斗哦!");
               this._fightState = 1;
            }
         }
         else
         {
            AlertManager.showAlert("没有设置首发精灵,暂时不可补梦,以防遇到对战不可进入战斗哦!");
            this._fightState = 2;
         }
      }
      
      private function addRandomGift(param1:int) : void
      {
         this.clearGiftList();
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            if(_loc2_ < param1)
            {
               this._giftList[_loc2_].visible = true;
               this._giftList[_loc2_].addEventListener(MouseEvent.CLICK,this.onGiftClick);
            }
            else
            {
               this._giftList[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function clearGiftList() : void
      {
         var _loc1_:int = 0;
         if(this._giftList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._giftList.length)
            {
               this._giftList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onGiftClick);
               _loc1_++;
            }
         }
      }
      
      private function onGiftClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         this.setAllGiftMouseEnable(false);
         index = this._giftList.indexOf(evt.currentTarget as MovieClip);
         SwapManager.swapItem(COIN_SWAP,1,function(param1:IDataInput):void
         {
            _giftList[index].visible = false;
            setAllGiftMouseEnable(true);
            var _loc2_:int = getShowNum();
            if(_loc2_ == 0)
            {
               update();
            }
         },function(param1:uint):void
         {
            _giftList[index].visible = false;
            setAllGiftMouseEnable(true);
         });
      }
      
      private function getShowNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._giftList.length)
         {
            if(this._giftList[_loc2_].visible == true)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function setAllGiftMouseEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._giftList.length)
         {
            this._giftList[_loc2_].mouseEnabled = this._giftList[_loc2_].mouseChildren = param1;
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         Tick.instance.removeRender(this.fightStateValidate);
         this.clearGiftList();
         this.leave.removeEventListener(MouseEvent.CLICK,this.onLeave);
         this.leave = null;
         this._giftList = null;
         this.catchDispose();
         this.camera = null;
         this.ghost = null;
         this.maskMc = null;
         this.bgMc = null;
         this.grayBg = null;
      }
   }
}
