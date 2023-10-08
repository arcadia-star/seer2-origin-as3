package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80060 extends MapProcessor
   {
      
      private static const FIGHT_NUM_DAY:int = 843;
      
      private static const FIGHT_INDEX:Vector.<int> = Vector.<int>([668,669]);
      
      private static const ITEM_ID:uint = 400359;
       
      
      private var _npc:Mobile;
      
      public function MapProcessor_80060(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.bloodActInit();
      }
      
      private function bloodActInit() : void
      {
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(460,275));
            this._npc.resourceUrl = URLUtil.getNpcSwf(637);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "女王";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var canFightNum:int = 0;
         var itemNum:int = 0;
         var evt:MouseEvent = param1;
         this._npc.mouseEnabled = this._npc.mouseChildren = false;
         ItemManager.requestItemList(function():void
         {
            itemNum = ItemManager.getItemQuantityByReferenceId(ITEM_ID);
            DayLimitManager.getDoCount(FIGHT_NUM_DAY,function(param1:int):void
            {
               var val:int = param1;
               if(ActorManager.actorInfo.vipInfo.isVip())
               {
                  canFightNum = 2 - val;
               }
               else
               {
                  canFightNum = 1 - val;
               }
               if(canFightNum > 0)
               {
                  NpcDialog.show(637,"女王",[[0,"这个世界充满虚伪和欺骗，我将践踏一切！包括你！（如拥有十字架将进入弱化挑战，轻松战胜女王。当前拥有十字架" + "<font color=\'#FF0000\'>" + itemNum + "</font>个)"]],["开始挑战","准备一下"],[function():void
                  {
                     ItemManager.requestItemList(function():void
                     {
                        if(itemNum > 0)
                        {
                           FightManager.startFightWithWild(FIGHT_INDEX[1]);
                        }
                        else
                        {
                           FightManager.startFightWithWild(FIGHT_INDEX[0]);
                        }
                     });
                  },function():void
                  {
                     _npc.mouseEnabled = _npc.mouseChildren = true;
                  }]);
               }
               else
               {
                  NpcDialog.show(637,"女王",[[0,"你已经没有机会了，天快亮了，我也不想和你再耽误功夫！明天再来找我吧！"]],["知道了"],[]);
                  _npc.mouseEnabled = _npc.mouseChildren = true;
               }
            });
         });
      }
      
      private function bloodActDispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.bloodActDispose();
      }
   }
}
