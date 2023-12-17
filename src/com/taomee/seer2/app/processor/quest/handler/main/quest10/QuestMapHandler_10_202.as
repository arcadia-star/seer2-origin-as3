package com.taomee.seer2.app.processor.quest.handler.main.quest10
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_10;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10_202 extends QuestMapHandler
   {
       
      
      private var _stepAnimation1:MovieClip;
      
      private var _stepAnimation2:MovieClip;
      
      public function QuestMapHandler_10_202(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._stepAnimation1 = _processor.getMcFromLib("mc_202_1");
         this._stepAnimation2 = _processor.getMcFromLib("mc_202_2");
         if(_quest.isStepCompletable(3))
         {
            if(QuestProcessor_10(_processor).petStep == 3)
            {
               _map.content.addChild(this._stepAnimation1);
               MovieClipUtil.playMc(this._stepAnimation1,1,this._stepAnimation1.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_stepAnimation1);
                  NpcDialog.show(10,"巴蒂",[[0,"队长！怎么会有这么多小小葵！！！看来我们离答案越来越近了！小心！"]],["（巴蒂果然沉着冷静！）"],[function():void
                  {
                     NpcDialog.show(11,"多罗",[[0,"冲啊！哒哒嘀哒……！！！第七小分队！奋勇杀敌！！！冲啊！！！"]],["（多罗……囧……）"],[function():void
                     {
                        _map.content.addChild(_stepAnimation2);
                        MovieClipUtil.playMc(_stepAnimation2,1,_stepAnimation2.totalFrames,function():void
                        {
                           DisplayObjectUtil.removeFromParent(_stepAnimation2);
                           QuestManager.completeStep(_quest.id,3);
                           _processor.showMouseHintAt(40,360);
                        },true);
                     }]);
                  }]);
               },true);
            }
            else if(QuestProcessor_10(_processor).petStep > 3)
            {
               _processor.showMouseHintAt(60,360);
            }
         }
         else if(_quest.isStepCompletable(6))
         {
            _processor.showMouseHintAt(886,154);
         }
      }
   }
}
