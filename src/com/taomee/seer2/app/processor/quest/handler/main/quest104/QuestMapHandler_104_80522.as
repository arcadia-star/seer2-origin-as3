package com.taomee.seer2.app.processor.quest.handler.main.quest104
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_104_80522 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_104_80522(param1:QuestProcessor)
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
         var _loc1_:MovieClip = null;
         _loc1_ = _processor.resLib.getMovieClip("gang");
         _loc1_.x += 564;
         _loc1_.y -= 41;
         SceneManager.active.mapModel.front.addChild(_loc1_);
         _loc1_.buttonMode = true;
         _loc1_.mouseChildren = false;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var dialog:Array = [[93,"刚铎",[[0,"啊，是谁，走进了我的生命？是谁……"]],["又是这样……"]],[400,"小赛尔",[[0,"（小声试探着问）刚铎先生……？"]],["......"]],[93,"刚铎",[[0,"啊，星际使者，你也来这里观赏风景吗？"]],["........"]],[400,"小赛尔",[[0,"呃，请问……那只看上去像斑马一样的精灵是？"]],["......"]],[3106,"皮埃纳",[[0,"噜。噜噜。"]],["....."]],[93,"刚铎",[[0,"噢。这是飞翼氏族的稀有精灵皮埃纳——这只皮埃纳打小就和我认识。皮埃纳是与音乐有关的精灵，每当我在这儿唱歌，其它的皮埃纳都躲得远远地，唯独这只皮埃纳就会出现！果然是知音啊哈哈哈哈~"]],["或许是只有它觉得你唱得还行……"]],[10,"巴蒂",[[0,"真是神奇的精灵……它是飞行系精灵吗？看上去没长翅膀诶。"]],["......"]],[3106,"皮埃纳",[[0,"♪！~"]],["......"]],[11,"多罗",[[0,"吓！！∑(ﾟДﾟ≡ﾟДﾟ)它、它响了！！！"]],["大惊小怪的多罗= ="]],[93,"刚铎",[[0,"欢乐的皮埃纳会用特化的器官演奏出美妙的乐曲，它们是极富灵性的精灵。至于翅膀嘛……它发怒的时候，会长出翅膀哦！！要不要试试？喔哈哈哈哈哈！！"]],["等会儿……咱们跑题了吧。"]],[400,"小赛尔",[[0,"那个，不好意思，刚铎先生……其实今天来，是有一事相求。"]],["......"]],[93,"刚铎",[[0,"（直爽）大丈夫义薄云天！星际使者是值得尊敬的人物，我必将倾力相助！"]],["真是爽快的一条好汉……"]],[10,"巴蒂",[[0,"（嘟囔）没想到这么快就搞定了，这家伙虽然看上去怪但是莫名的好说话？"]],["......"]],[400,"小赛尔",[[0,"刚铎先生，我们在斯坦因遗留下来的设施之中发现了一扇门，这扇门后有我们所急需的东西。"]],["......"]],[93,"刚铎",[[0,"斯坦因留下的设施……急需的东西？星际使者，虽然你是值得尊敬的人物，但是鉴于这里仍旧是飞翼氏族的领土，我需要知道一些详细的信息。"]],["........"]],[400,"小赛尔",[[0,"刚铎先生，崇尚自由的你和你们，也一样的崇尚着真相吧？"]],["......"]],[93,"刚铎",[[0,"（想了一会）星际使者说的有道理，但是我们对于真相的感情，与其说是“崇尚”，不如说是“敬畏”。 "]],["『敬畏真相』？"]],[93,"刚铎",[[0,"我族有“保留真相”的传统，无论是在政变还是在战争之后，我族的族人都不会去修改甚至销毁遗留下来的史料，最多是将原先的史料封存起来，这样，后世的人也还会有再见到这些东西的机会。"]],["这种传统令人敬佩。"]],[400,"小赛尔",[[0,"刚铎先生，现在我们也在找寻着真相，而且这真相在很大程度上是被抹去了。我们还不知道是谁做了这种事，这一切又是为了什么。在迷茫之中，我们获得了斯坦因的提示，他让我们来这里看看。"]],["是的。"]],[93,"刚铎",[[0,"斯坦因啊……你们是见识过他的所作所为的，但即便如此还要相信他？"]],["......"]],[400,"小赛尔",[[0,"因为我和我的队友，甚至斯坦因，我们都忘记了什么重要的东西。你能想象记忆断开的感觉吗？明明知道那之后发生了什么，却什么都想不起来。"]],["......"]],[400,"小赛尔",[[0,"虽然我们也怀疑过他，但是在真相面前，所有人不都是平等的么？在寻找真相的先决条件之下，我们相信他，或者说，我们相信的是他也不是他——我们相信的是真相本身"]],["......"]],[93,"刚铎",[[0,"（长久地沉默）……"]],["......"]],[11,"多罗",[[0,"（小声）队长你刚才的那番话好厉害，我都不太明白……"]],["......."]],[93,"刚铎",[[0,"走吧，星际使者。我愿意帮忙。"]],["......."]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.completeStep(_quest.id,1);
            SceneManager.changeScene(SceneType.COPY,80524);
         });
      }
   }
}
