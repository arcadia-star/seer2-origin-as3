package com.taomee.seer2.app.processor.quest.handler.main.quest102
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class QuestMapHandler_102_80509 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_102_80509(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         if(!QuestManager.isAccepted(_quest.id))
         {
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         var _loc1_:Array = [[3094,"撒莱尔",[[0,"斯坦因！被你推下去之后，我就被传送到了这里！！我想起来了！！"]],["......"]],[400,"小赛尔",[[0,"很对，那么，巴蒂呢？她去了哪里？"]],["是啊……巴蒂去了哪里？"]],[3094,"撒莱尔",[[0,"（一时语塞）巴蒂她……她……我想不起来了，大概被传送回飞船了吧？我不知道……"]],["要不我问问她？"]],[400,"小赛尔",[[0,"（探出头来）嘿，反正不会有事的，那下面摔不死人！"]],["......"]],[3094,"撒莱尔",[[0,"……你谁啊？"]],["看起来很眼熟的样子。"]],[3020,"弗雷德",[[0,"语气平静，莫名带着点慈爱）风暴伊特啊，来和这位打个招呼吧。"]],["......"]],[400,"小赛尔",[[0,"就是这个铁皮？我还以为是什么大人物呢！"]],["这么不屑的语气是怎么回事？！"]],[3098,"翟",[[0,"我可是星际使者，别随便就看不起人啊！"]],["......"]],[3097,"乌尔栀",[[0,"星际使者又如何？不好意思。我只认可我眼前看到的东西。过去的头衔什么的都是虚名，我才不稀罕呢。"]],["......"]],[3096,"斯卡沃兹",[[0,"（自信）好啊，我随时奉陪！"]],["......"]],[3095,"艾本德",[[0,"（意味不明地笑）好了，既然我们达成了初步共识。现在来谈谈你和影灵兽的相遇吧。"]],["......"]]];
      }
   }
}
