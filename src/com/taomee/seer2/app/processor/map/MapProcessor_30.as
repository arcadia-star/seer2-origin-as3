package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_30 extends TitleMapProcessor
   {
       
      
      private var _referenceOne:MovieClip;
      
      private var _referenceTwo:MovieClip;
      
      private var _referenceThree:MovieClip;
      
      private var _referenceFour:MovieClip;
      
      private var _referenceFive:MovieClip;
      
      private var _referenceSix:MovieClip;
      
      private var _bigScreen:MovieClip;
      
      private var _screenClickCount:int = 0;
      
      private var _twoYearNpc:Mobile;
      
      private var _oldNpc:Mobile;
      
      private const DAY_LIST:Array = [5190,5192];
      
      private const SWAP_LIST:Vector.<int> = Vector.<int>([4199]);
      
      private const TASK_FINISH_FOV:int = 202496;
      
      private var timeId:int;
      
      public function MapProcessor_30(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMascot();
         this.initActivity();
         ModelLocator.getInstance().addEventListener(LogicEvent.TRAINER_PK_UPDATE,this.initTwoYearNpcHandle);
      }
      
      private function initMascot() : void
      {
      }
      
      private function initReference() : void
      {
         var _loc1_:Vector.<MovieClip> = null;
         this._referenceOne = _map.content["referenceOne"];
         this._referenceTwo = _map.content["referenceTwo"];
         this._referenceThree = _map.content["referenceThree"];
         this._referenceFour = _map.content["referenceFour"];
         this._referenceFive = _map.content["referenceFive"];
         this._referenceSix = _map.content["referenceSix"];
         var _loc2_:int = 0;
         _loc1_ = Vector.<MovieClip>([this._referenceOne,this._referenceTwo,this._referenceThree,this._referenceFour,this._referenceFive,this._referenceSix]);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            initInteractor(_loc1_[_loc2_]);
            _loc1_[_loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.onReferenceOver);
            _loc1_[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.offReferenceOver);
            _loc2_++;
         }
      }
      
      private function onReferenceOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      private function offReferenceOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      private function intScreen() : void
      {
         this._bigScreen = _map.content["bigScreen"];
         initInteractor(this._bigScreen);
         this._bigScreen.addEventListener(MouseEvent.CLICK,this.screenClick);
      }
      
      private function screenClick(param1:MouseEvent) : void
      {
         if(this._screenClickCount == 0)
         {
            ++this._screenClickCount;
            this._bigScreen.gotoAndStop(2);
         }
         else if(this._screenClickCount == 1)
         {
            --this._screenClickCount;
            this._bigScreen.gotoAndStop(1);
         }
      }
      
      private function initActivity() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
      }
      
      private function onActivityUnitClick(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "mapSwap")
         {
            OnlyFlagManager.RequestFlag(function():void
            {
               if(OnlyFlagManager.getFlag(376) == 1)
               {
                  NpcDialog.show(103,"突击队长",[[0,"作为突击队员可不能太贪心了，你已经兑换过奖励啦！"]],["我知道了……"]);
               }
               else
               {
                  ItemManager.requestEquipList(function():void
                  {
                     if(ItemManager.getItemByReferenceId(100162) == null)
                     {
                        NpcDialog.show(103,"突击队长",[[0,"你不是突击队员，所以不能获得奖励！什么？想加入突击队？先用分子密码兑换突击队服再来报到！！"]],["我知道了……"]);
                     }
                     else
                     {
                        ModuleManager.toggleModule(URLUtil.getAppModule("ThreeSelectOnePetPanel"),"正在打开3选1...");
                     }
                  });
               }
            });
         }
      }
      
      private function initTwoYearNpcHandle(param1:LogicEvent = null) : void
      {
         var evt:LogicEvent = param1;
         this._oldNpc = MobileManager.getMobile(7,MobileType.NPC);
         if(this._oldNpc)
         {
            this._oldNpc.visible = false;
         }
         DayLimitListManager.getDaylimitList(this.DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            if(info.getCount(DAY_LIST[1]) > 0 && info.getCount(DAY_LIST[0]) == 0)
            {
               if(!MobileManager.getMobile(7,MobileType.NPC))
               {
                  timeId = setTimeout(function():void
                  {
                     initNpc1();
                  },2000);
               }
               else
               {
                  initNpc1();
               }
            }
            else if(_oldNpc)
            {
               _oldNpc.visible = true;
            }
         });
      }
      
      private function initNpc1() : void
      {
         this.afterFinish();
         this._oldNpc = MobileManager.getMobile(7,MobileType.NPC);
         this._oldNpc.visible = false;
         clearInterval(this.timeId);
         this._twoYearNpc = new Mobile();
         this._twoYearNpc.width = this._oldNpc.width;
         this._twoYearNpc.height = this._oldNpc.height;
         this._twoYearNpc.label = this._oldNpc.label;
         this._twoYearNpc.setPostion(new Point(this._oldNpc.x,this._oldNpc.y));
         this._twoYearNpc.resourceUrl = this._oldNpc.resourceUrl;
         this._twoYearNpc.buttonMode = true;
         this.showMouseHintAtMonster(this._twoYearNpc);
         MobileManager.addMobile(this._twoYearNpc,MobileType.NPC);
         this._twoYearNpc.addEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
      }
      
      private function onTwoYearNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(400,"赛尔",[[0,"教官教官！！在人气大比拼中，我选择支持你了噢！！"]],["嘿嘿、是不是很感动呀？"],[function():void
         {
            NpcDialog.show(7,"娜威拉",[[0,"哇！你也选择支持我吗？那我就又能多一票了！~真开心，不过我还想要获得更多的人气~~~~"]],["我来帮教官拉票吧！"],[function():void
            {
               NpcDialog.show(7,"娜威拉",[[0,"好呀好呀！~难得你这么热心~~~那你就带着我的徽章去各处替我宣传宣传吧~~嘿嘿！~~记得去人多的地方噢~~去跑个5分钟什么的"]],["好哒！"],[function():void
               {
                  SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                     ActorManager.getActor().updateMiKaChangeAct();
                  });
                  afterFinish();
               }]);
            }]);
         }]);
      }
      
      private function afterFinish() : void
      {
         if(this._twoYearNpc)
         {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
         }
         if(this._oldNpc)
         {
            this._oldNpc.visible = true;
         }
         clearInterval(this.timeId);
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 50;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private function disposeTwoYearNpcHandle() : void
      {
         if(this._twoYearNpc)
         {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK,this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
         }
         this._oldNpc = null;
         clearInterval(this.timeId);
         ModelLocator.getInstance().removeEventListener(LogicEvent.TRAINER_PK_UPDATE,this.initTwoYearNpcHandle);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
