package com.taomee.seer2.app.processor.quest.handler.main.quest109
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_109_80554 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_109_80554(param1:QuestProcessor)
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
         this._npc = _processor.resLib.getMovieClip("npc");
         SceneManager.active.mapModel.front.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.mouseChildren = false;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var dialog:Array = [[10,"巴蒂",[[0,"队长，我们上次与约瑟王的谈话，可以说是收获颇多，也可以说是毫无收获。这个总结十分到位。"]],["是啊，最终还是要面对这个最艰涩的谜团。"]],[11,"多罗",[[0,"对不起，队长。当年我实在是太激动了，表现有点失控。现……现在我好了！我相信男神和女神不会分开的！因为我们都会找到希望！"]],["无论男神女神有什么典故，你能正常过来就好。"]],[10,"巴蒂",[[0,"既然连精灵王都不对劲，那么这一切究竟是怎么回事？如约瑟所说的，雷伊和凯萨是否也知道些什么呢？"]],["……"]],[400,"赛尔",[[0,"这就是我们要去寻找的了。走吧，唯有切实的行动才能解开所有的疑惑！雷伊已经在等我们了。"]],["……"]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY,80555);
         });
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._npc != null)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
   }
}
