package com.taomee.seer2.app.processor.quest.handler.main.quest111
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_111_80566 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_111_80566(param1:QuestProcessor)
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
         var dialog1:Array = null;
         var dialog0:Array = [[10,"巴蒂",[[0,"队长你可算来了，我这里有一些事情需要汇报。"]],["巴蒂真是一丝不苟啊。"]],[400,"赛尔",[[0,"请讲！"]],["……"]],[10,"巴蒂",[[0,"首先，为了防止多罗因为看到什么奇怪的东西而精神恍惚，我勒令他和我一起找文献。"]],["……很好，这个“勒令”用的漂亮。"]],[11,"多罗",[[0,"报，报告队长！我一直在好好工作，没有看龙傲天小说和罗曼史！我们找到了一些资料！"]],["相比于后半句，我觉得前半句更让我欣慰……"]],[10,"巴蒂",[[0,"队长你看，这些是我们找到的资料。"]],["……"]]];
         dialog1 = [[10,"巴蒂",[[0,"队长，你不妨想想，雷伊被萨伦帝国召唤出来的时候，动静也不小吧？"]],["雷伊！对，和雷伊一样！"]],[400,"赛尔",[[0,"完全有这种可能！萨伦帝国掌握了召唤的方法，像召唤雷伊一样召唤出了其他的精灵，而这些精灵能为他们所用！"]],["……"]],[11,"多罗",[[0,"队长！这很可怕对不对！谁知道我们面对的都是些什么啊！"]],["看起来确实可怕，但是这些精灵的表现也存在着疑点。"]],[10,"巴蒂",[[0,"所以说我们现在可不能被唬住！最聪明的我会找到真相的！萨伦帝国究竟在搞什么鬼，就由我来解密好了！"]],[" 真是自信啊"]],[400,"赛尔",[[0,"不过话说回来，要了解萨伦帝国的情况，我们首先要了解南半球，要了解南半球，我们首先要知道当年我们究竟经历了什么。"]],["巴蒂，那些数据怎么样了？"]],[10,"巴蒂",[[0,"这正是我要汇报的第二件事。队长，关于那个设施，我有一个大胆的想法。"]],["但说无妨!"]],[10,"巴蒂",[[0,"鉴于设施的现状，我想，我们可以试着用雷伊给我们的雷电结晶进行强制开机，这样，我们就可以直接对设施进行勘察。"]],[" 确实是一个大胆的想法。"]],[400,"赛尔",[[0,"虽然大胆，但是值得一试，这确实是一个天才的想法，不过我们应该更加稳妥。雷电结晶蕴含的能量很大，应该能起到强制开机的作用，但是如果电力过猛，也可能烧坏设施。"]],[" ……"]],[10,"巴蒂",[[0,"这样说来，队长你说的确实对。不妨让电系精灵帮我们把关，这样就能避免烧坏设施了！"]],["这也是我想到的。来试试吧！"]]];
         NpcDialog.showDialogs(dialog0,function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("111_0"),4,[[1,0]],function():void
            {
               NpcDialog.showDialogs(dialog1,function():void
               {
                  QuestManager.accept(_quest.id);
                  SceneManager.changeScene(SceneType.COPY,80567);
               });
            });
         });
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
