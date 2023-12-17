package com.taomee.seer2.app.processor.quest.handler.story.quest22
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_22_320 extends QuestMapHandler
   {
       
      
      private var _mc_3:MovieClip;
      
      private var _mc_4:MovieClip;
      
      public function QuestMapHandler_22_320(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initQuest2();
         }
      }
      
      private function initQuest2() : void
      {
         this._mc_3 = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._mc_3);
         this._mc_3.buttonMode = true;
         this._mc_3.addEventListener(MouseEvent.CLICK,this.onMC3Click);
         this._mc_4 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_4);
         this._mc_4.gotoAndStop(1);
         this._mc_4.buttonMode = true;
         this._mc_4.addEventListener(MouseEvent.CLICK,this.onQuest1);
      }
      
      private function onQuest1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(52,"蒂萨特",[[2,"给你个提示留心场景中发亮的物体哦！"]],["谢谢！"],[function():void
         {
         }]);
      }
      
      private function onMC3Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_3.removeEventListener(MouseEvent.CLICK,this.onMC3Click);
         NpcDialog.show(52,"蒂萨特",[[1,"哇！找到了！果然，旋转呼呼是风扇啊！"]],["看看写的什么？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("22_1"),1,[[1,0]],function():void
            {
               NpcDialog.show(52,"蒂萨特",[[0,"蛋壳鸡……蛋壳鸡……哦！是黄金之路吧？"]],["似乎是呢，那里有很多！"],[function():void
               {
                  NpcDialog.show(52,"蒂萨特",[[1,"绿巨人先生……会笑的绿巨人先生……去看看吧！"]],["（去黄金之路找找线索！）"],[function():void
                  {
                     MovieClipUtil.playMc(_mc_4,2,_mc_4.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,2);
                        _processor.showMouseHintAt(159,469);
                     },true);
                  }]);
               }]);
            });
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_3);
         DisplayUtil.removeForParent(this._mc_4);
         this._mc_3 = null;
         this._mc_4 = null;
      }
   }
}
