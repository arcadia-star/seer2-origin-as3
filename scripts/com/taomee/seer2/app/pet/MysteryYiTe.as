package com.taomee.seer2.app.pet
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import flash.events.MouseEvent;
   
   public class MysteryYiTe
   {
       
      
      private var _npc:Mobile;
      
      private var _npcDefinition:NpcDefinition;
      
      private const yiteID:int = 556;
      
      public function MysteryYiTe()
      {
         super();
         var _loc1_:XML = <npc id="556" resId="556" name="" dir="1" width="25" height="50" path="">
				</npc>;
         this._npcDefinition = new NpcDefinition(_loc1_);
         this._npc = MobileManager.createNpc(this._npcDefinition);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         DayLimitManager.getDoCount(629,function(param1:int):void
         {
            var count:int = param1;
            var hasFight:Boolean = false;
            var date1:int = count;
            var date2:int = int(TimeManager.getServerTime());
            var index1:int = int(date1 / 60 / 15);
            var index2:int = int(date2 / 60 / 15);
            hasFight = index1 == index2 ? true : false;
            if(hasFight)
            {
               NpcDialog.show(yiteID,"神伊特",[[0,"你已经挑战过我了哟，等我下一次藏好之后你再来找我吧，找到了我就让你和我再对战一次。快去准备一下吧。"]],["过会再来找你"],[null]);
            }
            else
            {
               NpcDialog.show(yiteID,"神伊特",[[0,"被你发现了，好吧，我就是伊特家族第12个伊特——神伊特！"]],["找的就是你！"],[function():void
               {
                  NpcDialog.show(yiteID,"神伊特",[[0,"那帮伊特家伙都不是我的对手，要不要给你一个打败我的机会，赢了就可以得到我偷来的宝贝。"]],["快来战斗吧","我准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(335);
                  },null]);
               }]);
            }
         });
      }
      
      public function get npc() : Mobile
      {
         return this._npc;
      }
   }
}
