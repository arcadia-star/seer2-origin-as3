package com.taomee.seer2.app.processor.activity.leiyiFight
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class LeiyiFight60
   {
       
      
      private var _hasReadData:Boolean;
      
      private var _num:uint;
      
      private var _peyName:String;
      
      private var _petcCount:uint;
      
      private var _shoolOpenGrow:LeiyiFightAgain60;
      
      private var _npc:Mobile;
      
      public function LeiyiFight60()
      {
         super();
         ModuleManager.addEventListener("AppearResultPanel",ModuleEvent.DISPOSE,this.onDisposePanel);
         Connection.addCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.onData);
         Connection.send(CommandSet.GET_RANGE_DAY_LIMIT_1209,1,406);
         this._npc = MobileManager.getMobile(154,MobileType.NPC);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.toShowDilog);
      }
      
      private function toShowDilog(param1:DialogPanelEvent) : void
      {
         var _loc2_:CustomUnit = new CustomUnit(FunctionalityType.ACTIVE,"开学高效资质训练","SchoolOpenAptitudeTrainPanel");
         var _loc3_:CustomUnit = new CustomUnit(FunctionalityType.ACTIVE,"开学极速成长训练","ShoolOpenGrowUpPanel");
         var _loc4_:CustomUnit = new CustomUnit(FunctionalityType.ACTIVE,"开学有奖智慧考验","SeerIIAnswerPanel");
         DialogPanel.functionalityBox.addUnit(_loc2_);
         DialogPanel.functionalityBox.addUnit(_loc3_);
         DialogPanel.functionalityBox.addUnit(_loc4_);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         var params:String = (event.content as DialogPanelEventData).params;
         var date:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
         if(params == "SchoolOpenAptitudeTrainPanel")
         {
            if(date.hours < 13)
            {
               NpcDialog.show(6,"贾斯汀和克拉克",[[7,"哦？资质特训在每天的13:00开启，时间还没到哦~"]],["好的，过会儿再来"],[function():void
               {
               }]);
            }
            else
            {
               ModuleManager.showAppModule("SchoolOpenAptitudeTrainPanel");
            }
         }
         else if(params == "ShoolOpenGrowUpPanel")
         {
            if(date.hours < 14)
            {
               NpcDialog.show(6,"贾斯汀和克拉克",[[7,"哦？经验特训在每天的14:00开启，时间还没到哦~"]],["好的，过会儿再来"],[function():void
               {
               }]);
            }
            else
            {
               ModuleManager.showAppModule("ShoolOpenGrowUpPanel");
            }
         }
         else if(params == "SeerIIAnswerPanel")
         {
            if(date.hours < 15)
            {
               NpcDialog.show(6,"贾斯汀和克拉克",[[7,"哦？智慧特训在每天的15:00开启，时间还没到哦~"]],["好的，过会儿再来"],[function():void
               {
               }]);
            }
            else
            {
               DayLimitManager.getDoCount(489,function(param1:int):void
               {
                  var count:int = param1;
                  if(count > 0)
                  {
                     NpcDialog.show(6,"贾斯汀和克拉克",[[7,"今天已经答过了，明天15:00再来吧~"]],["好的"],[function():void
                     {
                     }]);
                  }
                  else
                  {
                     ModuleManager.showAppModule("SeerIIAnswerPanel");
                  }
               });
            }
         }
      }
      
      private function GameOver() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 113)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               if(this._num < 10)
               {
                  this.nineWin();
               }
               else
               {
                  this.tenWin();
               }
            }
            else if(this._num < 10)
            {
               this.nineLose();
            }
            else
            {
               this.tenLose();
            }
            return;
         }
      }
      
      private function onDispose(param1:ModuleEvent) : void
      {
         this._shoolOpenGrow.onDispose(param1);
      }
      
      private function onData(param1:MessageEvent) : void
      {
         var _loc5_:uint = 0;
         Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.onData);
         this.hasReadeData();
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = uint(_loc2_.readUnsignedInt());
            this._num = _loc2_.readUnsignedInt();
            _loc4_++;
         }
         this.GameOver();
      }
      
      public function hasReadeData() : void
      {
         this._shoolOpenGrow = new LeiyiFightAgain60();
      }
      
      private function nineWin() : void
      {
         ServerMessager.addMessage("已经连续高效资质训练" + this._num + "场");
         NpcDialog.show(6,"克拉克",[[0,"好！不愧是赛尔号II上的小勇士，我见识了你的实力，这是送给你的奖励，加油！再接再厉！"]],["太好了！谢谢站长！"],[function():void
         {
            ModuleManager.showAppModule("SchoolOpenAptitudeTrainPanel");
         }]);
      }
      
      private function nineLose() : void
      {
         NpcDialog.show(6,"克拉克",[[0,"别气馁！再来一次！赛尔号II上的小勇士是不会轻言放弃的！这个先送给你作为鼓励！"]],["我一定会加油的！","下次再来！"],[function():void
         {
            FightManager.startFightWithWild(113);
         }]);
      }
      
      private function tenWin() : void
      {
         ServerMessager.addMessage("已经连续高效资质训练" + this._num + "场");
         ModuleManager.toggleModule(URLUtil.getAppModule("AptitudeSelectPetPanel"),"正在打开精灵面板...");
      }
      
      private function tenLose() : void
      {
         NpcDialog.show(6,"克拉克",[[0,"<font color=\'#ffcc00\'>{$name}</font>，相信你已经尽力了！给！这个拿去！我想对你的精灵有所帮助吧！"]],["下一次！我一定会战胜！"],[function():void
         {
            FightManager.startFightWithWild(113);
         }]);
      }
      
      private function onDisposePanel(param1:ModuleEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 113)
         {
            ModuleManager.removeEventListener("AppearResultPanel",ModuleEvent.DISPOSE,this.onDisposePanel);
            if(this._num < 10)
            {
               NpcDialog.show(6,"克拉克",[[0,"好！不愧是赛尔号II上的小勇士，我见识了你的实力，这是送给你的奖励，加油！再接再厉！"]],["太好了！谢谢站长！"],[]);
            }
            else
            {
               NpcDialog.show(6,"克拉克",[[0,"真棒！小赛尔！作为奖励，我给你一次提高精灵资质的机会！"]],["酷！"]);
            }
         }
      }
      
      public function dispose() : void
      {
         ModuleManager.removeEventListener("AppearResultPanel",ModuleEvent.DISPOSE,this.onDisposePanel);
         this._shoolOpenGrow.dispose();
         if(this._npc)
         {
            MobileManager.removeMobile(this._npc,MobileType.NPC);
            this._npc = null;
         }
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.toShowDilog);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
      }
   }
}
