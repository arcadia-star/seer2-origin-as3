package com.taomee.seer2.app.processor.activity.sLianYuAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.Tick;
   
   public class SLianYuAct
   {
      
      private static var _npc:Mobile;
      
      private static var _sTaskUI:MovieClip;
      
      private static var _overBtn:SimpleButton;
      
      private static var _timeTxt:TextField;
      
      private static var _finishNum:TextField;
      
      private static var _completeList:Vector.<MovieClip>;
      
      private static var _sNextTip:MovieClip;
      
      private static const FOR_LIST:Array = [205786,205787];
      
      private static const DAY_LIST:Array = [1698];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3962,3963,3964,3967,3965]);
      
      private static const MAP_LIST:Vector.<int> = Vector.<int>([80463,80462]);
      
      private static var _resLib:ApplicationDomain;
      
      private static var _curIndex:int;
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
      
      private static var _leaveTime:int;
      
      private static var _clickNum:int;
      
      private static var _mouseHint:MouseClickHintSprite;
       
      
      public function SLianYuAct()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(!isInAct())
         {
            return;
         }
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
      }
      
      private static function isInAct() : Boolean
      {
         var _loc1_:Boolean = false;
         if(DateUtil.isInTime(new Date(2015,4,1),new Date(2015,5,4,23,59,59)))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private static function onStart(param1:SceneEvent) : void
      {
         if(_resLib)
         {
            dispose();
         }
      }
      
      private static function onComplete(param1:SceneEvent = null) : void
      {
         var evt:SceneEvent = param1;
         if(MAP_LIST.indexOf(SceneManager.prevMapID) != -1)
         {
            dispose();
         }
         _curIndex = MAP_LIST.indexOf(SceneManager.active.mapID);
         if(_curIndex == -1)
         {
            return;
         }
         update(function():void
         {
            if(_curIndex == 1)
            {
               DisplayObjectUtil.removeFromParent(_sTaskUI);
               if(_par.infoVec[0] != 0)
               {
                  addNpc();
                  _npc.addEventListener(MouseEvent.CLICK,onNpc1);
               }
               else
               {
                  addNpc();
                  _npc.addEventListener(MouseEvent.CLICK,onNpc);
               }
            }
            if(_curIndex == 0)
            {
               if(_par.infoVec[0] == 0)
               {
                  return;
               }
               if(!_resLib)
               {
                  getURL(function():void
                  {
                     update(gameStepHandle);
                  });
               }
               else
               {
                  gameStepHandle();
               }
            }
         });
      }
      
      private static function onUpdate(param1:LogicEvent) : void
      {
         onComplete();
      }
      
      private static function gameStepHandle() : void
      {
         taskStateUiInit();
         updateTaskState();
      }
      
      private static function updateTaskState() : void
      {
         update(function():void
         {
            taskStateUiUpdate();
            taskStepHandle();
         });
      }
      
      private static function taskStateUiInit() : void
      {
         _sTaskUI = getMovie("STaskUI");
         _sTaskUI.x = 20;
         _sTaskUI.y = 280;
         LayerManager.uiLayer.addChild(_sTaskUI);
         _overBtn = _sTaskUI["overBtn"];
         _timeTxt = _sTaskUI["timeTxt"];
         _finishNum = _sTaskUI["finishNum"];
         _completeList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            _completeList.push(_sTaskUI["complete" + _loc1_]);
            _loc1_++;
         }
         _sNextTip = getMovie("SNextTip");
         _sNextTip.x = 529 + 85;
         _sNextTip.y = 461 + 85;
         _sNextTip.buttonMode = true;
         _clickNum = 0;
         _overBtn.addEventListener(MouseEvent.CLICK,onOver);
         ModelLocator.getInstance().addEventListener(LogicEvent.S_LIANYU_CLICK,onClickAdd);
      }
      
      private static function onClickAdd(param1:LogicEvent) : void
      {
         LayerManager.topLayer.addChild(_sTaskUI);
         ++_clickNum;
         updateClickNum();
      }
      
      private static function onOver(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         AlertManager.showConfirm("你确认结束任务吗？结束任务不会扣除任务次数哦。",function():void
         {
            SwapManager.swapItem(SWAP_LIST[3],1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               new SwapInfo(data);
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("SLianYuActPanel");
               });
            });
         });
      }
      
      private static function taskStateUiUpdate() : void
      {
         updateTime();
         updateClickNum();
         updateTaskFinish();
      }
      
      private static function taskStepHandle() : void
      {
         if(_info.getCount(DAY_LIST[0]) == 0)
         {
            playSceneMc(getMovie("Scene0"),function():void
            {
               ModuleManager.showAppModule("SLianYuActGamePanel",{"func":function():void
               {
                  updateTaskState();
               }});
            });
         }
         if(_info.getCount(DAY_LIST[0]) == 1)
         {
            playSceneMc(getMovie("Scene1"),function():void
            {
               _finishNum.text = "0/10";
               ModuleManager.showAppModule("SLianYuActClickPanel",{"func":function():void
               {
                  updateTaskState();
               }});
            });
         }
         if(_info.getCount(DAY_LIST[0]) == 2)
         {
            _finishNum.text = "10/10";
            SceneManager.active.mapModel.content.addChild(_sNextTip);
            showMouseHintAtMonster(_sNextTip);
            _sNextTip.addEventListener(MouseEvent.CLICK,onGoFinish);
         }
      }
      
      private static function onGoFinish(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,MAP_LIST[1]);
      }
      
      private static function playSceneMc(param1:MovieClip, param2:Function = null) : void
      {
         var res:MovieClip = param1;
         var callBack:Function = param2;
         SceneManager.active.mapModel.front.addChild(res);
         res.x = 580;
         res.y = 310;
         MovieClipUtil.playMc(res,2,res.totalFrames,function():void
         {
            DisplayUtil.removeForParent(res);
            res = null;
            if(callBack != null)
            {
               callBack();
            }
         },true);
      }
      
      private static function updateTime() : void
      {
         Tick.instance.removeRender(onTimeUpdate);
         _leaveTime = _par.infoVec[0] - TimeManager.getPrecisionServerTime();
         if(_leaveTime < 0)
         {
            _leaveTime = 0;
         }
         _timeTxt.text = DateUtil.getMS(_leaveTime);
         if(_leaveTime > 0)
         {
            Tick.instance.addRender(onTimeUpdate,1000);
         }
      }
      
      private static function updateClickNum() : void
      {
         _finishNum.text = _clickNum + "/10";
      }
      
      private static function updateTaskFinish() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 2)
         {
            if(_info.getCount(DAY_LIST[0]) > _loc1_)
            {
               _completeList[_loc1_].visible = true;
            }
            else
            {
               _completeList[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private static function onTimeUpdate(param1:int) : void
      {
         --_leaveTime;
         _timeTxt.text = DateUtil.getMS(_leaveTime);
         if(_leaveTime <= 0)
         {
            Tick.instance.removeRender(onTimeUpdate);
         }
      }
      
      private static function getURL(param1:Function = null) : void
      {
         var callBack:Function = param1;
         QueueLoader.load(URLUtil.getActivityAnimation("SLianYuAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            if(callBack != null)
            {
               callBack();
            }
         });
      }
      
      private static function getMovie(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return DomainUtil.getMovieClip(param1,_resLib);
         }
         return null;
      }
      
      private static function addNpc() : void
      {
         _npc = new Mobile();
         _npc.width = 82;
         _npc.height = 100;
         _npc.setPostion(new Point(810,510));
         _npc.resourceUrl = URLUtil.getNpcSwf(14);
         _npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npc.label = "S";
         _npc.labelImage.y = -_npc.height - 10;
         _npc.buttonMode = true;
         showMouseHintAtMonster(_npc);
         MobileManager.addMobile(_npc,MobileType.NPC);
      }
      
      private static function removeNpc() : void
      {
         if(_npc)
         {
            removeMouseHint();
            _npc.removeEventListener(MouseEvent.CLICK,onNpc);
            _npc.removeEventListener(MouseEvent.CLICK,onNpc1);
            DisplayUtil.removeForParent(_npc);
            _npc = null;
         }
      }
      
      private static function onNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(14,"S",[[2,"炼狱大门被雾霾笼罩，我的思念体因为受到神秘黑影的惊吓，身陷危难，小赛尔你愿意去帮助它吗？时间不多，你要尽快回来！"]],["我这就去","那什么……"],[function():void
         {
            SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               removeNpc();
               SceneManager.changeScene(SceneType.COPY,MAP_LIST[0]);
            });
         }]);
      }
      
      private static function onNpc1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(14,"S",[[1,"谢谢你帮我找回思念体，他们寄托着我对爸爸的思念，是我生命最宝贝的东西，谢谢你！"]],["不客气啦"],[function():void
         {
            update(function():void
            {
               if(TimeManager.getPrecisionServerTime() <= _par.infoVec[0])
               {
                  SwapManager.swapItem(SWAP_LIST[4],1,function(param1:IDataInput):void
                  {
                     var data:IDataInput = param1;
                     new SwapInfo(data);
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(2,function():void
                     {
                        ModuleManager.showAppModule("SLianYuActPanel");
                     });
                  },null,new SpecialInfo(1,1));
               }
               else
               {
                  ModuleManager.showAppModule("SLianYuActFailPanel");
               }
            });
         }]);
      }
      
      private static function showMouseHintAtMonster(param1:Sprite) : void
      {
         _mouseHint = new MouseClickHintSprite();
         _mouseHint.y = -80;
         _mouseHint.x = 0;
         param1.addChild(_mouseHint);
      }
      
      private static function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(_mouseHint);
         _mouseHint = null;
      }
      
      private static function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               if(callBack != null)
               {
                  callBack();
               }
            });
         });
      }
      
      private static function dispose() : void
      {
         Tick.instance.removeRender(onTimeUpdate);
         removeNpc();
         removeMouseHint();
         if(_sTaskUI)
         {
            DisplayObjectUtil.removeFromParent(_sTaskUI);
            _sTaskUI = null;
         }
         if(_overBtn)
         {
            _overBtn.removeEventListener(MouseEvent.CLICK,onOver);
            _overBtn = null;
         }
         ModelLocator.getInstance().removeEventListener(LogicEvent.S_LIANYU_CLICK,onClickAdd);
         ModelLocator.getInstance().removeEventListener(LogicEvent.S_LIANYU_UPDATE,onUpdate);
         _timeTxt = null;
         _finishNum = null;
         _completeList = null;
         _sNextTip = null;
      }
   }
}
