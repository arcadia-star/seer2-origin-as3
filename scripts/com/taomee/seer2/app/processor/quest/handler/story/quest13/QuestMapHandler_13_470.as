package com.taomee.seer2.app.processor.quest.handler.story.quest13
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   
   public class QuestMapHandler_13_470 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_13_470(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var params:String;
         var event:DialogCloseEvent = param1;
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         params = event.params;
         if(params == "13_0")
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("13_0"),2,[[1,0]],function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[4,"哇哇哇哇！！！实验禁地大探险？神秘精灵？哇哦！前进……"]],["（前往实验禁地）"],[function():void
               {
                  QuestManager.accept(_quest.id);
                  SceneManager.changeScene(SceneType.LOBBY,500);
               }]);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
      }
   }
}
