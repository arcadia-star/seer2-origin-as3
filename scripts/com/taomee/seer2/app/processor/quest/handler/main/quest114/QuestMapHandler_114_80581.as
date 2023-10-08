package com.taomee.seer2.app.processor.quest.handler.main.quest114
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_114_80581 extends QuestMapHandler
   {
       
      
      private var _dialogs:Array;
      
      public function QuestMapHandler_114_80581(param1:QuestProcessor)
      {
         this._dialogs = [[3124,"诗风",[[0,"久在樊笼里，复得返自然。不禁逸兴遄飞啊。"]],["……"]],[400,"小赛尔",[[0,"你……等等，这不是释放神兽的按钮吗？你是什么……？ "]],["……"]],[3124,"诗风",[[0,"名吾曰诗风兮，集诗歌以抒怀。"]],["……"]],[10,"巴蒂",[[0,"你叫诗风？不是神兽啊……斯坦……老铁皮！我巴蒂什么时候被这样捉弄过？！ "]],["……"]],[3124,"诗风",[[0,"山重水复疑无路，柳暗花明又一村。莫生气啊。 "]],["……"]],[10,"巴蒂",[[0,"好了好了，别安慰我了！我现在要想办法救这个神兽，顺便找到出去的路。我还要继续看看……"]],["……"]]];
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!QuestManager.isAccepted(_quest.id))
         {
            this.initStep0();
         }
      }
      
      private function initStep0() : void
      {
         var mc:MovieClip = SceneManager.active.mapModel.content["mv"];
         mc.visible = true;
         MovieClipUtil.playMc(mc,2,mc.totalFrames,function():void
         {
            NpcDialog.showDialogs(_dialogs,function():void
            {
               QuestManager.accept(_quest.id);
               SceneManager.changeScene(SceneType.COPY,80582);
            });
         });
      }
   }
}
