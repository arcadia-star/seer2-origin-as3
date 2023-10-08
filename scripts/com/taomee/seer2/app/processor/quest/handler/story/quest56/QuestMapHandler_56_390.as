package com.taomee.seer2.app.processor.quest.handler.story.quest56
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_56_390 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_56_390(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initNPC();
         }
      }
      
      private function initNPC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.npcTalkHandler);
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.content.addChild(this._mc_1);
      }
      
      private function npcTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(55,"神月老大",[[0,"【璞玉】是自古流传的秘宝，当然要由我地月氏族来保管。"]],["（糟，我有不详的预感……）"],[function():void
         {
            NpcDialog.show(56,"神爪财团老板",[[1,"你们这等粗鬼怎么能保管如此精妙的东西？当然是放在我们财团的超巨大保险箱里面才安全！！"]],["（果不其然……）"],[function():void
            {
               NpcDialog.show(84,"两大酋长",[[0,"哈哈，开玩笑的。我们会共同守护这块秘宝。星球之星，要记住，合作就如同你的左右脚，只有默契配合才能让你站起来，走向远方！"]],["嗯！接下来去找神沁酋长吧！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepCompleteHandler);
                  QuestManager.completeStep(_quest.id,4);
               }]);
            }]);
         }]);
      }
      
      private function onStepCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepCompleteHandler);
         Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onGetReward);
         Connection.send(CommandSet.ITEM_EXCHANGE_1055,447,1,0);
         SceneManager.changeScene(SceneType.LOBBY,540);
      }
      
      private function onGetReward(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055,this.onGetReward);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:SwapInfo = new SwapInfo(_loc2_);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepCompleteHandler);
      }
   }
}
