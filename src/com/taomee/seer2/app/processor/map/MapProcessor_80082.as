package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80082 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:int = 721;
      
      private static const FIGHT_NUM_DAY:int = 879;
      
      private static const FIGHT_NUM_MI_BUY_FOR:int = 203447;
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([5,5]);
       
      
      private var _npc:Mobile;
      
      public function MapProcessor_80082(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.kaiSeLinProcessActInit();
      }
      
      private function kaiSeLinProcessActInit() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            DayLimitManager.getDoCount(FIGHT_NUM_DAY,function(param1:int):void
            {
               var val:int = param1;
               ActiveCountManager.requestActiveCount(FIGHT_NUM_MI_BUY_FOR,function(param1:uint, param2:uint):void
               {
                  var canFightNum:int = 0;
                  var type:uint = param1;
                  var count:uint = param2;
                  if(type == FIGHT_NUM_MI_BUY_FOR)
                  {
                     if(VipManager.vipInfo.isVip())
                     {
                        if(val > FIGHT_NUM_RULE[1])
                        {
                           canFightNum = int(count);
                        }
                        else
                        {
                           canFightNum = FIGHT_NUM_RULE[1] - val + count;
                        }
                     }
                     else if(val > FIGHT_NUM_RULE[0])
                     {
                        canFightNum = int(count);
                     }
                     else
                     {
                        canFightNum = FIGHT_NUM_RULE[0] - val + count;
                     }
                     if(canFightNum > 0)
                     {
                        createNpc();
                     }
                     else
                     {
                        TweenNano.delayedCall(3,function():void
                        {
                           ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                           SceneManager.changeScene(SceneType.LOBBY,70);
                        });
                     }
                  }
               });
            });
         }
         else
         {
            this.createNpc();
         }
      }
      
      private function kaiSeLinProcessActDispose() : void
      {
         this.clearNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 140;
            this._npc.setPostion(new Point(645,320));
            this._npc.resourceUrl = URLUtil.getNpcSwf(666);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "霍克努尔";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(666,"霍克努尔",[[0,"我这里倒是有一点你想要的东西！不如先比一下？"]],["挑战吧！","准备一下"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX);
         }]);
      }
      
      private function clearNpc() : void
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
         this.kaiSeLinProcessActDispose();
         super.dispose();
      }
   }
}
