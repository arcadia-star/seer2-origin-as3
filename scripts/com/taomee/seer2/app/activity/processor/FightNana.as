package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class FightNana
   {
      
      private static const MAP_ID:uint = 900;
       
      
      public function FightNana()
      {
         super();
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         this.begainFight();
      }
      
      private function begainFight() : void
      {
         var btnData:ButtonPanelData = null;
         btnData = new ButtonPanelData();
         btnData.catchEnabled = false;
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == MAP_ID)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 126 && FightManager.fightWinnerSide != FightSide.LEFT)
            {
               NpcDialog.show(148,"娜娜",[[1,"记住，这世界上你最不该得罪的人就是女！技！师！"]],["继续挑战！","哎……那我还是走了"],[function():void
               {
                  FightManager.startFightWithWild(126,null,null,btnData);
               }]);
            }
            else if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 128 && FightManager.fightWinnerSide != FightSide.LEFT)
            {
               NpcDialog.show(148,"娜娜",[[1,"啊哈哈哈，你比我家那两个不成器的小鬼头都差好大一截！"]],["继续挑战！","哎……那我还是走了"],[function():void
               {
                  FightManager.startFightBinaryWild(128,null,null,btnData);
               }]);
            }
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         }
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var evt:MessageEvent = param1;
         var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
         if(parser.id == 1 && parser.index == 20)
         {
            NpcDialog.show(504,"愤怒的斯缇姆",[[3,"受不了这个残暴的大姐！铁皮，你要是能战胜我，我就跟你混算了！"]],["（我怎么觉得你们的脾气很衬……）"],[function():void
            {
               FightManager.startFightWithWild(127);
            }]);
         }
      }
      
      private function onActivityUnitClick(param1:DialogPanelEvent) : void
      {
         var btnData:ButtonPanelData = null;
         var evt:DialogPanelEvent = param1;
         btnData = new ButtonPanelData();
         btnData.catchEnabled = false;
         if((evt.content as DialogPanelEventData).params == "fight_single_npc_900")
         {
            NpcDialog.show(148,"娜娜",[[3,"你没看我正在气头上？也好，让我出出气吧！"]],["作为娱乐，切磋一下！","那么凶！我走啦！"],[function():void
            {
               FightManager.startFightWithWild(126,null,null,btnData);
            }]);
         }
         else if((evt.content as DialogPanelEventData).params == "fight_dual_npc_900")
         {
            NpcDialog.show(148,"娜娜",[[1,"双精灵？！这个我喜欢，这个就对了！！流离街上长大的孩子都要学会——打！群！架！"]],["好吧来切磋下吧！","我不想挨打……"],[function():void
            {
               FightManager.startFightBinaryWild(128,null,null,btnData);
            }]);
         }
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onActivityUnitClick);
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
   }
}
