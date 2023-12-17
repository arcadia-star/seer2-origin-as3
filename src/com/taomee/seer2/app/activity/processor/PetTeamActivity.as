package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class PetTeamActivity
   {
      
      private static const mapList:Vector.<uint> = Vector.<uint>([81,40,3840]);
      
      private static const npcIdList:Vector.<uint> = Vector.<uint>([477,499,601]);
      
      private static const dayList:Vector.<uint> = Vector.<uint>([5136,5139,5140]);
      
      private static const fightIndexList:Vector.<uint> = Vector.<uint>([1620,1621,1622]);
      
      private static const npcDiaLog:Vector.<String> = Vector.<String>(["挑战雷伊和布莱克","挑战凯萨和缪斯","挑战盖亚和卡修斯"]);
      
      private static var fightIndex:int = 0;
      
      private static var npcFightCount:Vector.<int> = Vector.<int>([]);
       
      
      public function PetTeamActivity()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(!isInAct())
         {
            return;
         }
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,onDiaLogShow);
      }
      
      private static function isInAct() : Boolean
      {
         var _loc1_:Boolean = false;
         if(DateUtil.isInTime(new Date(2015,6,17),new Date(2015,6,30,23,59,59)))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private static function onDiaLogShow(param1:DialogPanelEvent) : void
      {
         var _loc3_:CustomUnit = null;
         var _loc2_:int = mapList.indexOf(SceneManager.active.mapID);
         if(_loc2_ != -1 && param1.content == npcIdList[_loc2_] && npcFightCount.length != 0 && npcFightCount[_loc2_] < 3)
         {
            _loc3_ = new CustomUnit(FunctionalityType.ACTIVE,npcDiaLog[_loc2_],npcDiaLog[_loc2_]);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         }
      }
      
      private static function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,onCustomUnitClick);
         var _loc2_:String = DialogPanelEventData(param1.content).params;
         if(_loc2_ == "挑战雷伊和布莱克")
         {
            leiwenDialog();
         }
         else if(_loc2_ == "挑战凯萨和缪斯")
         {
            jinDialog();
         }
         else if(_loc2_ == "挑战盖亚和卡修斯")
         {
            menluoDialog();
         }
      }
      
      private static function leiwenDialog() : void
      {
         NpcDialog.show(477,"雷伊",[[0,"你的对手是我和布莱克!你不害怕吗？"]],["准备一下 ","没错，挑战的就是你们！"],[null,function():void
         {
            FightManager.startFightWithWild(fightIndexList[0]);
            fightIndex = 1;
         }]);
      }
      
      private static function jinDialog() : void
      {
         NpcDialog.show(499,"凯萨",[[0,"我和缪斯就是你的对手，你现在放弃还来得及！"]],["准备一下","没错，挑战的就是你们！"],[null,function():void
         {
            FightManager.startFightWithWild(fightIndexList[1]);
            fightIndex = 2;
         }]);
      }
      
      private static function menluoDialog() : void
      {
         NpcDialog.show(601,"盖亚",[[0,"希望我和卡修斯的组合没有吓跑你！我们最痛恨逃兵！"]],["准备一下","和战神挑战是我的荣幸！"],[null,function():void
         {
            FightManager.startFightWithWild(fightIndexList[2]);
            fightIndex = 3;
         }]);
      }
      
      private static function leiwenWin() : void
      {
         if(npcFightCount[2] < 3)
         {
            NpcDialog.show(477,"雷伊",[[0,"刚才是我的失误，下次我们就要动真格的了！"]],["呵呵，那咱们继续吧。"]);
         }
         else
         {
            NpcDialog.show(477,"雷伊",[[0,"今天的较量到此为止！让我好好准备，明天等着瞧！"]],["Ok"]);
         }
      }
      
      private static function jinWin() : void
      {
         if(npcFightCount[1] < 3)
         {
            NpcDialog.show(499,"凯萨",[[0,"看来我们小看你了，下次可没那么轻松了！"]],["呵呵，那咱们继续吧。"]);
         }
         else
         {
            NpcDialog.show(499,"凯萨",[[0,"今天的较量到此为止！让我好好准备，明天等着瞧！"]],["Ok"]);
         }
      }
      
      private static function menluoWin() : void
      {
         if(npcFightCount[0] < 3)
         {
            NpcDialog.show(601,"盖亚",[[0,"看来你的确很有勇气和实力，不过下次可就说不定了！"]],["呵呵，那咱们继续吧。"]);
         }
         else
         {
            NpcDialog.show(601,"盖亚",[[0,"今天的较量到此为止！让我好好准备，明天等着瞧！"]],["Ok"]);
         }
      }
      
      private static function leiwenLost() : void
      {
         NpcDialog.show(477,"雷伊",[[0,"哈哈哈！尝到我的厉害吧！"]],["啊啊！我要继续挑战你！"]);
      }
      
      private static function jinLost() : void
      {
         NpcDialog.show(499,"凯萨",[[0,"不自量力的家伙！赶紧走开！"]],["啊啊！我要继续挑战你！"]);
      }
      
      private static function menluoLost() : void
      {
         NpcDialog.show(601,"盖亚",[[0,"哼哼！回家练练再来吧！"]],["啊啊！我要继续挑战你！"]);
      }
      
      private static function onSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && fightIndex != 0)
         {
            if(FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               switch(fightIndex)
               {
                  case 1:
                     leiwenLost();
                     break;
                  case 2:
                     jinLost();
                     break;
                  case 3:
                     menluoLost();
               }
               fightIndex = 0;
               return;
            }
         }
         if(mapList.indexOf(SceneManager.active.mapID) != -1)
         {
            ActiveCountManager.requestActiveCount(250351,getArmy);
         }
      }
      
      private static function getArmy(param1:uint, param2:uint) : void
      {
         var _loc3_:LittleEndianByteArray = null;
         npcFightCount = Vector.<int>([]);
         if(mapList.indexOf(SceneManager.active.mapID) != param2 - 1 && param2 != 0)
         {
            _loc3_ = new LittleEndianByteArray();
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(dayList[0]);
            _loc3_.writeUnsignedInt(dayList[1]);
            _loc3_.writeUnsignedInt(dayList[2]);
            DayLimitListManager.getDoCount(_loc3_,daylimitFun);
         }
      }
      
      private static function daylimitFun(param1:DayLimitListInfo) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.dayLimitList.length)
         {
            npcFightCount[dayList.indexOf(param1.dayLimitList[_loc2_].id)] = param1.dayLimitList[_loc2_].count;
            _loc2_++;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA && fightIndex != 0)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               switch(fightIndex)
               {
                  case 1:
                     leiwenWin();
                     break;
                  case 2:
                     jinWin();
                     break;
                  case 3:
                     menluoWin();
               }
               fightIndex = 0;
            }
         }
      }
   }
}
