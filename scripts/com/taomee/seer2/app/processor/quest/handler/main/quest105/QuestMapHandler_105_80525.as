package com.taomee.seer2.app.processor.quest.handler.main.quest105
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
   
   public class QuestMapHandler_105_80525 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_105_80525(param1:QuestProcessor)
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
         this.onClick();
      }
      
      protected function onClick() : void
      {
         var dialog:Array = [[11,"多罗",[[0,"这里是哪？感觉好高啊……站不稳……还有点冷……大叔你骗我！这里一点也不安全！"]],["......"]],[93,"刚铎",[[0,"这位铁皮小伙，你可要多多锻炼啊！这里是飞翼氏族最高的地方——星象之台。本来我想着你们是铁皮，不怕冷也不怕呼吸困难，才打算带你们到这里，没想到你这么弱啊！"]],["他说的好有道理……"]],[11,"多罗",[[0,"……刚铎先生说的是……我确实很弱，我以后一定努力！"]],["........"]],[93,"刚铎",[[0,"那就祝你好运了铁皮！作为星际使者的队友，你可不能太弱啊！"]],["......"]],[10,"巴蒂",[[0,"（小声）然而多罗什么时候说话算话过……？"]],["....."]],[400,"小赛尔",[[0,"看看头顶的天空，不禁觉得自己和这个世界，都是这么的渺小。"]],["......"]],[93,"刚铎",[[0,"就是因为我们在天空下的渺小，所以我们才要不断地试翼起飞，向更高远的天空进发。我们不断挑战自我、打破“界限”，每次前进都能看到新的风景。如果世界只有那么一点点，那么生命又有何乐趣呢？"]],["刚铎先生说的真好……佩服佩服。"]],[93,"刚铎",[[0,"能被星际使者夸奖是我的荣幸！话说回来，这里的天空十分清澈，这里的的设施可以看到很远的地方，星际使者可以去试试。"]],["就是中央的那座设施吗？"]],[400,"小赛尔",[[0,"既然刚铎先生建议了，那么我就去开开眼界吧。"]],["......"]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            var movie1:MovieClip = null;
            movie1 = _processor.resLib.getMovieClip("woo");
            movie1.x += 246;
            movie1.y += 170;
            _map.front.addChild(movie1);
            MovieClipUtil.playMc(movie1,2,movie1.totalFrames,function():void
            {
               var dialog:Array;
               _map.front.removeChild(movie1);
               dialog = [[400,"小赛尔",[[0,"那里是……"]],["......"]],[93,"刚铎",[[0,"那里啊，很久以前就被观测到了，应该是能源之树强大的能量场形成的吧，看起来很漂亮。"]],["....."]],[10,"巴蒂",[[0,"队长，你应该想起了什么吧？"]],["似乎是的。"]],[400,"小赛尔",[[0,"（恍然大悟）就是那里！一切开始的地方，谜团开始的地方……我知道了！"]],["......"]],[93,"刚铎",[[0,"哎？莫非此情此景让星际使者受了启发，领悟了生命的奥秘？"]],["....."]],[400,"小赛尔",[[0,"谢谢刚铎先生……我知道接下来要怎么做了！"]],["......"]],[93,"刚铎",[[0,"能帮到星际使者是我的荣幸！那么，朝着你们的真相和自由前进吧！"]],["......"]],[11,"多罗",[[0,"队长你要去哪？"]],["......"]],[400,"小赛尔",[[0,"（坚定）我知道我们该去哪了！去一切的开始，去一切的尽头！"]],["......"]]];
               NpcDialog.showDialogs(dialog,function():void
               {
                  QuestManager.completeStep(_quest.id,1);
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            });
         });
      }
      
      protected function onClick1(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = _processor.resLib.getMovieClip("movie");
         _loc2_.x += 246;
         _loc2_.y += 170;
         _map.front.addChild(_loc2_);
      }
   }
}
