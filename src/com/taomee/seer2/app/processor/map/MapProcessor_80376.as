package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80376 extends MapProcessor
   {
      
      public static var fightId:int = 0;
       
      
      private var _npc:MovieClip;
      
      private var _cd:int;
      
      private var _thing:int = -1;
      
      private var jiangjunnum:int;
      
      private var fensinum:int;
      
      private var hanveCuMeimao:int;
      
      private var times:int;
      
      private var buytimes:int;
      
      private var DAYTIME:int = 1527;
      
      private var DAYCD:int = 1528;
      
      private var THINGFOR:int = 205355;
      
      private var BUYTIMEFOR:int = 205356;
      
      private var JIANGJUNLINGFOR:int = 205357;
      
      private var FENGSIFOR:int = 205358;
      
      private var HAVEGETCUFOR:int = 205359;
      
      private var FIGHT1:int = 1428;
      
      private var FIGHT2:int = 1429;
      
      private var _leaveTime:int;
      
      private var _haveCD:Boolean;
      
      private var _playIt:int;
      
      private var _eggFollow:Mobile;
      
      public function MapProcessor_80376(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(MapProcessor_80376.fightId == 0)
         {
            this.sendWin();
         }
         ActorManager.getActor().removeCarriedMobile(this._eggFollow);
         super.dispose();
      }
      
      private function sendWin() : void
      {
         if(this.hanveCuMeimao != 1)
         {
            return;
         }
         SwapManager.swapItem(3576,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            ModuleManager.showModule(URLUtil.getAppModule("CuMeiMaoMainPanel"),"正在打开面板...",{"func":update});
         },null,null);
      }
      
      override public function init() : void
      {
         this.update();
         this.createNpc();
         this._playIt = 0;
         this._eggFollow = new Mobile();
         this._eggFollow.resourceUrl = URLUtil.getPetSwf(849);
         ActorManager.getActor().addCarriedMobile(this._eggFollow,120);
         this._eggFollow.setPostion(new Point(ActorManager.getActor().x + 120,ActorManager.getActor().y));
         _map.content["timeMc"].visible = false;
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = _map.content["npc1025"];
            this._npc.gotoAndStop(1);
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep2Continue);
            _map.content.setChildIndex(this._npc,0);
         }
      }
      
      private function update() : void
      {
         DayLimitManager.getDoCount(this.DAYTIME,function(param1:int):void
         {
            var val:int = param1;
            times = 10 - val;
            DayLimitManager.getDoCount(DAYCD,function(param1:int):void
            {
               var val2:int = param1;
               _cd = val2;
               ActiveCountManager.requestActiveCountList([THINGFOR,BUYTIMEFOR,JIANGJUNLINGFOR,FENGSIFOR,HAVEGETCUFOR],function(param1:Parser_1142):void
               {
                  _thing = param1.infoVec[0];
                  buytimes = param1.infoVec[1];
                  times += buytimes;
                  jiangjunnum = param1.infoVec[2];
                  fensinum = param1.infoVec[3];
                  hanveCuMeimao = param1.infoVec[4];
                  fensinum = 0;
                  if(ItemManager.getItemByReferenceId(401100))
                  {
                     fensinum = ItemManager.getItemByReferenceId(401100).quantity;
                  }
                  jiangjunnum = 0;
                  if(ItemManager.getItemByReferenceId(401099))
                  {
                     jiangjunnum = ItemManager.getItemByReferenceId(401099).quantity;
                  }
                  _leaveTime = _cd - TimeManager.getPrecisionServerTime();
                  if(_cd == 0)
                  {
                     _map.content["timeMc"].visible = false;
                     _haveCD = false;
                  }
                  else if(_leaveTime <= 0)
                  {
                     if(_map.content)
                     {
                        _map.content["timeMc"].visible = false;
                     }
                     _haveCD = false;
                  }
                  else
                  {
                     if(_map.content)
                     {
                        _map.content["timeMc"].visible = true;
                     }
                     _haveCD = true;
                     Tick.instance.removeRender(updateTime);
                     updateTimeShow();
                     Tick.instance.addRender(updateTime,1000);
                  }
                  if(_playIt == 1)
                  {
                     _playIt = 0;
                     _npc.visible = false;
                     _map.front.addEventListener(Event.ENTER_FRAME,onFr);
                     if(_thing == 1)
                     {
                        thing1();
                        _map.front["mtom"].gotoAndPlay(2);
                     }
                     else if(_thing == 2)
                     {
                        thing2();
                        _map.front["mtox"].gotoAndPlay(2);
                     }
                     else if(_thing == 3)
                     {
                        thing3();
                        _map.front["mtox"].gotoAndPlay(2);
                     }
                     else if(_thing == 4)
                     {
                        thing4();
                        _map.front["mtox"].gotoAndPlay(2);
                     }
                     else if(_thing == 5)
                     {
                        thing5();
                        _map.front["mtox"].gotoAndPlay(2);
                     }
                  }
                  createNpc();
                  if(_thing == 0)
                  {
                     _npc.gotoAndStop(1);
                  }
                  else if(_thing == 1)
                  {
                     _npc.gotoAndStop(3);
                  }
                  else
                  {
                     _npc.gotoAndStop(2);
                  }
               });
            });
         });
      }
      
      private function onFr(param1:Event) : void
      {
         if(_map.front["mtox"].currentFrame == _map.front["mtox"].totalFrames)
         {
            this._npc.visible = true;
            _map.front.removeEventListener(Event.ENTER_FRAME,this.onFr);
         }
         if(_map.front["mtom"].currentFrame == _map.front["mtom"].totalFrames)
         {
            this._npc.visible = true;
            _map.front.removeEventListener(Event.ENTER_FRAME,this.onFr);
         }
      }
      
      private function updateTime(param1:int) : void
      {
         --this._leaveTime;
         this.updateTimeShow();
         if(this._leaveTime <= 0)
         {
            if(_map.content)
            {
               _map.content["timeMc"].visible = false;
            }
            this._haveCD = false;
            Tick.instance.removeRender(this.updateTime);
         }
      }
      
      private function updateTimeShow() : void
      {
         if(_map.content)
         {
            _map.content["timeMc"]["bar"].gotoAndStop(int(this._leaveTime * 100 / 120));
            _map.content["timeMc"]["timess"].text = "" + this.styleChange(this._leaveTime);
         }
      }
      
      public function styleChange(param1:int) : String
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc2_:int = param1 / 60;
         var _loc4_:int = param1 % 60;
         if(_loc2_ <= 9)
         {
            _loc3_ = "0" + String(_loc2_);
         }
         else
         {
            _loc3_ = String(_loc2_);
         }
         if(_loc4_ <= 9)
         {
            _loc5_ = "0" + String(_loc4_);
         }
         else
         {
            _loc5_ = String(_loc4_);
         }
         return _loc3_ + ":" + _loc5_;
      }
      
      private function fightOver(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.getPositionIndex() != this.FIGHT2 && FightManager.getPositionIndex() != this.FIGHT1)
            {
               return;
            }
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.fightOver);
            MapProcessor_80376.fightId = 0;
            SceneManager.changeScene(SceneType.LOBBY,70);
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               ServerMessager.addMessage("战斗胜利!");
            }
            else if(FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               ServerMessager.addMessage("战斗失败!");
            }
         }
      }
      
      private function initStep2Continue(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this._thing >= 0)
         {
            if(this._thing == 0)
            {
               if(this._haveCD)
               {
                  ServerMessager.addMessage("时间未到请等待!");
                  return;
               }
               if(this.times <= 0)
               {
                  ServerMessager.addMessage("次数不够!");
                  ShopManager.buyItemForId(605321,function():void
                  {
                     update();
                  });
                  return;
               }
               this._playIt = 1;
               SwapManager.swapItem(3568,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  update();
               },null,null);
            }
            else if(this._thing == 1)
            {
               this.thing1();
            }
            else if(this._thing == 2)
            {
               this.thing2();
            }
            else if(this._thing == 3)
            {
               this.thing3();
            }
            else if(this._thing == 4)
            {
               this.thing4();
            }
            else if(this._thing == 5)
            {
               this.thing5();
            }
         }
      }
      
      private function thing1() : void
      {
         if(this.jiangjunnum == 0)
         {
            NpcDialog.show(1029," 大将军",[[0,"哦？好粗的眉毛！"]],["恩",""],[function():void
            {
               NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
               {
                  NpcDialog.show(1029,"大将军",[[0,"好好好，粉丝，那我就不客套了，你带来了我的签名令牌了吗？有1个令牌我的阿兹尔会更屈服与你，会容易战胜，胜利后你就能得到粉丝印记"]],[" 我还没有 ",""],[function():void
                  {
                     NpcDialog.show(1029,"大将军",[[0,"那你可以过会儿再来找我，完成一些简单的事情我会给你一些，你也可以现在和我挑战，胜利了也能得到奖励。"]],[" 直接挑战 ","过会儿再来 "],[function():void
                     {
                        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,fightOver);
                        MapProcessor_80376.fightId = 1;
                        FightManager.startFightWithWild(FIGHT1);
                     },function():void
                     {
                     }]);
                  },function():void
                  {
                  }]);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
            return;
         }
         NpcDialog.show(1030,"大将军",[[0,"哦？好粗的眉毛！"]],["恩",""],[function():void
         {
            NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
            {
               NpcDialog.show(1030,"大将军",[[0,"好好好，粉丝，那我就不客套了，你带来了我的签名令牌了吗？<font color=\'#ff0000\'> 有1个令牌</font>我的阿兹尔会更屈服与你，你会更容易战胜它，胜利后你就能得到<font color=\'#ff0000\'>粉丝印记</font>"]],[" 我有令牌（已拥有 " + jiangjunnum + " 个）",""],[function():void
               {
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,fightOver);
                  MapProcessor_80376.fightId = 1;
                  FightManager.startFightWithWild(FIGHT1);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
         },function():void
         {
         }]);
      }
      
      private function thing2() : void
      {
         NpcDialog.show(1030,"大将军",[[0,"休息的时候也不让我清闲啊"]],["恩",""],[function():void
         {
            NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
            {
               NpcDialog.show(1030,"大将军",[[0,"你真的是我的粉丝吗？最近冒充我粉丝的太多了，在这个明星相册里先找到我再讲。"]],["我货真价实",""],[function():void
               {
                  SwapManager.swapItem(3569,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     ModuleManager.showModule(URLUtil.getAppModule("CuGameGameZhaoPanel"),"打开保护的挑战面板...",{"func":update});
                     update();
                  },null,null);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
         },function():void
         {
         }]);
      }
      
      private function thing3() : void
      {
         NpcDialog.show(1030,"大将军",[[0,"休息的时候也不让我清闲啊"]],["恩",""],[function():void
         {
            NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
            {
               NpcDialog.show(1030,"大将军",[[0,"你真的是我的粉丝吗？你知道我精灵是谁吗？你最好先了解一下它再说"]],["我货真价实",""],[function():void
               {
                  SwapManager.swapItem(3571,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     ModuleManager.showModule(URLUtil.getAppModule("CuGameTieMuPanel"),"打开保护的挑战面板...",{"func":update});
                     update();
                  },null,null);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
         },function():void
         {
         }]);
      }
      
      private function thing4() : void
      {
         NpcDialog.show(1030,"大将军:",[[0,"休息的时候也不让我清闲啊"]],["恩",""],[function():void
         {
            NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
            {
               NpcDialog.show(1030,"大将军",[[0,"可以啊！不如你跟着我练练看"]],["我货真价实",""],[function():void
               {
                  SwapManager.swapItem(3573,1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     ModuleManager.showModule(URLUtil.getAppModule("CuGameThreePanel"),"打开保护的挑战面板...");
                     update();
                  },null,null);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
         },function():void
         {
         }]);
      }
      
      private function thing5() : void
      {
         NpcDialog.show(1030,"大将军",[[0,"休息的时候也不让我清闲啊"]],["恩",""],[function():void
         {
            NpcDialog.show(838,"粗眉毛",[[0,"将大军，你……我……我是你的粉丝，（激动的语无伦次了……），你看我能有幸得到你的指导吗？"]],["恩",""],[function():void
            {
               NpcDialog.show(1030,"大将军",[[0,"人有三急……我暂时不能指导你了，我的精灵阿兹尔可以先和你切磋下"]],["我货真价实",""],[function():void
               {
                  MapProcessor_80376.fightId = 1;
                  SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,fightOver);
                  FightManager.startFightWithWild(FIGHT2);
               },function():void
               {
               }]);
            },function():void
            {
            }]);
         },function():void
         {
         }]);
      }
   }
}
