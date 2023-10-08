package com.taomee.seer2.app.processor.quest.handler.main.quest107
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_107_80536 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_107_80536(param1:QuestProcessor)
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
         _loc1_.x += 310;
         _loc1_.y += 135;
         SceneManager.active.mapModel.front.addChild(_loc1_);
         _loc1_.buttonMode = true;
         _loc1_.mouseChildren = false;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var dialog0:Array = null;
         var dialog1:Array = null;
         var e:MouseEvent = param1;
         var dialog:Array = [[400,"小赛尔",[[0,"队友们，我来了。"]],["......"]],[10,"巴蒂",[[0,"队长看起来信心满满嘛！"]],["那是当然！"]],[400,"小赛尔",[[0,"没想到居然能够完成影灵兽的挑战，看来我们真的进步很大啊。"]],["........"]],[11,"多罗",[[0,"太好了！多谢队长夸奖！"]],["这样神经大条也挺好的？"]],[400,"小赛尔",[[0,"那么，我们就向着真相再迈出一步吧！——看，菲亚斯就在那块巨石上呢。"]],["......."]],[10,"巴蒂",[[0,"菲亚斯！你还记得我们吗？"]],["........"]],[157,"菲亚斯",[[0,"（迷茫）是你吗……不，不是——赛尔们，你们找我有什么事吗？"]],["......."]],[400,"小赛尔",[[0,"回忆的能力，逍遥的灵魂。有人让我们来找你，也许你能帮助我们。"]],["......."]],[157,"菲亚斯",[[0,"……是谁？不，那已经不重要了。那说的不是我，虽然获得了回忆的能力，但是我的心也受困于此……不过我大概知道你们要找谁了。"]],["你果然知道？"]],[10,"巴蒂",[[0,"那真是太好了！菲亚斯，能告诉我那是谁吗？"]],["......."]],[157,"菲亚斯",[[0,"远在天边，近在眼前……"]],["......."]]];
         dialog0 = [[0,"???",[[0,"……你们是谁……星际……使者？"]],["好空灵的声音，你是谁？你不是菲亚斯？"]],[10,"巴蒂",[[0,"是的，我是星际使者，这是我的队友们。听说您能够帮助我们找回丢失的记忆。"]],["不知不觉使用了敬称啊。 "]],[0,"???",[[0,"丢失的记忆……你们找对了。在这漂浮在高空的世外之地，有着隐藏在云海之中的藏书……"]],["......"]],[11,"多罗",[[0,"云海藏书，我们已经去过了。我们因此确认了【记忆残缺】的事实，但是却无法获知全部的真相。"]],["您，有办法么？"]]];
         dialog1 = [[93,"刚铎",[[0,"嗨星际使者，又见面了！看来你的探索取得了长足的进展嘛！"]],["是的，但是问题又来了……"]],[11,"多罗",[[0,"大叔你好……不对！大叔你背后那个不是翼灵兽吗？！"]],["……翼灵兽！"]],[307,"翼灵兽",[[0,"正是吾辈。在听闻了刚铎先生的陈述之后，吾辈便想到了这里。现在你们果然来了。"]],["......"]],[10,"巴蒂",[[0,"优雅的翼灵兽，您知道恢复记忆的方法？"]],["也许会离真相更进一步……"]],[307,"翼灵兽",[[0,"（抬头望向空中的虚影）既然他们找到了您，那么吾辈不妨向他们解释一下吧？"]],["翼灵兽……这语气是怎么回事？"]],[0,"???",[[0,"但说无妨。"]],["......."]],[307,"翼灵兽",[[0,"所谓【云海藏书】，是构建在这位前辈的能力基础上形成的……它将来自星球各地的几千只精灵的精神联结起来，将记忆化成文字，直接记录在书卷上。正是如此，【云海藏书】的记载从未失真。"]],["........"]],[11,"多罗",[[0,"好……好厉害！"]],["等等，你们是不是想到了什么？"]],[93,"刚铎",[[0,"啊，这段解释我也是今天才听到的，哈哈！星际使者，你和你的队友又让我大开眼界了！"]],["刚铎先生又过奖了……"]],[10,"巴蒂",[[0,"果然，斯坦因可能用设施模仿了这种能力，但是似乎没有成功过，我只看到了一些不完全的数据。"]],["应该是这样的。"]],[93,"刚铎",[[0,"哈，听起来感觉有点不服气啊。飞翼氏族的超强能力就这么被利用了！"]],["说的也是。"]],[307,"翼灵兽",[[0,"模仿也是一种力量，科技是斯坦因的力量，也是他追求自由的手段。要知道，一个真正为了自由的人连生命和爱都能抛弃，又如何在意站在谁的肩膀上呢？"]],["自由，生命和爱？"]],[11,"多罗",[[0,"翼灵姐姐你是我的女神！没有为什么！"]],["又泪奔了，连辈分都错乱了……"]],[0,"???",[[0,"凌霄，这番话颇是逍遥啊。"]],["......."]],[11,"多罗",[[0,"还是不比前辈您的。"]],["它称呼翼灵兽什么？它是翼灵兽的前辈？"]],[400,"小赛尔",[[0,"凌霄？这名字好像在云海藏书上读到过？不对，这个问题先放下。星际使者，你继续。"]],["。。。。。"]],[307,"翼灵兽",[[0,"那么这位……这位前辈，您能帮我们找回失去的记忆吗？"]],["......"]],[0,"???",[[0,"真正自由的人不需要凭借外物之力，所有的答案都需要你们自己寻找。"]],["这大概是飞翼氏族的祖训吧。"]],[400,"小赛尔",[[0,"虽然聪明的我喜欢挑战，但是为什么你分明知道所有真相，却对我们秘而不宣？"]],["........"]],[0,"???",[[0,"无己，无功，无名，只是在高空俯瞰，默默记录历史，这就是我的逍遥。得其境界，便可得其逍遥。"]],["这境界也太高了吧……"]],[11,"多罗",[[0,"好……好厉害，那个……估计只有约瑟才能达到这境界了。"]],["喂，在翼灵兽面前这么说会是什么结果啊？！"]],[307,"翼灵兽",[[0,"这样说来正好。约瑟作为这星球上最强的个体之一，总不可能那么容易就被抹去记忆了。可惜吾辈自由自在，不问世事（微笑）吾辈是帮不上你们了。"]],["没想到莫名地什么都没发生？"]],[400,"小赛尔",[[0,"等等……约瑟？（不对！这不对！【希望之光】！）我要回云海藏书看看，你们等我一会！"]],["......"]],[10,"巴蒂",[[0,"我知道队长想到了什么！我也去去就来！"]],["......"]],[11,"多罗",[[0,"你们干什么啊？……为什么把我和女神留在一起？"]],["......."]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            var movie1:MovieClip = _processor.resLib.getMovieClip("ying");
            movie1.x += 340;
            movie1.y += 60;
            SceneManager.active.mapModel.front.addChild(movie1);
            MovieClipUtil.playMc(movie1,2,movie1.totalFrames,function():void
            {
               NpcDialog.showDialogs(dialog0,function():void
               {
                  var movie1:MovieClip = _processor.resLib.getMovieClip("mama");
                  movie1.x += 246;
                  movie1.y += 170;
                  SceneManager.active.mapModel.front.addChild(movie1);
                  MovieClipUtil.playMc(movie1,2,movie1.totalFrames,function():void
                  {
                     NpcDialog.showDialogs(dialog1,function():void
                     {
                        QuestManager.accept(_quest.id);
                        SceneManager.changeScene(SceneType.COPY,80537);
                     });
                  });
               });
            });
         });
      }
   }
}
