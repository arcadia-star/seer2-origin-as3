package com.taomee.seer2.app.processor.quest.handler.main.quest106
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_106_80520 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_106_80520(param1:QuestProcessor)
      {
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
         var _loc1_:MovieClip = null;
         _loc1_ = _processor.resLib.getMovieClip("duoLuo");
         _loc1_.x += 450;
         _loc1_.y += 100;
         SceneManager.active.mapModel.front.addChild(_loc1_);
         _loc1_.buttonMode = true;
         _loc1_.mouseChildren = false;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var dialog:Array = [[400,"小赛尔",[[0,"队友们，我不知道该怎么说，但是今天确实是个重要的日子。我们要再向真相迈出一步……也许是最重要的一步。"]],["感觉很有宿命的意味啊。"]],[11,"多罗",[[0,"队长你不说我也明白。我们走了这么久，最后要回到一切开始的地方。"]],["看来斯坦因……很看好我们？"]],[10,"巴蒂",[[0,"队长，虽然不太懂你们在说什么，但是我很紧张，我们失去的记忆是不是可以找回来了？"]],["........"]],[400,"小赛尔",[[0,"很有可能，而我相信我们所找到的，不只是我们自己失去的东西。"]],["。。。。。"]],[11,"多罗",[[0,"那么就出发吧！宿命一般的感觉，肩负重任的感觉，这就是最聪明的我要担负的！。"]],["这也是我们和整个阿卡迪亚要担负的……"]],[10,"巴蒂",[[0,"亮晶晶……亮晶晶小队出发！目的地……目的地是哪来着？"]],["。。。。。"]],[400,"小赛尔",[[0,"目的地能源之潮，出发！"]],["。。。。。"]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY,80529);
         });
      }
   }
}
