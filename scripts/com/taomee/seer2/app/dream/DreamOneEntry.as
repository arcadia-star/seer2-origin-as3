package com.taomee.seer2.app.dream
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   
   public class DreamOneEntry
   {
      
      private static var _dreamOneMainMC:MovieClip;
      
      private static var _dreamOneEggMC:MovieClip;
      
      private static var _back:Function;
       
      
      public function DreamOneEntry()
      {
         super();
      }
      
      public static function dreamOneEntry(param1:MovieClip, param2:MovieClip) : void
      {
         _dreamOneMainMC = param1;
         _dreamOneEggMC = param2;
         _dreamOneMainMC.visible = false;
         _dreamOneMainMC.mouseChildren = false;
         _dreamOneMainMC.mouseEnabled = false;
         _dreamOneEggMC.visible = false;
         _dreamOneEggMC.mouseChildren = false;
         _dreamOneEggMC.mouseEnabled = false;
         getCurrQuestIndex(onDreamOneEntry);
      }
      
      private static function onDreamOneEntry(param1:int) : void
      {
         var index:int = param1;
         if(index == 0)
         {
            startOne();
         }
         else if(index == 6)
         {
            SwapManager.swapItem(3877,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               updateSwap();
            });
         }
      }
      
      private static function updateSwap() : void
      {
         ServerBufferManager.updateServerBuffer(ServerBufferType.DREAM_ONE_ENTRY,6,1);
         NpcDialog.show(766,"小梦",[[0,"看来你已经知道永恒梦境的基本规则了，奖励你一个珍贵的【全系扭蛋牌】。"]],["这是啥玩意？"],[function():void
         {
            NpcDialog.show(766,"小梦",[[0,"别小看这小小的牌子，用它有可能召唤出所有精灵哦！去梦境扭蛋机试试吧！"]],["那么有用！快去看看"],[function():void
            {
               ModuleManager.showModule(URLUtil.getAppModule("DreamEggPanel"),"");
            }]);
         }]);
      }
      
      private static function startOne() : void
      {
         NpcDialog.show(766,"小梦",[[0,"你好啊，" + ActorManager.actorInfo.nick + "。这里是我们最新发现的一座神殿，我们称之为永恒殿。"]],["我能在这里干什么？？"],[function():void
         {
            _dreamOneMainMC.visible = true;
            NpcDialog.show(766,"小梦",[[0,"在这里你可以进入永恒梦境进行冒险，这里是梦境的入口。"]],["（点击永恒梦境）"],[function():void
            {
               ModuleManager.addEventListener("DreamMainPanel",ModuleEvent.SHOW,onModuleShow);
            }]);
         }]);
      }
      
      public static function updateOneServerBuff(param1:int) : void
      {
         ServerBufferManager.updateServerBuffer(ServerBufferType.DREAM_ONE_ENTRY,param1,1);
      }
      
      private static function onModuleShow(param1:ModuleEvent) : void
      {
         if(param1.content == "DreamMainPanel")
         {
            ModuleManager.removeEventListener("DreamMainPanel",ModuleEvent.SHOW,onModuleShow);
            _dreamOneMainMC.visible = false;
         }
      }
      
      public static function getCurrQuestIndex(param1:Function) : void
      {
         _back = param1;
         ServerBufferManager.getServerBuffer(ServerBufferType.DREAM_ONE_ENTRY,getServerBuff);
      }
      
      private static function getServerBuff(param1:ServerBuffer) : void
      {
         var _loc2_:int = 42;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(param1.readDataAtPostion(_loc4_) != 0)
            {
               _loc3_++;
            }
            _loc4_++;
         }
         _back(_loc3_);
      }
   }
}
