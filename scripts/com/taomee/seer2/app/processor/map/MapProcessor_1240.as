package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class MapProcessor_1240 extends MapProcessor
   {
       
      
      private var _npc324:Mobile;
      
      private var _mark:AcceptableMark;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function MapProcessor_1240(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_493);
         ServerBufferManager.getServerBuffer(ServerBufferType.SHIHUNBEAST_FIRST_CHARPTER,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(1);
            if(_loc2_ == 2)
            {
               QuestManager.completeStep(10249,2);
            }
         });
      }
      
      private function onUnit(param1:DialogPanelEvent) : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
         if(param1.content.params == "蚀魂兽第一章")
         {
            this.branthDialog();
         }
      }
      
      private function branthDialog() : void
      {
         NpcDialog.show(400,"赛尔",[[0,"白雪公主，巴金斯日志指引我来到这里，是有关蚀魂兽的消息了吗？  "]],["过了这么久，终于有线索了。"],[function():void
         {
            NpcDialog.show(324,"白雪公主",[[0,"是你呀，" + ActorManager.actorInfo.nick + "。你已经是今天第二个来到这里的了，之前也有一个有轮子的奇怪机器人来过这里。 "]],["奇怪的机器人？"],[function():void
            {
               NpcDialog.show(324,"白雪公主",[[0,"没错，不过他什么也没有问，只顾低头看着什么，嘴里念念有词，随后就离开了。"]],["我似乎知道来的是谁了。"],[function():void
               {
                  NpcDialog.show(400,"赛尔",[[0,"奇怪的机器人应该是斯坦因博士吧。  "]],["公主，他往哪里走了？"],[function():void
                  {
                     NpcDialog.show(324,"白雪公主",[[0,"他去了后花园的方向，去那里看看吧。" + ActorManager.actorInfo.nick + "，如果有蚀魂兽的消息，一定要告诉我哦！"]],["公主请放心！我这就去。"],[function():void
                     {
                        ServerBufferManager.updateServerBuffer(ServerBufferType.SHIHUNBEAST_FIRST_CHARPTER,1,1);
                        if(_mark != null)
                        {
                           DisplayObjectUtil.removeFromParent(_mark);
                        }
                        _mouseHint = new MouseClickHintSprite();
                        _mouseHint.x = 251;
                        _mouseHint.y = 519;
                        _map.front.addChild(_mouseHint);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
