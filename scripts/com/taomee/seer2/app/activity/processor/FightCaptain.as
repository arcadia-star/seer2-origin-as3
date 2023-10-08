package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class FightCaptain
   {
       
      
      public function FightCaptain()
      {
         super();
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         var _loc1_:int = int(FightManager.currentFightRecord.initData.positionIndex);
         if(SceneManager.prevSceneType == SceneType.ARENA && _loc1_ == 124)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
            }
            else
            {
               this.noWin();
            }
            return;
         }
      }
      
      private function onActivityUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "FightCaptain")
         {
            if(ItemManager.getSpecialItem(500510) != null || ItemManager.getSpecialItem(500508) != null)
            {
               NpcDialog.show(1002,"上尉",[[0,"哼！废话少说，让我们用实力来证明！(击败队长，系统将扣除该队精灵王争霸赛200点积分）"]],["我遇强则强","上尉威武！！！"],[function():void
               {
                  Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,onPlayHint);
                  Connection.send(CommandSet.DAILY_LIMIT_1065,457);
               }]);
            }
            else
            {
               NpcDialog.show(1002,"上尉",[[0,"<font color=\'#ffcc00\'>{$name}</font>，我们是队友哦，去挑战其他队伍的队长吧！"]],["嗯，我知道啦！"],[]);
            }
         }
      }
      
      private function onPlayHint(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onPlayHint);
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         var _loc3_:uint = _loc2_.count;
         if(_loc3_ < 3)
         {
            FightManager.startFightWithWild(124);
         }
         else
         {
            NpcDialog.show(1002,"上尉",[[0,"今天的较量到此为止！让我好好准备，明天等着瞧！"]],["OK!"],[]);
         }
      }
      
      private function win() : void
      {
         NpcDialog.show(1002,"上尉",[[0,"呼！刚刚我还没有发挥全部的实力，快点！咱们继续决斗！"]],["谁怕谁啊！"],[function():void
         {
            SwapManager.swapItem(474,1,null,null,new SpecialInfo(1,2));
         }]);
      }
      
      private function noWin() : void
      {
         NpcDialog.show(1002,"上尉",[[0,"哼哼！回家练练再来吧！"]],["啊啊！我要继续挑战你！!","退出挑战！"],[function():void
         {
            FightManager.startFightWithWild(124);
         }]);
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onPlayHint);
      }
   }
}
