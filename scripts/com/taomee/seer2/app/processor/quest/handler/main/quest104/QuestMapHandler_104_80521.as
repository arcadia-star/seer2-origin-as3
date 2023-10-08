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
   
   public class QuestMapHandler_104_80521 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_104_80521(param1:QuestProcessor)
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
         var dialog:Array = [[400,"小赛尔",[[0,"巴蒂，怎么了？"]],["......"]],[10,"巴蒂",[[0,"队长，虽然我是最聪明的，但是现在我仍旧无法打开这扇门。"]],["什么？"]],[400,"小赛尔",[[0,"斯坦因设下的门禁有这么厉害？"]],["........"]],[10,"巴蒂",[[0,"不，其实这道门的门禁我还是能解开的，问题在于，它还有一道用精灵力量构成的禁制。"]],["精灵的力量？"]],[11,"多罗",[[0,"而且我们问了伊娃博士，她说那是翼灵兽的力量……我感觉世界不会再充满爱了……"]],["没这么夸张吧？"]],[10,"巴蒂",[[0,"虽然确实如此，但是事态还不至于严重到这个地步吧？"]],["......"]],[10,"巴蒂",[[0,"队长，找你来是因为我要请示下一步的行动。"]],["......"]],[400,"小赛尔",[[0,"作为队长我一定会认真考虑你的建议。你说吧！"]],["......"]],[10,"巴蒂",[[0,"我请求队长向刚铎求助。这道封锁很可能是当年斯坦因抽取翼灵兽的力量制成的，而当年正是刚铎破除了斯坦因用来隔离并抽取翼灵兽力量的【拘束器】，所以，我们有必要向他求助。"]],["没错，只有他了。"]],[400,"小赛尔",[[0,"巴蒂，你说的很对。现在我们有必要寻求他的帮助"]],["......"]],[10,"巴蒂",[[0,"多谢队长！那么接下来说服那个怪大叔的任务就交给你们了！"]],["……怪大叔？"]],[400,"小赛尔",[[0,"……我们现在就出发吧。"]],["前往汲雨之岛！"]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY,80522);
         });
      }
   }
}
