package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.NianshouAct;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_40 extends TitleMapProcessor
   {
       
      
      private var _twoYearNpc:Mobile;
      
      private var _oldNpc:Mobile;
      
      private const DAY_LIST:Array = [5190,5192];
      
      private const SWAP_LIST:Vector.<int> = Vector.<int>([4199]);
      
      private const TASK_FINISH_FOV:int = 202496;
      
      private var timeId:int;
      
      public function MapProcessor_40(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMascot();
         ModelLocator.getInstance().addEventListener(LogicEvent.TRAINER_PK_UPDATE,this.initTwoYearNpcHandle);
         NianshouAct.init();
      }
      
      private function initMascot() : void
      {
      }
      
      override public function dispose() : void
      {
         NianshouAct.leaveMap40();
         super.dispose();
      }
      
      private function initTwoYearNpcHandle(param1:LogicEvent = null) : void
      {
         var evt:LogicEvent = param1;
         this._oldNpc = MobileManager.getMobile(5,MobileType.NPC);
         if(this._oldNpc)
         {
            this._oldNpc.visible = false;
         }
         DayLimitListManager.getDaylimitList(this.DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            if(info.getCount(DAY_LIST[1]) > 0 && info.getCount(DAY_LIST[0]) == 0)
            {
               if(!MobileManager.getMobile(5,MobileType.NPC))
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
         this._oldNpc = MobileManager.getMobile(5,MobileType.NPC);
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
            NpcDialog.show(5,"乔休尔",[[0,"哇！你也选择支持我吗？那我就又能多一票了！~真开心，不过我还想要获得更多的人气~~~~"]],["我来帮教官拉票吧！"],[function():void
            {
               NpcDialog.show(5,"乔休尔",[[0,"好呀好呀！~难得你这么热心~~~那你就带着我的徽章去各处替我宣传宣传吧~~嘿嘿！~~记得去人多的地方噢~~去跑个5分钟什么的"]],["好哒！"],[function():void
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
   }
}
