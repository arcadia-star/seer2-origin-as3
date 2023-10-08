package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   
   public class YufengAct
   {
      
      private static const QEST_STEPS:Array = [function(param1:Function):void
      {
         SceneManager.changeScene(SceneType.COPY,80591,0,0,false,0,param1);
      },function(param1:Function):void
      {
         NpcDialog.showDialogsByText("quest/dialog/10255/1.json",param1);
      },function(param1:Function):void
      {
         SceneManager.changeScene(SceneType.COPY,80592,0,0,false,0,param1);
      },function(param1:Function):void
      {
         NpcDialog.showDialogsByText("quest/dialog/10255/2.json",param1);
      },function(param1:Function):void
      {
         ModuleManager.showAppModule("YufengPvpRulePanel",param1);
      },function(param1:Function):void
      {
         NpcDialog.showDialogsByText("quest/dialog/10255/3.json",param1);
      },function(param1:Function):void
      {
         var _loc2_:* = SceneManager.active.mapModel.content["mv"];
         _loc2_.gotoAndStop(1);
         MovieClipUtil.playMc(_loc2_,2,_loc2_.totalFrames,param1);
      },function(param1:Function):void
      {
         NpcDialog.showDialogsByText("quest/dialog/10255/4.json",param1);
      },function(param1:Function):void
      {
         var fightId:* = undefined;
         var cb:Function = param1;
         fightId = 1884;
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function complete(param1:SceneEvent):void
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,complete);
               if(fightId == FightManager.currentFightRecord.initData.positionIndex)
               {
                  cb();
               }
            }
         });
         FightManager.startFightWithWild(fightId);
      },function(param1:Function):void
      {
         NpcDialog.showDialogsByText("quest/dialog/10255/5.json",param1);
      }];
       
      
      public function YufengAct()
      {
         super();
      }
      
      public static function startQuest() : void
      {
         var index:int = 0;
         processFunctionArray(QEST_STEPS,function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,1183);
         });
      }
      
      private static function processFunctionArray(param1:Array, param2:Function = null) : void
      {
         var index:int = 0;
         var funs:Array = param1;
         var cb:Function = param2;
         index = 0;
         var handleFun:Function = function():void
         {
            var fun:Function;
            if(index == funs.length)
            {
               if(cb != null)
               {
                  cb();
               }
               return;
            }
            fun = funs[index];
            fun(function():void
            {
               ++index;
               handleFun();
            });
         };
         handleFun();
      }
   }
}
